# A list of software to install

1. [1. Compulsory](#1-compulsory)
   1. [1.1 Any OS](#11-any-os)
   2. [1.2 Windows only](#12-windows-only)
   3. [1.3 Linux only](#13-linux-only)
   4. [1.3 MacOS only](#13-macos-only)
2. [2. Optional](#2-optional)
   1. [2.1 Any OS](#21-any-os)
   2. [2.2 Windows only](#22-windows-only)
   3. [2.3 Linux only](#23-linux-only)
   4. [2.4 MacOS only](#24-macos-only)
3. [Linux related](#linux-related)
   1. [Enabling right mouse click option for a Synaptics mousepad](#enabling-right-mouse-click-option-for-a-synaptics-mousepad)
   2. [Configuring GetDeb](#configuring-getdeb)
   3. [Make battery last longer](#make-battery-last-longer)
   4. [Installing gnome on top of Ubuntu](#installing-gnome-on-top-of-ubuntu)
   5. [Removing Unity](#removing-unity)
   6. [Stuck at login manager](#stuck-at-login-manager)

## 1. Compulsory

### 1.1 Any OS

- [Java SDK](https://adoptopenjdk.net/)
  - Ubuntu

    ```plaintext
    sudo apt-get update
    sudo apt-get install default-jdk
    ```

- Git
  - Ubuntu

    ```plaintext
    sudo apt-get install git
    ```

- Protocol Buffers
- kdiff3
  - macos

    `git config --global mergetool.kdiff3.path /Applications/kdiff3.app/Contents/MacOS/kdiff3`
    
- [clang](https://clang.llvm.org/)
- gcc
  - [Windows](http://www.msys2.org/)

    [Useful Link](https://www.devdungeon.com/content/how-setup-gcc-msys2-eclipse-windows-c-development)

    Add to `PATH`:

    - C:\msys64\mingw64\bin
    - C:\msys64\usr\bin

    ```plaintext
    pacman -Syu
    pacman -S base-devel
    pacman -S mingw-w64-x86_64-toolchain
    pacman -S mingw-w64-x86_64-cmake
    optional: pacman -S mingw-w64-x86_64-qt5
    ```

- Python
  - Ubuntu

    ```plaintext
    sudo apt-get python3.6

    // This does not seem to work
    python -m pip install --upgrade pip
    // So we use this
    sudo apt-install python-pip

    pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose
    // Consider adding this at the end of your ~/.bashrc file
    export PATH="$PATH:/home/your_user/.local/bin"
    ```

    [Reference](https://scipy.org/install.html)

- nodejs
  - Ubuntu

    ```plaintext
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo apt-get install -y build-essential
    ```

  - npm global packages (`npm list -g --depth 0`)

    ```plaintext
    +-- @angular/cli
    +-- @vue/cli
    +-- david
    +-- npm-check-updates
    +-- gh-pages
    +-- http-server
    +-- @gridsome/cli
    +-- compressjs
    +-- create-react-app
    +-- electron-packager
    +-- markdown
    +-- node-gyp
    +-- npm
    +-- rxjs-tslint
    +-- webpack
    +-- webpack-cli
    +-- webpack-dev-server
    +-- rimraf
    +-- serve
    +-- @marp-team/marp-cli
    +-- markdownlint-cli
    `-- windows-build-tools
    ```

- MarkText
- Sublime Text
  To open command prompt at file root: ctrl + alt + t
  - Ubuntu [ref](https://www.sublimetext.com/docs/3/linux_repositories.html)

    ```plaintext
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime-text
    ```

- Sublime Merge
  - Ubuntu [ref](https://www.sublimemerge.com/docs/linux_repositories)

    ```plaintext
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime-merge
    ```

- Postman
- Latex (MikTex on Windows)
  - Ubuntu

    ```plaintext
    sudo apt-get install texlive-full
    ```

    *After you installed texlive-full you can list all the installed language packs with dpkg -l texlive-lang-\*. Then you can remove the unneeded ones with sudo apt-get purge -y texlive-lang-... (where ... is the language).
    [Reference](https://tex.stackexchange.com/questions/372130/how-to-install-a-more-minimal-but-complete-texlive-on-ubuntu#comment919440_372130)*

- TexStudio
  - Ubuntu

    *May have to install libqt5scripts*

    ```plaintext
    sudo dpkg -i texstudio_*_amd64.deb
    sudo apt --fix-broken install
    ```

- DotNet Core
- Visual Studio Code editor
- gradle
  - Ubuntu

    ```plaintext
    sdk install gradle 4.2.1
    ```

  - Windows

    ```plaintext
    gradle.org/install/
    ```

- [q](https://github.com/harelba/q)
- FileZilla
- Vivaldi Browser
- Pandoc
- Audacity
- Google Chrome
- Libre Office
- [Beekeeper Studio](https://github.com/beekeeper-studio/beekeeper-studio)
- GIMP
- Inkscape
- VLC Media player
- [Virtual Volumes View](http://vvvapp.sourceforge.net/)
- Opera Browser (for free VPN)
- [Graphviz](https://graphviz.gitlab.io)
- KeePass Password Safe
  - Ubuntu

    _*If you want an older version of KeePass 2.x*_

    ```plaintext
    sudo apt-get update
    sudo apt-get install keepass2
    ```

    _*If you want the most recent verion of KeePass 2.x*_

     ```plaintext
     sudo apt-add-repository ppa:jtaylor/keepass
     sudo apt-get update
     sudo apt-get install keepass2
     ```

     _*If you want something compatible with KeePass 1.x but is not actually KeePass*_

     ```plaintext
     sudo apt-get update
     sudo apt-get install keepassx
     ```

     [Reference](https://sourceforge.net/p/keepass/discussion/329220/thread/17d1bd26/#4a47/2783)

### 1.2 Windows only

- 7zip
- [Windows PowerToys](https://github.com/microsoft/PowerToys)
- [Rufus](https://rufus.ie/)
- Microsoft OneDrive
- Visual Studio Community Edition
- Android SDK
- Android Studio
- WinPython (includes Spyder)
- ILSpy
- SysinternalsSuite
- GitExtensions
- Windows Media Player classic
- Adobe Lightroom
- Putty
- Tor browser
- Lame For Audacity (bundled in Windows and Mac versions)
- Not Another Pdf Scanner 2
- Paint.NET
- [dnGrep](https://github.com/dnGrep/dnGrep)
- Scrivener
- [Popc*** T***](https://github.com/popcorn-official/popcorn-desktop)
- qBittorrent
- [QTTabBar](http://qttabbar.wikidot.com/)
  - <https://www.raymond.cc/blog/how-to-have-tabs-in-your-windows-explorer/>
- ZoneAlarm Free Firewall
- SumatraPdf
- XnViewMP
- NitroPdf
- DisplayFusion
- Calibre
- FreeCommander XE

    ```plaintext
    Add new toolbar, then add following items
    Hyper -> Define Favorite Toolbars
        Name: Hyper
        Program or folder: C:\Users\<username>\AppData\Local\hyper\Hyper.exe
        Start folder: %ActivDir%
        Parameter: %ActivDir%
    Cmder -> Define Favorite Toolbars
        Name: Cmder
        Program or folder: C:\Programs\cmder_mini\Cmder.exe
        Start folder: %ActivDir%
        Parameter: /START %ActivDir% /TASK cmd::Cmder
    ```

- BurnAware Free
- [AIM player](https://www.aimp.ru/)
- Google\Nik Collection
- Speccy
- ProcessHacker
- Greenshot
- Winscp
- CDisplayEx
- f.lux
- DaVinci Resolve
- RoslynPad
- Powershell Core
- Windows Terminal
- [Screen to Gif](https://www.screentogif.com/)
- Linux Subsystem for Windows
  - [How to Install zsh and Oh My Zsh in Windows 10](https://www.maketecheasier.com/install-zsh-and-oh-my-zsh-windows10/)
  - [How to change the dark blue in wsl to something brighter](https://superuser.com/a/1409856/783826)

  ```plaintext
  sudo apt-get install zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```

### 1.3 Linux only

- conky
- [Peek](https://github.com/phw/peek)
- redshift

    ```plaintext
    sudo apt install redshift
    sudo apt install redshift-gtk
    ```

- Meld
- Spyder
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

### 1.3 MacOS only

- Address bar in finder
  
  ```plaintext
  1) defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES && killall Finder
  2) View -> Show Path Bar OR alt + command + P
  Reference: https://superuser.com/questions/174297/how-can-i-get-an-address-bar-in-finder
  ```

- [iterm2](https://iterm2.com/)
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [Antigen](https://github.com/zsh-users/antigen)
- [AppCleaner](http://freemacsoft.net/appcleaner/)
- Pine media player
- [Lightshot](https://app.prntscr.com/en/index.html)
- [nvm](https://github.com/nvm-sh/nvm)

  [Installing Multiple Versions of Node.js Using nvm](https://www.sitepoint.com/quick-tip-multiple-versions-node-nvm/)

- [pyenv](https://github.com/pyenv/pyenv)
- [jenv](https://github.com/jenv/jenv)

  <https://github.com/AdoptOpenJDK/homebrew-openjdk>
  `/usr/libexec/java_home -V`

`brew list`, `brew cask list`, `brew leaves`.

## 2. Optional

### 2.1 Any OS

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
- yarn
- R
  - Ubuntu

    ```plaintext
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    deb http://cran.r-project.org/bin/linux/ubuntu zesty/
    sudo apt-get update
    sudo apt-get install r-base
    sudo apt-get install r-base-dev
    ```

- R Studio
  - Ubuntu

    ```plaintext
    sudo apt --fix-broken install
    sudo apt-get install libjpeg62
    wget http://ftp.ca.debian.org/debian/pool/main/g/gstreamer0.10/libgstreamer0.10-0_0.10.36-1.5_amd64.deb
    wget http://ftp.ca.debian.org/debian/pool/main/g/gst-plugins-base0.10/libgstreamer-plugins-base0.10-0_0.10.36-2_amd64.deb
    ```

    *Now install with dpkg*

    ```plaintext
    sudo dpkg -i libgstreamer0.10-0_0.10.36-1.5_amd64.deb
    sudo dpkg -i libgstreamer-plugins-base0.10-0_0.10.36-2_amd64.deb
    ```

    *We’ve purposefully installed old packages and don’t want Ubuntu’s package manager to enthusiastically upgrade them next time we update. To resolve that problem will put a hold on them with apt-mark:*

    ```plaintext
    sudo apt-mark hold libgstreamer-plugins-base0.10-0
    sudo apt-mark hold libgstreamer0.10
    sudo apt-mark showhold
    sudo dpkg -i rstudio-***-amd64.deb
    ```

    *[Reference](https://mikewilliamson.wordpress.com/2016/11/14/installing-r-studio-on-ubuntu-16-10/)*

- Qt SDK
- [Onivim2](https://github.com/onivim/oni2)
- Neovim
- Lua
- [ZeroBrane Studio Lua IDE](https://studio.zerobrane.com/)
- [SciTE](https://www.scintilla.org/SciTEDownload.html)
- [geany](https://www.geany.org/)
- [geany plugins](https://plugins.geany.org/downloads.html)
- [CMake](https://cmake.org/)
- Scala
- Ruby
- Typora
- DB Browser for SQLite
- [Boostnote](https://boostnote.io/)
- Joplin
- [MarkText](https://github.com/marktext/marktext)
- Bitnami Wordpress stack installer
- Aptana plugin for Eclipse Java IDE
- MySQL Workbench
- Evolus Pencil
- Go lang
  - Set GOROOT to where Go was installed (`C:\Go` on windows)
  - Be sure to set GOPATH env (user) variable (`G:\dev\go` as an example on Windows; default: `%USERPROFILE%\go`)
  - GO projects will need to be under `G:\dev\go`, using the above example. Possibly under a folder call \_my-projects. Alternately, a different folder can also be used for personal Go projects.
  - Add `G:\dev\go\bin` (using above example) to PATH.
- Dart lang
- Scilab
- [GNU Octave](https://www.gnu.org/software/octave/)
- [SageMath](http://www.sagemath.org)
- [Junolab for Julia](http://junolab.org)
- GNU Plot
- [ImageMagick](https://imagemagick.org/)
- Blender
- Pencil animation
- Synfig Studio
- Krita
- Scribus
- plume-creator
- Ren'Py
- Freemind
- VirtualBox
- [Google Play Music Desktop Player](https://www.googleplaymusicdesktopplayer.com/)
- Atom code editor
- Brackets code editor
- Bleachbit
- [Insomnia](https://insomnia.rest/)
- [Advanced REST client](https://github.com/advanced-rest-client/arc-electron)
- RedNotebook
- [Open Broadcaster Software](https://obsproject.com/)
  - [Dark screen on windows issue](https://obsproject.com/forum/threads/laptop-black-screen-when-capturing-read-here-first.5965/)

    ```plaintext
    Open Settings and search for "Graphics Settings". Select "Classic App" and browse to C:\Program Files\obs-studio\bin\64bit\obs64.exe (or wherever you have installed OBS). Click "Options".

    If you want to use display capture to capture your screen / desktop, select "Power Saving".
    If you want to use game capture to capture a game or use the NVENC encoder, select "High Performance".
    ```

  - Audio filter:
    - <https://medium.com/@Wootpeanuts/removing-background-noise-with-obs-studio-17214d967fe0>
    - <https://helping-squad.com/obs-studio-how-to-configure-your-microphone-noise-suppression-noise-gate-and-gain-filter/>

    ```plaintext
    Noise suppression
    Noise Gate
    Gain
    ```

- [ReaPlugs VST](https://www.reaper.fm/reaplugs/)
- Openshot video editor
  - Ubuntu

    ```plaintext
    sudo add-apt-repository ppa:openshot.developers/ppa
    sudo apt-get update
    sudo apt-get install openshot-qt
    ```

- IntelliJ IDEA Community Edition
  - Ubuntu

    ```plaintext
    sudo tar xf <ideaIC or ideaIU>-*.tar.gz -C /opt/
    cd opt/<ideaIC or ideaIU>-*/bin
    ./idea.sh
    ```

  Plugins: CheckStyle, Findbugs
- Jetbrains PyCharm IDE Community Edition
- [Vectr](https://vectr.com)
- Lua
  - Windows

    [Installing Lua on a Windows system](http://www.thijsschreijer.nl/blog/?p=863)
- ZeroBrane Studio Lua IDE
- Pomodoro based productivity app - [Pomotroid](https://github.com/Splode/pomotroid)
- Spotify
  - [Ad blocking](https://github.com/x0uid/SpotifyAdBlock)
- [ytmdesktop-plus](https://github.com/manastalukdar/ytmdesktop-plus)

### 2.2 Windows only

- Microsoft Threat Modeling Tool
- [winget](https://github.com/microsoft/winget-cli)
- Atlassian SourceTree
- Autodesk Pixlr
- FotoSketcher
- Itranslator 2003 Beta
- [Mp3tag](https://www.mp3tag.de/en/)
- PdfEscape
- Freac Audio Converter
- EaseUS Partition Master
- EaseUS Data Recovery
- Acronis Disk Director
- Recuva
- Lockhunter
- Wox
- [Search and Replace](http://searchandreplace.com/)
- yWriter6
- Manuskript
- Notepad++
    <http://setup-steps.blogspot.com/2013/05/notepad-nppexec-add-java-compiler.html>
- ImageGlass
- Adobe Photoshop
- Irfanview
- WinCatalog
- Nodepad3
- ffmpeg
- Hyper.is
- cmder
- Twitch
- [Terminus](https://github.com/Eugeny/terminus)
- Open Live Writer
- Samsung Data Migration
- Brother printer driver (MFC-J835DW)
- Autodesk Sketchbook
- Pocketcasts
- Discord
- [Multi Commander](http://multicommander.com/)
- Eclipse Installer
- Eclipse Java IDE (Latest Released and Latest)
  - PyDev

### 2.3 Linux only

- 7zip
- [Stacer](https://github.com/oguzhaninan/Stacer)
- GitKraken
- Android Studio
  - Ubuntu

    ```plaintext
    sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
    sudo apt-get install unzip
    sudo unzip <filename.zip> -d /opt/
    ```

    *Navigate to the android-studio/bin/ directory, and execute studio.sh.
    To make Android Studio available in your list of applications, select Tools > Create Desktop Entry from the Android Studio menu bar.*

### 2.4 MacOS only

- [jabba](https://github.com/shyiko/jabba)

## Linux related

### Enabling right mouse click option for a Synaptics mousepad

1. Open a terminal by pressing Ctrl+Alt+T and use the following command: `sudo nautilus`. This will open a window with sudo privileges and allow you to change and save root files.
2. Find and open the file: /usr/share/X11/xorg.conf.d/70-synaptics.conf
3. Locate the paragraph:

    ```plaintext
    # This option enables the bottom right corner to be a right button on clickpads
    # and the right and middle top areas to be right / middle buttons on clickpads
    # with a top button area.
    # This option is only interpreted by clickpads.
      Section "InputClass"
          Identifier "Default clickpad buttons"
          MatchDriver "synaptics"
          Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"
          Option "SecondarySoftButtonAreas" "58% 0 0 15% 42% 58% 0 15%"
        EndSection
    ```

4. Add two extra lines before `Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"` :

    ```plaintext
    Option "ClickPad"         "true"
    Option "EmulateMidButtonTime" "0"
    ```

   (first one enables right click and the second middle click)

5. Now save the changes and Log out/Log in. The right click should be working now!

[Reference](https://askubuntu.com/questions/579645/right-click-on-synaptic-touchpad-not-working-on-ubuntu-14-10)

On Wayland desktop enviroment:

- [ref](https://ask.fedoraproject.org/en/question/100632/touchpad-libinput-to-xorg-configuration-not-working/)
- [ref](http://www.ubuntuvibes.com/2017/04/how-to-configure-touchpad-in-ubuntu.html)
- [ref](https://bbs.archlinux.org/viewtopic.php?id=222883)
- [ref](https://www.topbug.net/blog/2017/02/23/enable-natural-scrolling-for-trackpads-using-libinput/)
- [ref](https://superuser.com/questions/1252871/migrate-from-x11-to-wayland-multitouch-on-fedora-25?newreg=0570eaa16b904c98a5d82a677c449d4e)

### Configuring GetDeb

Install the getdeb package.
Or configure the repository manually:
Go to System-Administration-Software Sources, Third-Party Software tab, Add:

```plaintext
deb http://archive.getdeb.net/ubuntu zesty-getdeb apps
```

Add the repository GPG key, open a terminal window and type:

```plaintext
wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
```

If the application cannot be found, run this command and try again: `sudo apt-get update`.
If you want to uninstall the GetDeb repository run this command: `sudo apt-get remove getdeb-repository`.

[Reference](http://www.getdeb.net/updates/Ubuntu/17.04#how_to_install)

### Make battery last longer

TLP is Linux management power application, this application controls CPU temperature and this contributes to better control of battery life in long run. 

For installation and launching run: `sudo apt install tlp tlp-rdw && sudo tlp start`

[Reference](http://www.linuxandubuntu.com/home/15-things-to-do-after-installing-ubuntu-1704-zesty-zapus)

### Installing gnome on top of Ubuntu

```plaintext
sudo apt-get install ubuntu-gnome-desktop
```

*Then choose gdm3 or lightdm. Recommend to reboot.
If you need to change the login manager later on you can do that with `dpkg-reconfigure gdm3` or `dpkg-reconfigure lightdm` respectively.*

[Reference](https://askubuntu.com/questions/766071/install-gnome-shell-on-ubuntu-16-04?noredirect=1&lq=1)

### Removing Unity

```plaintext
sudo apt purge unity8 ubuntu-system-settings && sudo apt autoremove
```

### Stuck at login manager

[Reference](https://unix.stackexchange.com/questions/170650/ubuntu-does-no-let-me-log-in-to-my-user-how-can-i-fix-it)
