# Path configuration.
typeset -U path PATH
path=(
	"$HOME/.local/bin"
	"$HOME/.cargo/bin"
	$path
)
export PATH

# Environment configuration.
export LANG="en_US.UTF-8" # Configures the language and locale.
export EDITOR="micro"     # Configures the editor.
export PAGER="less"       # Configures the pager.

# Desktop environment fixes.
export GTK_USE_PORTAL=1               # Use the KDE file picker.
export GTK_MODULES=appmenu-gtk-module # Enables global menu support.
export UBUNTU_MENUPROXY=1             # Enables global menu support for really old applications apparently?
