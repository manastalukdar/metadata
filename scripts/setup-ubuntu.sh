#!/bin/bash
# Ubuntu Development Environment Setup Script
# Run with: bash scripts/setup-ubuntu.sh

set -e  # Exit on any error

echo "🚀 Starting Ubuntu development environment setup..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install essential tools
echo "🔧 Installing essential development tools..."
sudo apt install -y \
    git \
    curl \
    wget \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    python3 \
    python3-pip \
    python3-venv \
    flatpak \
    snapd \
    gdebi \
    redshift \
    redshift-gtk \
    meld \
    conky

# Install SDKman
echo "☕ Installing SDKman..."
if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash
    source ~/.sdkman/bin/sdkman-init.sh
    sdk version
fi

# Install Java
echo "☕ Installing Java..."
source ~/.sdkman/bin/sdkman-init.sh
sdk install java 21.0.5-tem

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

# Configure redshift
echo "🌅 Configuring redshift..."
mkdir -p ~/.config
cat > ~/.config/redshift.conf << 'EOF'
[redshift]
temp-day=6500
temp-night=4500
location-provider=manual

[manual]
lat=40.7
lon=-74.0
EOF

# Install additional tools via snap
echo "📦 Installing additional tools via snap..."
sudo snap install code --classic
sudo snap install rclone --classic

echo "✅ Ubuntu setup completed successfully!"
echo "⚠️  Please restart your terminal or run 'source ~/.bashrc' to reload environment variables"