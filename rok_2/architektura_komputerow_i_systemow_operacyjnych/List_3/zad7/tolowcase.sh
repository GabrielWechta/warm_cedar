#!/bin/bah 

for file in ./*
do
	new=${file,,}
	echo $new
	if [ "$file" != "$new" ]; then
		mv "$file" "$new"
	fi
done
