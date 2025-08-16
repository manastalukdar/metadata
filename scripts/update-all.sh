#!/bin/bash
# Universal Update Script
# Updates all development tools and configurations

set -e

echo "🔄 Starting comprehensive system update..."

# Detect platform
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
        PLATFORM="ubuntu"
    elif command -v dnf &> /dev/null; then
        PLATFORM="fedora"
    else
        PLATFORM="linux"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    PLATFORM="windows"
else
    PLATFORM="unknown"
fi

echo "🖥️ Detected platform: $PLATFORM"

# Update system packages
echo "📦 Updating system packages..."
case $PLATFORM in
    "ubuntu")
        sudo apt update && sudo apt upgrade -y
        sudo apt autoremove -y
        ;;
    "fedora")
        sudo dnf update -y
        sudo dnf autoremove -y
        ;;
    "macos")
        if command -v brew &> /dev/null; then
            brew update && brew upgrade
            brew cleanup
        fi
        ;;
    "windows")
        echo "⚠️ Windows updates require manual intervention"
        echo "Run: winget upgrade --all"
        ;;
esac

# Update Node.js packages
if command -v npm &> /dev/null; then
    echo "🟢 Updating Node.js global packages..."
    npm update -g
    npm audit fix
fi

# Update Python packages
if command -v pip3 &> /dev/null; then
    echo "🐍 Updating Python packages..."
    pip3 install --upgrade pip --user
    
    # Update packages in default virtual environment if it exists
    if [ -d "$HOME/.venv/default" ]; then
        source "$HOME/.venv/default/bin/activate"
        pip install --upgrade pip
        pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U
        deactivate
    fi
fi

# Update Rust
if command -v rustup &> /dev/null; then
    echo "🦀 Updating Rust..."
    rustup update
fi

# Update Go
if command -v go &> /dev/null; then
    echo "🐹 Updating Go tools..."
    go install -a std
fi

# Update SDKman packages
if [ -d "$HOME/.sdkman" ]; then
    echo "☕ Updating SDKman and Java..."
    source ~/.sdkman/bin/sdkman-init.sh
    sdk selfupdate
    sdk update
fi

# Update vim/neovim plugins
if command -v nvim &> /dev/null; then
    echo "📝 Updating Neovim plugins..."
    nvim +PlugUpdate +qall
fi

# Update VS Code extensions
if command -v code &> /dev/null; then
    echo "🔧 Updating VS Code extensions..."
    code --update-extensions
fi

# Clean up
echo "🧹 Cleaning up..."
case $PLATFORM in
    "ubuntu"|"fedora")
        # Clear package cache
        sudo apt autoremove -y &> /dev/null || true
        sudo dnf autoremove -y &> /dev/null || true
        ;;
    "macos")
        if command -v brew &> /dev/null; then
            brew cleanup
        fi
        ;;
esac

# Run health check
echo "🏥 Running health check..."
if [ -f "scripts/check-versions.sh" ]; then
    bash scripts/check-versions.sh
else
    echo "⚠️ Health check script not found"
fi

echo "✅ System update completed successfully!"
echo "💡 Consider backing up your configurations: scripts/backup-configs.sh"