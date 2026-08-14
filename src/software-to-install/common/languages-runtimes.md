# Languages & Runtimes

Programming languages, SDKs, and version/environment managers.

[mise](https://mise.jdx.dev) manages the runtimes on every platform. Versions are pinned by the `mise:` tags below, which generate [`scripts/pkgs/mise.txt`](../../../scripts/pkgs/mise.txt) — change a version there and re-run the setup script to switch.

pyenv and nvm are installed alongside it; see [Version managers](#version-managers) for how they interact, since all three want to own `python` and `node` on `PATH`.

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

### Version managers

Installed from Homebrew on all three platforms: apt has no `nvm` package, and Homebrew keeps one source rather than a different recipe per distro (the same reason nushell uses it).

- [pyenv](https://github.com/pyenv/pyenv) `brew:pyenv`
  - Shell init, needed before `pyenv` works — add to `~/.zshrc`:

    ```shell
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    ```

  - Building a Python needs the usual headers and libs (`zlib`, `bzip2`, `readline`, `sqlite`, `openssl`, `libffi` dev packages). See [pyenv's wiki](https://github.com/pyenv/pyenv/wiki#suggested-build-environment).
  - Windows: [pyenv-win](https://github.com/pyenv-win/pyenv-win); run `pyenv update` after installing.
- [nvm](https://github.com/nvm-sh/nvm) `brew:nvm`
  - Shell init — Homebrew does not wire this up, so add to `~/.zshrc`:

    ```shell
    export NVM_DIR="$HOME/.nvm"
    source "$(brew --prefix nvm)/nvm.sh"
    ```

  - Upstream prefers its own installer over Homebrew: `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash`. Either way the shell lines above are required, since nvm is a shell function rather than a binary — which is also why it never shows up in `check-versions.sh`.
  - Useful: `nvm install node --reinstall-packages-from=node`, `echo "node" > .nvmrc`, `nvm use node`, `nvm ls`.

#### Precedence with mise

All three put a `python`/`node` shim on `PATH`, so **whichever initializes last wins**. That is a genuine footgun: `mise use -g node@lts` and `nvm use 20` can disagree, and `which node` then depends on `~/.zshrc` ordering rather than on intent.

Pick one owner per language and be deliberate about it.

*Simplest:* let mise own the defaults. Put the mise activation **last** in `~/.zshrc`, and treat pyenv and nvm as on-demand tools for the occasional project needing a version or build flag mise cannot express.

*Otherwise:* drop `python`/`node` from `mise.txt` by removing those two `mise:` tags, and let pyenv and nvm own them outright — leaving mise for java, go, rust and gradle.

mise already reads `.nvmrc` and `.python-version`, so per-project pinning works without nvm or pyenv being involved at all.

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

Kept for reference; mise covers these, and the setup scripts do not install them. pyenv and nvm are Mandatory — see [Version managers](#version-managers) above.

- SDKman — <http://sdkman.io/install.html>

  ```bash
  curl -s "https://get.sdkman.io" | bash
  source ~/.sdkman/bin/sdkman-init.sh
  sdk version
  ```

- virtualenv
  - macOS: `brew install pyenv-virtualenv`
  - Prefer `uv venv` for new work; pyenv-virtualenv only matters if you are already managing interpreters with pyenv.
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
