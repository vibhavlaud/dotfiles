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
    xclip \
    build-essential \
    python3 \
    python3-pip \
    python3-venv

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
# Dotfiles
# -------------------------

echo "Setting up dotfiles..."

cd "$HOME/dotfiles"

stow bash
stow tmux
stow nvim

echo "Done!"
