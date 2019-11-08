#!/bin/bash 

for file in /proc/*
do
	pid=${file#"/proc/"}
	#echo $pid
	if [[ "$pid" =~ ^[0-9]+$ ]]
	then
		for insight in $file/*
		do
			ls $insight -l 
		done
	fi

done

#for files open count echo "PID = $pid with $(ls /proc/$pid/fd/ | wc -l) file descriptors"
