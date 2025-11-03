# Path to your oh-my-zsh installation.
export ZSH="$HOME/manastalukdar/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/bin"

export PATH="$PATH:$HOME/manastalukdar/.dotnet/tools"

alias typ='find . -name *.c3typ | xargs grep'
alias json='find . -name *.json | xargs grep'
alias js='find . -name *.js | xargs grep'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Above content copied from bash_profile

# https://www.sitepoint.com/quick-tip-multiple-versions-node-nvm/
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# antidote begins

# Clone antidote if necessary.
[[ -e ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Source antidote.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# generate ~/.zsh_plugins.zsh
antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh

source ~/.zsh_plugins.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
# santidote load

# Initialize antidote's dynamic mode, which changes `antidote bundle`
# from static mode.
source <(antidote init)

# antidote ends

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"


# direnv
eval "$(direnv hook zsh)"

INTELLIGENCE=~/data/labelbox-dev/intelligence/

function ipm2() {
  cwd=$(pwd)
  cd $INTELLIGENCE
  npx pm2 "$@"
  cd $cwd
}

export YVM_DIR=/opt/homebrew/opt/yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/manastalukdar/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/manastalukdar/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/manastalukdar/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/manastalukdar/google-cloud-sdk/completion.zsh.inc'; fi

export HELM_REGISTRY_CONFIG=$HOME/.docker/config.json

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=which chromium

export PATH="$HOME/.local/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"
