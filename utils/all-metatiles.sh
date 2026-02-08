#!/usr/bin/env bash

for f in gfx/tilesets/*.2bpp.lz; do
	g=`basename $f`
	utils/metatiles.py ${g%.2bpp.lz}
done
