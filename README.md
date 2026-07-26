# Supported Platforms:

**Linux (Recommended)**

This repository is primarily developed and tested on Linux (Ubuntu) and WSL.

Running the installer should produce a fully working development environment with minimal manual configuration.

**macOS**

The installer also supports macOS through Homebrew.

Most packages will install automatically, but a few terminal settings must be configured manually to match the intended appearance.

Specifically, you should:

Install and select a Nerd Font (for example, JetBrains Mono Nerd Font).
Configure your terminal to use the Catppuccin Mocha color scheme (or another compatible theme).
Ensure your terminal supports true color.
Select the Nerd Font in your terminal profile.

Without these settings, tmux and Neovim may still function correctly, but icons, colors, and the status bar may not render as intended.
Run `<leader> I` (leader in this case is Ctrl-a, by default. This can be modified in dotfiles/tmux/.tmux.conf) so that TPM will install all plugins.

# Features

The installer will:

- Install development tools and dependencies
- Install Neovim
- Install tmux
- Install GNU Stow
- Install zoxide
- Install Node.js via nvm
- Install the Python package manager (uv)
- Install TPM (Tmux Plugin Manager)
- Configure shell dotfiles using GNU Stow
- Back up existing configuration files before replacing them

The installer is designed to be non-destructive. Existing configuration files are backed up rather than overwritten.

# Installation

## Clone the repository:

- git clone https://github.com/vibhavlaud/dotfiles.git ~/dotfiles
- cd ~/dotfiles

## Run the installer:

- chmod +x install.sh (if necessary)
- ./install.sh

# Modifications

You can freely modify the configuration of anything in this repository to your heart's content. There is no need to re-run the installer after making changes to configuration files within this repository as those changes are immediately reflected in the files pointed to by the symlinks. Making these changes available on other workstations is as easy as commiting and pushing to your fork of this repository, then pulling those changes from the desired workstation. This will work immediately, with the exception of any changes to the structure of the repository (i.e. files were added or deleted, or directories were renamed). In that case, just re-run the install.sh script and you are good to go!

Happy CLI-maxxing :)
