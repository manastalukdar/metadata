# Developer Tools

Compilers and build tools, version-control clients and diff/merge tools, database clients, and API clients.

## Mandatory

### Compilers & build

- [clang](https://clang.llvm.org/)
- gcc
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

### Version control & diff

- kdiff3
  - macos

    `git config --global mergetool.kdiff3.path /Applications/kdiff3.app/Contents/MacOS/kdiff3`

- GitHub CLI
- [GitHub Desktop](https://github.com/apps/desktop)

### Database clients

- [Beekeeper Studio](https://github.com/beekeeper-studio/beekeeper-studio)

### API clients

- [Bruno](https://www.usebruno.com)

## Optional

### Compilers & build

- [CMake](https://cmake.org/)
- Qt SDK

### Version control & diff

- GitKraken
- [Beyond Compare](https://www.scootersoftware.com) (macOS)

### Database clients

- [DB Browser for SQLite](https://github.com/sqlitebrowser/sqlitebrowser)
- [beekeeper studio](https://github.com/beekeeper-studio/beekeeper-studio/)
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
