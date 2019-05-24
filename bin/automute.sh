#!/usr/bin/env zsh

LAST_WIN_ACTIVE=""
while :
do
    sleep 0.25
    win="$(xdotool getwindowfocus getwindowpid)"
    if [ "$LAST_WIN_ACTIVE" != "$win" ]; then
        focus_index=$(pacmd list-sink-inputs | awk '/index:/{si = $2}; /'"$win"'/{print si; exit}')
        [[ "$focus_index" ]] && pactl set-sink-input-mute "$focus_index" false
        unfocus_index=$(pacmd list-sink-inputs | awk '/index:/{si = $2}; /'"$LAST_WIN_ACTIVE"'/{print si; exit}')
        [[ "$focus_index" ]] && [[ "$unfocus_index" ]] && pactl set-sink-input-mute "$unfocus_index" true
        LAST_WIN_ACTIVE="$win"
    fi
done

