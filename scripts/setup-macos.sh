#!/usr/bin/env bash
# macOS Development Environment Setup
#
# Run with: bash scripts/setup-macos.sh
#
# The package lists live in scripts/pkgs/*.txt — one package per line, '#' for
# comments. To add a tool, add a line to the right list; do not edit this script.
#
#   brew-cask.txt    GUI apps (the macOS equivalent of flatpak.txt)
#   brew-macos.txt   CLI formulae that Linux gets from dnf/apt
#   brew-common.txt  CLI tools shared with Linux
#   mise.txt         language runtimes and dev CLIs (per-user) — shared
#   npm.txt          node global CLIs — shared
#   uv.txt           python CLI tools — shared
#
# Idempotent: safe to re-run. Every step is a no-op when already satisfied.

set -uo pipefail   # deliberately NOT -e: one unavailable cask must not abort a
                   # 100-package install. Failures are collected and reported.

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib-pkgs.sh"

echo "🚀 Starting macOS development environment setup..."

# ---------------------------------------------------------------------------
say "Xcode Command Line Tools"
# ---------------------------------------------------------------------------
# Homebrew needs these, and the install is a GUI prompt on a fresh machine.
xcode-select -p >/dev/null 2>&1 || {
    xcode-select --install
    echo "Finish the Xcode Command Line Tools install, then re-run this script."
    exit 1
}

# ---------------------------------------------------------------------------
say "Homebrew"
# ---------------------------------------------------------------------------
if ! have brew; then
    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Apple silicon installs to /opt/homebrew, Intel to /usr/local.
for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$candidate" ]] && { eval "$("$candidate" shellenv)"; break; }
done
have brew || { warn "brew not found — cannot continue"; report; exit 1; }
try brew update

# ---------------------------------------------------------------------------
say "CLI tools (brew)"
# ---------------------------------------------------------------------------
inst brew-macos  brew install
inst brew-common brew install

# ---------------------------------------------------------------------------
say "Applications (brew --cask)"
# ---------------------------------------------------------------------------
inst brew-cask brew install --cask

# ---------------------------------------------------------------------------
setup_mise_tiers
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
say "Shell"
# ---------------------------------------------------------------------------
# macOS already defaults to zsh; only oh-my-zsh is missing.
[[ -d "$HOME/.oh-my-zsh" ]] || \
    RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# git needs an absolute path to the kdiff3 bundled inside the .app.
if [[ -x /Applications/kdiff3.app/Contents/MacOS/kdiff3 ]]; then
    git config --global mergetool.kdiff3.path \
        /Applications/kdiff3.app/Contents/MacOS/kdiff3
fi

# ---------------------------------------------------------------------------
say "Done"
# ---------------------------------------------------------------------------
report

cat <<'NOTES'

Next steps (not scripted — they need your credentials or a restart):
  - Restart your shell, then run: bash scripts/check-versions.sh
  - GitHub SSH key + auth: see src/software-to-install/linux/fedora/packages.md
  - Restore dotfiles/configs:  bash scripts/restore-configs.sh

FileZilla was removed from Homebrew; download it from filezilla-project.org.
NOTES

manual_notes
