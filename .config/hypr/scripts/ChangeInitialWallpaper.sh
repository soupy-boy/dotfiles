#!/bin/bash

# ChangeInitialWallpaper.sh
# Dynamically updates hyprpaper.conf and hyprlock.conf with wallpaper

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <wallpaper_path>"
    exit 1
fi

echo "begin change initial wallpaper script"
# Define the path to hyprpaper.conf using an environment variable

HYPRLOCK_CONF_PATH="$HOME/.config/hypr/hyprlock.conf"
HYPRPAPER_CONF_PATH="$HOME/.config/hypr/hyprpaper.conf"

# Get the wallpaper path and filename
wallpaper_path="$1"
wallpaper_name=$(basename "$wallpaper_path")

# if wallpaper doesn't exist exit
if [ ! -f "$wallpaper_path" ]; then
    echo "Warning: wallpaper does not exist, skipping intial wallpaper changes."
    exit 1
fi

# convert absolute path to ~ notation for configs
wallpaper_path_tilde=$(echo "$wallpaper_path" | sed "s|^$HOME|~|")

# set wallpaper in hyprlock.conf
sed -i "/^background {/ ,/^}/ s|^\(\s*path\s*=\s*\).*|\1$wallpaper_path_tilde|" "$HYPRLOCK_CONF_PATH"

# set wallpaper in hyprpaper.conf
# Replace only the wallpaper path, keep monitor names intact
sed -i -E "s|(path[[:blank:]]*=[[:blank:]]*)[^[:blank:]}]*|\1${wallpaper_path_tilde}|g" "$HYPRPAPER_CONF_PATH"
