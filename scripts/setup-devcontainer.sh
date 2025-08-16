#!/bin/bash
# DevContainer Post-Create Setup Script
# Runs automatically when devcontainer is created

set -e

echo "🚀 Setting up development environment in container..."

# Install starship prompt
echo "⭐ Installing starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Copy starship configuration
if [ -f "/workspaces/metadata/src/configurations/starship/starship.toml" ]; then
    mkdir -p ~/.config
    cp /workspaces/metadata/src/configurations/starship/starship.toml ~/.config/
fi

# Install Python packages
echo "🐍 Installing Python development packages..."
pip install --user ruff black aider jupyter pandas numpy matplotlib seaborn

# Install Node.js global packages
echo "🟢 Installing Node.js global packages..."
npm install -g @anthropic-ai/claude-code typescript ts-node nodemon

# Set up git configuration template
echo "🔧 Setting up git configuration template..."
cat > ~/.gitconfig-template << 'EOF'
[user]
    name = Your Name
    email = your.email@example.com

[core]
    editor = code --wait
    autocrlf = input

[init]
    defaultBranch = main

[pull]
    rebase = true

[push]
    default = simple
    autoSetupRemote = true

[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    lg = log --oneline --graph --decorate
EOF

echo "📝 Git configuration template created at ~/.gitconfig-template"
echo "   Please copy and customize with your details: cp ~/.gitconfig-template ~/.gitconfig"

# Set up shell aliases
echo "🔗 Setting up shell aliases..."
cat >> ~/.bashrc << 'EOF'

# Development aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'

# Python aliases
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'

EOF

echo "✅ DevContainer setup completed!"
echo "🔄 Please reload your shell or restart terminal to apply changes"