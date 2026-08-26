#!/bin/zsh

# Paths to use for this configuration file.
ZSH_PLUGINS_DIRECTORY="/usr/share/zsh/plugins" # Path where zsh plugins are stored.

# zsh options.
setopt always_to_end        # Move cursor to the end of a completed word.
setopt auto_menu            # Show completion menu on successive tab press.
setopt auto_param_slash     # Append / to directory names on completion.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt autocd               # Change dir just by typing the dir name.
setopt complete_in_word     # Allow completion from within a word/phrase.
setopt correct              # Offer autocorrect for commands.
setopt extendedglob         # Use extended globbing features.
setopt hist_ignore_all_dups # Do not write duplicate commands to history.
setopt hist_ignore_space    # Do not save commands starting with a space.
setopt hist_reduce_blanks   # Remove extra blanks before saving command to history.
setopt hist_verify          # Load history expansions into the prompt for review before running.
setopt incappendhistory     # Write history incrementally.
setopt interactive_comments # Allow comments in interactive shells.
setopt no_beep              # Disable the annoying terminal beep.
setopt no_hup               # Don't kill background jobs when the shell exits.
setopt pushd_ignore_dups    # Don't push multiple copies of the same directory onto the stack.
setopt sharehistory         # Share history between all sessions.

# Interactive line editor configuration.
WORDCHARS=${WORDCHARS//[\/]/} # Affects word boundaries for movements/deletion.
DIRSTACKSIZE=9                # Limit directory stack memory for cd -.

# Keybinding fixes.
bindkey -e                       # Emacs mode
bindkey '^[[H' beginning-of-line # Home key
bindkey '^[[F' end-of-line       # End key
bindkey '^[[3~' delete-char      # Delete key
bindkey '^[[1;5C' forward-word   # Ctrl+Right
bindkey '^[[1;5D' backward-word  # Ctrl+Left

# History search based on partially typed commands.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search   # Up arrow
bindkey '^[[B' down-line-or-beginning-search # Down arrow

# History configuration.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Quality of life aliases.
alias grep="grep --color=auto"
alias ls="ls -lah --color=auto"
alias mkdir="mkdir -p"

# System log alias.
alias syslog="sudo tail -f /var/log/messages || sudo tail -f /var/log/syslog"

# Universal archive extractor tool.
extract() {
	if [ -f "$1" ]; then
		case "$1" in
		*.tar.bz2) tar xjf "$1" ;;
		*.tar.gz) tar xzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xf "$1" ;;
		*.tbz2) tar xjf "$1" ;;
		*.tgz) tar xzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*) echo "'$1' cannot be extracted via ex" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Kitty SSH wrapper. $ pacman -S kitty
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Completion support.
autoload -Uz compinit
compinit

# Tools: fnm.
if command -v fnm >/dev/null 2>&1; then
	eval "$(fnm env --use-on-cd)"
fi

# Tools: uv.
if command -v uv >/dev/null 2>&1; then
	eval "$(uv generate-shell-completion zsh)"
fi

# Tools: rustup.
if command -v rustup >/dev/null 2>&1; then
	source <(rustup completions zsh)
fi

# Tools: rv.
if command -v rv >/dev/null 2>&1; then
	eval "$(rv env zsh)"
fi

# Tools: Starship. $ pacman -S starship
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init zsh)"
else
	PROMPT='%F{green}%n@%m%f %F{blue}%~%f $ '
fi

# Plugins: command-not-found. $ pacman -S pkgfile
if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
	source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# Completion styling options.
zstyle ':completion:*' menu select                        # Navigable menu for completions.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive tab completion.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Match the colors to ls.

# Plugins: Autosuggestions. $ pacman -S zsh-autosuggestions
if [[ -s "$ZSH_PLUGINS_DIRECTORY/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
	ZSH_AUTOSUGGEST_MANUAL_REBIND=1
	source "$ZSH_PLUGINS_DIRECTORY/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Plugins: Syntax highlighting. $ pacman -S zsh-syntax-highlighting
if [[ -s "$ZSH_PLUGINS_DIRECTORY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
	source "$ZSH_PLUGINS_DIRECTORY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
