#!/usr/bin/env bash

echo 'Server dotfiles install initiated.'

fish -c 'set -U HOMESERVER true'

./update-bashrc

./install fd fish git tmux vim scripts lf javascript

cd ~/.dotfiles-personal 2> /dev/null && ./install-server.sh

echo 'Server dotfiles install complete.'

