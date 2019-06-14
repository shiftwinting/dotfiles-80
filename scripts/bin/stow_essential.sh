#!/usr/bin/env sh

cd ~/dotfiles
xargs -a essential4stow.txt stow -R
