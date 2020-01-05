#!/usr/bin/env sh
current_wd="$(pwd)"

mkdir -p ~/repos && cd ~/repos

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/nvim
mkdir -p ~/.config/mpv
mkdir -p ~/.vim/spell
mkdir -p ~/.gnupg
mkdir -p ~/.ssh/sockets
mkdir -p ~/.config/systemd/user

cp ~/dotfiles/systemd/* ~/.config/systemd/user
systemctl --user enable --now tmux@ssh
systemctl --user enable --now tmux@tty

if [ ! -d 'st' ]; then
    git clone https://github.com/ruifm/st.git
    (
    cd st || exit
    git remote add upstream https://git.suckless.org/st
    git remote update
    )
fi

[ ! -d 'i3blocks-contrib' ] && git clone https://github.com/vivien/i3blocks-contrib.git

cd ~/dotfiles && stow -R home

cd "$current_wd" || exit
