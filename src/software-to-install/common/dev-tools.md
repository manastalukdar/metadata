# Developer Tools

Compilers and build tools, version-control clients and diff/merge tools, database clients, and API clients.

## Mandatory

### Compilers & build

- [clang](https://clang.llvm.org/) `dnf:clang` `apt:clang` `brew-macos:llvm`
- gcc `dnf:gcc` `dnf:gcc-c++`
  - Ubuntu gets gcc and g++ from `build-essential`; macOS from the Xcode Command Line Tools.
  - [Windows](https://www.msys2.org/wiki/MSYS2-installation/)

    [Useful Link](https://www.devdungeon.com/content/how-setup-gcc-msys2-eclipse-windows-c-development)

    Add to `PATH`:

    - C:\msys64\mingw64\bin
    - C:\msys64\usr\bin

    ```plaintext
    pacman -Syuu
    optional: pacman -Syu --disable-download-timeout --needed
    pacman -S --disable-download-timeout --needed base-devel
    pacman -S --disable-download-timeout --needed mingw-w64-x86_64-toolchain
    pacman -S --disable-download-timeout --needed mingw-w64-x86_64-cmake
    optional: pacman -S --disable-download-timeout --needed mingw-w64-x86_64-qt6
    ```

- [CMake](https://cmake.org/) `native:cmake`
- make `native:make`

### Version control & diff

- kdiff3 `dnf:kdiff3` `apt:kdiff3` `cask:kdiff3`
  - macos

    `git config --global mergetool.kdiff3.path /Applications/kdiff3.app/Contents/MacOS/kdiff3`

- meld `dnf:meld` `apt:meld` `cask:meld`
- GitHub CLI `native:gh`
- [GitHub Desktop](https://github.com/apps/desktop) `flatpak:io.github.shiftey.Desktop` `cask:github`
  - The flatpak is the community Linux build.
- [BitComet](https://www.bitcomet.com/en) `manual`
  - Vendor downloads only — no Homebrew cask, no Flathub app, and not in the Fedora or Ubuntu repos. Get it from [the downloads page](https://www.bitcomet.com/en/downloads).

### Database clients

- [Beekeeper Studio](https://github.com/beekeeper-studio/beekeeper-studio) `flatpak:io.beekeeperstudio.Studio` `cask:beekeeper-studio`

### API clients

- [Bruno](https://www.usebruno.com) `flatpak:com.usebruno.Bruno` `cask:bruno`

## Optional

### Compilers & build

- Qt SDK

### Version control & diff

- GitKraken
- [Beyond Compare](https://www.scootersoftware.com) (macOS)
- [Git Credential Manager](https://github.com/git-ecosystem/git-credential-manager). [Credential store options](https://github.com/git-ecosystem/git-credential-manager/blob/main/docs/credstores.md).

### Database clients

- [DB Browser for SQLite](https://github.com/sqlitebrowser/sqlitebrowser)
- [DBeaver Community](https://dbeaver.io)
- MySQL Workbench

### API clients

- [Insomnia](https://insomnia.rest/)
- [Nightingle](https://nightingale.rest)
- [Advanced REST client](https://github.com/advanced-rest-client/arc-electron)
- Postman

### Modelling & misc

- [Evolus Pencil](https://github.com/evolus/pencil)
- [Gaphor](https://github.com/gaphor/gaphor)
- [massCode](https://github.com/massCodeIO/massCode)
- [Vectr](https://vectr.com)
