#!/bin/bash

for file in *.asm; do
  if grep -q "tmhm" "$file"; then
    sed -i 's/\(tmhm .*\)/\1, CUT, FLY, SURF, WHIRLPOOL, FLASH/' "$file"
  fi
done
