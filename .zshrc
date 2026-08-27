# set gruvbox color scheme in linux tty (vc)
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0282828
  \e]P1cc241d
  \e]P298971a
  \e]P3d79921
  \e]P4458588
  \e]P5b16286
  \e]P6689d6a
  \e]P7a89984
  \e]P8928374
  \e]P9fb4934
  \e]PAb8bb26
  \e]PBfabd2f
  \e]PC83a598
  \e]PDd3869b
  \e]PE8ec07c
  \e]PFebdbb2
  "
  # get rid of artifacts
  clear
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=( 
    git
    zsh-autosuggestions
    fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
pokemon-colorscripts --no-title -s -r


# for ssh agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export EDITOR=nvim
export VISUAL=$EDITOR

# android development
export JAVA_HOME=/opt/android-studio/jbr

# path stuff
export PATH=$PATH:/usr/lib/emscripten
export PATH="$HOME/.cargo/bin:$PATH"

# aliases
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# load local env vars (hidden so i don't commit to public dotfiles)
[ -f "$HOME/.zshrc_local" ] && source "$HOME/.zshrc_local"
