#!/bin/bash

echo "Installing basic packages: git, NetworkManager, Bluetooth, NeoVim, and drivers..."
pacman -S --noconfirm --needed networkmanager bluez bluez-utils
systemctl enable NetworkManager

# Additional packages
echo "Installing additional useful packages..."
pacman -S --noconfirm --needed fastfetch git

# Install common GPU drivers
pacman -S --noconfirm --needed mesa

# Detect and install AMD/ATI Vulkan driver
if lspci | grep -E -i "VGA|3D" | grep -q "AMD\|ATI"; then
  echo "AMD/ATI GPU detected. Installing vulkan-radeon..."
  pacman -S --noconfirm --needed vulkan-radeon
fi

# Detect and install Intel Vulkan driver
if lspci | grep -E -i "VGA|3D" | grep -q "Intel"; then
  echo "Intel GPU detected. Installing vulkan-intel..."
  pacman -S --noconfirm --needed vulkan-intel
fi

if [ -n "$aur_helper" ]; then
  $aur_helper -S --noconfirm --needed auto-cpufreq
else
  echo "No AUR helper installed. Skipping auto-cpufreq installation."
fi
