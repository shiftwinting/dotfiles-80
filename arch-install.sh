#!/usr/bin/env sh
set -e

current_wd="$(pwd)"

mkdir -p ~/repos/aur && cd ~/repos/aur

yay -Syu --needed base-devel pacman-contrib

if [ ! -d 'yay' ]; then
    git clone https://aur.archlinux.org/yay.git
    (
    cd yay || exit
    makepkg -si
    )
fi

yay -Syu --needed "$(cat ~/dotfiles/lists/pkglist.txt)"
yay -S --needed --asdeps "$(cat ~/dotfiles/lists/opt.txt)"

sudo reflector --country Spain --country Portugal --country France --age 12 --completion-percent 100 --sort score --cache-timeout 0 --connection-timeout 2 --fastest 10 --verbose --save /etc/pacman.d/mirrorlist

cd ~/dotfiles

sudo stow -t /etc -R etc

sudo cp systemd/network/* /etc/systemd/network/

sudo systemctl enable --now cpupower
sudo systemctl enable --now cronie
sudo systemctl enable --now earlyoom
sudo systemctl enable --now irqbalance
sudo systemctl enable --now systemd-networkd
sudo systemctl enable --now systemd-resolved
sudo systemctl enable --now systemd-resolved
sudo systemctl enable --now iwd
sudo systemctl enable --now sshd
sudo systemctl enable --now thermald
sudo systemctl enable --now acpid

~/dotfiles/create-efi.sh

cd "$current_wd" || exit

~/dotfiles/bootstrap.sh
