#! /usr/bin/env bash
set -e
stow X
stow acestream-launcher
stow git
stow i3
stow i3blocks
stow kitty
stow mpv
stow neofetch
stow ranger
stow rofi
stow tmux
stow vim
stow youtube-dl

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm -f ~/.zshrc
stow zsh
