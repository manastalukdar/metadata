#!/bin/bash
# Version Check Script
# Checks installed versions of development tools

echo "🔍 Development Tools Version Check"
echo "=================================="

# Function to check version
check_version() {
    local tool="$1"
    local cmd="$2"
    
    if command -v "$tool" &> /dev/null; then
        version=$(eval "$cmd" 2>&1 | head -n1)
        echo "✅ $tool: $version"
    else
        echo "❌ $tool: Not installed"
    fi
}

# Core development tools
echo ""
echo "🔧 Core Development Tools:"
check_version "git" "git --version"
check_version "python3" "python3 --version"
check_version "node" "node --version"
check_version "npm" "npm --version"
check_version "java" "java --version"

# Build tools
echo ""
echo "🏗️ Build Tools:"
check_version "gcc" "gcc --version"
check_version "make" "make --version"
check_version "cmake" "cmake --version"
check_version "gradle" "gradle --version"

# Version managers. mise supersedes nvm / sdkman / pyenv / jenv — those were
# shell functions rather than binaries, so they never showed up here anyway.
echo ""
echo "📦 Version Managers:"
check_version "mise" "mise --version"
check_version "uv" "uv --version"
if command -v mise &> /dev/null; then
    echo "   pinned by mise:"
    mise ls --current --no-header 2>/dev/null | awk '{printf "     %s %s\n", $1, $2}'
fi

# Package managers (the tiers in scripts/pkgs/)
echo ""
echo "🗃️ Package Managers:"
check_version "flatpak" "flatpak --version"
check_version "brew" "brew --version"
# paru is the AUR tier on CachyOS/Arch; absent everywhere else, which is what
# the ❌ line correctly reports.
check_version "paru" "paru --version"

# Editors
echo ""
echo "✏️ Editors:"
check_version "code" "code --version"
check_version "code-insiders" "code-insiders --version"
check_version "subl" "subl --version"
check_version "vim" "vim --version"
check_version "nvim" "nvim --version"
check_version "emacs" "emacs --version"

# Shell tools
echo ""
echo "🐚 Shell Tools:"
check_version "zsh" "zsh --version"
check_version "bash" "bash --version"

# Container tools
echo ""
echo "🐳 Container Tools:"
check_version "docker" "docker --version"
check_version "podman" "podman --version"

# Cloud tools
echo ""
echo "☁️ Cloud Tools:"
check_version "gh" "gh --version"
check_version "aws" "aws --version"

# Language-specific tools
echo ""
echo "🔧 Language-Specific Tools:"
check_version "pip" "pip --version"
check_version "ruff" "ruff --version"
check_version "black" "black --version"
check_version "cargo" "cargo --version"
check_version "go" "go version"

# System info
echo ""
echo "💻 System Information:"
echo "OS: $(uname -s -r)"
if command -v lsb_release &> /dev/null; then
    echo "Distribution: $(lsb_release -d | cut -f2)"
fi
echo "Shell: $SHELL"
echo "User: $(whoami)"
echo "Home: $HOME"

# Check disk space
echo ""
echo "💾 Disk Space:"
df -h ~ | tail -1

echo ""
echo "✅ Version check completed!"
echo "💡 Run 'scripts/setup-<platform>.sh' to install missing tools"