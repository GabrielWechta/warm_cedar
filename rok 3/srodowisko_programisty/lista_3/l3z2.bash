#!/bin/bash
for path in $(svn ls -r $1 -R $2 | grep -v '/$')
do
	# echo $2$path
	one_file=$(svn cat -r $1 $2$path) 
	all_files="${all_files} "
	all_files=$all_files$one_file
done
echo $all_files | tr '[:space:]' '[\n*]' | grep -v "^\s*$" | sort | uniq -c | sort -bnr
