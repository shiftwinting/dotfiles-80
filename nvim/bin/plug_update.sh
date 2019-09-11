#!/usr/bin/env sh
stty -ixoff
nvim +PlugUpgrade +PlugUpdate
stty -ixon
