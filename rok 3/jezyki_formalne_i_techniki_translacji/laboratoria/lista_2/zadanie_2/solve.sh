#!/bin/bash
flex $3 -o$1.c $1.l 
gcc $1.c -O3 -o $1.exe
./$1.exe < $2

# unless you use the ‘-l’ lex compatibility option, in which case yytext will be an array.