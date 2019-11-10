#!/bin/bash

url=$1
time=$2
filename=$(echo $url | cut -d '.' -f 2)
i=1
echo $filename
lynx -dump "$url" > $filename
git add $filename
git commit -m "$filename $i"
((i++))	

while true; do
	lynx -dump "$url" > $filename
	if git diff --quiet HEAD $filename; then
	    echo "nothing new"
	else
		echo "something new"		
		git add $filename
		git commit -m "$filename $i"
		((i++))	
		xmessage -bg BLUE -center "something on wdwd has changed!"
	fi
	sleep $time
done

