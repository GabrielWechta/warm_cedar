#!/bin/bash

url=https://cdn2.thecatapi.com/images/bo4.jpg

curl ${url} > catpicture

catimg catpicture -r 2

rm catpicture
