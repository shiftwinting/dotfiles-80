#!/bin/sh

if [ "$(hostname)" = "garry" ]; then
    xinput set-prop 12 292 1
    xinput set-prop 12 300 1
    # protonmail-bridge --no-window &
elif [ "$(hostname)" = "dev-004p" ]; then
    synclient HorizTwoFingerScroll=1
    synclient VertScrollDelta=-77
    synclient HorizScrollDelta=-77
    synclient PalmDetect=1
    # /opt/kaspersky/kesl/libexec/kesl-gui &
    [ -f "$HOME"/adas/helpers/mount.sh ] && "$HOME"/adas/helpers/mount.sh rui.ferreira
fi
