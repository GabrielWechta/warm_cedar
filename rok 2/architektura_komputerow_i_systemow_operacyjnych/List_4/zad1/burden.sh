#!/bin/bash
value=0
get_value() {
	value=$(cat /proc/loadavg | cut -d ' ' -f 4 | cut -d '/' -f 2)
}
while true; do
get_value

echo -en "$value\r"
sleep 1
done
