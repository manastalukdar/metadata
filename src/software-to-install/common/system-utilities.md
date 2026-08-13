# System Utilities

File managers and transfer, system monitors and cleaners, disk imaging, screen/webcam capture, launchers, and downloaders.

## Mandatory

- FileZilla `dnf:filezilla` `apt:filezilla`
  - No longer available as a Homebrew cask; download from [filezilla-project.org](https://filezilla-project.org) on macOS.
- [rclone](https://rclone.org) `brew:rclone`
  - Used for Microsoft OneDrive; see [linux/fedora/onedrive.md](../linux/fedora/onedrive.md).
- [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/) `snap:storage-explorer` `cask:microsoft-azure-storage-explorer`
  - Snap-only on Linux — the sole reason `snapd` is still installed.
- [Virtual Volumes View](http://vvvapp.sourceforge.net/) `manual`
- [Open Video Downloader (youtube-dl-gui)](https://github.com/jely2002/youtube-dl-gui) `manual`
  - The CLI it wraps is in [cli-utilities.md](cli-utilities.md) as `yt-dlp`.

## Optional

### File management & transfer

- [Spacedrive](https://www.spacedrive.com). [Source](https://github.com/spacedriveapp/spacedrive).

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
