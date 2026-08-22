# Core

Base CLI and system essentials, and typography. Foundational tools assumed by most other categories.

Install tags (`native:`, `dnf:`, `pacman:`, `cask:`, …) feed [`scripts/pkgs/`](../../../scripts/pkgs/) — see [the README](../README.md#relationship-to-scriptspkgs).

## Mandatory

- Git `native:git`
  - Ubuntu

    ```plaintext
    sudo apt-get install git
    ```

- Git LFS `native:git-lfs`
- curl `native:curl`
- wget `native:wget`
- [zsh](https://www.zsh.org) `native:zsh`
- SSH askpass `dnf:openssh-askpass` `apt:ssh-askpass` `pacman:x11-ssh-askpass`
  - Fedora's and Ubuntu's packages register themselves as the system askpass; Arch's does not, so on CachyOS export `SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass` (and `SSH_ASKPASS_REQUIRE=prefer`) if you want the GUI prompt.
- 7zip `dnf:p7zip` `dnf:p7zip-plugins` `apt:p7zip-full` `apt:p7zip-rar` `pacman:7zip` `brew-macos:p7zip`
  - Arch's `7zip` is upstream's own build and already covers what Fedora splits into `p7zip-plugins`.
- unzip `native:unzip`
- [htop](https://htop.dev) `native:htop`
- Protocol Buffers `dnf:protobuf-compiler` `apt:protobuf-compiler` `pacman:protobuf` `brew-macos:protobuf`
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) `pacman:ttf-meslo-nerd` `pacman:ttf-firacode-nerd` `cask:font-meslo-lg-nerd-font` `cask:font-fira-code-nerd-font`
  - Not packaged for Fedora or Ubuntu, so `setup-fedora.sh` and `setup-ubuntu.sh` download Meslo and FiraCode into `~/.local/share/fonts`. Arch packages both, so `setup-cachyos.sh` skips that download.
- Fonts `manual`
  - Computer Modern: [here](https://www.fontsquirrel.com/fonts/computer-modern), [here](https://www.1001fonts.com/cmu-font.html)
  - Latin Modern Sans Serif: [here](https://www.fontsquirrel.com/fonts/Latin-Modern-Sans), [here](https://www.1001fonts.com/latin-modern-sans-font.html)
