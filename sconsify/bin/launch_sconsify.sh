#!/usr/bin/env sh

set -e

i3-msg workspace 10
i3-msg split v
$TERMINAL -e sconsify &
$TERMINAL -e cava &

sleep 3

i3-msg move up
