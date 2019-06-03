#!/usr/bin/env sh

originalWD=$(pwd)

echo "pip update:"
echo
echo
pip_update.sh

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
echo "dotfiles update:"
cd ~/dotfiles && git pull && stow_all.sh

echo
echo
echo
echo
echo "i3blocks-contrib update:"
cd ~/i3blocks-contrib && git pull

echo
echo
echo
echo
echo "st terminal update:"
cd ~/st && git pull && make install

cd "$originalWD" || exit
