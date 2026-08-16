# Fedora — Packages

Fedora-specific software and native `dnf`/`copr`/`snap` install recipes. Cross-platform tools live under [../../common/](../../common/). For system setup (RPM Fusion, Flathub, codecs, etc.) see [post-install.md](post-install.md); for NVIDIA and OneDrive see [nvidia.md](nvidia.md) and [onedrive.md](onedrive.md).

## Mandatory

### Multimedia

- [Moosync](https://github.com/Moosync/Moosync) `dnf:moosync`

    ```shell
    dnf copr enable ovenoboyo/Moosync
    dnf install moosync
    ```

### Editors

- [MikTex](https://miktex.org/download)

    ```shell
    sudo rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xD6BC243565B2087BC3F897C9277A7293F59E4889"
    sudo curl -L -o /etc/yum.repos.d/miktex.repo https://miktex.org/download/fedora/35/miktex.repo
    sudo dnf update
    sudo dnf install miktex
    ```

### Git Related

- GitHub SSH Access

    ```shell
    $ description="$(id -un) ($(hostname -f))"
    $ ssh-keygen -t ed25519 -C "${description}"
    $ Generating public/private ed25519 key pair.
    Enter file in which to save the key ($HOME/.ssh/github): $HOME/.ssh/github
    ...
    $ eval "$(ssh-agent -s)"
    $ ssh-add $HOME/.ssh/github
    $ # enter passphrase
    $ gh auth refresh -h github.com -s admin:public_key
    ! First copy your one-time code: XXXX-XXXX
    Press Enter to open github.com in your browser...
    Opening in existing browser session.
    [69494:69494:0100/000000.661538:ERROR:sandbox_linux.cc(377)] InitializeSandbox() called with multiple threads in process gpu-process.

    ✓ Authentication complete.
    $ gh ssh-key add $HOME/.ssh/github.pub --title "${description}"
    ```

### Office Utilities

- Document processing: Fedora comes with Libre Office.

