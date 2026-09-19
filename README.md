dotfiles repository for all configuration and scripts that i have

# manual installs

## pokemon-colorscripts
```bash
git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
cd pokemon-colorscripts
sudo ./install.sh
```

## wleave
```bash
cd scripts
./update_wleave.sh
```

## proton ge
```bash
cd scripts
./protonge_update.sh
```

## setup for dotfiles itself

### config add on all files you want tracked
```bash
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
config config filter.home.clean 'sed "s|$HOME|@@HOMEDIR@@|g"'
config config filter.home.smudge 'sed "s|@@HOMEDIR@@|$HOME|g"'
config add ~/.config/waybar
```

# attributions

## code adapted from JaKooLit Hyprland-Dots originally, still using many scripts originally from here - https://github.com/JaKooLit/Hyprland-Dots
## Gruvminimal theme for gtk, kvantum, and qt - https://github.com/MrVivekRajan/Hypr-Dots
