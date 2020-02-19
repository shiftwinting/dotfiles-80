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

wget "https://github.com/neovim/neovim/archive/v0.4.3.tar.gz"
tar xf v0*.tar.gz
cd neovim*/
make -j4 CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME"/.local install

cd "$current_wd"
