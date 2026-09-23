#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Random Wallpaper ( CTRL ALT W)

wallDIR="$HOME/Pictures/wallpapers"
scriptsDir="$HOME/.config/hypr/scripts"

monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`

# Retrieve image files
PICS=($(ls "${wallDIR}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))
RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"

for m in $monitor; do
    hyprctl hyprpaper wallpaper "$m,${wallDIR}/${RANDOM_PIC}"
done
ln -sf "${wallDIR}/${RANDOM_PIC}" "${wallDIR}/.current_wallpaper"
