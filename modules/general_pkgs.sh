#!/bin/bash

source "$(dirname "$0")/../defaults"

# Install terminal
pacman -S --noconfirm --needed $TERMINAL

# Install file manager
pacman -S $FILE_MANAGER gvfs gvfs-mtp gvfs-afc gvfs-gphoto2 udisks2 polkit

# Install browser
pacman -S $BROWSER

# Install text editor
pacman -S --noconfirm --needed $EDITOR
