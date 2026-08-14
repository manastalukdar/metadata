# System Utilities

File managers and transfer, system monitors and cleaners, disk imaging, screen/webcam capture, launchers, and downloaders.

## Mandatory

- FileZilla `dnf:filezilla` `apt:filezilla`
  - No longer available as a Homebrew cask; download from [filezilla-project.org](https://filezilla-project.org) on macOS.
- [rclone](https://rclone.org) `brew:rclone`
  - Used for Microsoft OneDrive; see [linux/fedora/onedrive.md](../linux/fedora/onedrive.md).
- [rsync](https://rsync.samba.org) `native:rsync`
  - Preinstalled on all three platforms, but tagged anyway: macOS ships Apple's fork rather than upstream rsync, and installing the formula puts a current 3.x on `PATH` ahead of it.
  - Complements rclone rather than replacing it — rsync for local and SSH copies, rclone for cloud remotes.
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

### Misc

- [Virtual Volumes View](http://vvvapp.sourceforge.net/) `manual`
- [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/) `snap:storage-explorer` `cask:microsoft-azure-storage-explorer`
  - Snap-only on Linux. Now that this is Optional, nothing is tagged `snap:`, so the setup scripts no longer install `snapd` at all — moving this back to Mandatory means restoring that bootstrap (each `setup-*.sh` has the commands in a comment where the snap step used to be).
