#!/usr/bin/env bash

grep --exclude-dir=".git" --exclude-dir="extras" --exclude-dir="utils" -rl "$1" . | xargs sed -i 's/'$1'/'$2'/g'
