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

wget "https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz"
wget "https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz"
wget "https://invisible-mirror.net/archives/ncurses/current/ncurses.tar.gz"

tar xf libevent*.tar.gz
cd libevent*/
./configure --prefix="$HOME"/.local --enable-shared
make -j4 && make install
cd ..

tar xf ncurses*.tar.gz
cd ncurses*/
./configure --prefix="$HOME"/.local --with-shared --enable-pc-files --with-pkg-config-libdir="$HOME"/.local/lib/pkgconfig
make -j4 && make install
cd ..

tar xf tmux*.tar.gz
cd tmux*/
PKG_CONFIG_PATH="$HOME"/.local/lib/pkgconfig ./configure --prefix="$HOME"/.local
make -j4 && make install

cd "$current_wd"
