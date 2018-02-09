tilepal: MACRO
; vram bank, pals
x = \1 << 3
rept _NARG +- 1
	db (x | PAL_BG_\2)
	shift
endr
ENDM

Tileset00PalMap:
TilesetJohto1PalMap:
INCLUDE "gfx/tilesets/johto1_palette_map.asm"

TilesetJohto2PalMap:
INCLUDE "gfx/tilesets/johto2_palette_map.asm"

TilesetKanto1PalMap:
INCLUDE "gfx/tilesets/kanto1_palette_map.asm"

TilesetJohto3PalMap:
INCLUDE "gfx/tilesets/johto3_palette_map.asm"

TilesetHouse1PalMap:
INCLUDE "gfx/tilesets/house1_palette_map.asm"

TilesetHouse2PalMap:
INCLUDE "gfx/tilesets/house2_palette_map.asm"

TilesetPokeCenterPalMap:
INCLUDE "gfx/tilesets/pokecenter_palette_map.asm"

TilesetGatePalMap:
INCLUDE "gfx/tilesets/gate_palette_map.asm"

TilesetPortPalMap:
INCLUDE "gfx/tilesets/port_palette_map.asm"

TilesetLabPalMap:
INCLUDE "gfx/tilesets/lab_palette_map.asm"

TilesetFacilityPalMap:
INCLUDE "gfx/tilesets/facility_palette_map.asm"

TilesetMartPalMap:
INCLUDE "gfx/tilesets/mart_palette_map.asm"

TilesetMansionPalMap:
INCLUDE "gfx/tilesets/mansion_palette_map.asm"

TilesetGameCornerPalMap:
INCLUDE "gfx/tilesets/game_corner_palette_map.asm"

TilesetGym1PalMap:
INCLUDE "gfx/tilesets/gym1_palette_map.asm"

TilesetHouse3PalMap:
INCLUDE "gfx/tilesets/house3_palette_map.asm"

TilesetGym2PalMap:
INCLUDE "gfx/tilesets/gym2_palette_map.asm"

TilesetGym3PalMap:
INCLUDE "gfx/tilesets/gym3_palette_map.asm"

TilesetLighthousePalMap:
INCLUDE "gfx/tilesets/lighthouse_palette_map.asm"

TilesetKanto2PalMap:
INCLUDE "gfx/tilesets/kanto2_palette_map.asm"

TilesetPokeComPalMap:
INCLUDE "gfx/tilesets/pokecom_palette_map.asm"

TilesetBattleTowerPalMap:
INCLUDE "gfx/tilesets/battle_tower_palette_map.asm"

TilesetTowerPalMap:
INCLUDE "gfx/tilesets/tower_palette_map.asm"

TilesetCavePalMap:
TilesetQuietCavePalMap:
INCLUDE "gfx/tilesets/cave_palette_map.asm"

TilesetParkPalMap:
INCLUDE "gfx/tilesets/park_palette_map.asm"

TilesetRuinsPalMap:
TilesetAlphPalMap:
INCLUDE "gfx/tilesets/ruins_palette_map.asm"

TilesetRadioTowerPalMap:
INCLUDE "gfx/tilesets/radio_tower_palette_map.asm"

TilesetWarehousePalMap:
INCLUDE "gfx/tilesets/warehouse_palette_map.asm"

TilesetIcePathPalMap:
INCLUDE "gfx/tilesets/ice_path_palette_map.asm"

TilesetForestPalMap:
INCLUDE "gfx/tilesets/forest_palette_map.asm"

TilesetSafariPalMap:
INCLUDE "gfx/tilesets/safari_palette_map.asm"

TilesetPokemonMansionPalMap:
INCLUDE "gfx/tilesets/pokemon_mansion_palette_map.asm"

TilesetFarawayPalMap:
INCLUDE "gfx/tilesets/faraway_palette_map.asm"

TilesetTunnelPalMap:
INCLUDE "gfx/tilesets/tunnel_palette_map.asm"

TilesetDecorPalMap:
INCLUDE "gfx/tilesets/decor_palette_map.asm"

TilesetShamoutiPalMap:
INCLUDE "gfx/tilesets/shamouti_palette_map.asm"

TilesetMuseumPalMap:
INCLUDE "gfx/tilesets/museum_palette_map.asm"

TilesetHotelPalMap:
INCLUDE "gfx/tilesets/hotel_palette_map.asm"

TilesetValenciaPalMap:
INCLUDE "gfx/tilesets/valencia_palette_map.asm"

TilesetJohto4PalMap:
INCLUDE "gfx/tilesets/johto4_palette_map.asm"
