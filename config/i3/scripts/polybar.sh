#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/mainbar-i3.log /tmp/dummy.log
for m in $(polybar --list-monitors | cut -d":" -f1); do
	MONITOR=$m polybar mainbar-i3 2>&1 | tee -a /tmp/mainbar-i3.log & disown
	MONITOR=$m polybar dummy 2>&1 | tee -a /tmp/dummy.log & disown
done
echo "Bars launched..."