#!/usr/bin/env bash

PICTURE=~/.local/share/backgrounds/Dracula_arch.png
SCREENSHOT="scrot $PICTURE"

BLUR="5x4"

$SCREENSHOT
convert $PICTURE -blur $BLUR $PICTURE
i3lock -i $PICTURE

