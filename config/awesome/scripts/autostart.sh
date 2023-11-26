#!/bin/sh

start() {
	[ -z "$(pidof -x $1)" ] && ${2:-$1} &
}

#notify-send "Running autostart"
#start /usr/lib/xfce-polkit/xfce-polkit
start nextcloud
#start mpd
start volumeicon
