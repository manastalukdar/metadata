# Core

Base CLI and system essentials, and typography. Foundational tools assumed by most other categories.

Install tags (`native:`, `dnf:`, `cask:`, …) feed [`scripts/pkgs/`](../../../scripts/pkgs/) — see [the README](../README.md#relationship-to-scriptspkgs).

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
- SSH askpass `dnf:openssh-askpass` `apt:ssh-askpass`
- 7zip `dnf:p7zip` `dnf:p7zip-plugins` `apt:p7zip-full` `apt:p7zip-rar` `brew-macos:p7zip`
- unzip `native:unzip`
- [htop](https://htop.dev) `native:htop`
- Protocol Buffers `dnf:protobuf-compiler` `apt:protobuf-compiler` `brew-macos:protobuf`
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) `cask:font-meslo-lg-nerd-font` `cask:font-fira-code-nerd-font`
  - Not packaged on Linux; the `setup-*.sh` scripts download Meslo and FiraCode into `~/.local/share/fonts`.
- Fonts `manual`
  - Computer Modern: [here](https://www.fontsquirrel.com/fonts/computer-modern), [here](https://www.1001fonts.com/cmu-font.html)
  - Latin Modern Sans Serif: [here](https://www.fontsquirrel.com/fonts/Latin-Modern-Sans), [here](https://www.1001fonts.com/latin-modern-sans-font.html)
