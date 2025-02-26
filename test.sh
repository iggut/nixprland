#!/usr/bin/env bash

clear

# NiXprLand logo
printf "\n%.0s" {1..2}
echo -e "\e[35m
    ███╗   ██╗██╗██╗  ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗ 
    ████╗  ██║██║╚██╗██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗
    ██╔██╗ ██║██║ ╚███╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║
    ██║╚██╗██║██║ ██╔██╗ ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║
    ██║ ╚████║██║██╔╝ ██╗██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝
    ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ 
\e[0m"
printf "\n%.0s" {1..1}

# Set colors
OK=$(tput setaf 2)[OK]$(tput sgr0)
ERROR=$(tput setaf 1)[ERROR]$(tput sgr0)
NOTE=$(tput setaf 3)[NOTE]$(tput sgr0)

set -euo pipefail

# Set Nix configuration for flakes
export NIX_CONFIG="experimental-features = nix-command flakes"

# Verify NixOS
if ! grep -qi nixos /etc/os-release; then
    echo "$ERROR This script must be run on NixOS"
    exit 1
fi

# Get user info
CURRENT_USER=$(whoami)
HARDWARE_PROFILE=$(sudo nixos-generate-config --show-hardware-config 2>&1 | grep -oP 'using hardware profile \K\w+')

# Setup directories
BACKUP_DIR="$HOME/.config/nixprland-backups"
FLAKE_DIR="$HOME/nixprland"
GTK_TMP_DIR=$(mktemp -d)
DOTS_TMP_DIR=$(mktemp -d)

mkdir -p "$BACKUP_DIR"

# Backup existing config
if [ -d "$FLAKE_DIR" ]; then
    echo "$NOTE Backing up existing configuration..."
    BACKUP_NAME="nixprland-$(date +%Y%m%d%H%M%S)"
    mv "$FLAKE_DIR" "$BACKUP_DIR/$BACKUP_NAME"
fi

# Clone main repo
echo "$NOTE Cloning nixprland repository..."
git clone https://github.com/iggut/nixprland.git "$FLAKE_DIR"
cd "$FLAKE_DIR" || exit 1

# Configure host directory
echo "$NOTE Setting up host configuration..."
mkdir -p "hosts/$HOSTNAME"
cp hosts/default/*.nix "hosts/$HOSTNAME/"

# Keyboard configuration
echo "$NOTE Configuring keyboard settings..."
read -rp "Enter keyboard layout [us]: " keyboardLayout
keyboardLayout=${keyboardLayout:-us}
read -rp "Enter console keymap [us]: " consoleKeyMap
consoleKeyMap=${consoleKeyMap:-us}

sed -i "s/keyboardLayout = \".*\"/keyboardLayout = \"$keyboardLayout\"/" "hosts/$HOSTNAME/variables.nix"
sed -i "s/consoleKeyMap = \".*\"/consoleKeyMap = \"$consoleKeyMap\"/" "hosts/$HOSTNAME/variables.nix"

# Configure flake
echo "$NOTE Configuring system profile..."
sed -i "s/host = \".*\"/host = \"$HOSTNAME\"/" flake.nix
sed -i "s/username = \".*\"/username = \"$CURRENT_USER\"/" flake.nix

# Generate hardware config
echo "$NOTE Generating hardware configuration..."
sudo nixos-generate-config --show-hardware-config > "hosts/$HOSTNAME/hardware.nix"

# Build system
echo "$NOTE Building system configuration..."
sudo nixos-rebuild switch --flake ".#$HOSTNAME"

# Install GTK themes and icons
echo "$NOTE Installing GTK themes and icons..."
git clone --depth 1 https://github.com/iggut/GTK-themes-icons.git "$GTK_TMP_DIR"
cd "$GTK_TMP_DIR" && chmod +x auto-extract.sh && ./auto-extract.sh
cd && rm -rf "$GTK_TMP_DIR"
echo "$OK GTK themes & icons installed to ~/.icons & ~/.themes"

# Install Hyprland dots
echo "$NOTE Installing Hyprland configuration..."
git clone --depth 1 https://github.com/iggut/Hyprland-Dots.git "$DOTS_TMP_DIR"
cd "$DOTS_TMP_DIR" && chmod +x copy.sh && ./copy.sh
cd && rm -rf "$DOTS_TMP_DIR"
echo "$OK Hyprland dotfiles installed"

# Final message
cat << EOF

${OK} Installation complete!
${NOTE} Installed components:
  - NixOS system configuration
  - Keyboard layout: $keyboardLayout
  - Console keymap: $consoleKeyMap
  - GTK themes/icons
  - Hyprland dotfiles
  - User: $CURRENT_USER
  - Hostname: $HOSTNAME
  - Hardware profile: $HARDWARE_PROFILE

${NOTE} Recommended next steps:
  1. Reboot your system
  2. Run 'Hyprland' to start the compositor
  3. Check ~/.config/hypr for configuration files

EOF

read -rp "Reboot now? (y/N): " REBOOT_CHOICE
if [[ "$REBOOT_CHOICE" =~ [Yy] ]]; then
    systemctl reboot
fi