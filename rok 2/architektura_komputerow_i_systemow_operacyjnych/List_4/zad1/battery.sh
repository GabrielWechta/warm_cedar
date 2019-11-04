#!/bin/bash
value=0
get_value() {
	value=$(cat /sys/class/power_supply/BAT1/uevent | grep "POWER_SUPPLY_CAPACITY=" | cut -d '=' -f 2 )
}

while true; do
	get_value
	echo "${value}%\r\c"
	sleep 1
done
