Signs:
	table_width 2
	farbank "Map Name Sign Graphics"
	fardw WoodSignGFX
	fardw CitySignGFX
	fardw ForestSignGFX
	fardw CaveSignGFX
	fardw RouteSignGFX
	fardw WaterSignGFX
	fardw BuildingSignGFX
	assert_table_length NUM_SIGNS

SignPals:
	table_width 1 palettes
INCLUDE "gfx/signs/signs.pal"
	assert_table_length NUM_SIGNS
