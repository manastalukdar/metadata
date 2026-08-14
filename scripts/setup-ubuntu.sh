#!/usr/bin/env bash
# Ubuntu Development Environment Setup
#
# Run with: bash scripts/setup-ubuntu.sh
#
# The package lists live in scripts/pkgs/*.txt — one package per line, '#' for
# comments. To add a tool, add a line to the right list; do not edit this script.
#
#   apt.txt          OS, drivers, system integration, anything needing root
#   flatpak.txt      GUI desktop apps (flathub) — shared with Fedora
#   mise.txt         language runtimes and dev CLIs (per-user) — shared
#   npm.txt          node global CLIs — shared
#   uv.txt           python CLI tools — shared
#   brew-common.txt  CLI tools apt and mise do not carry — shared
#   snap.txt         currently empty; snapd is not installed (see the note below)
#
# Idempotent: safe to re-run. Every step is a no-op when already satisfied.

set -uo pipefail   # deliberately NOT -e: one unavailable package must not abort
                   # a 300-package install. Failures are collected and reported.

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib-pkgs.sh"

echo "🚀 Starting Ubuntu development environment setup..."

KEYRINGS=/etc/apt/keyrings
sudo install -d -m 0755 "$KEYRINGS"

# aptrepo <name> <key-url> <"deb ... " line, with KEY substituted for the keyring>
aptrepo() {
    local name="$1" keyurl="$2" line="$3"
    if [[ ! -f "$KEYRINGS/$name.gpg" ]]; then
        curl -fsSL "$keyurl" | sudo gpg --dearmor -o "$KEYRINGS/$name.gpg" \
            || { warn "could not fetch signing key for $name"; return 0; }
        sudo chmod 0644 "$KEYRINGS/$name.gpg"
    fi
    echo "${line//KEY/$KEYRINGS/$name.gpg}" \
        | sudo tee "/etc/apt/sources.list.d/$name.list" >/dev/null
}

# ---------------------------------------------------------------------------
say "Third-party repositories"
# ---------------------------------------------------------------------------
ARCH="$(dpkg --print-architecture)"
CODENAME="$(lsb_release -cs)"
RELEASE="$(lsb_release -rs)"

sudo apt-get update
sudo apt-get install -y curl wget gnupg ca-certificates \
    apt-transport-https software-properties-common lsb-release

# Microsoft prod repo: powershell and the current .NET SDKs. Shipped as a deb
# that installs the repo definition and key for us.
if [[ ! -f /etc/apt/sources.list.d/microsoft-prod.list ]]; then
    tmp="$(mktemp -d)"
    if curl -fsSL -o "$tmp/ms-prod.deb" \
        "https://packages.microsoft.com/config/ubuntu/$RELEASE/packages-microsoft-prod.deb"; then
        sudo dpkg -i "$tmp/ms-prod.deb" || warn "microsoft-prod repo install failed"
    else
        warn "no Microsoft prod repo published for Ubuntu $RELEASE"
    fi
    rm -rf "$tmp"
fi

aptrepo vscode https://packages.microsoft.com/keys/microsoft.asc \
    "deb [arch=$ARCH signed-by=KEY] https://packages.microsoft.com/repos/code stable main"
aptrepo microsoft-edge https://packages.microsoft.com/keys/microsoft.asc \
    "deb [arch=$ARCH signed-by=KEY] https://packages.microsoft.com/repos/edge stable main"
aptrepo sublime https://download.sublimetext.com/sublimehq-pub.gpg \
    "deb [signed-by=KEY] https://download.sublimetext.com/ apt/stable/"
aptrepo vivaldi https://repo.vivaldi.com/archive/linux_signing_key.pub \
    "deb [arch=$ARCH signed-by=KEY] https://repo.vivaldi.com/archive/deb/ stable main"
aptrepo google-chrome https://dl.google.com/linux/linux_signing_key.pub \
    "deb [arch=$ARCH signed-by=KEY] https://dl.google.com/linux/chrome/deb/ stable main"
# Rancher Desktop, from the openSUSE Build Service. The trailing "./" is the
# flat-repository form OBS publishes; it is not a typo.
aptrepo isv-rancher-stable \
    https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/Release.key \
    "deb [signed-by=KEY] https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/ ./"

# Ulauncher is only published as a PPA.
if ! grep -rq ulauncher /etc/apt/sources.list.d/ 2>/dev/null; then
    try sudo add-apt-repository -y ppa:agornostal/ulauncher
fi

# ---------------------------------------------------------------------------
say "System packages (apt)"
# ---------------------------------------------------------------------------
sudo apt-get update
try sudo apt-get upgrade -y
inst apt sudo apt-get install -y
try sudo apt-get autoremove -y

# ---------------------------------------------------------------------------
say "Desktop apps (flatpak)"
# ---------------------------------------------------------------------------
sudo apt-get install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
inst flatpak flatpak install -y --noninteractive flathub

# Nothing is tagged `snap:` any more, so snapd is not installed. To bring the
# tier back: add a `snap:` tag in the docs, put snapd back in
# pkgs/apt.extra.txt, and restore the bootstrap:
#
#   sudo snap wait system seed.loaded && inst snap sudo snap install --classic

# ---------------------------------------------------------------------------
setup_mise_tiers
# ---------------------------------------------------------------------------

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
    inst brew-common brew install
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
    compgen -G "$FONTDIR/$font*" >/dev/null && continue
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
[[ "${SHELL:-}" == *zsh ]] || try chsh -s "$(command -v zsh)"

# Redshift needs your coordinates; only write a config if there is none.
if [[ ! -f "$HOME/.config/redshift.conf" ]]; then
    mkdir -p "$HOME/.config"
    cat > "$HOME/.config/redshift.conf" <<'EOF'
[redshift]
temp-day=6500
temp-night=4500
location-provider=manual

[manual]
; Edit these to your own latitude/longitude.
lat=40.7
lon=-74.0
EOF
    echo "wrote ~/.config/redshift.conf — set lat/lon to your location"
fi

# ---------------------------------------------------------------------------
say "Done"
# ---------------------------------------------------------------------------
report

cat <<'NOTES'

Next steps (not scripted — they need your credentials or a reboot):
  - Restart your shell, then run: bash scripts/check-versions.sh
  - GitHub SSH key + auth: see src/software-to-install/linux/fedora/packages.md
  - Restore dotfiles/configs:  bash scripts/restore-configs.sh

Fedora-only packages (Moosync, Lite XL) have no Ubuntu equivalent — build from
source or fetch a .deb from upstream releases if you want them.
NOTES

manual_notes
