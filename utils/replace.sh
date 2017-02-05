#!/usr/bin/env bash

sed -i 's/'$1'/'$2'/' $(grep -lwr --include="*.asm" --exclude-dir=".git" --exclude-dir="extras" --exclude-dir="utils" *.asm)
