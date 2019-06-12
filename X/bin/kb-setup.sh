#!/usr/bin/env sh

setxkbmap -layout es
setxkbmap -option caps:swapescape

xkb_id=$(xinput --list --id-only "SONiX USB DEVICE" 2> /dev/null) || exit 0

[ -n "$xkb_id" ] && setxkbmap -device "$xkb_id" -layout us
