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
cd /tmp

git clone https://github.com/neovim/neovim
cd neovim
git checkout release-0.4
make -j4 CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME"/.local install

cd "$current_wd"
