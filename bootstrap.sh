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
mkdir -p ~/.ssh/sockets
mkdir -p ~/.config/systemd/user
mkdir -p ~/.config/notmuch
mkdir -p ~/.config/wget
mkdir -p ~/.config/spotify-tui
mkdir -p ~/.config/aspell
mkdir -p ~/.config/bash-completion
mkdir -p ~/.config/cargo
mkdir -p ~/.config/nv
mkdir -p ~/.config/mutt/accounts
mkdir -p ~/.config/less
mkdir -p ~/.local/share/terminfo
mkdir -p ~/.config/X11
mkdir -p ~/.config/tmux
mkdir -p ~/.config/abook
mkdir -p ~/.config/calcurse
mkdir -p ~/.config/iptyhon/profile_default
mkdir -p ~/.local/share/calcurse
mkdir -p ~/.config/gdb
mkdir -p ~/.config/nvidia
mkdir -p ~/.config/zsh
mkdir -p ~/.config/npm
mkdir -p ~/.config/vim/spell
mkdir -p ~/.config/isync
mkdir -p ~/.cache/npm
mkdir -p ~/.local/share/npm
mkdir -p ~/.local/share/wineprefixes/default
mkdir -p ~/.cache/vim/undo
mkdir -p ~/.cache/vim/swap
mkdir -p ~/.cache/vim/backup

cp -r ~/dotfiles/systemd/user/* ~/.config/systemd/user

cd ~/dotfiles || exit
stow -R home

cd "$current_wd" || exit
