#!/usr/bin/env sh

set -e

current_wd=$(pwd)

~/dotfiles/scripts/bin/stow_all.sh

mkdir ~/Pictures/screenshots
mkdir -p ~/repos
cd ~/repos

git clone git@github.com:ruifm/st.git
(
cd st || exit
make install
git remote add upstream https://git.suckless.org/st
)

git clone https://github.com/vivien/i3blocks-contrib.git

git clone git@github.com:ruifm/surf.git
(
cd surf || exit
make install
git remote add upstream https://git.suckless.org/surf
)

cd "$current_wd" || exit

~/dotfiles/scripts/bin/update_all.sh
