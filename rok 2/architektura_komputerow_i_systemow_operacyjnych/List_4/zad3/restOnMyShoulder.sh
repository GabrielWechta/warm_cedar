#!/bin/bash

url=https://api.thecatapi.com/v1/images/search
curl ${url} > kitty
catlink=$(jq '.[].url' kitty -r)
curl ${catlink} > kittyimage
catimg -r 2 kittyimage
