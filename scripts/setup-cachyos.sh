#!/usr/bin/env bash
# CachyOS (Arch) Development Environment Setup
#
# Run with: bash scripts/setup-cachyos.sh
#
# The package lists live in scripts/pkgs/*.txt — one package per line, '#' for
# comments. To add a tool, add a line to the right list; do not edit this script.
#
#   pacman.txt       OS, drivers, system integration, anything needing root
#   aur.txt          packages only the AUR carries, built by paru
#   flatpak.txt      GUI desktop apps (flathub) — shared with Fedora and Ubuntu
#   mise.txt         language runtimes and dev CLIs (per-user) — shared
#   npm.txt          node global CLIs — shared
#   uv.txt           python CLI tools — shared
#   snap.txt         currently empty; snapd is not installed (see the note below)
#
# Deliberately absent, compared with setup-fedora.sh and setup-ubuntu.sh:
#
#   Third-party repos. Everything Fedora needs a COPR/OBS/Microsoft repo for is
#   an AUR package here, so this script adds no repositories at all.
#   Homebrew. brew-common.txt exists because dnf and apt lack a few CLI tools;
#   Arch has them, so they carry pacman: tags. See linux/cachyos/packages.md.
#   The Nerd Font download. Arch packages ttf-meslo-nerd and ttf-firacode-nerd.
#
# Idempotent: safe to re-run. Every step is a no-op when already satisfied.

set -uo pipefail   # deliberately NOT -e: one unavailable package must not abort
                   # a 300-package install. Failures are collected and reported.

# The helpers and the package lists in pkgs/ are resolved relative to this file,
# so the repository has to be on disk. Without this guard a `curl | bash` attempt
# dies with five confusing "command not found" lines instead of one clear reason.
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib-pkgs.sh" || {
    echo "Could not load lib-pkgs.sh next to this script." >&2
    echo "These scripts need the whole repository (they read scripts/pkgs/*.txt), so:" >&2
    echo "    git clone https://github.com/manastalukdar/metadata.git" >&2
    echo "    cd metadata && bash scripts/setup-cachyos.sh" >&2
    exit 1
}

logtee "$@"   # also write this run to scripts/setup-cachyos.log

# ---------------------------------------------------------------------------
# makepkg — and therefore paru — refuses to run as root, so a `sudo bash
# setup-cachyos.sh` would install the pacman tier and then fail every single AUR
# package. Fail here instead, where the message is still readable.
# ---------------------------------------------------------------------------
if ((EUID == 0)); then
    echo "Run this as your normal user, not root: AUR packages cannot be built" >&2
    echo "as root, and the mise/npm/uv tiers install into \$HOME." >&2
    exit 1
fi
have pacman || { echo "no pacman — this script is for CachyOS/Arch" >&2; exit 1; }

sudo -v || { echo "sudo access is required" >&2; exit 1; }

# ---------------------------------------------------------------------------
say "Mirrors"
# ---------------------------------------------------------------------------
# CachyOS layers its own repos ahead of Arch's, so both lists matter. Guarded by
# `have` so this script also runs on plain Arch, where neither tool is present.
# pacman-conf, not grep on pacman.conf: it resolves Include directives, so it
# still answers correctly if the CachyOS repos move into /etc/pacman.d/.
ON_CACHYOS=0
pacman-conf --repo-list 2>/dev/null | grep -q '^cachyos' && ON_CACHYOS=1

if have cachyos-rate-mirrors; then
    try sudo cachyos-rate-mirrors
else
    echo "  cachyos-rate-mirrors not present — skipping (plain Arch?)"
fi

# ---------------------------------------------------------------------------
say "System packages (pacman)"
# ---------------------------------------------------------------------------
# Refresh the keyrings before the upgrade: on an install that has sat idle for a
# few months, expired signing keys make every later package fail to verify.
#
# This is the one sanctioned `-Sy` without `-u` — the Arch-recommended keyring
# procedure. It is safe only because a keyring package is data files with no
# library dependencies, so it cannot land in the partial-upgrade trap that
# linux/cachyos/post-install.md warns about.
try sudo pacman -Sy --needed --noconfirm archlinux-keyring
((ON_CACHYOS)) && try sudo pacman -S --needed --noconfirm cachyos-keyring

# The one hard failure in this script. Everything below installs packages, and
# installing onto a system whose upgrade did not complete is exactly the partial
# upgrade that breaks an Arch install — better to stop with the system
# consistent than to continue and link new packages against old libraries.
sudo pacman -Syu --noconfirm || {
    echo "" >&2
    echo "System upgrade failed — stopping before installing anything else, so" >&2
    echo "you are not left with a partially-upgraded system. Resolve it with:" >&2
    echo "    sudo pacman -Syu" >&2
    echo "then re-run this script (it is idempotent)." >&2
    exit 1
}

# --needed makes this idempotent: already-current packages are skipped rather
# than reinstalled, which is what keeps a re-run cheap.
inst pacman sudo pacman -S --needed --noconfirm

# ---------------------------------------------------------------------------
say "AUR packages (paru)"
# ---------------------------------------------------------------------------
# CachyOS preinstalls paru. Bootstrap it from the AUR if it is missing so this
# script works on a plain Arch install too — that needs base-devel and git,
# both of which the pacman tier above has just installed.
if ! have paru; then
    say "Bootstrapping paru"
    tmp="$(mktemp -d)"
    if git clone --depth=1 https://aur.archlinux.org/paru-bin.git "$tmp/paru-bin" &&
       (cd "$tmp/paru-bin" && makepkg -si --noconfirm); then
        :
    else
        warn "could not bootstrap paru — skipping the AUR tier"
    fi
    rm -rf "$tmp"
fi

if have paru; then
    # --skipreview: this is an unattended batch install, so there is no one to
    # read the PKGBUILD diffs. Review them on interactive updates instead —
    # see linux/cachyos/post-install.md. --removemake keeps build-only
    # dependencies from accumulating across re-runs.
    inst aur paru -S --needed --noconfirm --skipreview --removemake
else
    warn "paru not found — skipping the AUR tier ($(pkglist aur | wc -l) packages)"
fi

# ---------------------------------------------------------------------------
say "Desktop apps (flatpak)"
# ---------------------------------------------------------------------------
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
inst flatpak flatpak install -y --noninteractive flathub

# Nothing is tagged `snap:` any more, so snapd is not installed and no daemon or
# /snap symlink is set up. To bring the tier back: add a `snap:` tag in the docs,
# put snapd in pkgs/aur.extra.txt (snapd is AUR-only on Arch), and restore:
#
#   sudo systemctl enable --now snapd.socket
#   sudo ln -sf /var/lib/snapd/snap /snap
#   sudo snap wait system seed.loaded && inst snap sudo snap install --classic

# ---------------------------------------------------------------------------
setup_mise_tiers
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
say "Fonts"
# ---------------------------------------------------------------------------
# The Nerd Fonts came from pacman (ttf-meslo-nerd, ttf-firacode-nerd), so there
# is nothing to download — just refresh the cache so they are visible now.
fc-cache -f >/dev/null

# ---------------------------------------------------------------------------
say "Shell"
# ---------------------------------------------------------------------------
[[ -d "$HOME/.oh-my-zsh" ]] || \
    RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
[[ "${SHELL:-}" == *zsh ]] || try chsh -s "$(command -v zsh)"

ensure_shell_init

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
report; rc=$?

cat <<'NOTES'

Next steps (not scripted — they need your credentials or a reboot):
  - Restart your shell, then run: bash scripts/check-versions.sh
  - GitHub SSH key + auth: see src/software-to-install/linux/fedora/packages.md
  - Restore dotfiles/configs:  bash scripts/restore-configs.sh <backup-dir>
      (backups live in ~/config-backups/, newest last: ls -d ~/config-backups/*)
  - Graphics drivers:  sudo chwd -a    (then reboot)
      Details and the NVIDIA hybrid-laptop cases:
      src/software-to-install/linux/cachyos/post-install.md
  - OneDrive: the AUR package is abraunegg's client, the same one Fedora uses,
      so src/software-to-install/linux/fedora/onedrive.md applies as written.
  - Battery (TLP conflicts with power-profiles-daemon, so it is opt-in):
      sudo pacman -S tlp tlp-rdw
      sudo systemctl disable --now power-profiles-daemon
      sudo systemctl enable --now tlp

One Mandatory tool has no Arch or AUR package: q (harelba/q). RBQL, installed
from the uv tier, covers the same SQL-over-CSV job.
NOTES

manual_notes linux

exit "$rc"
