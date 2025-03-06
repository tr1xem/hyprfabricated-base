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
bash "$(dirname "$0")/modules/general_pkgs.sh" $aur_helper

###########################################
# Install Other Basic Packages & Drivers
###########################################
bash "$(dirname "$0")/modules/misc.sh"

###########################################
# Install Grub CyberRe theme
###########################################
echo "Install CyberRe grub theme? [Y/n]: "
read -r choice
case "$choice" in
  "y"|"Y"|"")
      bash "$(dirname "$0")/modules/grub_theme.sh"
      ;;
    "n"|"N")
      echo "No grub theme will be installed."
      ;;
    *)
      echo "Invalid option. No grub theme will be installed."
      ;;
  esac

echo "Basic installation and setup complete."
echo "Installing hyprfabricated..."

###########################################
# Install hyprfabricated
###########################################
curl -fsSL https://raw.githubusercontent.com/tr1xem/hyprfabricated/main/install.sh | bash
