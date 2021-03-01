#!/bin/bash
url=http://api.icndb.com/jokes/random
curl -s ${url} > chuckjoke
chuck=$(jq '.value.joke' chuckjoke -r)
rm chuckjoke
echo $chuck
