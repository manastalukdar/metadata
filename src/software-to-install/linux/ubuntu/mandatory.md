# Mandatory

- Flatpak

  ```plaintext
  sudo apt install flatpak
  ```

- SDKman

  ```bash
  curl -s "https://get.sdkman.io" | bash
  source ~/.sdkman/bin/sdkman-init.sh
  # Verify installation
  sdk version
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
- sdkman 

    ```plaintext
    http://sdkman.io/install.html
    ```

- gdebi
  - Ubuntu
    `sudo apt install gdebi`
- snapd
  - Ubuntu
    `sudo apt install snapd` or `sudo snap install`
- rclone (for Microsoft OneDrive)
  - Ubuntu
      *Fetch and unpack*

      ```plaintext
      curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
      unzip rclone-current-linux-amd64.zip
      cd rclone-*-linux-amd64
      ```

      *Copy binary file*

      ```plaintext
      sudo cp rclone /usr/bin/
      sudo chown root:root /usr/bin/rclone
      sudo chmod 755 /usr/bin/rclone
      ```

      *Install manpage*

      ```plaintext
      sudo mkdir -p /usr/local/share/man/man1
      sudo cp rclone.1 /usr/local/share/man/man1/
      sudo mandb
      ```

      *Run `rclone config` to setup. See [rclone config docs](https://rclone.org/docs/) for more details.*
      *For setting up Microsoft OneDrive - steps [here](https://rclone.org/onedrive/).*
      [Reference](https://rclone.org/install/)

      *You could also install rclone using snapd:* `sudo snap install rclone --classic`
