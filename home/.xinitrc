#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

if [ "$(hostname)" != "halley" ]; then
    xrandr --setprovideroutputsource modesetting NVIDIA-0
fi
xrandr --auto

systemctl --user import-environment DISPLAY
dbus-update-activation-environment --systemd DISPLAY

# invoke global X session script
# shellcheck source=/home/sommerfeld/.xprofile
[ -f ~/.xprofile ] && . ~/.xprofile &
#exec dbus-launch --autolaunch="$(cat /var/lib/dbus/machine-id)" i3
exec i3
