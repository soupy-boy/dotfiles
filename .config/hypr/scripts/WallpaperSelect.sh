#!/bin/bash
# This script for selecting wallpapers (SUPER W)

SCRIPTSDIR="$HOME/.config/hypr/scripts"

# WALLPAPERS PATH
wallDIR="$HOME/Pictures/wallpapers"

monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`

# Retrieve image files
PICS=($(ls "${wallDIR}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))
RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME="${#PICS[@]}. random"

# Rofi command
rofi_command="rofi -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"

menu() {
  for i in "${!PICS[@]}"; do
    # Displaying .gif to indicate animated images
    if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
      printf "$(echo "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${wallDIR}/${PICS[$i]}\n"
    else
      printf "${PICS[$i]}\n"
    fi
  done

  printf "$RANDOM_PIC_NAME\n"
}


main() {
  choice=$(menu | ${rofi_command})

  # No choice case

  if [[ -z $choice ]]; then
    exit 0
  fi

  # Random choice case
  if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
    for m in $monitor; do
        hyprctl hyprpaper wallpaper "$m, ${wallDIR}/${RANDOM_PIC}"
    done
    ${SCRIPTSDIR}/ChangeInitialWallpaper.sh "${wallDIR}/${RANDOM_PIC}"
    exit 0
  fi

  # Find the index of the selected file
  pic_index=-1
  for i in "${!PICS[@]}"; do
    filename=$(basename "${PICS[$i]}")
    if [[ "$filename" == "$choice"* ]]; then
      pic_index=$i
      break
    fi
  done

  if [[ $pic_index -ne -1 ]]; then
    for m in $monitor; do
        hyprctl hyprpaper wallpaper "$m, ${wallDIR}/${PICS[$pic_index]}"
    done
    ${SCRIPTSDIR}/ChangeInitialWallpaper.sh "${wallDIR}/${PICS[$pic_index]}"
  else
    echo "Image not found."
    exit 1
  fi
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

main

