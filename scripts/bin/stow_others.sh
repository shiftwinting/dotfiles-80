#!/usr/bin/env sh

cd ~/dotfiles
xargs -a lists/list4stow.txt stow -R
