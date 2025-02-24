#!/usr/bin/env bash

clear

printf "\n%.0s" {1..2}  
echo -e "\e[35m
	╦╔═┌─┐┌─┐╦    ╦ ╦┬ ┬┌─┐┬─┐┬  ┌─┐┌┐┌┌┬┐
	╠╩╗│ ││ │║    ╠═╣└┬┘├─┘├┬┘│  ├─┤│││ ││ 2025
	╩ ╩└─┘└─┘╩═╝  ╩ ╩ ┴ ┴  ┴└─┴─┘┴ ┴┘└┘─┴┘ 
\e[0m"
printf "\n%.0s" {1..1}

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
WARN="$(tput setaf 1)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
MAGENTA="$(tput setaf 5)"
ORANGE="$(tput setaf 214)"
WARNING="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
SKY_BLUE="$(tput setaf 6)"
RESET="$(tput sgr0)"

set -e 


echo "-----"
printf "\n%.0s" {1..2}




echo "-----"
printf "\n%.0s" {1..3}

# Clean up
# GTK Themes and Icons
if [ -d "GTK-themes-icons" ]; then
    echo "$NOTE GTK themes and Icons folder exist..deleting..." 
    rm -rf "GTK-themes-icons" 
fi

echo "-----"
printf "\n%.0s" {1..3}


# Cloning Hyprland-Dots repo to home folder
# KooL's Dots installation
printf "$NOTE Downloading Hyprland-Dots to HOME folder..\n"
if [ -d ~/Hyprland-Dots ]; then
  cd ~/Hyprland-Dots
  git stash
  git pull
  git stash apply
  chmod +x copy.sh
  ./copy.sh 
else
  if git clone --depth 1 https://github.com/JaKooLit/Hyprland-Dots ~/Hyprland-Dots; then
    cd ~/Hyprland-Dots || exit 1
    chmod +x copy.sh
    ./copy.sh 
  else
    echo -e "$ERROR Can't download Hyprland-Dots"
  fi
fi


printf "\n%.0s" {1..2}
if command -v Hyprland &> /dev/null; then
  printf "\n${OK} Yey! Installation Completed.${RESET}\n"
  sleep 2
  printf "\n${NOTE} You can start Hyprland by typing Hyprland (note the capital H!).${RESET}\n"
  printf "\n${NOTE} It is highly recommended to reboot your system.${RESET}\n\n"

  # Prompt user to reboot
  read -rp "${CAT} Would you like to reboot now? (y/n): ${RESET}" HYP

  if [[ "$HYP" =~ ^[Yy]$ ]]; then
    # If user confirms, reboot the system
    systemctl reboot
  else
    # Print a message if the user does not want to reboot
    echo "Reboot skipped."
  fi
else
  # Print error message if Hyprland is not installed
  printf "\n${WARN} Hyprland failed to install. Please check Install-Logs...${RESET}\n\n"
  exit 1
fi