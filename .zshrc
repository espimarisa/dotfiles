#!/bin/zsh

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"
alias l="ls -CF"
alias la="ls -A"
alias ll="ls -alF"
alias ls="ls --color=auto"

# Environment variables
export EDITOR="micro"
export LANG="en_US.UTF-8"
export PAGER="less"
export NVM_DIR="$HOME/.nvm"

# ZSH options
setopt auto_param_slash
setopt autocd
setopt correct
setopt extendedglob
setopt histignoredups
setopt incappendhistory
setopt sharehistory
setopt interactive_comments

# Path configuration
path=(
  "$HOME/bin"
  "$HOME/.bun/bin"
  "$HOME/.cargo/bin"
  "$HOME/.rbenv/bin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "/usr/bin"
  "/usr/sbin"
  "/bin"
  "/sbin"
)

# Tools
eval "$(rbenv init - zsh)"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Functions
path() {
  echo -e "${PATH//:/\\n}"
}
