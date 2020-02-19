#!/usr/bin/env sh
set -e

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/man
mkdir -p ~/.local/share/nvim
mkdir -p ~/.local/etc
mkdir -p ~/.local/include
mkdir -p ~/.local/lib
mkdir -p ~/.local/libexec

current_wd="$(pwd)"
cd "$HOME"/.local/bin

wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage nvim
chmod u+x nvim

cd "$current_wd"
