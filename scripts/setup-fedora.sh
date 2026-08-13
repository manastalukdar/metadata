#!/usr/bin/env bash
# Fedora Development Environment Setup
#
# Run with: bash scripts/setup-fedora.sh
#
# The package lists live in scripts/pkgs/*.txt — one package per line, '#' for
# comments. To add a tool, add a line to the right list; do not edit this script.
#
#   dnf.txt      OS, drivers, system integration, anything needing root/systemd
#   flatpak.txt  GUI desktop apps (flathub)
#   mise.txt     language runtimes and version-pinned dev CLIs (per-user)
#   npm.txt      node global CLIs (installed against the mise-managed node)
#   uv.txt       python CLI tools (each in its own isolated venv)
#   brew.txt     escape hatch for CLI tools none of the above carry
#   snap.txt     last resort, for apps that exist nowhere else
#
# Idempotent: safe to re-run. Every step is a no-op when already satisfied.

set -uo pipefail   # deliberately NOT -e: one unavailable package must not abort
                   # a 300-package install. Failures are collected and reported.

PKGS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/pkgs"
FAILED=()

say()  { echo -e "\n\033[1;34m==>\033[0m $*"; }
warn() { echo -e "\033[1;33m[warn]\033[0m $*" >&2; FAILED+=("$*"); }
have() { command -v "$1" >/dev/null 2>&1; }

# inst <list-name> <install-command...>
# Reads pkgs/<list-name>.txt, strips comments and blanks, installs in one batch.
# If the batch fails, retries one package at a time so a single bad or
# release-renamed package name cannot take the rest of the list down with it.
inst() {
    local name="$1"; shift
    local file="$PKGS/$name.txt" pkgs
    [[ -f "$file" ]] || { warn "missing list: $file"; return 0; }
    pkgs="$(awk '{sub(/#.*/, "")} NF' "$file")"
    [[ -n "$pkgs" ]] || return 0
    say "$name: installing $(wc -l <<<"$pkgs") entries"
    if ! xargs -r "$@" <<<"$pkgs"; then
        warn "$name: batch failed, retrying individually"
        xargs -r -n1 "$@" <<<"$pkgs" || warn "$name: some entries failed (see above)"
    fi
}

# ---------------------------------------------------------------------------
# dnf4 / dnf5 compatibility. Fedora 41+ ships dnf5, which renamed both the
# skip-broken flag and the whole config-manager subcommand syntax.
# ---------------------------------------------------------------------------
SKIP=--skip-unavailable
dnf install --help 2>/dev/null | grep -q -- --skip-unavailable || SKIP=--setopt=strict=0

addrepo() {   # addrepo <url-of-a-.repo-file>
    if dnf config-manager --help 2>/dev/null | grep -q addrepo; then
        sudo dnf -y config-manager addrepo --from-repofile="$1"
    else
        sudo dnf -y config-manager --add-repo "$1"
    fi
    # A second run reports "already exists" — that is success, not failure.
    return 0
}

enablerepo() {   # enablerepo <repo-id>
    if dnf config-manager --help 2>/dev/null | grep -q setopt; then
        sudo dnf -y config-manager setopt "$1.enabled=1"
    else
        sudo dnf -y config-manager --set-enabled "$1"
    fi
}

msrepo() {   # msrepo <id> <baseurl>
    sudo tee "/etc/yum.repos.d/$1.repo" >/dev/null <<EOF
[$1]
name=$1
baseurl=$2
enabled=1
autorefresh=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
}

# ---------------------------------------------------------------------------
say "Third-party repositories"
# ---------------------------------------------------------------------------
sudo dnf -y install "dnf-command(config-manager)" dnf-plugins-core 2>/dev/null

# RPM Fusion — required for vlc, ffmpeg and the multimedia codecs.
sudo dnf -y install \
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
msrepo vscode            https://packages.microsoft.com/yumrepos/vscode
msrepo microsoft-edge-dev https://packages.microsoft.com/yumrepos/edge
msrepo microsoft-prod    https://packages.microsoft.com/rhel/9/prod/   # powershell

sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
addrepo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
addrepo https://repo.vivaldi.com/archive/vivaldi-fedora.repo

# Google Chrome ships in Fedora's own third-party repo definitions.
sudo dnf -y install fedora-workstation-repositories && enablerepo google-chrome

sudo dnf -y copr enable ovenoboyo/Moosync
sudo dnf -y copr enable sentry/lite            # lite-xl

# Double Commander's OBS repo is not published for every Fedora release. If this
# 404s, doublecmd-gtk is simply skipped by the install step below.
addrepo "https://download.opensuse.org/repositories/home:Alexx2000/Fedora_$(rpm -E %fedora)/home:Alexx2000.repo" \
    || warn "Double Commander repo unavailable for Fedora $(rpm -E %fedora)"

# ---------------------------------------------------------------------------
say "System packages (dnf)"
# ---------------------------------------------------------------------------
sudo dnf -y upgrade --refresh
sudo dnf -y group install "Development Tools" "C Development Tools and Libraries"
inst dnf sudo dnf install -y "$SKIP"

say "Multimedia codecs"
sudo dnf -y group upgrade --with-optional Multimedia
sudo dnf -y install "$SKIP" \
    gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav

# ---------------------------------------------------------------------------
say "Desktop apps (flatpak)"
# ---------------------------------------------------------------------------
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
inst flatpak flatpak install -y --noninteractive flathub

# ---------------------------------------------------------------------------
say "Snap (only for apps available nowhere else)"
# ---------------------------------------------------------------------------
sudo systemctl enable --now snapd.socket
sudo ln -sf /var/lib/snapd/snap /snap
# snapd needs a moment before its seeding completes and installs will work.
sudo snap wait system seed.loaded && inst snap sudo snap install --classic

# ---------------------------------------------------------------------------
say "Runtimes and dev CLIs (mise)"
# ---------------------------------------------------------------------------
# mise replaces nvm + pyenv + sdkman + jenv: one tool, versions pinned in
# pkgs/mise.txt, no shell-init soup.
have mise || curl -fsSL https://mise.run | sh
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"
have mise || { warn "mise install failed — skipping mise/npm/uv tiers"; MISE_DEAD=1; }

if [[ -z "${MISE_DEAD:-}" ]]; then
    inst mise mise use --global --yes
    mise install --yes

    say "Node global CLIs (npm)"
    corepack enable 2>/dev/null
    inst npm npm install -g

    say "Python CLI tools (uv)"
    # uv tool install takes one package at a time, each in its own venv.
    xargs -r -n1 uv tool install < <(awk '{sub(/#.*/, "")} NF' "$PKGS/uv.txt") \
        || warn "some uv tools failed"
fi

# ---------------------------------------------------------------------------
say "Homebrew (escape hatch)"
# ---------------------------------------------------------------------------
if ! have brew; then
    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
BREW=/home/linuxbrew/.linuxbrew/bin/brew
if [[ -x "$BREW" ]]; then
    eval "$("$BREW" shellenv)"
    inst brew brew install
else
    warn "brew not found — skipping brew tier"
fi

# ---------------------------------------------------------------------------
say "Nerd Fonts"
# ---------------------------------------------------------------------------
# Not packaged anywhere, so fetch the two the configs actually reference.
FONTDIR="$HOME/.local/share/fonts"
mkdir -p "$FONTDIR"
for font in Meslo FiraCode; do
    if compgen -G "$FONTDIR/$font*" >/dev/null; then continue; fi
    tmp="$(mktemp -d)"
    if curl -fsSL -o "$tmp/$font.zip" \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip"; then
        unzip -qo "$tmp/$font.zip" -d "$FONTDIR/$font" -x '*.txt' '*.md'
    else
        warn "could not download $font Nerd Font"
    fi
    rm -rf "$tmp"
done
fc-cache -f >/dev/null

# ---------------------------------------------------------------------------
say "Shell"
# ---------------------------------------------------------------------------
[[ -d "$HOME/.oh-my-zsh" ]] || \
    RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
[[ "$SHELL" == *zsh ]] || chsh -s "$(command -v zsh)"

# ---------------------------------------------------------------------------
say "Done"
# ---------------------------------------------------------------------------
if ((${#FAILED[@]})); then
    echo -e "\n\033[1;33m${#FAILED[@]} step(s) needed attention:\033[0m"
    printf '  - %s\n' "${FAILED[@]}"
fi

cat <<'NOTES'

Next steps (not scripted — they need your credentials or a reboot):
  - Restart your shell, then run: bash scripts/check-versions.sh
  - GitHub SSH key + auth: see src/software-to-install/linux/fedora/packages.md
  - Restore dotfiles/configs:  bash scripts/restore-configs.sh
  - OneDrive:                  src/software-to-install/linux/fedora/onedrive.md
  - NVIDIA drivers:            src/software-to-install/linux/fedora/nvidia.md
  - Battery (TLP conflicts with power-profiles-daemon, so it is opt-in):
      sudo dnf install tlp tlp-rdw && sudo dnf remove power-profiles-daemon
      sudo systemctl enable tlp

Not available from any package manager — install by hand:
  DaVinci Resolve, Cursor, Notion (use the PWA), Outlook (use the PWA),
  MuCommander, Azure Storage Explorer (snap, handled above).
NOTES
