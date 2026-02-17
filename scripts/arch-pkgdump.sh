#!/bin/sh

# This script outputs all installed packages via paru to a text file.
# To install from the file, run paru -S --needed - < ~/.pkglist.txt

paru -Qq >~/.pkglist.txt
