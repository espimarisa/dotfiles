#!/bin/zsh

#
# Zim
#

export ZIM_HOME="${HOME}/.zim"
mkdir -p "${ZIM_HOME}"

# Auto install zimfw.zsh if missing
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
  # Use curl if available
  if (( ${+commands[curl]} )); then
    print -R "Zim: Downloading zimfw.zsh with curl..."
    curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh

  # Use wget is available
  elif (( ${+commands[wget]} )); then
    print -R "Zim: Downloading zimfw.zsh with wget..."
    mkdir -p "${ZIM_HOME}" && wget -nv -O "${ZIM_HOME}/zimfw.zsh" \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    print -R "Zim: Error: curl or wget is required to download zimfw.zsh." >&2
  fi
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
# This runs 'zimfw init' if .zimrc has changed or init.zsh is missing/older.
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc}" ]]; then
  # Check if zimfw.zsh exists before trying to source it
  if [[ -f "${ZIM_HOME}/zimfw.zsh" ]]; then
      print -R "Zim: Initializing modules..."
    # Source the zimfw script to run the init command
    source "${ZIM_HOME}/zimfw.zsh" init
  # Check if ZIM_HOME itself exists before showing the error
  elif [[ -e "${ZIM_HOME}" ]]; then
      print -R "Zim: Error: ${ZIM_HOME}/zimfw.zsh not found." >&2
  fi
fi

# Source Zim's generated init script (if it exists and is readable)
if [[ -s "${ZIM_HOME}/init.zsh" ]]; then
  source "${ZIM_HOME}/init.zsh"
else
    # Only warn if the file is expected but missing/empty
    if [[ -e "${ZIM_HOME}" ]]; then
        print -R "Zim: Warning: ${ZIM_HOME}/init.zsh not found or empty. Run 'zimfw install'." >&2
    fi
fi

#
# ZSH
#

WORDCHARS=${WORDCHARS//[\/]/} # Affects word boundaries for movements/deletion

# Settings for Zim modules
ZSH_AUTOSUGGEST_MANUAL_REBIND=1 # autosuggestions
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets) # highlighting

setopt auto_param_slash      # Append / to directory names on completion
setopt autocd                # Change dir just by typing the dir name
setopt correct               # Auto correct commands
setopt extendedglob          # Use extended globbing features (#, ~, ^)
setopt HIST_IGNORE_ALL_DUPS  # If a new command is identical to an older one, remove the older one
setopt incappendhistory      # Write history incrementally
setopt interactive_comments  # Allow comments even in interactive shells
setopt sharehistory          # Share history between all sessions

# Environment variables
export EDITOR="micro"
export PAGER="less"
export LANG="en_US.UTF-8"

#
# Aliases
#

alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"
alias l="ls -CF" # List files, classify type (/ @ * | =)
alias la="ls -A" # List all files including hidden, except . and ..
alias ll="ls -alF" # List all files, long format, classify type
alias ls="ls --color=auto"


# PATH Configuration
typeset -U path
path=(
  # User-specific bins
  "$HOME/bin"
  "$HOME/.local/bin"

  # Tool-specific bins
  "$HOME/.bun/bin"
  "$HOME/.cargo/bin"
  "$HOME/.rbenv/bin"

  # System paths
  "/usr/local/sbin"
  "/usr/local/bin"
  "/usr/bin"
  "/usr/sbin"
  "/bin"
  "/sbin"
)

export PATH

#
# Tools
#

# rbenv
if (( ${+commands[rbenv]} )); then
  eval "$(rbenv init - zsh)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"

# Check standard system package path
if [[ -s "/usr/share/nvm/init-nvm.sh" ]]; then
    source "/usr/share/nvm/init-nvm.sh"

# Check standard user install path
elif [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
fi


#
# Functions
#

showpath() {
  print -l -- $path
}
