#!/usr/bin/env bash

echo 'Debian dotfiles install initiated.'

./update-bashrc

./install fd fish git tmux vim scripts lf javascript i3 fonts

./copyinstall-i3-configs.sh

cd ~/.dotfiles-personal 2> /dev/null && ./install-desktop.sh

echo 'Debian dotfiles install complete.'

