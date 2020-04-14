#!/usr/bin/env sh
set -e

mkdir -p ~/.local/bin

current_wd="$(pwd)"
cd /tmp

wget "https://github.com/gokcehan/lf/releases/download/r14/lf-linux-amd64.tar.gz"
tar xf lf*
cp lf "$HOME"/.local/bin

cd "$current_wd"
