#!/usr/bin/env sh

cd ~/dotfiles
xargs -a lists/essential4stow.txt stow -R
