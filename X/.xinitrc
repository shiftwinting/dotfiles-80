#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
systemctl --user import-environment DISPLAY
export vblank_mode=0
exec primusrun i3
