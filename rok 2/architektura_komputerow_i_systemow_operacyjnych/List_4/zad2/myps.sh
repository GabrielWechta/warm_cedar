#!/bin/bash 
echo -e "ppid:\tpid:\tname:\t\tstate:\t\t\tnumber_of_files_opened:"
for file in /proc/*
do
	pid=${file#"/proc/"}
	files_opened="idk"
	if [[ "$pid" =~ ^[0-9]+$ ]]
	then
		ppid=$(cat $file/status | grep PPid: -m 1 | cut -d ':' -f 2 | sed -e 's/^[\t]*//')
		name=$(cat $file/status | grep Name: -m 1 | cut -d ':' -f 2 | sed -e 's/^[\t]*//')
		state=$(cat $file/status | grep State: -m 1 | cut -d ':' -f 2 | sed -e 's/^[\t]*//' | cut -d ' ' -f 1)
		TEST=$(ssh root@localhost 'ls /proc/$pid/fd/' 2>&1)

		files_opened=$(ls /proc/$pid/fd/ | wc -l)

		echo -e "$ppid\t$pid\t$name\t\t$state\t\t\t$files_opened"
	fi

done
#for files open count echo "files_opened = $(ls /proc/$pid/fd/ | wc -l) file descriptors"
