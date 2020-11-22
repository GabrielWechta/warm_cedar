#!/bin/bash
for f in $(svn ls -r $1 -R $2 | grep "[^\/]$")
do
	svn cat -r $1 "$2$f" | tr "A-Z " "a-z\n" | grep . | sort -u
done | sort | uniq -c | sort -bnr
