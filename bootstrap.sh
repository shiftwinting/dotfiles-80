#! /usr/bin/env bash
set -e
stow X
stow acestream-launcher
stow csgo || stow csgo_alt
stow dunst
stow git
stow i3
stow i3blocks
stow kitty
stow mpv
stow neofetch
stow ranger
stow rofi
stow tmux
stow vim
stow youtube-dl

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm -f ~/.zshrc
stow zsh

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your PATH)
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp -f ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
# Update the path to the kitty icon in the kitty.desktop file
sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop
sudo cp -f ~/.local/share/applications/kitty.desktop /usr/local/share/applications
