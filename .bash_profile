# Prefer the KDE file picker.
export GTK_USE_PORTAL=1

# Fix GTK apps missing their menu bars.
export GTK_MODULES="unity-gtk-module"
export SAL_USE_VCLPLUGIN=gtk

eval "dbus-launch --auto-syntax"
