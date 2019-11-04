#!/bin/bash

# Global variables
interface="wlo1"
received_bytes=""
old_received_bytes=""
transmitted_bytes=""
old_transmitted_bytes=""

get_values() #byte down na 1 miejscu byte up na 9
{
    line=$(cat /proc/net/dev | grep $interface | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
    eval $line
}

fix()
{
    vel=$1

    let "velKB=$vel/1024"
    let "velMB=$velKB/1024"
    if [ $velMB != 0 ]; then
	echo -n "$velMB MB/s";
    elif [ $velKB != 0 ]; then
	echo -n "$velKB KB/s";
    else
 	echo -n "$vel B/s";
    fi
}
 
get_values
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
 
while true; 
do
    get_values

    vel_recv=$((received_bytes-old_received_bytes))
    vel_trans=$((transmitted_bytes-old_transmitted_bytes))

    echo "$vel_recv $vel_trans"
 
    old_received_bytes=$received_bytes
    old_transmitted_bytes=$transmitted_bytes
 
    sleep 1;
done
