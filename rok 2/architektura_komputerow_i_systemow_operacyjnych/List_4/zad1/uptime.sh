#!/bin/bash
value=0
get_value() {
	value=$(cat /proc/uptime | cut -d '.' -f 1)
}
echo "System is up in:"
while true; do
get_value

days=$((value/(24*60*60)))
value=$((value%(24*60*60)))
hours=$((value/(60*60)))
value=$((value%(60*60)))
minutes=$((value/60))
value=$((value%60))
echo -en "D: $days\tH: $hours\tM: $minutes\tS: $value\r"
sleep 1
done
echo "Are you sure you shouldn't go to sleep?"
