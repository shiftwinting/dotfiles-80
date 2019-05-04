#! /usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    echo "This script needs to be run as root:"
    exec sudo -- "$0" "$@"
fi


DISTRO=$(lsb_release -d | awk -F" " '{print $2}')

if [[ $DISTRO == "Ubuntu" ]]; then
    add-apt-repository -y ppa:jonathonf/vim
    add-apt-repository -y ppa:neovim-ppa/stable
    add-apt-repository -y ppa:dawidd0811/neofetch
    add-apt-repository -y ppa:jonathonf/i3
    add-apt-repository -y ppa:jasonpleau/rofi
fi

apt update
apt install -y \
    stow \
    ripgrep \
    zsh \
    mpv \
    i3 \
    i3blocks \
    i3lock \
    rofi \
    youtube-dl \
    neofetch \
    ranger \
    vim \
    vim-nox \
    vim-gtk \
    neovim \
    nnn \
    tmux \
    imagemagick \
    scrot \
    sxiv \
    node \
    yarn \
    ruby-dev \
    zathura \
    libnotify


if [[ $DISTRO == "Ubuntu" ]]; then
    CWD=$(pwd)
    cd /tmp
    wget http://ftp.es.debian.org/debian/pool/main/i/i3lock-fancy/i3lock-fancy_0.0~git20160228.0.0fcb933-2_amd64.deb
    dpkg -i i3lock-fancy_0.0~git20160228.0.0fcb933-2_amd64.deb
    cd $CWD
else
    apt install -y \
        i3lock-fancy \
        python-neovim \
        python3-neovim
fi

snap install acestreamplayer
gem install neovim
npm install -g neovim
