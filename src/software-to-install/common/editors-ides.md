# Editors & IDEs

Traditional code editors and IDEs. AI-first editors and coding agents live in [ai-tools.md](ai-tools.md).

## Mandatory

- Sublime Text

  To open command prompt at file root: ctrl + alt + t
  MarkdownEditing Settings
  `"color_scheme": "Packages/MonokaiC/themes/ME-MonokaiC.tmTheme"`
  - Ubuntu [ref](https://www.sublimetext.com/docs/3/linux_repositories.html)

    ```plaintext
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime-text
    ```

- Visual Studio Code editor

## Optional

- [Onivim2](https://github.com/onivim/oni2)
- [Neovim](https://github.com/neovim/neovim)
  - Linux-Fedora

    ```shell
    sudo dnf install -y neovim python3-neovim
    sudo dnf install neovim-qt # [neovim-qt](https://github.com/equalsraf/neovim-qt)
    ```

- [SciTE](https://www.scintilla.org/SciTEDownload.html)
- [geany](https://www.geany.org/)
  - [geany plugins](https://plugins.geany.org/downloads.html)
- [Pyzo](https://pyzo.org/index.html)
- [ZeroBrane Studio Lua IDE](https://studio.zerobrane.com/)
- [Spyder](https://www.spyder-ide.org)
  - <https://github.com/spyder-ide/spyder-notebook>
  - <https://github.com/spyder-ide/spyder-terminal>
  - <https://github.com/spyder-ide/spyder-unittest>
- IntelliJ IDEA Community Edition
  - Ubuntu

    ```plaintext
    sudo tar xf <ideaIC or ideaIU>-*.tar.gz -C /opt/
    cd opt/<ideaIC or ideaIU>-*/bin
    ./idea.sh
    ```

    Plugins: CheckStyle, Findbugs

- Jetbrains PyCharm IDE Community Edition
- [Brackets code editor](https://github.com/brackets-cont/brackets)
- [Lapce](https://lapce.dev) [source](https://github.com/lapce/lapce)
- [Lite XL](https://lite-xl.com/en/) [source](https://github.com/lite-xl/lite-xl)
  - Linux->Fedora

    ```shell
    # https://lite-xl.com/?/downloads
    # Packages: https://copr.fedorainfracloud.org/coprs/sentry/lite/packages/
    sudo dnf copr enable sentry/lite && sudo dnf install lite-xl-nightly
    ```

- [CudaText](https://cudatext.github.io/index.html)
- [Zed Editor](https://zed.dev)
- Bitnami Wordpress stack installer
- Aptana plugin for Eclipse Java IDE
- Android Studio
  - Ubuntu
    - <https://dev.to/janetmutua/installing-android-studio-on-ubuntu-2204-complete-guide-1kh8>
    - <https://developer.android.com/studio/run/emulator-acceleration?utm_source=android-studio#vm-linux>

    ```shell
    tar -zxvf android-studio-2022.1.1.21-linux.tar.gz
    sudo mv android-studio /opt/
    sudo ln -sf /opt/android-studio/bin/studio.sh /bin/android-studio
    sudo nano /usr/share/applications/android-studio.desktop
    ```

    Snippet to add:

    ```plaintext
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=Android Studio
    Comment=Android Studio
    Exec=bash -i "/opt/android-studio/bin/studio.sh" %f
    Icon=/opt/android-studio/bin/studio.png
    Categories=Development;IDE;
    Terminal=false
    StartupNotify=true
    StartupWMClass=jetbrains-android-studio
    Name[en_GB]=android-studio.desktop
    ```

    Uninstalling:

    ```shell
    sudo rm /usr/share/applications/android-studio.desktop
    sudo rm -r /usr/bin/android-studio
    sudo rm -rf /opt/android-studio
    rm -rf ~/android-studio-2022.1.1.21-linux.tar.gz
    ```
