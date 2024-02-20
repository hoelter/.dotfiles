#!/usr/bin/env bash

echo 'Macbook dotfiles install initiated.'

fish -c 'set -U MACBOOK true'

./update-zshrc

# echo "Creating podman to docker alias"
# ln -s /opt/homebrew/bin/podman ~/.local/bin/docker

./install fd fish git tmux vim kitty scripts lf javascript alacritty

cd ~/.dotfiles-personal 2> /dev/null && ./install-macbook.sh

echo 'Macbook dotfiles install complete.'


