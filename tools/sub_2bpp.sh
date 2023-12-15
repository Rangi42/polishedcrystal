#!/usr/bin/env bash
# Usage: sub_2bpp.sh tileset.2bpp [start=0] length
# Skip the first 'start' tiles, keep up to the next 'length' tiles

set -euo pipefail

# 2bpp: 8x8 pixels/tile * 2 bits/pixel / 8 bits/byte = 16 bytes/tile

if [ "$#" -eq 2 ]; then
	LENGTH=$(expr $2 \* 16)
	head -c $LENGTH "$1"
else
	START=$(expr $2 \* 16 + 1)
	LENGTH=$(expr $3 \* 16)
	tail -c +$START "$1" | head -c $LENGTH
fi
