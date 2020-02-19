#!/usr/bin/env sh
set -e

mkdir -p ~/.local/bin
mkdir -p ~/.local/share
mkdir -p ~/.local/etc
mkdir -p ~/.local/include
mkdir -p ~/.local/lib
mkdir -p ~/.local/libexec

current_wd="$(pwd)"
cd /tmp

wget "ftp://ftp.gnu.org/gnu/stow/stow-latest.tar.gz"
tar xf stow*
cd stow*/
./configure --prefix="$HOME"/.local
make -j4 && make install

cd "$current_wd"
