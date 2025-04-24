#!/bin/zsh

#
# Aliases
#

alias ..="cd .."                     # Go up one directory
alias ...="cd ../.."                 # Go up two directories
alias g="git"                        # Shortcut for git
alias grep="grep --color=auto"       # Always colorize grep output
alias l="ls -CF"                     # List files in columns
alias la="ls -A"                     # List all files including hidden
alias ll="ls -alF"                   # List detailed information
alias ls="ls --color=auto"           # Always colorize ls output
alias ohmyzsh="$EDITOR ~/.oh-my-zsh" # Edit Oh My Zsh directory using defined $EDITOR
alias zshconfig="$EDITOR ~/.zshrc"   # Edit this configuration file using defined $EDITOR

#
# Completions
#

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"               # bun
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # nvm

#
# Environment Variables
#

export EDITOR="micro"         # Set the preferred editor for command-line tools (e.g., git commit messages).
export LANG="en_US.UTF-8"     # Set the default language and locale settings.
export NVM_DIR="$HOME/.nvm"   # Define the installation directory for nvm (Node Version Manager). Must be set before sourcing nvm.sh.
export PAGER="less"           # Set the preferred pager for viewing long outputs (e.g., man pages).
export ZSH="$HOME/.oh-my-zsh" # Define the installation directory for Oh My Zsh. Must be set before sourcing oh-my-zsh.sh.

#
# Oh My Zsh configuration
#

# Set the desired Oh My Zsh theme.
ZSH_THEME="robbyrussell"

# Define Oh My Zsh plugins to load (ensure custom ones are installed).
plugins=(
  archlinux
  bun
  docker
  docker-compose
  dotenv
  git
  node
  npm
  rbenv
  rust
  zsh-autosuggestions     # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
)

# Source the main Oh My Zsh initialization script if it exists.
# Loads theme, plugins, completions, and core functions. Must run after ZSH, ZSH_THEME, plugins are set.
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "Oh My Zsh not found at $ZSH"
fi

#
# PATH Configuration
#

# Add Bun binary path.
if [ -d "$HOME/.bun/bin" ]; then
  export PATH="$HOME/.bun/bin:$PATH"
fi

# Add Cargo (Rust) binary path.
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Add Rbenv binary path.
if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

# Add ~/.local/bin (Common place for user-specific scripts/binaries).
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

#
# Shell Options
#

# Configure Zsh shell behavior using 'setopt'. Sorted alphabetically.
setopt autocd           # Change directory without typing 'cd'.
setopt correct          # Offer correction for mistyped commands.
setopt extendedglob     # Enable extended globbing patterns.
setopt histignoredups   # Don't store duplicate commands consecutively in history.
setopt incappendhistory # Append history entries incrementally, not just on exit.
setopt sharehistory     # Share history between all active shells (use with incappendhistory).

#
# Tools
#

# Load nvm (Node Version Manager) script if it exists.
# Recommended to be loaded late in the startup process. NVM_DIR must be set earlier.
if [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"
else
  echo "nvm script not found at $NVM_DIR/nvm.sh"
fi

# Initialize rbenv (Ruby Version Manager) shims and autocompletion.
# Must run after rbenv's bin directory is added to PATH.
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - zsh)"
fi
