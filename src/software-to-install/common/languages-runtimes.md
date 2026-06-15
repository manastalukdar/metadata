# Languages & Runtimes

Programming languages, SDKs, and version/environment managers.

## Mandatory

- [Java SDK](https://adoptium.net)
  - [Ubuntu](https://adoptium.net/installation/linux#_deb_installation_on_debian_or_ubuntu)
    - `sdk install java 21.0.5-tem`: using SDKman
    - Alternative: `sudo apt install openjdk-21-jdk`
    - Verify: `java --version && javac --version`

- Python
  - Ubuntu

    ```plaintext
    sudo apt-get install python3 python3-pip python3-venv

    # Upgrade pip
    python3 -m pip install --upgrade pip --user

    # Create virtual environment (recommended)
    python3 -m venv ~/.venv/default
    source ~/.venv/default/bin/activate

    pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose
    // Consider adding this at the end of your ~/.bashrc file
    export PATH="$PATH:/home/your_user/.local/bin"
    ```

    [Reference](https://scipy.org/install.html)

  - pip packages to install: (`pip list`)
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

    # Reload shell or source nvm
    source ~/.bashrc
    # Or: \. "$HOME/.nvm/nvm.sh"

    # Download and install Node.js LTS:
    nvm install --lts
    nvm use --lts
    nvm alias default node

    # Verify installation:
    node --version && npm --version

    # Enable corepack for yarn/pnpm
    corepack enable
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
    +-- @anthropic-ai/claude-code
    +-- @google/gemini-cli
    +-- windows-build-tools
    +-- @fission-ai/openspec@1.3.1
    +-- @google/gemini-cli@0.40.1
    +-- @mariozechner/pi-coding-agent@0.72.0
    +-- @mermaid-js/mermaid-cli@11.14.0
    +-- claudish@7.0.3
    +-- corepack@0.34.7
    ```

- DotNet Core
  - Linux->Fedora: `sudo dnf install dotnet-sdk-6.0`

- gradle
  - Ubuntu

    ```plaintext
    sdk install gradle 4.2.1
    ```

  - Windows

    ```plaintext
    gradle.org/install/
    ```

### Version & environment managers

- SDKman
  - Ubuntu

    ```bash
    curl -s "https://get.sdkman.io" | bash
    source ~/.sdkman/bin/sdkman-init.sh
    # Verify installation
    sdk version
    ```

  - <http://sdkman.io/install.html>

- pyenv
  - [MacOS / Linux](https://github.com/pyenv/pyenv): `brew install pyenv`
  - [Windows](https://github.com/pyenv-win/pyenv-win/issues/153)

    ```plaintext
    After installing run `pyenv update` (https://github.com/pyenv-win/pyenv-win/issues/153)
    ```

- virtualenv
  - MacOS: `brew install pyenv-virtualenv`

- [nvm](https://github.com/nvm-sh/nvm)
  - macOS

    ```shell
    nvm install node --reinstall-packages-from=node
    echo "node" > .nvmrc
    nvm use node
    nvm ls
    nvm versions
    ```

    [Installing Multiple Versions of Node.js Using nvm](https://www.sitepoint.com/quick-tip-multiple-versions-node-nvm/)

  - Linux-Fedora: `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash`

- [jenv](https://github.com/jenv/jenv)
  - macOS
    - <https://github.com/AdoptOpenJDK/homebrew-openjdk>
    - `/usr/libexec/java_home -V`
  - Linux-Fedora

    ```shell
    git clone https://github.com/jenv/jenv.git ~/.jenv
    # Shell: zsh
    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(jenv init -)"' >> ~/.zshrc
    ```

- JDK, java home, etc. (macOS):
  - <https://medium.com/notes-for-geeks/java-home-and-java-home-on-macos-f246cab643bd>
  - <https://mattshomepage.com/articles/2016/May/22/java_home_mac_os_x/>

## Optional

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

- Scala
- Ruby
- Go lang
  - Set GOROOT to where Go was installed (`C:\Go` on windows)
  - Be sure to set GOPATH env (user) variable (`G:\dev\go` as an example on Windows; default: `%USERPROFILE%\go`)
  - GO projects will need to be under `G:\dev\go`, using the above example. Possibly under a folder call \_my-projects. Alternately, a different folder can also be used for personal Go projects.
  - Add `G:\dev\go\bin` (using above example) to PATH.
- Dart lang
- [Lua](http://www.lua.org)
  - Windows: [Installing Lua on a Windows system](http://www.thijsschreijer.nl/blog/?p=863)
- [PyPy](https://www.pypy.org/index.html)
- [jabba](https://github.com/shyiko/jabba) (macOS)
- [Strawberry Perl](https://strawberryperl.com) (Windows)

### Scientific & numerical computing

- [Scilab](https://www.scilab.org)
- [GNU Octave](https://www.gnu.org/software/octave/)
- [SageMath](http://www.sagemath.org)
- [Junolab for Julia](http://junolab.org)
- [GNU Plot](http://www.gnuplot.info)
