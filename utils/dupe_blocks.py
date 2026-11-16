#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import glob
from itertools import batched

for metatiles_path in glob.iglob("data/tilesets/*_metatiles.bin"):
	name = metatiles_path.split("/")[-1].removesuffix("_metatiles.bin")
	with open(metatiles_path, "rb") as file:
		metatiles = file.read()
	attributes_path = metatiles_path.removesuffix("_metatiles.bin") + "_attributes.bin"
	with open(attributes_path, "rb") as file:
		attributes = file.read()
	collision_path = metatiles_path.removesuffix("_metatiles.bin") + "_collision.asm"
	with open(collision_path, "r", encoding="utf-8") as file:
		collisions = [line.split(";")[0].strip() for line in file if line.startswith("\ttilecoll")]
	assert len(metatiles) == len(attributes)
	assert len(metatiles) % 16 == 0
	assert len(metatiles) // 16 == len(collisions)
	tileset = list(zip(batched(metatiles, 16), batched(attributes, 16), collisions))
	for i in range(len(tileset)):
		for j in range(i+1, len(tileset)):
			if tileset[i] == tileset[j]:
				print(f"{name}: blocks ${i:02X} and ${j:02X} are duplicates")
