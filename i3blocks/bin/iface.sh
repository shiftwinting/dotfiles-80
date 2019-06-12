#!/usr/bin/env sh

if [ "$(hostname)" = "garry" ]; then
    echo wlo1
elif [ "$(hostname)" = "dev-004p" ]; then
    echo wlp2s0
fi
