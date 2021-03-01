#!/bin/bash
burden=0
get_burden() {
	burden=$(cat /proc/loadavg | cut -d ' ' -f 4 | cut -d '/' -f 2)
}
while true; do
get_burden

echo -en "$burden\r"
sleep 1
done
