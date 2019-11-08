#!/bin/bash
battery=0
get_battery() {
	battery=$(cat /sys/class/power_supply/BAT1/uevent | grep "POWER_SUPPLY_CAPACITY=" | cut -d '=' -f 2 )
}

while true; do
	get_battery
	echo -en "Battery: ${battery}%"
	sleep 1
done
