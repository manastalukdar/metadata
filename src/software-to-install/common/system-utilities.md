# System Utilities

File managers and transfer, system monitors and cleaners, disk imaging, screen/webcam capture, launchers, and downloaders.

## Mandatory

- [mise](https://mise.jdx.dev) `manual`
- [Double Commander](https://doublecommander.com) `dnf:doublecmd-gtk` `apt:doublecmd-gtk`
  - Fedora: not in the official repos, add the upstream OBS repo first [[ref](https://software.opensuse.org/download.html?project=home%3AAlexx2000&package=doublecmd-gtk)]:

    ```shell
    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:Alexx2000/Fedora_36/home:Alexx2000.repo
    sudo dnf install doublecmd-gtk
    ```

  - Deliberately **not** tagged for CachyOS. `doublecmd-gtk2` is the only Double Commander package in the AUR (no Qt build, no Flathub build either), and it compiles Pascal — which means pulling `lazarus`, a 1.36 GB Pascal IDE, on every version bump. Krusader below fills the same role from the official repos instead.
- [Krusader](https://krusader.org) `pacman:krusader`
  - The orthodox twin-panel file manager on CachyOS, standing in for Double Commander above. Same Total Commander lineage; in `extra`, so it never builds from source.
  - It is a KDE app, so on a GNOME desktop it pulls KDE Frameworks 6 and Qt6 — about 145 MB across its direct dependencies. That is a one-time permanent cost, traded against re-fetching a 1.36 GB compiler on every Double Commander upgrade.
  - Only tagged for CachyOS: Fedora and Ubuntu keep Double Commander, so nothing changes there.
  - Optional extras it will use if present, most of which this repo already installs: `7zip`, `kdiff3`, `rsync`, `kde-cli-tools` (root mode and file associations).
- FileZilla `dnf:filezilla` `apt:filezilla` `pacman:filezilla`
  - No longer available as a Homebrew cask; download from [filezilla-project.org](https://filezilla-project.org) on macOS.
- Microsoft OneDrive `dnf:onedrive` `apt:onedrive` `aur:onedrive-abraunegg` `cask:onedrive`
  - Preinstalled on Windows; see [windows/packages.md](../windows/packages.md).
  - Microsoft ships no official Linux client; `dnf`/`apt`/the AUR install [abraunegg/onedrive](https://github.com/abraunegg/onedrive), a CLI sync daemon. Setup, multi-account and SharePoint config: [linux/fedora/onedrive.md](../linux/fedora/onedrive.md) (the client is the same, so that guide applies on CachyOS too).
  - The AUR package compiles the D sources, so it needs a D compiler as a build dependency and takes a few minutes to upgrade — see [linux/cachyos/post-install.md](../linux/cachyos/post-install.md#upgrading-the-aur-packages-that-compile).
- [rclone](https://rclone.org) `brew:rclone` `pacman:rclone`
  - Used for Microsoft OneDrive: [rclone OneDrive setup](https://rclone.org/onedrive/), and [linux/fedora/onedrive.md](../linux/fedora/onedrive.md).
- [rsync](https://rsync.samba.org) `native:rsync`
  - Preinstalled on all three platforms, but tagged anyway: macOS ships Apple's fork rather than upstream rsync, and installing the formula puts a current 3.x on `PATH` ahead of it.
  - Complements rclone rather than replacing it — rsync for local and SSH copies, rclone for cloud remotes.
- [Open Video Downloader (youtube-dl-gui)](https://github.com/jely2002/youtube-dl-gui) `manual`
  - The CLI it wraps is in [cli-utilities.md](cli-utilities.md) as `yt-dlp`.

## Optional

### File management & transfer

- [Spacedrive](https://www.spacedrive.com). [Source](https://github.com/spacedriveapp/spacedrive).
- [muCommander](https://www.mucommander.com). Java-based, so one build runs on all three platforms.

### Maintenance & cleanup

- [Bleachbit](https://www.bleachbit.org)
- [Czkawka](https://github.com/qarmin/czkawka)

### Disk & imaging

- <https://etcher.balena.io>

### Capture

- [yawcam](https://yawcam.com)
- [ScreenRec](https://screenrec.com)

### Launchers

- [ueli](https://github.com/oliverschwendener/ueli)

### Misc

- [Virtual Volumes View](http://vvvapp.sourceforge.net/) `manual`
- [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/) `snap:storage-explorer` `cask:microsoft-azure-storage-explorer`
  - Snap-only on Linux. Now that this is Optional, nothing is tagged `snap:`, so the setup scripts no longer install `snapd` at all — moving this back to Mandatory means restoring that bootstrap (each `setup-*.sh` has the commands in a comment where the snap step used to be).
