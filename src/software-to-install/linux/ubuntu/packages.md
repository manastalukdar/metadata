# Ubuntu — Packages

Ubuntu-specific software and native install recipes. Cross-platform tools live under [../../common/](../../common/); version managers like SDKman live in [languages-runtimes](../../common/languages-runtimes.md).

## Mandatory

Tools shared with Fedora — conky, redshift, Meld, Peek, the GNOME pieces and the font packages — are tagged once in [../common.md](../common.md). Flatpak and snapd are installed as plumbing by `setup-ubuntu.sh`.

- gdebi `apt:gdebi`
  - `sudo apt install gdebi`

## Optional

- [Stacer](https://github.com/oguzhaninan/Stacer)
- [Albert](https://github.com/albertlauncher/albert)
- [Sayonara Player](https://sayonara-player.com)
- [Cutter Reverse Engineering platform](https://cutter.re)
- [Cuda Text test editor](https://cudatext.github.io)

    ```plaintext
    sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
    sudo apt-get install unzip
    sudo unzip <filename.zip> -d /opt/
    ```

    *Navigate to the android-studio/bin/ directory, and execute studio.sh.
    To make Android Studio available in your list of applications, select Tools > Create Desktop Entry from the Android Studio menu bar.*
