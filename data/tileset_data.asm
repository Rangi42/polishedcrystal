INCLUDE "constants.asm"

tilecoll: MACRO
	db COLL_\1, COLL_\2, COLL_\3, COLL_\4
ENDM


SECTION "Tileset Data 1", ROMX

Tileset00GFX::
TilesetJohto1GFX::
INCBIN "gfx/tilesets/johto1.2bpp.lz"

Tileset00Meta::
TilesetJohto1Meta::
INCBIN "data/tilesets/johto1_metatiles.bin"

Tileset00Coll::
TilesetJohto1Coll::
INCLUDE "data/tilesets/johto1_collision.asm"

TilesetKanto1GFX::
INCBIN "gfx/tilesets/kanto1.2bpp.lz"

TilesetKanto1Meta::
INCBIN "data/tilesets/kanto1_metatiles.bin"


SECTION "Tileset Data 2", ROMX

TilesetHouse1GFX::
INCBIN "gfx/tilesets/house1.2bpp.lz"

TilesetHouse1Meta::
INCBIN "data/tilesets/house1_metatiles.bin"

TilesetHouse1Coll::
INCLUDE "data/tilesets/house1_collision.asm"

TilesetMuseumMeta::
INCBIN "data/tilesets/museum_metatiles.bin"

TilesetMuseumColl::
INCLUDE "data/tilesets/museum_collision.asm"

TilesetValenciaColl::
INCLUDE "data/tilesets/valencia_collision.asm"


SECTION "Tileset Data 3", ROMX

TilesetPortGFX::
INCBIN "gfx/tilesets/port.2bpp.lz"

TilesetPortMeta::
INCBIN "data/tilesets/port_metatiles.bin"

TilesetPortColl::
INCLUDE "data/tilesets/port_collision.asm"

TilesetMansionGFX::
INCBIN "gfx/tilesets/mansion.2bpp.lz"

TilesetMansionMeta::
INCBIN "data/tilesets/mansion_metatiles.bin"

TilesetMansionColl::
INCLUDE "data/tilesets/mansion_collision.asm"

TilesetGameCornerGFX::
INCBIN "gfx/tilesets/game_corner.2bpp.lz"

TilesetGameCornerMeta::
INCBIN "data/tilesets/game_corner_metatiles.bin"

TilesetGameCornerColl::
INCLUDE "data/tilesets/game_corner_collision.asm"

TilesetGym1GFX::
INCBIN "gfx/tilesets/gym1.2bpp.lz"

TilesetGym1Meta::
INCBIN "data/tilesets/gym1_metatiles.bin"

TilesetGym1Coll::
INCLUDE "data/tilesets/gym1_collision.asm"


SECTION "Tileset Data 4", ROMX

TilesetGateGFX::
INCBIN "gfx/tilesets/gate.2bpp.lz"

TilesetGateMeta::
INCBIN "data/tilesets/gate_metatiles.bin"

TilesetGateColl::
INCLUDE "data/tilesets/gate_collision.asm"

TilesetHouse3GFX::
INCBIN "gfx/tilesets/house3.2bpp.lz"

TilesetHouse3Meta::
INCBIN "data/tilesets/house3_metatiles.bin"

TilesetHouse3Coll::
INCLUDE "data/tilesets/house3_collision.asm"

TilesetGym2GFX::
INCBIN "gfx/tilesets/gym2.2bpp.lz"

TilesetGym2Meta::
INCBIN "data/tilesets/gym2_metatiles.bin"

TilesetGym2Coll::
INCLUDE "data/tilesets/gym2_collision.asm"

TilesetParkGFX::
INCBIN "gfx/tilesets/park.2bpp.lz"

TilesetParkMeta::
INCBIN "data/tilesets/park_metatiles.bin"

TilesetParkColl::
INCLUDE "data/tilesets/park_collision.asm"


SECTION "Tileset Data 5", ROMX

TilesetFacilityGFX::
INCBIN "gfx/tilesets/facility.2bpp.lz"

TilesetFacilityMeta::
INCBIN "data/tilesets/facility_metatiles.bin"

TilesetFacilityColl::
INCLUDE "data/tilesets/facility_collision.asm"

TilesetLighthouseGFX::
INCBIN "gfx/tilesets/lighthouse.2bpp.lz"

TilesetLighthouseMeta::
INCBIN "data/tilesets/lighthouse_metatiles.bin"

TilesetLighthouseColl::
INCLUDE "data/tilesets/lighthouse_collision.asm"

TilesetPokeComGFX::
INCBIN "gfx/tilesets/pokecom.2bpp.lz"

TilesetPokeComMeta::
INCBIN "data/tilesets/pokecom_metatiles.bin"

TilesetPokeComColl::
INCLUDE "data/tilesets/pokecom_collision.asm"

TilesetIcePathGFX::
INCBIN "gfx/tilesets/ice_path.2bpp.lz"

TilesetIcePathMeta::
INCBIN "data/tilesets/ice_path_metatiles.bin"

TilesetIcePathColl::
INCLUDE "data/tilesets/ice_path_collision.asm"


SECTION "Tileset Data 6", ROMX

TilesetMartGFX::
INCBIN "gfx/tilesets/mart.2bpp.lz"

TilesetMartMeta::
INCBIN "data/tilesets/mart_metatiles.bin"

TilesetMartColl::
INCLUDE "data/tilesets/mart_collision.asm"

TilesetTowerGFX::
INCBIN "gfx/tilesets/tower.2bpp.lz"

TilesetTowerMeta::
INCBIN "data/tilesets/tower_metatiles.bin"

TilesetTowerColl::
INCLUDE "data/tilesets/tower_collision.asm"

TilesetRadioTowerGFX::
INCBIN "gfx/tilesets/radio_tower.2bpp.lz"

TilesetRadioTowerMeta::
INCBIN "data/tilesets/radio_tower_metatiles.bin"

TilesetRadioTowerColl::
INCLUDE "data/tilesets/radio_tower_collision.asm"

TilesetWarehouseMeta::
INCBIN "data/tilesets/warehouse_metatiles.bin"

TilesetWarehouseColl::
INCLUDE "data/tilesets/warehouse_collision.asm"


SECTION "Tileset Data 7", ROMX

TilesetPokeCenterGFX::
INCBIN "gfx/tilesets/pokecenter.2bpp.lz"

TilesetPokeCenterMeta::
INCBIN "data/tilesets/pokecenter_metatiles.bin"

TilesetPokeCenterColl::
INCLUDE "data/tilesets/pokecenter_collision.asm"

TilesetRuinsMeta::
INCBIN "data/tilesets/ruins_metatiles.bin"

TilesetRuinsColl::
INCLUDE "data/tilesets/ruins_collision.asm"

TilesetAlphMeta::
INCBIN "data/tilesets/alph_metatiles.bin"

TilesetAlphColl::
INCLUDE "data/tilesets/alph_collision.asm"


SECTION "Tileset Data 8", ROMX

TilesetCaveGFX::
INCBIN "gfx/tilesets/cave.2bpp.lz"

TilesetQuietCaveGFX::
INCBIN "gfx/tilesets/quiet_cave.2bpp.lz"

TilesetCaveMeta::
TilesetQuietCaveMeta::
INCBIN "data/tilesets/cave_metatiles.bin"

TilesetCaveColl::
TilesetQuietCaveColl::
INCLUDE "data/tilesets/cave_collision.asm"

TilesetForestGFX::
INCBIN "gfx/tilesets/forest.2bpp.lz"

TilesetForestMeta::
INCBIN "data/tilesets/forest_metatiles.bin"

TilesetForestColl::
INCLUDE "data/tilesets/forest_collision.asm"

TilesetValenciaGFX::
INCBIN "gfx/tilesets/valencia.2bpp.lz"


SECTION "Tileset Data 9", ROMX

TilesetJohto2GFX::
INCBIN "gfx/tilesets/johto2.2bpp.lz"

TilesetJohto2Meta::
INCBIN "data/tilesets/johto2_metatiles.bin"

TilesetJohto2Coll::
INCLUDE "data/tilesets/johto2_collision.asm"

TilesetJohto3GFX::
INCBIN "gfx/tilesets/johto3.2bpp.lz"

TilesetJohto3Meta::
INCBIN "data/tilesets/johto3_metatiles.bin"

TilesetJohto3Coll::
INCLUDE "data/tilesets/johto3_collision.asm"

TilesetSafariGFX::
INCBIN "gfx/tilesets/safari.2bpp.lz"

TilesetSafariMeta::
INCBIN "data/tilesets/safari_metatiles.bin"

TilesetSafariColl::
INCLUDE "data/tilesets/safari_collision.asm"


SECTION "Tileset Data 10", ROMX

TilesetHouse2GFX::
INCBIN "gfx/tilesets/house2.2bpp.lz"

TilesetHouse2Meta::
INCBIN "data/tilesets/house2_metatiles.bin"

TilesetHouse2Coll::
INCLUDE "data/tilesets/house2_collision.asm"


SECTION "Tileset Data 11", ROMX

TilesetGym3GFX::
INCBIN "gfx/tilesets/gym3.2bpp.lz"

TilesetGym3Meta::
INCBIN "data/tilesets/gym3_metatiles.bin"

TilesetGym3Coll::
INCLUDE "data/tilesets/gym3_collision.asm"

TilesetWarehouseGFX::
INCBIN "gfx/tilesets/warehouse.2bpp.lz"

TilesetPokemonMansionGFX::
INCBIN "gfx/tilesets/pokemon_mansion.2bpp.lz"

TilesetPokemonMansionMeta::
INCBIN "data/tilesets/pokemon_mansion_metatiles.bin"

TilesetPokemonMansionColl::
INCLUDE "data/tilesets/pokemon_mansion_collision.asm"

TilesetKanto1Coll::
INCLUDE "data/tilesets/kanto1_collision.asm"


SECTION "Tileset Data 12", ROMX

TilesetBattleTowerGFX::
INCBIN "gfx/tilesets/battle_tower.2bpp.lz"

TilesetBattleTowerMeta::
INCBIN "data/tilesets/battle_tower_metatiles.bin"

TilesetBattleTowerColl::
INCLUDE "data/tilesets/battle_tower_collision.asm"

TilesetTunnelGFX::
INCBIN "gfx/tilesets/tunnel.2bpp.lz"

TilesetTunnelMeta::
INCBIN "data/tilesets/tunnel_metatiles.bin"

TilesetTunnelColl::
INCLUDE "data/tilesets/tunnel_collision.asm"

TilesetDecorGFX::
INCBIN "gfx/tilesets/decor.2bpp.lz"

TilesetDecorMeta::
INCBIN "data/tilesets/decor_metatiles.bin"

TilesetDecorColl::
INCLUDE "data/tilesets/decor_collision.asm"

TilesetShamoutiGFX::
INCBIN "gfx/tilesets/shamouti.2bpp.lz"

TilesetShamoutiMeta::
INCBIN "data/tilesets/shamouti_metatiles.bin"

TilesetShamoutiColl::
INCLUDE "data/tilesets/shamouti_collision.asm"


SECTION "Tileset Data 13", ROMX

TilesetMuseumGFX::
INCBIN "gfx/tilesets/museum.2bpp.lz"

TilesetHotelGFX::
INCBIN "gfx/tilesets/hotel.2bpp.lz"

TilesetHotelMeta::
INCBIN "data/tilesets/hotel_metatiles.bin"

TilesetHotelColl::
INCLUDE "data/tilesets/hotel_collision.asm"


SECTION "Tileset Data 14", ROMX

TilesetLabGFX::
INCBIN "gfx/tilesets/lab.2bpp.lz"

TilesetLabMeta::
INCBIN "data/tilesets/lab_metatiles.bin"

TilesetLabColl::
INCLUDE "data/tilesets/lab_collision.asm"

TilesetFarawayGFX::
INCBIN "gfx/tilesets/faraway.2bpp.lz"

TilesetFarawayMeta::
INCBIN "data/tilesets/faraway_metatiles.bin"

TilesetFarawayColl::
INCLUDE "data/tilesets/faraway_collision.asm"

TilesetValenciaMeta::
INCBIN "data/tilesets/valencia_metatiles.bin"


SECTION "Tileset Data 15", ROMX

TilesetRuinsGFX::
TilesetAlphGFX::
INCBIN "gfx/tilesets/ruins.2bpp.lz"

TilesetJohto4GFX::
INCBIN "gfx/tilesets/johto4.2bpp.lz"

TilesetJohto4Meta::
INCBIN "data/tilesets/johto4_metatiles.bin"

TilesetJohto4Coll::
INCLUDE "data/tilesets/johto4_collision.asm"


SECTION "Tileset Data 16", ROMX

TilesetKanto2GFX::
INCBIN "gfx/tilesets/kanto2.2bpp.lz"

TilesetKanto2Meta::
INCBIN "data/tilesets/kanto2_metatiles.bin"

TilesetKanto2Coll::
INCLUDE "data/tilesets/kanto2_collision.asm"
