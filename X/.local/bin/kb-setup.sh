#!/usr/bin/env sh

[ -r ~/.Xkeymap ] && xkbcomp ~/.Xkeymap "$DISPLAY"
if [ "$(hostname)" = "halley" ]; then
    setxkbmap -layout no
else
    setxkbmap -layout es
fi
setxkbmap -option "caps:swapescape"
xcape -e "Control_L=Escape"
if [ "$(hostname)" = "garry" ]; then
    xmodmap ~/.Xmodmap
fi
xset r rate 250 30

setlayout() {
    ids=$(xinput --list | sed -ne '/Virtual core keyboard/{:a' -e 'n;p;ba' -e '}' | grep "$1" | sed -n 's/.*id=\([0-9]\+\).*/\1/p')
    for i in $ids
    do
        setxkbmap -device "$i" -layout "$2"
    done
 }

setlayout "Kingston HyperX Alloy FPS Pro Mechanical Gaming Keyboard" us
setlayout "SONiX USB DEVICE" us
