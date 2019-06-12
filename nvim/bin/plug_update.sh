#!/usr/bin/env sh
stty -ixoff
nvim --headless +PlugUpgrade +PlugUpdate +qa
stty -ixon
