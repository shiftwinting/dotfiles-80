#!/usr/bin/env sh

SINK=$(pactl list sinks short | grep RUNNING | cut -f 1)

[ -n "$SINK" ] && echo "$SINK" || echo 0
