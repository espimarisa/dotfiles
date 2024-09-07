# rbenv
eval "$(~/.rbenv/bin/rbenv init - --no-rehash zsh)"

# Bun
[ -s "/home/espi/.bun/_bun" ] && source "/home/espi/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Fixes GPG on WSL2
export GPG_TTY=$(tty)

# Starship
eval "$(starship init zsh)"
