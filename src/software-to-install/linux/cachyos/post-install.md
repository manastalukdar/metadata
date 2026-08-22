# CachyOS — Post-install Configuration

See also: [packages](packages.md), [Linux common](../common.md).

Much of what the Fedora and Ubuntu guides cover (extra repositories, codec groups, driver repos) has no CachyOS equivalent, because the Arch repos and the AUR already carry it. What follows is what genuinely does need doing.

## Mirrors

CachyOS layers its own repositories ahead of Arch's, and a slow mirror for either shows up as a slow `-Syu`. Both are re-ranked with the tools that ship on the ISO:

```shell
sudo cachyos-rate-mirrors          # ranks the CachyOS mirrors
sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist   # Arch mirrors
```

`setup-cachyos.sh` runs `cachyos-rate-mirrors` when it is present and skips it otherwise, so the script also works on plain Arch.

## Configure pacman for faster downloads and nicer output

`sudo nano /etc/pacman.conf`, then in the `[options]` section:

```plaintext
ParallelDownloads = 10
Color
ILoveCandy
VerbosePkgLists
```

CachyOS already sets `ParallelDownloads` and `Color` on a fresh install — check before adding duplicates, since pacman takes the *last* occurrence of a key.

## Add Flathub Repository

Flatpak is installed by the setup script (it is in [`pkgs/pacman.extra.txt`](../../../../scripts/pkgs/pacman.extra.txt)), but the remote is separate:

```shell
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## AUR packages, and what that costs

`paru` builds AUR packages from source on your machine, using a `PKGBUILD` that any AUR user can update. Two habits worth keeping:

- **Read the diff.** `paru` shows the `PKGBUILD` diff before building on updates; do not reflexively accept it. This is the one tier in this repository where the package contents are not signed by a distribution.
- **Never build as root.** `paru`/`makepkg` refuse to run as root, so `setup-cachyos.sh` exits early if invoked with `sudo` rather than letting it fail 200 packages in.

Most of the 14 entries in [`pkgs/aur.txt`](../../../../scripts/pkgs/aur.txt) are `-bin` packages — prebuilt vendor binaries repackaged — which install in seconds. Two genuinely compile, and those are the ones that make an upgrade expensive. See the next section.

## Upgrading the AUR packages that compile

For an AUR package, *upgrading is rebuilding*. `paru -Syu` (which [`update-all.sh`](../../../../scripts/update-all.sh) runs) picks up new versions automatically, but you pay the build cost each time upstream cuts a release. Two entries in `aur.txt` are affected:

| Package | Toolchain it pulls in | Rough cost |
| --- | --- | --- |
| `rancher-desktop` | `npm`, `nodejs`, `nvm`, `go` | 10–30 min, mostly npm downloads |
| `onedrive-abraunegg` | `d-compiler` | a few minutes |

The rest either repackage a vendor archive or need only `imagemagick` for icon resizing (`vivaldi-snapshot`, `microsoft-edge-dev-bin`), `sassc`/`gettext` (`gnome-shell-extension-dash-to-dock`) or `python-setuptools` (`ulauncher`) — all effectively instant.

A third used to be here: `doublecmd-gtk2` compiled Pascal and pulled `lazarus`, a 1.36 GB IDE, on every bump. CachyOS uses [Krusader](https://krusader.org) from `extra` instead — same orthodox twin-panel design, no build. See [../../common/system-utilities.md](../../common/system-utilities.md) for the reasoning; Fedora and Ubuntu still get Double Commander.

Four ways to handle the rebuild cost, in the order worth considering:

1. **Let `paru -Syu` do it.** Fine if you update on a schedule you do not sit and watch. Nothing to configure.
2. **Hold it back and upgrade deliberately.** `paru` honours pacman's `IgnorePkg`, so adding this to `/etc/pacman.conf` takes it off the automatic path and prints a "skipping" notice instead:

    ```ini
    IgnorePkg = rancher-desktop
    ```

    Then rebuild when it suits you: `paru -S rancher-desktop`. This is the recommended option for Rancher Desktop specifically — a container GUI does not need same-day patches.

3. **Use the AppImage instead of the package** for Rancher Desktop. It self-updates, never rebuilds, and is upstream's own binary — see [../../common/containers-virtualization.md](../../common/containers-virtualization.md) for the URL. Best choice if you want to *run* it rather than have the package manager own it.
4. **`rancher-desktop-bin` exists** in the AUR and skips the compile entirely. It was considered and rejected for the `aur:` tag: at the time of writing it trailed the source package by a release (1.23.1 vs 1.24.0) with 1 vote against 10, so it trades build time for a laggier and less-watched package. Switch to it knowingly, not by default.

Two things that apply regardless of which you pick:

- **Build-time toolchains linger.** `setup-cachyos.sh` passes `--removemake`, so the first run cleans up `npm`/`go`/`lazarus`/`d-compiler` afterwards. A later plain `paru -Syu` does not, so those toolchains stay installed once you have upgraded through them. Run `paru -Sc` or `pacman -Qtdq | sudo pacman -Rns -` to reclaim the space.
- **They coexist with mise, they do not conflict.** `rancher-desktop` makedepends on the *pacman* `nodejs`/`npm`/`go` packages while [`mise.txt`](../../../../scripts/pkgs/mise.txt) manages your own Node and Go. Both install; mise's shims come first in `PATH`, so your shell still gets the mise versions. This is why a Rancher Desktop rebuild pulls in a Go toolchain you never asked for.

## Multimedia codecs

No group upgrade and no third-party repository — the `gst-plugins-*` and `gst-libav` packages in [`pkgs/pacman.extra.txt`](../../../../scripts/pkgs/pacman.extra.txt) are the whole story. `ffmpeg` in `extra` is built with the non-free encoders enabled, so there is no RPM-Fusion-style split to work around.

## Graphics drivers

Use CachyOS's hardware detection rather than installing driver packages by hand — this is the equivalent of Fedora's [nvidia.md](../fedora/nvidia.md), and it is one command:

```shell
sudo chwd -a          # autodetect and install the right driver
chwd -l               # list what it would pick
```

For NVIDIA specifically, `chwd` picks between the proprietary and open-kernel-module flavours based on your card's generation. Reboot afterwards. If you are on a hybrid laptop, `cachyos-kernel-manager` and the [CachyOS wiki NVIDIA page](https://wiki.cachyos.org/configuration/nvidia_setup/) cover the Optimus cases.

Deliberately not scripted: it installs kernel modules and needs a reboot.

## Kernel flavours

CachyOS's whole premise is the patched kernel, and it ships several schedulers. `cachyos-kernel-manager` (GUI) or `pacman -S linux-cachyos-bore` etc. switch between them. Keep the stock `linux-cachyos` installed as a fallback boot entry before trying an RT or LTO variant.

## Changing Hostname

`sudo hostnamectl set-hostname "new-name"`

## Gnome Tweaks and Gnome Extensions

Applies as written in the [Fedora guide](../fedora/post-install.md#gnome-tweaks-and-gnome-extensions), with two substitutions:

- The Extensions app is `extension-manager` from `extra` (Arch has no `gnome-extensions-app` package; the built-in Extensions app lives inside `gnome-shell`).
- Individual extensions are packaged in the AUR as `gnome-shell-extension-*`, which survives a `-Syu` better than installing them from [extensions.gnome.org](https://extensions.gnome.org) does. Check the extension supports your GNOME version before a major upgrade — Arch moves GNOME faster than Fedora does.

## Reduce Battery Usage

Same TLP-versus-`power-profiles-daemon` conflict as Fedora, same resolution:

```shell
sudo pacman -S tlp tlp-rdw
sudo systemctl disable --now power-profiles-daemon
sudo systemctl enable --now tlp
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
```

Left opt-in rather than scripted, because it disables a service the desktop's power menu talks to.

## Rancher Desktop: privileged ports for Traefik

Identical to Fedora — see [that section](../fedora/post-install.md#rancher-desktop-privileged-ports-for-traefik). The sysctl and the `/dev/kvm` permission check are not distro-specific.

## Fractional scaling

`gsettings set org.gnome.desktop.interface text-scaling-factor 1.5`

## Package maintenance

- Update everything, repos and AUR together: `paru -Syu`
- Repos only: `sudo pacman -Syu`
- Remove orphans: `pacman -Qtdq | sudo pacman -Rns -` (no-ops cleanly when there are none)
- Clear the package cache: `paccache -r` keeps the last 3 versions; `sudo pacman -Sc` is the blunt version
- Flatpaks: `flatpak update && flatpak uninstall --unused`
- [`scripts/update-all.sh`](../../../../scripts/update-all.sh) does all of the above plus the mise/npm/uv tiers

**Never `pacman -Sy` without `u`.** A partial upgrade — refreshing the package databases without upgrading — is the one reliable way to break an Arch install, because a newly-downloaded package will link against libraries your system has not upgraded to yet.

## Troubleshooting and Known Issues

The hardware and desktop notes in the [Fedora troubleshooting section](../fedora/post-install.md#troubleshooting-and-known-issues) (external monitors over USB-C, MS Teams screen sharing, wake-from-suspend, multiple GitHub accounts) are about GNOME, Wayland and vendor apps rather than about Fedora, so they apply here unchanged.

CachyOS-specific:

- **Keyring failures on a long-idle install.** `sudo pacman -Sy archlinux-keyring cachyos-keyring` before the full upgrade if signature checks start failing.
- **An AUR package stops building** after a system library bumps its soname. Usually fixed by rebuilding it (`paru -S --rebuild <pkg>`); if not, the AUR comments page for the package is where the fix appears first.
- **`x86-64-v3` requirement.** The CachyOS repos target newer CPUs than baseline `x86-64`. On an older machine the installer falls back to the generic repos; if you cloned an install onto old hardware, verify with `/usr/lib/ld-linux-x86-64.so.2 --help | grep supported`.
