#!/usr/bin/env sh

VOL=$(pactl list sinks | grep RUNNING -A 8 | grep Volume | cut -d " " -f 6)

default_vol() {
    pactl list sinks | grep "Sink #0" -A 9 | grep Volume | cut -d " " -f 6
}

is_muted_default() {
    pactl list sinks | grep "Sink #0" -A 8 | grep Mute | cut -d " " -f 2
}

is_muted() {
    pactl list sinks | grep RUNNING -A 7 | grep Mute | cut -d " " -f 2
}

if [ -n "$VOL" ]; then
    p_is_muted=$(is_muted)
    if [ "$p_is_muted" = "yes" ]; then
        echo "MUTED"
    else
        echo "$VOL"
    fi
else
    p_is_muted=$(is_muted_default)
    if [ "$p_is_muted" = "yes" ]; then
        echo "MUTED"
    else
        default_vol
    fi
fi
