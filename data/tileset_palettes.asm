TilesetBGPalette::
	table_width 1 palettes
INCLUDE "gfx/tilesets/bg_tiles.pal"
	assert_table_length 8 * 5 + 4 ; morn, day, nite, eve, indoor, water

RoofPals:
	table_width COLOR_SIZE * 2 * 3
INCLUDE "gfx/tilesets/roofs.pal"
	assert_table_length NUM_MAP_GROUPS + 1

OvercastRoofPals:
	table_width COLOR_SIZE * 2 * 3
INCLUDE "gfx/tilesets/roofs_overcast.pal"
	assert_table_length NUM_MAP_GROUPS + 1

; The palettes below are used by `paletteswap` callbacks.

OverworldGreenPalettes::
INCLUDE "gfx/tilesets/palette-swap/bg-green.pal"

OverworldWaterPalettes::
INCLUDE "gfx/tilesets/palette-swap/bg-water.pal"

OverworldYellowPalettes::
INCLUDE "gfx/tilesets/palette-swap/bg-yellow.pal"

GameCornerExteriorPalettes::
INCLUDE "gfx/tilesets/palette-swap/game-corner.pal"

PewterCityMuseumRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/pewter-museum.pal"

GoldenrodMuseumRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/goldenrod-museum.pal"

GoldenrodBikeShopRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/goldenrod-bike-shop.pal"

GoldenrodCityRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/goldenrod-roof.pal"

GoldenrodHarborPlantVendorAwningPalettes::
INCLUDE "gfx/tilesets/palette-swap/plant-vendor.pal"

GoldenrodHarborDollVendorAwningPalettes::
INCLUDE "gfx/tilesets/palette-swap/doll-vendor.pal"

SilphCoRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/silph-co.pal"

FuchsiaCityRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/fuchsia-roof.pal"

SafariZoneRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/safari-zone-roof.pal"

LavenderRadioTowerRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/lavender-radio-tower-roof.pal"

MrPokemonsHouseRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/mr-pokemon-roof.pal"

MrPsychicsHouseRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/mr-psychic-roof.pal"

NuggetBridgePalettes::
RuggedRoadSouthFlowerPalettes::
INCLUDE "gfx/tilesets/palette-swap/nugget-bridge.pal"

VermilionCityRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/vermilion-roof.pal"

SeagallopFerryRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/seagallop-ferry-roof.pal"
