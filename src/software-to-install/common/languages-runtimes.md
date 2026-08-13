# Languages & Runtimes

Programming languages, SDKs, and version/environment managers.

[mise](https://mise.jdx.dev) manages all of these on every platform, replacing nvm, pyenv, SDKman and jenv. Versions are pinned by the `mise:` tags below, which generate [`scripts/pkgs/mise.txt`](../../../scripts/pkgs/mise.txt) — change a version there and re-run the setup script to switch.

## Mandatory

- [Java SDK](https://adoptium.net) `mise:java@temurin-21`
  - [Ubuntu](https://adoptium.net/installation/linux#_deb_installation_on_debian_or_ubuntu)
    - Alternative without mise: `sudo apt install openjdk-21-jdk`
    - Verify: `java --version && javac --version`

- Python `mise:python@3.13`
  - The system `python3` is still installed (some distro packages need it), but project work uses the mise-managed interpreter.
  - Libraries — NumPy, pandas, SciPy, scikit-learn, TensorFlow, Keras, jupyter, opencv-python, Cython, statsmodels, plotly, seaborn, dask — belong to a *project's* virtual environment, created per repo with `uv venv` / `uv sync`. They are deliberately not installed globally.

- nodejs `mise:node@lts`
  - `corepack enable` is run by the setup scripts, which provides yarn and pnpm.

- DotNet Core `dnf:dotnet-sdk-9.0` `apt:dotnet-sdk-9.0`
  - From the Microsoft prod repo on both distros.

- gradle `mise:gradle@latest`
- [uv](https://github.com/astral-sh/uv) `mise:uv@latest` — fast Python package & project manager
  - Standalone installers, if you want it before mise: `curl -LsSf https://astral.sh/uv/install.sh | sh`, or `powershell -c "irm https://astral.sh/uv/install.ps1 | iex"` on Windows.
- Go lang `mise:go@latest`
  - Set `GOPATH` for personal projects; add `$GOPATH/bin` to `PATH`.
- Rust `mise:rust@latest`

### Python CLI tools

Installed with `uv tool install`, each into its own isolated environment — never into a project venv or the system Python.

- [ruff](https://github.com/astral-sh/ruff) `uv:ruff`
- [black](https://github.com/psf/black) `uv:black`
- [aider](https://github.com/Aider-AI/aider) `uv:aider-chat`
- [JupyterLab](https://jupyter.org) `uv:jupyterlab`
- [git-filter-repo](https://github.com/newren/git-filter-repo) `uv:git-filter-repo`

### Node global CLIs

AI coding agents live in [ai-tools.md](ai-tools.md); these are the rest.

- TypeScript `npm:typescript` `npm:ts-node`
- [Vue CLI](https://cli.vuejs.org) `npm:@vue/cli`
- [serve](https://github.com/vercel/serve) `npm:serve`
- [http-server](https://github.com/http-party/http-server) `npm:http-server`
- [rimraf](https://github.com/isaacs/rimraf) `npm:rimraf`
- [node-gyp](https://github.com/nodejs/node-gyp) `npm:node-gyp`
- [less](https://lesscss.org) `npm:less`
- [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli) `npm:markdownlint-cli`
- [mermaid-cli](https://github.com/mermaid-js/mermaid-cli) `npm:@mermaid-js/mermaid-cli`
- [Marp CLI](https://github.com/marp-team/marp-cli) `npm:@marp-team/marp-cli`
- [gh-pages](https://github.com/tschaub/gh-pages) `npm:gh-pages`
- [npm-check-updates](https://github.com/raineorshine/npm-check-updates) `npm:npm-check-updates`
- [vsce](https://github.com/microsoft/vscode-vsce) `npm:vsce`

## Optional

### Superseded version managers

Kept for reference; mise covers all four, and the setup scripts no longer install them.

- SDKman — <http://sdkman.io/install.html>

  ```bash
  curl -s "https://get.sdkman.io" | bash
  source ~/.sdkman/bin/sdkman-init.sh
  sdk version
  ```

- pyenv
  - [MacOS / Linux](https://github.com/pyenv/pyenv): `brew install pyenv`
  - [Windows](https://github.com/pyenv-win/pyenv-win/issues/153): after installing run `pyenv update`
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

### Other languages

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
