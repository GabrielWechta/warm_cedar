#!/bin/bash

timeOut=$2
while :
do
    if ping -s $3 -Mdo -c1 -t $timeOut $1 >respond
    then
        break
    else
        ((timeOut++))
    fi
done

echo "it takes: $timeOut"
cat respond
