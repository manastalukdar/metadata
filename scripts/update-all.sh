#!/usr/bin/env bash
# Universal Update Script
# Updates all development tools and configurations.
#
# Mirrors the tiers in scripts/pkgs/: system packages, flatpak, snap, mise,
# npm, uv, brew. Adding a tool to a pkgs list needs no change here.

set -uo pipefail   # not -e: a single updater that is absent or unhappy must not
                   # abort the rest of the run

FAILED=()
say()  { echo -e "\n\033[1;34m==>\033[0m $*"; }
warn() { echo -e "\033[1;33m[warn]\033[0m $*" >&2; FAILED+=("$*"); }
have() { command -v "$1" >/dev/null 2>&1; }
try()  { "$@" || warn "failed: $*"; }

echo "🔄 Starting comprehensive system update..."

# Detect platform
if [[ "${OSTYPE:-}" == "linux-gnu"* ]]; then
    if have apt; then
        PLATFORM="ubuntu"
    elif have dnf; then
        PLATFORM="fedora"
    else
        PLATFORM="linux"
    fi
elif [[ "${OSTYPE:-}" == "darwin"* ]]; then
    PLATFORM="macos"
elif [[ "${OSTYPE:-}" == "msys" ]] || [[ "${OSTYPE:-}" == "cygwin" ]]; then
    PLATFORM="windows"
else
    PLATFORM="unknown"
fi

echo "🖥️ Detected platform: $PLATFORM"

say "📦 System packages"
case $PLATFORM in
    "ubuntu")
        try sudo apt update
        try sudo apt upgrade -y
        try sudo apt autoremove -y
        ;;
    "fedora")
        try sudo dnf upgrade --refresh -y
        try sudo dnf autoremove -y
        ;;
    "macos")
        ;;   # handled by the Homebrew step below
    "windows")
        echo "⚠️ Windows updates require manual intervention"
        echo "Run: winget upgrade --all"
        ;;
esac

if have flatpak; then
    say "📦 Flatpak apps"
    try flatpak update -y
    try flatpak uninstall --unused -y
fi

if have snap; then
    say "📦 Snap apps"
    try sudo snap refresh
fi

# mise owns node, python, java, go, rust, gradle and friends — it replaces the
# nvm / sdkman / pyenv / jenv updates this script used to do one by one.
if have mise; then
    say "🔧 Runtimes and dev CLIs (mise)"
    try mise self-update -y
    try mise upgrade -y
    try mise prune -y
fi

if have npm; then
    say "🟢 Node global packages"
    try npm update -g
fi

if have uv; then
    say "🐍 Python CLI tools"
    try uv tool upgrade --all
    try uv self update
fi

if have brew; then
    say "🍺 Homebrew"
    try brew update
    try brew upgrade
    try brew cleanup
fi

# vim-plug only; other plugin managers self-update on next launch.
if have nvim && [[ -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]; then
    say "📝 Neovim plugins"
    try nvim +PlugUpdate +qall
fi

for editor in code code-insiders; do
    if have "$editor"; then
        say "🔧 $editor extensions"
        try "$editor" --update-extensions
    fi
done

say "🏥 Health check"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/check-versions.sh" ]]; then
    bash "$SCRIPT_DIR/check-versions.sh"
else
    warn "check-versions.sh not found"
fi

if ((${#FAILED[@]})); then
    echo -e "\n\033[1;33m${#FAILED[@]} step(s) needed attention:\033[0m"
    printf '  - %s\n' "${FAILED[@]}"
else
    echo -e "\n✅ System update completed successfully!"
fi
echo "💡 Consider backing up your configurations: scripts/backup-configs.sh"
