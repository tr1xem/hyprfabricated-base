#!/bin/bash

echo "Select an AUR helper to install:"
echo "1) yay"
echo "2) paru"
echo "3) yay-bin"
echo "4) paru-bin"
echo "5) None"
read -p "Enter option number [1-5]: " aur_choice

install_aur_helper() {
  local repo_url=$1
  local pkg_dir=$(basename "$repo_url" .git)
  pacman -S --noconfirm --needed base-devel git
  cd /tmp
  if [ -d "$pkg_dir" ]; then
    rm -rf "$pkg_dir"
  fi
  git clone "$repo_url"
  cd "$pkg_dir"
  makepkg -si --noconfirm --needed
  cd /tmp
}

case $aur_choice in
  1)
    echo "Installing yay from AUR..."
    install_aur_helper "https://aur.archlinux.org/yay.git"
    aur_helper="yay"
    ;;
  2)
    echo "Installing paru from AUR..."
    install_aur_helper "https://aur.archlinux.org/paru.git"
    aur_helper="paru"
    ;;
  3)
    echo "Installing yay-bin from official repos..."
    pacman -S --noconfirm --needed yay-bin
    aur_helper="yay"
    ;;
  4)
    echo "Installing paru-bin from official repos..."
    pacman -S --noconfirm --needed paru-bin
    aur_helper="paru"
    ;;
  5)
    echo "Skipping AUR helper installation."
    aur_helper=""
    ;;
  *)
    echo "Invalid option. Skipping AUR helper installation."
    aur_helper=""
    ;;
esac
