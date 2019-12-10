#!/usr/bin/env sh
current_wd="$(pwd)"

mkdir -p ~/repos && cd ~/repos

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/nvim
mkdir -p ~/.config
mkdir -p ~/.vim/spell
mkdir -p ~/.gnupg
mkdir -p ~/.ssh/sockets

cp -r ~/dotfiles/systemd ~/.config
systemctl --user enable --now tmux@ssh
systemctl --user enable --now tmux@tty

if [ ! -d 'st' ]; then
    git clone https://github.com/ruifm/st.git
    (
    cd st || exit
    make install
    git remote add upstream https://git.suckless.org/st
    git remote update
    )
fi

[ ! -d 'i3blocks-contrib' ] && git clone https://github.com/vivien/i3blocks-contrib.git

if [ ! -d 'surf' ]; then
    git clone https://github.com/ruifm/surf.git
    (
    cd surf || exit
    make install
    git remote add upstream https://git.suckless.org/surf
    git remote update
    )
fi

~/dotfiles/scripts/.local/bin/stow_all.sh

cd "$current_wd" || exit
