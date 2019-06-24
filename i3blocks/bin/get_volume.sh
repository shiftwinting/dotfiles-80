#!/usr/bin/env sh

SINK=$(get_sink.sh)
NOW=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $((SINK + 1)) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
IS_MUTED=$(pactl list sinks | awk '/Mute/ { print $2 }' | head -n $((SINK + 1)) | tail -n 1)

LABEL="🔊"
if [ "$IS_MUTED" = "yes" ]; then
    LABEL="🔇"
fi

printf "%s%s" "$LABEL" "$NOW"
