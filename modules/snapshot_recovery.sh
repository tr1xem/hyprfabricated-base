#!/bin/bash

ROOT_FS=$(findmnt -n -o FSTYPE /)

if [ "$ROOT_FS" == "btrfs" ]; then
  echo "Btrfs filesystem detected."
  echo "Select a system restore tool to install:"
  echo "1) BTRFS Assistant and BTRFS Snapshots"
  echo "2) Timeshift"
  echo "3) None"
  read -p "Enter option number [1-3]: " choice
  case "$choice" in
    1)
      echo "Installing Snapper and related tools..."
      pacman -S --noconfirm --needed snapper btrfs-assistant grub-btrfs
      snapper -c root create-config /
      echo "Snapper has been configured. You may wish to further adjust /etc/snapper/configs/root."
      ;;
    2)
      echo "Installing Timeshift..."
      pacman -S --noconfirm --needed timeshift
      ;;
    3)
      echo "No snapshot tool will be installed."
      ;;
    *)
      echo "Invalid option. No snapshot tool will be installed."
      ;;
  esac
else
  echo "Non-Btrfs filesystem detected."
  echo "Do you want to install Timeshift or nothing? (y/n)"
  read -r choice
  case "$choice" in
    y)
      echo "Installing Timeshift..."
      pacman -S --noconfirm --needed timeshift
      ;;
    n)
      echo "No snapshot tool will be installed."
      ;;
    *)
      echo "Invalid option. No snapshot tool will be installed."
      ;;
  esac
fi
