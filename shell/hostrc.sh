#!/bin/sh

if [ "$(hostname)" = "garry" ]; then
    # laptop specific commands here
    xinput set-prop 12 292 1
    xinput set-prop 12 300 1
    # protonmail-bridge --no-window &
fi
