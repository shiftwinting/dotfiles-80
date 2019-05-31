#!/usr/bin/env sh

cd ~/dotfiles
xargs -a list4stow.txt stow -R
