# Containers & Virtualization

Container runtimes, virtual machines, and reproducible-environment tools.

## Mandatory

- [Podman](https://podman.io) `native:podman`
  - Same package name from dnf, apt, pacman and brew, hence the single `native:` tag.
  - Rootless containers work out of the box on Fedora, Ubuntu and CachyOS. On macOS the formula installs only the client, so it needs a Linux VM first — not scripted, since it downloads an image and picks a resource budget:

    ```shell
    podman machine init && podman machine start
    ```

  - [Podman Desktop](https://podman-desktop.io) is the GUI (`cask:podman-desktop` on macOS, flatpak on Linux) and is listed under Optional below.
- [Rancher Desktop](https://rancherdesktop.io) `dnf:rancher-desktop` `apt:rancher-desktop` `aur:rancher-desktop` `cask:rancher`
  - [Install docs](https://docs.rancherdesktop.io/getting-started/installation/). Ships its own `docker`/`nerdctl` CLI plus a local Kubernetes cluster, so it stands in for Docker Desktop — do not run both.
  - Linux packages come from the openSUSE Build Service `isv:Rancher:stable` repo, which the setup scripts add:
    - Fedora: `sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/isv:/Rancher:/stable/fedora/isv:Rancher:stable.repo`
    - Ubuntu: key `https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/Release.key`, repo `deb [signed-by=...] https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/ ./`
    - AppImage alternative: <https://download.opensuse.org/repositories/isv:/Rancher:/stable/AppImage/rancher-desktop-latest-x86_64.AppImage>
    - CachyOS: the AUR package builds from upstream source, so no repo is needed — but that means every upgrade is a 10–30 minute rebuild. Options for living with that (hold it back, use the AppImage, or `rancher-desktop-bin`) are in [linux/cachyos/post-install.md](../linux/cachyos/post-install.md#upgrading-the-aur-packages-that-compile).
  - macOS: upstream recommends the DMG from [GitHub releases](https://github.com/rancher-sandbox/rancher-desktop/releases) and notes the Homebrew cask is *not* maintained by the Rancher Desktop team. The `rancher` cask is tagged anyway so a rebuild stays unattended — change it to `manual` if that caveat outweighs the automation.
  - Requirements
    - Linux: x86_64 with AMD-V/VT-x and read-write `/dev/kvm`. macOS 13+. Windows 11 with WSL.
    - `pass` and `gpg` for credential storage — `pass` is in [cli-utilities.md](cli-utilities.md), and both distros ship GnuPG.
    - Traefik binding ports 80/443 needs `net.ipv4.ip_unprivileged_port_start=80`. That lowers privileged-port protection machine-wide, so it is documented rather than scripted: see [fedora/post-install.md](../linux/fedora/post-install.md).

## Optional

- Docker
  - Ubuntu

    *Set up the repository: Set up the Docker CE repository on Ubuntu. The lsb_release -cs sub-command prints the name of your Ubuntu version, like xenial or trusty.*

    ```plaintext
    sudo apt-get -y install \
      apt-transport-https \
      ca-certificates \
      curl
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
           "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
           $(lsb_release -cs) \
           stable"
    sudo apt-get update
    ```

    *Get Docker CE: Install the latest version of Docker CE on Ubuntu.*

    ```plaintext
    sudo apt-get -y install docker-ce
    ```

    *Test your Docker CE installation: Test your installation.*

    ```plaintext
    sudo docker run hello-world
    ```

    [Reference1](https://store.docker.com/editions/community/docker-ce-server-ubuntu?tab=description), [Reference2](https://askubuntu.com/questions/909691/how-to-install-docker-on-ubuntu-17-04)

- <https://orbstack.dev/>
- [VirtualBox](https://www.virtualbox.org)
- [Nix](https://nixos.org/learn/)
- [Podman Desktop](https://podman-desktop.io)
