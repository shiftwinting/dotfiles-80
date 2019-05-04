#!/usr/bin/env bash

if [[ "$(hostname)" == "garry" ]]; then
    # laptop specific commands here
    protonmail-bridge &
    xinput set-prop 12 292 1
    xinput set-prop 12 300 1
fi
