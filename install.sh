#!/bin/bash
set -e

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Exiting."
  exit 1
fi

echo "Starting system update..."
pacman -Syu --noconfirm --needed

###########################################
# Filesystem Snapshot Setup (Btrfs vs. Other)
###########################################
bash "$(dirname "$0")/modules/snapshot_recovery.sh"

#############################
# Install Hyprland
#############################
echo "Installing Hyprland..."
pacman -S --noconfirm --needed hyprland

pacman -S --noconfirm --needed sddm
systemctl enable sddm

###########################################
# Chaotic AUR Repository Setup
###########################################
bash "$(dirname "$0")/modules/chaotic_aur.sh"

###########################################
# Install AUR Helper (Choice)
###########################################
bash "$(dirname "$0")/modules/aur_helper.sh"

###########################################
# Install essential basic packages
###########################################
bash "$(dirname "$0")/modules/general_pkgs.sh"

###########################################
# Install Other Basic Packages & Drivers
###########################################
bash "$(dirname "$0")/modules/misc.sh"

echo "Basic installation and setup complete."
