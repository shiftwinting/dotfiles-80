#!/usr/bin/env sh
# xinitrc file, used by all X sessions started by xinit (startx)

# shellcheck source=/dev/null
[ -r  ~/.xprofile ] && . ~/.xprofile &
exec bspwm
