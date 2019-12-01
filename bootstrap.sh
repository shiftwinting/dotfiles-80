#!/usr/bin/env sh
set -e

current_wd="$(pwd)"

mkdir -p ~/repos && cd ~/repos

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/nvim
mkdir -p ~/.config
mkdir -p ~/.vim/spell

if [ ! -d 'st' ]; then
    git clone git@github.com:ruifm/st.git
    (
    cd st || exit
    make install
    git remote add upstream https://git.suckless.org/st
    git remote update
    )
fi

[ ! -d 'i3blocks-contrib' ] && git clone https://github.com/vivien/i3blocks-contrib.git

if [ ! -d 'surf' ]; then
    git clone git@github.com:ruifm/surf.git
    (
    cd surf || exit
    make install
    git remote add upstream https://git.suckless.org/surf
    git remote update
    )
fi

~/dotfiles/scripts/bin/stow_all.sh

cd "$current_wd" || exit
