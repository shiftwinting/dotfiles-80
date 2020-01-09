#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

if [ "$(hostname)" != "halley" ]; then
    xrandr --setprovideroutputsource modesetting NVIDIA-0
fi
xrandr --auto

# invoke global X session script
[ -f ~/.xprofile ] && . ~/.xprofile &
exec i3
