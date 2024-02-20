#!/usr/bin/env bash

echo 'WSL dotfiles install initiated.'

./update-bashrc

./install fd fish git tmux vim scripts lf

# Only executes if in wsl
./configure-wsl

echo 'WSL dotfiles install complete.'

