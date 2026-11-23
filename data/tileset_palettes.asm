TilesetBGPalette::
	table_width 1 palettes
INCLUDE "gfx/tilesets/bg_tiles.pal"
	assert_table_length 8 * 5 ; morn, day, nite, eve, indoor
INCLUDE "gfx/tilesets/bg_dungeon_water.pal"
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

GameCornerExteriorPalettes::
INCLUDE "gfx/tilesets/palette-swap/game-corner.pal"

PewterCityMuseumRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/pewter-museum.pal"

GoldenrodMuseumRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/goldenrod-museum.pal"

GoldenrodBikeShopRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/goldenrod-bike-shop.pal"

GoldenrodHarborPlantVendorAwningPalettes::
INCLUDE "gfx/tilesets/palette-swap/plant-vendor.pal"

GoldenrodHarborDollVendorAwningPalettes::
INCLUDE "gfx/tilesets/palette-swap/doll-vendor.pal"

PokemonFanClubRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/pokemon-fan-club-roof.pal"

SilphCoRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/silph-co.pal"

CeladonHotelRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/celadon-hotel.pal"

PowerPlantRoofPalettes:
INCLUDE "gfx/tilesets/palette-swap/power-plant.pal"

SafariZoneRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/safari-zone-roof.pal"

DayOfWeekSiblingsHouseRoofPalettes::
LavenderRadioTowerRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/lavender-radio-tower-roof.pal"

MrPokemonsHouseRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/mr-pokemon-roof.pal"

MrPsychicsHouseRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/mr-psychic-roof.pal"

SteelWingHouseRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/steel-wing-roof.pal"

NuggetBridgePalettes::
RuggedRoadSouthFlowerPalettes::
INCLUDE "gfx/tilesets/palette-swap/nugget-bridge.pal"

SeagallopFerryRoofPalettes::
INCLUDE "gfx/tilesets/palette-swap/seagallop-ferry-roof.pal"
