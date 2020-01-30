#!/usr/bin/env sh
# xinitrc file, used by all X sessions started by xinit (startx)

if [ "$(hostname)" != "halley" ]; then
    xrandr --setprovideroutputsource modesetting NVIDIA-0
fi
xrandr --auto

if [ "$(hostname)" = "garry" ]; then
    xrandr --output eDP-1-1 --off
    xrandr --output HDMI-0 --primary --mode 1920x1080 --rate 144
fi

# shellcheck source=/dev/null
[ -r  ~/.xprofile ] && . ~/.xprofile &
exec bspwm
