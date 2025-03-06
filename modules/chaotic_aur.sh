#!/bin/bash

read -p "Do you want to enable Chaotic AUR? (y/n): " enable_chaotic
if [[ "$enable_chaotic" =~ ^[Yy]$ ]]; then
  echo "Enabling Chaotic AUR repository..."
  # Import Chaotic AUR key (adjust keyserver if necessary)
  pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
  pacman-key --lsign-key FBA220DFC880C036
  # Append repository entry if not already present
  if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
    cat <<EOF >> /etc/pacman.conf

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
  fi
  pacman -Sy --noconfirm --needed
fi
