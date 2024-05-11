# Optional

- MarkText
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
- [Neovim](https://github.com/neovim/neovim)

  - Linux-Fedora

    ```shell
    sudo dnf install -y neovim python3-neovim
    sudo dnf install neovim-qt # [neovim-qt](https://github.com/equalsraf/neovim-qt)
    ```

- [Lua](http://www.lua.org)
- [ZeroBrane Studio Lua IDE](https://studio.zerobrane.com/)
- [SciTE](https://www.scintilla.org/SciTEDownload.html)
- [geany](https://www.geany.org/)
- [geany plugins](https://plugins.geany.org/downloads.html)
- [CMake](https://cmake.org/)
- Scala
- Ruby
- [Pyzo](https://pyzo.org/index.html)
- [Typora](https://typora.io)
- [DB Browser for SQLite](https://github.com/sqlitebrowser/sqlitebrowser)
- [beekeeper studio](https://github.com/beekeeper-studio/beekeeper-studio/)
- [Boostnote](https://boostnote.io/)
- [Joplin](https://github.com/laurent22/joplin/)
- [MarkText](https://github.com/marktext/marktext)
- Bitnami Wordpress stack installer
- Aptana plugin for Eclipse Java IDE
- MySQL Workbench
- [Evolus Pencil](https://github.com/evolus/pencil)
- Go lang
  - Set GOROOT to where Go was installed (`C:\Go` on windows)
  - Be sure to set GOPATH env (user) variable (`G:\dev\go` as an example on Windows; default: `%USERPROFILE%\go`)
  - GO projects will need to be under `G:\dev\go`, using the above example. Possibly under a folder call \_my-projects. Alternately, a different folder can also be used for personal Go projects.
  - Add `G:\dev\go\bin` (using above example) to PATH.
- Dart lang
- [Scilab](https://www.scilab.org)
- [GNU Octave](https://www.gnu.org/software/octave/)
- [SageMath](http://www.sagemath.org)
- [Junolab for Julia](http://junolab.org)
- [GNU Plot](http://www.gnuplot.info)
- [ImageMagick](https://imagemagick.org/)
- [Blender](https://www.blender.org)
- [TexMaker](https://www.xm1math.net/texmaker/)
- [Pencil animation](https://www.pencil2d.org), [code](https://github.com/pencil2d/pencil).
- [Synfig Studio](https://www.synfig.org)
- [Krita](https://krita.org/en/)
- [HandBrake](https://handbrake.fr): video transcoder. [code](https://github.com/HandBrake/HandBrake).
- [Scribus](https://www.scribus.net)
- [skribisto](https://github.com/jacquetc/skribisto). Software for writers. Continuation of plume-creator.
- [Ren'Py](https://www.renpy.org)
- [Freeplane](https://github.com/freeplane/freeplane). Newer fork of Freemind.
- [VirtualBox](https://www.virtualbox.org)
- [Google Play Music Desktop Player](https://www.googleplaymusicdesktopplayer.com/)
- [Brackets code editor](https://github.com/brackets-cont/brackets)
- [Bleachbit](https://www.bleachbit.org)
- [kdnlive](https://kdenlive.org/en/)
- [Insomnia](https://insomnia.rest/)
- [Nightingle](https://nightingale.rest)
- [Advanced REST client](https://github.com/advanced-rest-client/arc-electron)
- [RedNotebook](https://rednotebook.sourceforge.io): desktop journal.
- [glogg](https://glogg.bonnefon.org/index.html)
- [yawcam](https://yawcam.com)
- [ScreenRec](https://screenrec.com) 
- [sift](https://github.com/svent/sift)
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
- [Openshot video editor](https://github.com/OpenShot/openshot-qt)
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
- [ueli](https://github.com/oliverschwendener/ueli)
- [PyPy](https://www.pypy.org/index.html)
- [digiKam](https://www.digikam.org)
- [massCode](https://github.com/massCodeIO/massCode)
- [ClamAV](https://www.clamav.net)
- [Gaphor](https://github.com/gaphor/gaphor)
- [Enve](https://github.com/MaurycyLiebner/enve)
- [Zotero](https://www.zotero.org/)
- [LazPaint](https://lazpaint.github.io/)
- [Alacritty terminal emulator](https://alacritty.org). [source](https://github.com/alacritty/alacritty).
- [Obsidian](https://obsidian.md)
- [Logseq](https://logseq.com) 
- [novelWriter](https://novelwriter.io). [source](https://github.com/vkbo/novelWriter)
- [glances](https://github.com/nicolargo/glances)
- [Zettlr](https://www.zettlr.com/)
- [lite-xl](https://github.com/lite-xl/lite-xl)
  - Linux->Fedora

    ```shell
    # https://lite-xl.com/?/downloads
    # Packages: https://copr.fedorainfracloud.org/coprs/sentry/lite/packages/
    sudo dnf copr enable sentry/lite && sudo dnf install lite-xl-nightly
    ```
