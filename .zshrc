#!/bin/zsh

export ZIM_HOME="${HOME}/.zim"

# Auto install zimfw.zsh if missing.
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
	mkdir -p "${ZIM_HOME}"
	print -R "Zim: Downloading zimfw.zsh..."
	curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
		https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh

fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc}" ]]; then
	# Check if zimfw.zsh exists before trying to source it.
	if [[ -f "${ZIM_HOME}/zimfw.zsh" ]]; then
		print -R "Zim: Initializing modules..."
		source "${ZIM_HOME}/zimfw.zsh" init
	fi
fi

# Source Zim's generated init script.
if [[ -s "${ZIM_HOME}/init.zsh" ]]; then
	source "${ZIM_HOME}/init.zsh"
fi

WORDCHARS=${WORDCHARS//[\/]/}              # Affects word boundaries for movements/deletion.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1            # Autosuggestion support.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets) # Highlighting support.
setopt auto_param_slash                    # Append / to directory names on completion.
setopt autocd                              # Change dir just by typing the dir name.
setopt correct                             # Auto correct commands.
setopt extendedglob                        # Use extended globbing features.
setopt HIST_IGNORE_ALL_DUPS                # If a new command is identical to an older one, remove the older one.
setopt incappendhistory                    # Write history incrementally.
setopt interactive_comments                # Allow comments even in interactive shells.
setopt sharehistory                        # Share history between all sessions.
export EDITOR="micro"                      # Use micro as the editor.
export PAGER="less"                        # Use less as the pager.
export LANG="en_US.UTF-8"                  # en_US
alias grep="grep --color=auto"             # Use color in grep.
alias ls="ls --color=auto"                 # Use color in ls.

typeset -U path
path=(
	"$HOME/bin"
	"$HOME/.local/bin"
	"$HOME/.bun/bin"   # Bun binaries
	"$HOME/.cargo/bin" # Cargo binaries
	"/usr/local/sbin"
	"/usr/local/bin"
	"/usr/bin"
	"/usr/sbin"
	"/bin"
	"/sbin"
)

export PATH
export NVM_DIR="$HOME/.nvm" # NVM

# Check standard system package path for nvm.
if [[ -s "/usr/share/nvm/init-nvm.sh" ]]; then
	source "/usr/share/nvm/init-nvm.sh"

# Check standard user install path for nvm.
elif [[ -s "$NVM_DIR/nvm.sh" ]]; then
	source "$NVM_DIR/nvm.sh"
fi
