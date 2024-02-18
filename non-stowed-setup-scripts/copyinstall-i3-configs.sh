#!/usr/bin/env bash

echo 'Starting copying of files for i3 setup'

sudo cp ~/.dotfiles/non-stowed-copied-files/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/.
sudo cp ~/.dotfiles/non-stowed-copied-files/50-enable-Cozette.conf /etc/fonts/conf.avail/.

echo 'Completed copying of files for i3 setup'
