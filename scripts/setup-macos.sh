#!/bin/bash
# macOS Development Environment Setup Script
# Run with: bash scripts/setup-macos.sh

set -e  # Exit on any error

echo "🚀 Starting macOS development environment setup..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew
echo "📦 Updating Homebrew..."
brew update

# Install essential tools
echo "🔧 Installing essential development tools..."
brew install git python3 node wget curl

# Install development tools
echo "🛠️ Installing development tools..."
brew install --cask visual-studio-code
brew install --cask cursor
brew install --cask iterm2
brew install --cask sublime-text
brew install --cask sublime-merge

# Install SDKman
echo "☕ Installing SDKman..."
if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash
    source ~/.sdkman/bin/sdkman-init.sh
    sdk install java 21.0.5-tem
fi

# Install Node.js via nvm
echo "🟢 Installing Node.js via nvm..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    source ~/.bash_profile || source ~/.zshrc
    nvm install --lts
    nvm use --lts
    nvm alias default node
    corepack enable
fi

# Install Python environment
echo "🐍 Setting up Python environment..."
python3 -m pip install --upgrade pip --user
python3 -m venv ~/.venv/default
source ~/.venv/default/bin/activate
pip install ruff black aider

# Install additional utilities
echo "🎯 Installing additional utilities..."
brew install pyenv pyenv-virtualenv
brew install --cask bruno
brew install --cask keepassxc
brew install --cask vlc
brew install --cask telegram-desktop
brew install pandoc
brew install gh

echo "✅ macOS setup completed successfully!"
echo "⚠️  Please restart your terminal or run 'source ~/.zshrc' (or ~/.bash_profile) to reload environment variables"