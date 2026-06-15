# Ubuntu — Packages

Ubuntu-specific software and native install recipes. Cross-platform tools live under [../../common/](../../common/); version managers like SDKman live in [languages-runtimes](../../common/languages-runtimes.md).

## Mandatory

- Flatpak

  ```plaintext
  sudo apt install flatpak
  ```

- conky
- [Peek](https://github.com/phw/peek)
- redshift

    ```bash
    sudo apt update
    sudo apt install redshift redshift-gtk
    # Configure location for automatic adjustment
    echo '[redshift]\ntemp-day=6500\ntemp-night=4500\nlocation-provider=manual\n[manual]\nlat=40.7\nlon=-74.0' > ~/.config/redshift.conf
    ```

- Meld
- [Spyder](https://www.spyder-ide.org)
  - <https://github.com/spyder-ide/spyder-notebook>
  - <https://github.com/spyder-ide/spyder-terminal>
  - <https://github.com/spyder-ide/spyder-unittest>
- gdebi
  - `sudo apt install gdebi`
- snapd
  - `sudo apt install snapd` or `sudo snap install`
- rclone (for Microsoft OneDrive)
  - *Fetch and unpack*

    ```plaintext
    curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
    unzip rclone-current-linux-amd64.zip
    cd rclone-*-linux-amd64
    ```

  - *Copy binary file*

    ```plaintext
    sudo cp rclone /usr/bin/
    sudo chown root:root /usr/bin/rclone
    sudo chmod 755 /usr/bin/rclone
    ```

  - *Install manpage*

    ```plaintext
    sudo mkdir -p /usr/local/share/man/man1
    sudo cp rclone.1 /usr/local/share/man/man1/
    sudo mandb
    ```

  - *Run `rclone config` to setup. See [rclone config docs](https://rclone.org/docs/) for more details.*
    *For setting up Microsoft OneDrive - steps [here](https://rclone.org/onedrive/).*
    [Reference](https://rclone.org/install/)
  - *You could also install rclone using snapd:* `sudo snap install rclone --classic`

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
