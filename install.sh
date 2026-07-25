#!/usr/bin/env bash
set -euo pipefail

echo "Updating package lists..."
sudo apt update

echo "Installing packages..."
sudo apt install -y \
    git \
    stow \
    tmux \
    ripgrep \
    fd-find \
    fzf \
    curl \
    unzip \
    zoxide \
    build-essential \
    python3 \
    python3-pip \
    python3-venv


# -------------------------
# Node.js / npm via nvm
# -------------------------

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
    echo "Installing nvm..."

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
else
    echo "nvm already installed"
fi

# Load nvm into this script
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
fi

if ! command -v node >/dev/null 2>&1; then
    echo "Installing Node.js LTS..."

    nvm install --lts
    nvm alias default 'lts/*'
else
    echo "Node.js already installed: $(node --version)"
fi


# -------------------------
# Neovim
# -------------------------

if ! command -v nvim >/dev/null 2>&1; then
    echo "Installing Neovim..."

    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

    chmod u+x nvim-linux-x86_64.appimage

    sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
else
    echo "Neovim already installed"
fi


# -------------------------
# uv (Python package manager)
# -------------------------

if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "uv already installed"
fi

# -------------------------
# TPM (Tmux Plugin Manager)
# -------------------------

if [ ! -f "$HOME/.tmux/plugins/tpm/tpm" ]; then
    echo "Installing TPM..."

    mkdir -p "$HOME/.tmux/plugins"

    git clone https://github.com/tmux-plugins/tpm \
        "$HOME/.tmux/plugins/tpm"
else
    echo "TPM already installed"
fi

# -------------------------
# Dotfiles
# -------------------------

echo "Setting up dotfiles..."

cd "$HOME/dotfiles"

stow bash
stow tmux
stow nvim

echo "Done!"
echo "Node version: $(node --version)"
echo "npm version: $(npm --version)"
