#!/bin/bash
# Rofi menu for Quick Edit / View of Settings (SUPER E)

configs="$HOME/.config/hypr/configs"
UserConfigs="$HOME/.config/hypr/UserConfigs"

editor=nvim

menu(){
  printf "1. view Env-variables\n"
  printf "2. view Keybinds\n"
  printf "3. view Monitors\n"
  printf "4. view Settings\n"
  printf "5. view Startup_Apps\n"
  printf "6. view Window-Rules\n"
}

main() {
    choice=$(menu | rofi -dmenu -config ~/.config/rofi/config-compact.rasi | cut -d. -f1)
    case $choice in
        1)
            kitty -e $editor "$configs/ENVariables.conf"
            ;;
        2)
            kitty -e $editor "$configs/Keybinds.conf"
            ;;
        3)
            kitty -e $editor "$configs/Monitors.conf"
            ;;
        4)
            kitty -e $editor "$configs/Settings.conf"
            ;;
        5)
            kitty -e $editor "$configs/Startup_Apps.conf"
            ;;
        6)
            kitty -e $editor "$configs/WindowRules.conf"
            ;;
        *)
            ;;
    esac
}

main
