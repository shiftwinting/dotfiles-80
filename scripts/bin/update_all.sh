#!/usr/bin/env sh

originalWD=$(pwd)

echo "system update:"
echo
echo
if [ "$(hostname)" = "garry" ]; then
    yay -Syu
else
    sudo apt update && sudo apt upgrade -y
fi

echo "pip update:"
echo
echo
pip_update.sh

echo
echo
echo
echo
echo "dotfiles update:"
cd ~/dotfiles && git pull && stow_all.sh

echo
echo
echo
echo
echo "vim-plug update:"
plug_update.sh


echo
echo
echo
echo
echo "i3blocks-contrib update:"
cd ~/repos/i3blocks-contrib && git pull

echo
echo
echo
echo
echo "st terminal update:"
cd ~/repos/st && git pull && make install

echo
echo
echo
echo
echo "surf terminal update:"
cd ~/repos/surf && git pull && make install

cd "$originalWD" || exit
