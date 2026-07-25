#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"
OS="$(uname -s)"

echo "=================================="
echo " Dotfiles installer"
echo "=================================="
echo
echo "Detected OS: $OS"
echo

read -p "Continue with installation? (y/N) " answer

if [[ "$answer" != "y" ]]; then
    echo "Cancelled."
    exit 0
fi


# -------------------------
# Package installation
# -------------------------

install_linux_packages() {
    echo "Installing Linux packages..."

    sudo apt update

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
}


install_macos_packages() {

    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew..."

        /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi


    echo "Installing macOS packages..."

    brew install \
        git \
        stow \
        tmux \
        ripgrep \
        fd \
        fzf \
        zoxide \
        neovim
}


case "$OS" in
    Linux)
        install_linux_packages
        ;;
    Darwin)
        install_macos_packages
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac



# -------------------------
# nvm / Node
# -------------------------

install_nvm() {

    export NVM_DIR="$HOME/.nvm"

    if [ ! -d "$NVM_DIR" ]; then

        echo "Installing nvm..."

        curl -o- \
        https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh \
        | bash

    else

        echo "nvm already installed"

    fi


    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
    fi


    if ! command -v node >/dev/null 2>&1; then

        echo "Installing Node LTS..."

        nvm install --lts
        nvm alias default 'lts/*'

    else

        echo "Node already installed: $(node --version)"

    fi
}

install_nvm



# -------------------------
# uv
# -------------------------

install_uv() {

    if ! command -v uv >/dev/null 2>&1; then

        echo "Installing uv..."

        curl -LsSf https://astral.sh/uv/install.sh | sh

    else

        echo "uv already installed"

    fi
}

install_uv



# -------------------------
# TPM
# -------------------------

install_tpm() {

    TPM="$HOME/.tmux/plugins/tpm"

    if [ ! -d "$TPM" ]; then

        echo "Installing TPM..."

        mkdir -p "$HOME/.tmux/plugins"

        git clone \
            https://github.com/tmux-plugins/tpm \
            "$TPM"

    else

        echo "TPM already installed"

    fi
}

install_tpm



# -------------------------
# Dotfile handling
# -------------------------

backup_if_exists() {

    target="$1"

    if [ -e "$target" ] && [ ! -L "$target" ]; then

        backup="${target}.backup.$(date +%Y%m%d%H%M%S)"

        echo "Backing up:"
        echo "  $target"
        echo "-> $backup"

        mv "$target" "$backup"

    fi
}


stow_package() {

    package="$1"

    echo
    echo "Setting up $package..."

    cd "$DOTFILES"

    # Handle common stow targets

    case "$package" in

        zsh)
            backup_if_exists "$HOME/.zshrc"
            ;;

        bash)
            backup_if_exists "$HOME/.bashrc"
            ;;

        tmux)
            backup_if_exists "$HOME/.tmux.conf"
            ;;

        nvim)
            backup_if_exists "$HOME/.config/nvim"
            ;;

    esac


    stow "$package"
}



# -------------------------
# Choose shell config
# -------------------------

SHELL_NAME="$(basename "${SHELL:-bash}")"

echo
echo "Detected shell: $SHELL_NAME"


if [[ "$SHELL_NAME" == "zsh" ]]; then
    stow_package zsh
else
    stow_package bash
fi


stow_package tmux
stow_package nvim



# -------------------------
# Finish
# -------------------------

echo
echo "=================================="
echo " Installation complete!"
echo "=================================="
echo

echo "Versions:"
echo "Node: $(node --version 2>/dev/null || echo missing)"
echo "npm:  $(npm --version 2>/dev/null || echo missing)"
echo "nvim: $(nvim --version | head -1 2>/dev/null || echo missing)"
echo "tmux: $(tmux -V 2>/dev/null || echo missing)"

echo
echo "Restart your terminal to load shell changes."
