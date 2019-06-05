#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# shellcheck source=/home/sommerfeld/.env.sh
[ -f ~/.env.sh ] && . ~/.env.sh
[ -f ~/.Xresources ] && xrdb ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
# invoke global X session script
# shellcheck source=/home/sommerfeld/.xprofile
[ -f ~/.xprofile ] && . ~/.xprofile
systemctl --user import-environment DISPLAY
dbus-update-activation-environment --systemd DISPLAY
#exec dbus-launch --autolaunch="$(cat /var/lib/dbus/machine-id)" i3
exec i3
