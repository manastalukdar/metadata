# Troubleshooting Guide

Common issues and solutions when setting up development environments.

## Table of Contents

1. [General Issues](#general-issues)
2. [Platform-Specific Issues](#platform-specific-issues)
3. [Tool-Specific Issues](#tool-specific-issues)
4. [Configuration Issues](#configuration-issues)

## General Issues

### Permission Denied Errors

**Problem**: Script fails with permission denied
```bash
bash: ./setup-ubuntu.sh: Permission denied
```

**Solution**:
```bash
chmod +x scripts/setup-ubuntu.sh
# Or run with bash directly
bash scripts/setup-ubuntu.sh
```

### Network/Download Issues

**Problem**: Downloads fail or timeout

**Solutions**:
1. Check internet connection
2. Use alternative mirrors:
   ```bash
   # For apt (Ubuntu/Debian)
   sudo apt update --fix-missing
   
   # For dnf (Fedora)
   sudo dnf clean all && sudo dnf makecache
   ```
3. Configure proxy if behind corporate firewall

### Environment Variables Not Loading

**Problem**: Commands not found after installation

**Solution**:
```bash
# Reload shell configuration
source ~/.bashrc    # For bash
source ~/.zshrc     # For zsh

# Or restart terminal
```

## Platform-Specific Issues

### Ubuntu/Debian

#### Package Lock Issues
**Problem**: `Could not get lock /var/lib/dpkg/lock`

**Solution**:
```bash
sudo killall apt apt-get
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*
sudo dpkg --configure -a
sudo apt update
```

#### Python Installation Issues
**Problem**: Multiple Python versions causing conflicts

**Solution**:
```bash
# Use update-alternatives to manage Python versions
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
# Or use pyenv for version management
```

### macOS

#### Homebrew Installation Issues
**Problem**: Homebrew installation fails

**Solutions**:
```bash
# Clear Homebrew cache
brew cleanup

# Reset Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Xcode Command Line Tools
**Problem**: Git or compiler not found

**Solution**:
```bash
xcode-select --install
```

### Windows

#### PowerShell Execution Policy
**Problem**: Scripts cannot be executed

**Solution**:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### WSL Issues
**Problem**: WSL not working or outdated

**Solution**:
```powershell
# Update WSL
wsl --update
wsl --set-default-version 2
```

## Tool-Specific Issues

### SDKman

#### SDKman Not Found
**Problem**: `sdk: command not found`

**Solution**:
```bash
# Ensure SDKman is sourced
echo 'source ~/.sdkman/bin/sdkman-init.sh' >> ~/.bashrc
source ~/.bashrc
```

### NVM (Node Version Manager)

#### NVM Command Not Found
**Problem**: `nvm: command not found`

**Solution**:
```bash
# Add to shell profile
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc
source ~/.bashrc
```

### Git

#### SSH Key Issues
**Problem**: Git push fails with authentication error

**Solution**:
```bash
# Generate new SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to SSH agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Add public key to GitHub/GitLab
cat ~/.ssh/id_ed25519.pub
```

### Docker

#### Docker Permission Issues (Linux)
**Problem**: `permission denied while trying to connect to Docker daemon`

**Solution**:
```bash
# Add user to docker group
sudo usermod -aG docker $USER
# Logout and login again, or run:
newgrp docker
```

## Configuration Issues

### Vim/Neovim

#### Plugin Manager Not Working
**Problem**: vim-plug not installing plugins

**Solution**:
```bash
# Install vim-plug manually
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# For Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

#### Python Provider Issues
**Problem**: Neovim Python provider not working

**Solution**:
```bash
# Install pynvim
pip3 install --user pynvim

# Check health in Neovim
:checkhealth provider
```

### Starship

#### Prompt Not Loading
**Problem**: Starship prompt not appearing

**Solution**:
```bash
# Ensure starship is in PATH
which starship

# Add to shell profile
echo 'eval "$(starship init bash)"' >> ~/.bashrc    # For bash
echo 'eval "$(starship init zsh)"' >> ~/.zshrc      # For zsh
```

### Fonts

#### Nerd Fonts Not Displaying
**Problem**: Icons/symbols not showing in terminal

**Solution**:
1. Install a Nerd Font (e.g., FiraCode Nerd Font)
2. Set terminal font to the Nerd Font variant
3. Restart terminal application

## Getting Help

### Reporting Issues
If you encounter issues not covered here:

1. Check tool-specific documentation
2. Search existing GitHub issues
3. Create new issue with:
   - Operating system and version
   - Tool versions
   - Complete error message
   - Steps to reproduce

### Useful Commands for Debugging

```bash
# System information
uname -a                    # System info
lsb_release -a             # Linux distribution info
echo $SHELL                # Current shell

# Check installations
which python3 node npm git # Check if tools are in PATH
python3 --version          # Check Python version
node --version             # Check Node.js version

# Environment variables
echo $PATH                 # Check PATH
env | grep -i python       # Check Python-related variables
```