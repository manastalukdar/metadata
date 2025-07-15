# Mandatory

- [Java SDK](https://adoptium.net)
  - [Ubuntu](https://adoptium.net/installation/linux#_deb_installation_on_debian_or_ubuntu)
    - `sdk install java 21.0.5-tem`: using SDKman

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

  pip packages to install: (`pip list`)

  - Cython
  - [Rummage](https://github.com/facelessuser/Rummage/)
  - [git-filter-repo](https://github.com/newren/git-filter-repo)
  - pandas
  - NumPy
  - Scikit-learn (o)
  - Gradio (o)
  - TensorFlow
    - Keras
  - SciPy
  - scikit-image
  - jupyterlab
  - cv2
  - opencv-python
  - opencv-contrib-python
  - Statsmodels (o)
  - Plotly (o)
  - Seaborn (o)
  - Dask (o)
  - vaex (o)
  - ruff
  - black
  - [aider](https://github.com/Aider-AI/aider)

- nodejs
  - [Ubuntu](https://nodejs.org/en/download/current)

    ```plaintext
    # Download and install nvm:
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"

    # Download and install Node.js:
    nvm install 24

    # Verify the Node.js version:
    node -v # Should print "v24.4.0".
    nvm current # Should print "v24.4.0".

    # Verify npm version:
    npm -v # Should print "11.4.2".
    ```

  - npm global packages (`npm list -g --depth 0`)

    ```plaintext
    +-- @angular/cli
    +-- @vue/cli
    +-- david
    +-- npm-check-updates
    +-- standard
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
    +-- npm-check-updates
    +-- vsce
    +-- yo
    +-- generator-code
    +-- ts-node@latest
    +-- typescript@latest
    +-- @types/node
    +-- less
    +-- @anthropic-ai/claude-code [link](https://ai-claude.net/code/#system-requirements)
    +-- @google/gemini-cli [link](https://github.com/google-gemini/gemini-cli)
    `-- windows-build-tools
    ```

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

- Sublime Merge
  - Ubuntu [ref](https://www.sublimemerge.com/docs/linux_repositories)

    ```plaintext
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime-merge
    ```

- [Bruno](https://www.usebruno.com)
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

    <https://code.launchpad.net/~sunderme/+archive/ubuntu/texstudio>

    dark mode:

    - <https://github.com/thatlittleboy/TeXstudio-Qt-Stylesheet>

- DotNet Core
  - Linux->Fedora: `sudo dnf install dotnet-sdk-6.0`
- Visual Studio Code editor
- [Cursor code editor](https://www.cursor.com)
  - https://cursor.com/api/download?platform=win32-x64&releaseTrack=stable
- Powershell Core
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
  - <https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip>
- [starship](https://github.com/starship/starship)
  - <https://starship.rs/guide/>
  - <https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip>
  - VSCode: `terminal.integrated.fontFamily`: `FiraCode NF`
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- gradle
  - Ubuntu

    ```plaintext
    sdk install gradle 4.2.1
    ```

  - Windows

    ```plaintext
    gradle.org/install/
    ```

- [RBQL](https://github.com/mechatroner/RBQL)
- [q](https://github.com/harelba/q)
- [nushell](https://github.com/nushell/nushell)
- [yq](https://github.com/mikefarah/yq)
- [jq](https://github.com/stedolan/jq)
- Fonts
  - Computer Modern: [here](https://www.fontsquirrel.com/fonts/computer-modern), [here](https://www.1001fonts.com/cmu-font.html)
  - Latin Modern Sans Serif: [here](https://www.fontsquirrel.com/fonts/Latin-Modern-Sans), [here](https://www.1001fonts.com/latin-modern-sans-font.html)

- Pinta
- pyenv

  - [MacOS / Linux](https://github.com/pyenv/pyenv): `brew install pyenv`

  - [Windows](https://github.com/pyenv-win/pyenv-win/issues/153)

     ```plaintext
     After installing run `pyenv update` (https://github.com/pyenv-win/pyenv-win/issues/153)
     ```

- virtualenv

  - MacOS: `brew install pyenv-virtualenv`

- FileZilla
- Vivaldi Browser
- Microsoft Edge Dev
- Pandoc
- Audacity
- GitHub CLI
- [GitHub Desktop](https://github.com/apps/desktop)
- Google Chrome
- Libre Office
- [Beekeeper Studio](https://github.com/beekeeper-studio/beekeeper-studio)
- GIMP
- Inkscape
- VLC Media player
- [Telegram Desktop](https://telegram.org)
- [Tor browser](https://www.torproject.org)
- [Virtual Volumes View](http://vvvapp.sourceforge.net/)
- Opera Browser (for free VPN)
- [Graphviz](https://graphviz.gitlab.io)
- DaVinci Resolve
- Slack
- Notion
- Pocketcasts
- [Open Video Downloader (youtube-dl-gui)](https://github.com/jely2002/youtube-dl-gui)
- KeePass Password Safe
  - <https://keepassxc.org/> for Linux
  - <https://macpassapp.org/> for macos
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
