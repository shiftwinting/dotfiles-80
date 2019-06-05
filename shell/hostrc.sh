#!/bin/sh

if [ "$(hostname)" = "garry" ]; then
    xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1
    xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Natural Scrolling Enabled" 1
    protonmail-bridge --no-window &
elif [ "$(hostname)" = "dev-004p" ]; then
    synclient HorizTwoFingerScroll=1
    synclient VertScrollDelta=-77
    synclient HorizScrollDelta=-77
    synclient PalmDetect=1
    # [ -f "$HOME"/adas/helpers/mount.sh ] && ping -c 1 win_sm_dt > /dev/null 2>&1 && "$HOME"/adas/helpers/mount.sh rui.ferreira || echo "Failed to mount"
fi
