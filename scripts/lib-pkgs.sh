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

# Print the tools that no package manager on this platform can install. The list
# is generated from `manual` tags in the docs by scripts/gen-pkgs.sh.
manual_notes() {
    local list="$PKGS/manual.txt"
    [[ -f "$list" ]] || return 0
    say "Not installable by any package manager — install these by hand"
    awk '{sub(/#.*/, "")} NF { print "  - " $0 }' "$list"
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
