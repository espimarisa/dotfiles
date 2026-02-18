#!/bin/zsh

# Paths to use for this configuration file.
ZSH_PLUGINS_DIRECTORY="/usr/share/zsh/plugins" # Path where zsh plugins are stored.

# zsh options.
setopt auto_param_slash     # Append / to directory names on completion.
setopt autocd               # Change dir just by typing the dir name.
setopt correct              # Offer autocorrect for commands.
setopt extendedglob         # Use extended globbing features.
setopt hist_ignore_all_dups # Do not write duplicate commands to history.
setopt hist_verify          # Load history expansions into the prompt for review before running.
setopt incappendhistory     # Write history incrementally.
setopt interactive_comments # Allow comments in interactive shells.
setopt no_beep              # Disable the annoying terminal beep.
setopt sharehistory         # Share history between all sessions.

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

# Completion support. $ paru -S zsh-completions
autoload -Uz compinit
compinit

# Desktop environment fixes.
export GTK_USE_PORTAL=1               # Use the KDE file picker. $ paru -S xdg-desktop-portal-kde
export GTK_MODULES=appmenu-gtk-module # Global menu support. $ paru -S appmenu-gtk-module

# Environment configuration.
export LANG="en_US.UTF-8"            # Locale configuration.
export EDITOR="micro"                # Sets the editor. $ paru -S micro xclip wl-clipboard
export PAGER="less"                  # Sets the pager. $ paru -S less
export WORDCHARS=${WORDCHARS//[\/]/} # Affects word boundaries for movements/deletion.

# History configuration.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Quality of life aliases.
alias grep="grep --color=auto"
alias ls="ls -lah --color=auto"
alias mkdir="mkdir -p"

# Paru package management aliases. $ paru
alias update="paru -Syu"                               # Update the system.
alias cleanup="paru -c"                                # Clean paru cache.
alias lsorphans="paru -Qtdq"                           # List orphaned packages.
alias rmorphans="paru -Qtdq | paru -Rns - --noconfirm" # Remove orphaned packages.

# Command examples. $ paru -S tealdeer
alias tldr="tldr --update" # Auto-updates cache before searching.

# Path configuration.
typeset -U path PATH
path=(
	"$HOME/.local/bin"
	"$HOME/.cargo/bin" # Rust binaries.
	$path
)
export PATH

# Kitty SSH wrapper. Resolves terminfo issues on remote servers.
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Tools: rbenv. $ paru -S rbenv ruby-build.
if [[ -d "$HOME/.rbenv/bin" ]]; then
	path=("$HOME/.rbenv/bin" $path)
fi
if command -v rbenv >/dev/null 2>&1; then
	eval "$(rbenv init - zsh)"
fi

# Tools: nvm. $ paru -S nvm
if [[ -s "/usr/share/nvm/init-nvm.sh" ]]; then
	source "/usr/share/nvm/init-nvm.sh"
elif [[ -s "$HOME/.nvm/nvm.sh" ]]; then
	source "$HOME/.nvm/nvm.sh"
fi

# Tools: Starship. $ paru -S starship
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init zsh)"
else
	# Fallback prompt.
	PROMPT='%F{green}%n@%m%f %F{blue}%~%f $ '
fi

# Plugins: command-not-found. $ paru -S pkgfile
if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
	source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# Plugins: Autosuggestions. $ paru -S zsh-autosuggestions
if [[ -s "$ZSH_PLUGINS_DIRECTORY/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
	ZSH_AUTOSUGGEST_MANUAL_REBIND=1
	source "$ZSH_PLUGINS_DIRECTORY/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Plugins: Syntax highlighting. $ paru -S zsh-syntax-highlighting
if [[ -s "$ZSH_PLUGINS_DIRECTORY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
	source "$ZSH_PLUGINS_DIRECTORY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
