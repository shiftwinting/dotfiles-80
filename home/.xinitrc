#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

if [ "$(hostname)" != "halley" ]; then
    xrandr --setprovideroutputsource modesetting NVIDIA-0
fi
xrandr --auto

# shellcheck source=/dev/null
[ -r  ~/.xprofile ] && . ~/.xprofile &
exec i3
