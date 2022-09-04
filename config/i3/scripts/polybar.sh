#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "--- Startup ---" | tee -a /tmp/mainbar-i3.log /tmp/secondarybar-i3.log /tmp/dummy.log
outputs=$(polybar --list-monitors | cut -d":" -f1)
monitors=($outputs)
primary=${monitors[0]}
for m in "${monitors[@]}"; do
	if [ "$m" = "$primary" ]; then
		MONITOR=$m polybar mainbar-i3 2>&1 | tee -a /tmp/mainbar-i3.log & disown
		MONITOR=$m polybar dummy 2>&1 | tee -a /tmp/dummy.log & disown
	else
		MONITOR=$m polybar secondarybar-i3 2>&1 | tee -a /tmp/secondarybar-i3.log & disown
		MONITOR=$m polybar dummy 2>&1 | tee -a /tmp/dummy.log & disown
	fi
done
echo "Bars launched..."