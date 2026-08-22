# CachyOS — Packages

CachyOS-specific software and native `pacman`/AUR install recipes. Cross-platform tools live under [../../common/](../../common/), and Linux-only-but-any-distro tools under [../common.md](../common.md). For system setup (mirrors, Flathub, codecs, drivers) see [post-install.md](post-install.md).

CachyOS is Arch Linux with its own optimized (`x86-64-v3`/`v4`) repositories layered ahead of `core`/`extra`, so anything in the Arch repos or the AUR installs unchanged. Two consequences for this repository:

- **Almost no third-party repo setup.** The COPR, OBS and Microsoft repos that [setup-fedora.sh](../../../../scripts/setup-fedora.sh) and [setup-ubuntu.sh](../../../../scripts/setup-ubuntu.sh) spend most of their length adding are all replaced by AUR packages. `setup-cachyos.sh` adds no repositories at all.
- **No Homebrew.** `brew-common.txt` exists because dnf and apt lack a handful of CLI tools. Arch does not, so those tools carry `pacman:` tags and CachyOS skips the brew tier. The one casualty is [q](https://github.com/harelba/q), which has no Arch or AUR package — see [../../common/cli-utilities.md](../../common/cli-utilities.md).

## Mandatory

### Multimedia

- [Moosync](https://github.com/Moosync/Moosync) `aur:moosync-bin`

    ```shell
    paru -S moosync-bin
    ```

### Editors

- [MikTex](https://miktex.org/download)

    Only needed if you want MikTeX specifically; the `pacman:texlive-*` collections tagged in [../../common/writing-publishing.md](../../common/writing-publishing.md) are what the setup script installs.

    ```shell
    paru -S miktex
    ```

### Git Related

- GitHub SSH Access

    Identical to the Fedora recipe — see [../fedora/packages.md](../fedora/packages.md#git-related). Nothing in it is distro-specific.

### Office Utilities

- Document processing: install LibreOffice from Flathub (tagged in [../../common/productivity-notes.md](../../common/productivity-notes.md)); unlike Fedora, CachyOS does not ship an office suite by default on every edition.

## Optional

- [CachyOS Kernel Manager](https://wiki.cachyos.org/features/kernel_manager/) — GUI for switching between CachyOS's kernel flavours (BORE, EEVDF, RT). Preinstalled on the desktop editions.
- [cachyos-gaming-meta](https://wiki.cachyos.org/configuration/gaming/) — Steam, Proton, Wine, MangoHud and friends in one meta-package. Not installed by the setup script; it is a large, opinionated bundle.
- `pacman -S paru-git` — the AUR helper CachyOS preinstalls is `paru`. `setup-cachyos.sh` bootstraps it from source if it is somehow missing, so a plain Arch install works too.
