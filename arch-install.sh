#!/usr/bin/env sh
set -e

current_wd="$(pwd)"

mkdir -p ~/repos && cd ~/repos

if [ ! -d 'yay' ]; then
    git clone https://aur.archlinux.org/yay.git
    (
    cd yay || exit
    makepkg -si
    )
fi

yay -Syu --needed "$(cat ~/dotfiles/pacman/pkglist.txt)"
yay -S --needed --asdeps "$(cat ~/dotfiles/pacman/optdeplist.txt)"

reflector --country Spain --country Portugal --country France --latest 20 --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist; rm -f /etc/pacman.d/mirrorlist.pacnew

cd "$current_wd" || exit
