#!/usr/bin/env sh
set -e

current_wd=$(pwd)

cat ~/dotfiles/lists/groups.txt | sudo pacman -Syu -
cat ~/dotfiles/lists/nativepkgs.txt | sudo pacman -Syu -

mkdir -p ~/pics/screenshots
mkdir -p ~/repos

cd ~/repos

if [ ! -d 'yay' ]; then
    git clone https://aur.archlinux.org/yay.git
    (
    cd yay || exit
    makepkg -si
    )
fi

yay -Syu - < ~/dotfiles/lists/aurpkgs.txt

gem install neovim
npm install -g neovim

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

mkdir -p ~/.local/bin
mkdir -p ~/.local/share
mkdir -p ~/.config
mkdir -p ~/.vim

~/dotfiles/scripts/bin/stow_all.sh

cd "$current_wd" || exit
