#!/bin/bash
flex $3 -o$1.c $1.l 
gcc $1.c -O3 -o $1.exe
./$1.exe < $2
