#!/bin/sh
# Compares baserom.gbc and pokecrystal.gbc

# create baserom.txt if necessary
if [ ! -f baserom.txt ]; then
	hexdump -C baserom.gbc > baserom.txt
fi

hexdump -C polishedcrystal-3.0.0-beta-0xff.gbc > polishedcrystal-3.0.0-beta-0xff.txt

diff -u baserom.txt polishedcrystal-3.0.0-beta-0xff.txt | less