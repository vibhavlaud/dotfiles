# -------------------------
# ssh-agent
# -------------------------

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null
fi

# Add first SSH private key found
SSH_KEY=$(find "$HOME/.ssh" -maxdepth 1 -type f \
    ! -name "config" \
    ! -name "known_hosts" \
    ! -name "*.pub" \
    | head -n 1)

if [ -n "$SSH_KEY" ]; then
    ssh-add -q "$SSH_KEY" 2>/dev/null
fi


# -------------------------
# PATH additions
# -------------------------

if [ -d "/opt/nvim" ]; then
    export PATH="$PATH:/opt/nvim"
fi


# -------------------------
# zoxide
# -------------------------

eval "$(zoxide init zsh)"


# -------------------------
# uv
# -------------------------

if [ -f "$HOME/.local/bin/env" ]; then
    source "$HOME/.local/bin/env"
fi


# -------------------------
# Node Version Manager
# -------------------------

export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
fi


# -------------------------
# zsh behavior
# -------------------------

bindkey -v
