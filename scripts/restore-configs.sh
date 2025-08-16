#!/bin/bash
# Configuration Restore Script
# Restores configurations from a backup directory

if [ -z "$1" ]; then
    echo "❌ Usage: $0 <backup_directory>"
    echo "Example: $0 ~/config-backups/20241216_143022"
    exit 1
fi

BACKUP_DIR="$1"
if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ Backup directory not found: $BACKUP_DIR"
    exit 1
fi

echo "🔄 Restoring configurations from: $BACKUP_DIR"

# Function to restore file with confirmation
restore_file() {
    local source="$1"
    local dest="$2"
    
    if [ -f "$source" ]; then
        if [ -f "$dest" ]; then
            echo "⚠️  File exists: $dest"
            read -p "Overwrite? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo "Skipped: $dest"
                return
            fi
        fi
        
        echo "📄 Restoring: $dest"
        mkdir -p "$(dirname "$dest")"
        cp "$source" "$dest"
    fi
}

# Function to restore directory with confirmation
restore_dir() {
    local source="$1"
    local dest="$2"
    
    if [ -d "$source" ]; then
        if [ -d "$dest" ]; then
            echo "⚠️  Directory exists: $dest"
            read -p "Merge/Overwrite? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo "Skipped: $dest"
                return
            fi
        fi
        
        echo "📁 Restoring: $dest"
        mkdir -p "$(dirname "$dest")"
        cp -r "$source" "$dest"
    fi
}

# Show manifest if available
if [ -f "$BACKUP_DIR/MANIFEST.md" ]; then
    echo "📋 Backup manifest:"
    head -10 "$BACKUP_DIR/MANIFEST.md"
    echo ""
fi

# Restore shell configurations
restore_file "$BACKUP_DIR/shell/bashrc" "$HOME/.bashrc"
restore_file "$BACKUP_DIR/shell/zshrc" "$HOME/.zshrc"
restore_file "$BACKUP_DIR/shell/profile" "$HOME/.profile"

# Restore editor configurations
restore_file "$BACKUP_DIR/editors/vimrc" "$HOME/.vimrc"
restore_dir "$BACKUP_DIR/editors/nvim" "$HOME/.config/nvim"
restore_file "$BACKUP_DIR/editors/emacs" "$HOME/.emacs"
restore_dir "$BACKUP_DIR/editors/emacs.d" "$HOME/.emacs.d"

# Restore terminal configurations
restore_dir "$BACKUP_DIR/terminals/alacritty" "$HOME/.config/alacritty"
restore_file "$BACKUP_DIR/prompt/starship.toml" "$HOME/.config/starship.toml"

# Restore development tools
restore_file "$BACKUP_DIR/git/gitconfig" "$HOME/.gitconfig"

# Restore VS Code (cross-platform)
if [[ "$OSTYPE" == "darwin"* ]]; then
    restore_dir "$BACKUP_DIR/vscode" "$HOME/Library/Application Support/Code/User"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    restore_dir "$BACKUP_DIR/vscode" "$HOME/.config/Code/User"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    restore_dir "$BACKUP_DIR/vscode" "$APPDATA/Code/User"
fi

echo "✅ Configuration restore completed!"
echo "⚠️  Please restart your terminal/applications to apply changes"