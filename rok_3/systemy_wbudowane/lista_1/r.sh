#!/bin/bash
if [ "$#" -gt 1 ]
then
	file_name=$1
	entity_name=$2
else
	file_name=$1
	entity_name=$1
fi

#analysis
ghdl -a $file_name

#elaborate
ghdl -e $entity_name

#running simulation
ghdl -r $entity_name
