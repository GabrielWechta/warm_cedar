#!/bin/bash
battery=0
get_battery() {
	battery=$(cat /sys/class/power_supply/BAT1/uevent | grep "POWER_SUPPLY_CAPACITY=" | cut -d '=' -f 2 )
}

tput clear
tput civis

while true; do
	get_battery
	line="===================================================================================================="
	missing=$((101-$battery))
	procentage=${line::-${missing}}
	now=$( date +"%T")
	tput setf 5
	echo "$now: ${battery}% $procentage"
	tput setf 7
	sleep 15

done

