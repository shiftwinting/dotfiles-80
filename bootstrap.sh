#!/usr/bin/env sh
current_wd="$(pwd)"

mkdir -p ~/repos
cd ~/repos || exit

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/nvim
mkdir -p ~/.config/mpv
mkdir -p ~/.vim/spell
mkdir -p ~/.gnupg
mkdir -p ~/.ssh/sockets
mkdir -p ~/.config/systemd/user
mkdir -p ~/.config/notmuch-config
mkdir -p ~/.config/wget
mkdir -p ~/.config/zsh
mkdir -p ~/.cache

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


cd ~/dotfiles && stow -R home

cd "$current_wd" || exit
