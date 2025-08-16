#!/bin/bash
# Fedora Development Environment Setup Script
# Run with: bash scripts/setup-fedora.sh

set -e  # Exit on any error

echo "🚀 Starting Fedora development environment setup..."

# Update system
echo "📦 Updating system packages..."
sudo dnf update -y

# Install essential development tools
echo "🔧 Installing essential development tools..."
sudo dnf groupinstall -y "Development Tools" "C Development Tools and Libraries"
sudo dnf install -y \
    git \
    curl \
    wget \
    python3 \
    python3-pip \
    python3-virtualenv \
    flatpak \
    snapd \
    redshift \
    redshift-gtk \
    meld \
    conky \
    neovim \
    python3-neovim \
    neovim-qt

# Enable snapd
echo "📦 Enabling snapd..."
sudo systemctl enable --now snapd.socket
sudo ln -sf /var/lib/snapd/snap /snap

# Install dotnet
echo "🔷 Installing .NET SDK..."
sudo dnf install -y dotnet-sdk-8.0

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
    source ~/.bashrc
    nvm install --lts
    nvm use --lts
    nvm alias default node
    corepack enable
fi

# Install Python packages
echo "🐍 Installing Python packages..."
python3 -m pip install --upgrade pip --user
python3 -m venv ~/.venv/default
source ~/.venv/default/bin/activate
pip install ruff black aider

# Install additional tools via flatpak
echo "📦 Installing additional tools via flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.kde.kdiff3

# Install lite-xl editor
echo "✏️ Installing lite-xl editor..."
sudo dnf copr enable -y sentry/lite
sudo dnf install -y lite-xl-nightly

echo "✅ Fedora setup completed successfully!"
echo "⚠️  Please restart your terminal or run 'source ~/.bashrc' to reload environment variables"