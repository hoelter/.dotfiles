#!/usr/bin/env bash

echo 'Starting copying of files for i3 setup'

sudo cp -n ~/.dotfiles/non-stowed-copied-files/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/. || true

# Had issue with neovim xterm colors
# sudo cp ~/.dotfiles/non-stowed-copied-files/30bpp-displayp3colorsupport.conf /etc/X11/xorg.conf.d/. || true

echo 'Completed copying of files for i3 setup'
