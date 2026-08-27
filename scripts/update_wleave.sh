#!/usr/bin/bash

cd "$HOME/projects/rust/wleave"
git pull
cargo build --release
sudo cp target/release/wleave /usr/bin

sudo mkdir -p /etc/wleave
sudo mkdir -p /usr/share/wleave/icons

sudo cp style.css /etc/wleave
sudo cp layout.json /etc/wleave
sudo cp completions/wleave.bash /usr/share/bash-completion/completions/wleave
sudo cp completions/_wleave /usr/share/zsh/site-functions/_wleave
sudo cp icons/*.svg /usr/share/wleave/icons
