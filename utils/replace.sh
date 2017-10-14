#!/usr/bin/env bash

grep --exclude-dir=".git" --exclude-dir="tools" --exclude-dir="utils" --exclude-dir="crowdmap" -rl "$1" . | xargs sed -i 's/'$1'/'$2'/g'
