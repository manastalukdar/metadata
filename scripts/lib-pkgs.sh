#!/usr/bin/env bash
# Shared helpers for the setup and update scripts. Source it, do not run it:
#
#   source "$(dirname "${BASH_SOURCE[0]}")/lib-pkgs.sh"
#
# Callers should use `set -uo pipefail` and deliberately NOT `set -e`: with a
# few hundred packages, one name that a distro release renamed must not abort
# the whole run. Failures are collected in FAILED and printed by report().

PKGS="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)/pkgs"
# Without this, sourcing from a shell that has no BASH_SOURCE (zsh) resolves
# PKGS to the wrong directory and every list quietly reads as empty — which
# looks like a successful install of nothing.
[[ -d "$PKGS" ]] || {
    echo "lib-pkgs.sh: cannot find $PKGS — run these scripts with bash" >&2
    return 1 2>/dev/null || exit 1
}
FAILED=()

say()  { echo -e "\n\033[1;34m==>\033[0m $*"; }
warn() { echo -e "\033[1;33m[warn]\033[0m $*" >&2; FAILED+=("$*"); }
have() { command -v "$1" >/dev/null 2>&1; }
try()  { "$@" || warn "failed: $*"; }

# logtee — mirror this run to <script>.log beside the script (gitignored by
# *.log) while still printing to the terminal. Call it once, early, as
# `logtee "$@"`. It re-execs the script through `tee` rather than using
# `exec > >(tee ...)`, so the shell cannot exit before tee flushes the tail —
# the final report() summary is the part you most need in the log.
logtee() {
    [[ -z "${SETUP_LOG:-}" ]] || return 0   # already inside the re-exec
    local src="${BASH_SOURCE[1]}"
    export SETUP_LOG="${src%.sh}.log"
    { exec bash "$src" "$@"; } 2>&1 | tee "$SETUP_LOG"
    exit "${PIPESTATUS[0]}"
}

# pkglist <list-name> — print a list's entries, comments and blanks stripped.
pkglist() { awk '{sub(/#.*/, "")} NF' "$PKGS/$1.txt"; }

# inst <list-name> <install-command...>
# Installs a list in one batch, then retries one entry at a time if the batch
# fails, so a single bad or renamed package cannot take the rest down with it.
inst() {
    local name="$1"; shift
    local file="$PKGS/$name.txt" pkgs
    [[ -f "$file" ]] || { warn "missing list: $file"; return 0; }
    pkgs="$(pkglist "$name")"
    [[ -n "$pkgs" ]] || return 0
    say "$name: installing $(wc -l <<<"$pkgs") entries"
    if ! xargs -r "$@" <<<"$pkgs"; then
        warn "$name: batch failed, retrying individually"
        xargs -r -n1 "$@" <<<"$pkgs" || warn "$name: some entries failed (see above)"
    fi
}

# instone <list-name> <install-command...>
# For installers that accept exactly one package per invocation (uv tool, etc).
instone() {
    local name="$1"; shift
    local pkgs; pkgs="$(pkglist "$name")"
    [[ -n "$pkgs" ]] || return 0
    say "$name: installing $(wc -l <<<"$pkgs") entries"
    xargs -r -n1 "$@" <<<"$pkgs" || warn "$name: some entries failed (see above)"
}

# manual_notes <linux|macos>
# Print the tools that no package manager on this platform can install. The list
# is generated from `manual` tags in the docs by scripts/gen-pkgs.sh, which keeps
# a "# from <source>" header above each block — that is what scopes the output to
# the platform, so a Fedora run does not print macOS-only apps.
manual_notes() {
    local plat="${1:-}" list="$PKGS/manual.txt"
    [[ -f "$list" ]] || return 0
    say "Not installable by any package manager — install these by hand"
    awk -v plat="$plat" '
        /^# from / { keep = ($3 ~ /^common\//) || (plat != "" && index($3, plat "/") == 1); next }
        {sub(/#.*/, "")} NF && keep { print "  - " $0 }
    ' "$list"
}

# ensure_shell_init — put mise and ~/.local/bin on PATH for *future* shells.
#
# Must be called AFTER the oh-my-zsh step: its installer writes a fresh ~/.zshrc
# from the upstream template, which would discard anything appended before it.
# Without this, everything in mise.txt (node, python, java, go, rust) is on PATH
# only for the duration of the setup script and looks uninstalled afterwards.
ensure_shell_init() {
    say "Shell init"
    have mise || { warn "mise missing — shell init skipped, nothing to activate"; return 0; }
    local marker="# >>> metadata setup >>>" rc shell_name
    for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
        [[ "$rc" == *zshrc ]] && shell_name=zsh || shell_name=bash
        [[ -e "$rc" ]] || touch "$rc"
        grep -qF "$marker" "$rc" && continue
        cat >> "$rc" <<EOF

$marker
export PATH="\$HOME/.local/bin:\$PATH"
eval "\$(mise activate $shell_name)"
# <<< metadata setup <<<
EOF
        echo "  added mise activation to $rc"
    done
}

report() {
    if ((${#FAILED[@]})); then
        echo -e "\n\033[1;33m${#FAILED[@]} step(s) needed attention:\033[0m"
        printf '  - %s\n' "${FAILED[@]}"
        return 1
    fi
    return 0
}

# ---------------------------------------------------------------------------
# Cross-platform tiers, shared by every setup script: language runtimes and
# dev CLIs (mise), node globals (npm), python CLI tools (uv).
# ---------------------------------------------------------------------------
setup_mise_tiers() {
    say "Runtimes and dev CLIs (mise)"
    # mise replaces nvm + pyenv + sdkman + jenv with versions pinned in mise.txt.
    have mise || curl -fsSL https://mise.run | sh
    export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"
    have mise || { warn "mise install failed — skipping mise/npm/uv tiers"; return 0; }

    inst mise mise use --global --yes
    try mise install --yes

    say "Node global CLIs (npm)"
    corepack enable 2>/dev/null
    inst npm npm install -g

    instone uv uv tool install
}
