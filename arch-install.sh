#!/usr/bin/env sh
set -e

current_wd="$(pwd)"

mkdir -p ~/repos && cd ~/repos

yay -Syu --needed base-devel pacman-contrib

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

cd ~/dotfiles

sudo stow -t /etc -R etc

sudo systemctl enable --now cpupower
sudo systemctl enable --now cronie
sudo systemctl enable --now earlyoom
sudo systemctl enable --now irqbalance
sudo systemctl enable --now dhcpcd
sudo systemctl enable --now iwd
sudo systemctl enable --now ntpd
sudo systemctl enable --now sshd
sudo systemctl enable --now thermald
sudo systemctl enable --now acpid

~/dotfiles/create-efi.sh

cd "$current_wd" || exit

~/dotfiles/bootstrap.sh
