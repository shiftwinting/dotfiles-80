#!/usr/bin/env sh
current_wd="$(pwd)"

mkdir -p ~/repos/aur

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/nvim
mkdir -p ~/.local/etc
mkdir -p ~/.local/include
mkdir -p ~/.local/lib
mkdir -p ~/.local/libexec
mkdir -p ~/.config/mpv/watch_later
mkdir -p ~/.vim/spell
mkdir -p ~/.ssh/sockets
mkdir -p ~/.config/systemd/user
mkdir -p ~/.config/notmuch-config
mkdir -p ~/.config/wget
touch ~/.config/wget/wgetrc
mkdir -p ~/.config/spotify-tui
mkdir -p ~/.config/aspell
mkdir -p ~/.config/bash-completion
mkdir -p ~/.config/cargo
mkdir -p ~/.config/nv
mkdir -p ~/.config/less
touch ~/.config/wget/lesskey
mkdir -p ~/.local/share/terminfo
mkdir -p ~/.config/X11
mkdir -p ~/.config/tmux
mkdir -p ~/.config/abook
mkdir -p ~/.config/calcurse
mkdir -p ~/.local/share/calcurse
mkdir -p ~/.config/gdb
mkdir -p ~/.config/nvidia
mkdir -p ~/.config/zsh
mkdir -p ~/.cache
mkdir -p ~/.config/npm
mkdir -p ~/.cache/npm
mkdir -p ~/.local/share/npm

# cp ~/dotfiles/systemd/* ~/.config/systemd/user

# cd ~/repos || exit
# systemctl --user enable --now tmux@ssh
# systemctl --user enable --now tmux@tty

# if [ ! -d 'st' ]; then
#     git clone https://github.com/ruifm/st.git
#     (
#     cd st || exit
#     git remote add upstream https://git.suckless.org/st
#     git remote update
#     )
# fi


cd ~/dotfiles || exit
stow -R home || ~/.local/bin/stow -R home

cd "$current_wd" || exit
