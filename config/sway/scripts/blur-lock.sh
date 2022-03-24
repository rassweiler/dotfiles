#!/usr/bin/env bash

PICTURE=~/.blurred-bg.png
SCREENSHOT="scrot $PICTURE"

BLUR="5x4"

$SCREENSHOT
convert $PICTURE -blur $BLUR $PICTURE
i3lock -i $PICTURE
rm $PICTURE
