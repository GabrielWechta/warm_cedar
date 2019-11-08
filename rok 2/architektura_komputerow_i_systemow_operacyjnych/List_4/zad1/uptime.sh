#!/bin/bash
time=0
get_time() {
	time=$(cat /proc/uptime | cut -d '.' -f 1)
}
echo "System is up in:"
while true; do
get_time

days=$((time/(24*60*60)))
time=$((time%(24*60*60)))
hours=$((time/(60*60)))
time=$((time%(60*60)))
minutes=$((time/60))
time=$((time%60))
echo -en "D: $days\tH: $hours\tM: $minutes\tS: $time\r"
sleep 1
done
echo "Are you sure you shouldn't go to sleep?"
