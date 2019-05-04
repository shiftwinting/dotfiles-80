#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# shellcheck source=/home/sommerfeld/.env.sh
[ -f ~/.env.sh ] && . ~/.env.sh
# invoke global X session script
[ -f ~/.Xresources ] && xrdb ~/.Xresources
[ -f /etc/xprofile ] && . /etc/xprofile
# shellcheck source=/home/sommerfeld/.xprofile
[ -f ~/.xprofile ] && . ~/.xprofile
systemctl --user import-environment DISPLAY
exec dbus-launch --autolaunch="$(cat /var/lib/dbus/machine-id)" i3
