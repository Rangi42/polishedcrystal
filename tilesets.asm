INCLUDE "includes.asm"


SECTION "Roofs", ROMX

INCLUDE "tilesets/roofs.asm"


SECTION "Tileset Data 1", ROMX

Tileset00GFX::
TilesetJohto1GFX::
INCBIN "gfx/tilesets/johto1.2bpp.lz"

Tileset00Meta::
TilesetJohto1Meta::
INCBIN "tilesets/johto1_metatiles.bin"

Tileset00Coll::
TilesetJohto1Coll::
INCLUDE "tilesets/johto1_collision.asm"

TilesetKanto1GFX::
INCBIN "gfx/tilesets/kanto1.2bpp.lz"

TilesetKanto1Meta::
INCBIN "tilesets/kanto1_metatiles.bin"


SECTION "Tileset Data 2", ROMX

TilesetHouse1GFX::
INCBIN "gfx/tilesets/house1.2bpp.lz"

TilesetHouse1Meta::
INCBIN "tilesets/house1_metatiles.bin"

TilesetHouse1Coll::
INCLUDE "tilesets/house1_collision.asm"

TilesetMuseumMeta::
INCBIN "tilesets/museum_metatiles.bin"

TilesetMuseumColl::
INCLUDE "tilesets/museum_collision.asm"

TilesetValenciaColl::
INCLUDE "tilesets/valencia_collision.asm"


SECTION "Tileset Data 3", ROMX

TilesetPortGFX::
INCBIN "gfx/tilesets/port.2bpp.lz"

TilesetPortMeta::
INCBIN "tilesets/port_metatiles.bin"

TilesetPortColl::
INCLUDE "tilesets/port_collision.asm"

TilesetMansionGFX::
INCBIN "gfx/tilesets/mansion.2bpp.lz"

TilesetMansionMeta::
INCBIN "tilesets/mansion_metatiles.bin"

TilesetMansionColl::
INCLUDE "tilesets/mansion_collision.asm"

TilesetGameCornerGFX::
INCBIN "gfx/tilesets/game_corner.2bpp.lz"

TilesetGameCornerMeta::
INCBIN "tilesets/game_corner_metatiles.bin"

TilesetGameCornerColl::
INCLUDE "tilesets/game_corner_collision.asm"

TilesetGym1GFX::
INCBIN "gfx/tilesets/gym1.2bpp.lz"

TilesetGym1Meta::
INCBIN "tilesets/gym1_metatiles.bin"

TilesetGym1Coll::
INCLUDE "tilesets/gym1_collision.asm"


SECTION "Tileset Data 4", ROMX

TilesetGateGFX::
INCBIN "gfx/tilesets/gate.2bpp.lz"

TilesetGateMeta::
INCBIN "tilesets/gate_metatiles.bin"

TilesetGateColl::
INCLUDE "tilesets/gate_collision.asm"

TilesetHouse3GFX::
INCBIN "gfx/tilesets/house3.2bpp.lz"

TilesetHouse3Meta::
INCBIN "tilesets/house3_metatiles.bin"

TilesetHouse3Coll::
INCLUDE "tilesets/house3_collision.asm"

TilesetGym2GFX::
INCBIN "gfx/tilesets/gym2.2bpp.lz"

TilesetGym2Meta::
INCBIN "tilesets/gym2_metatiles.bin"

TilesetGym2Coll::
INCLUDE "tilesets/gym2_collision.asm"

TilesetParkGFX::
INCBIN "gfx/tilesets/park.2bpp.lz"

TilesetParkMeta::
INCBIN "tilesets/park_metatiles.bin"

TilesetParkColl::
INCLUDE "tilesets/park_collision.asm"


SECTION "Tileset Data 5", ROMX

TilesetFacilityGFX::
INCBIN "gfx/tilesets/facility.2bpp.lz"

TilesetFacilityMeta::
INCBIN "tilesets/facility_metatiles.bin"

TilesetFacilityColl::
INCLUDE "tilesets/facility_collision.asm"

TilesetLighthouseGFX::
INCBIN "gfx/tilesets/lighthouse.2bpp.lz"

TilesetLighthouseMeta::
INCBIN "tilesets/lighthouse_metatiles.bin"

TilesetLighthouseColl::
INCLUDE "tilesets/lighthouse_collision.asm"

TilesetPokeComGFX::
INCBIN "gfx/tilesets/pokecom.2bpp.lz"

TilesetPokeComMeta::
INCBIN "tilesets/pokecom_metatiles.bin"

TilesetPokeComColl::
INCLUDE "tilesets/pokecom_collision.asm"

TilesetIcePathGFX::
INCBIN "gfx/tilesets/ice_path.2bpp.lz"

TilesetIcePathMeta::
INCBIN "tilesets/ice_path_metatiles.bin"

TilesetIcePathColl::
INCLUDE "tilesets/ice_path_collision.asm"


SECTION "Tileset Data 6", ROMX

TilesetMartGFX::
INCBIN "gfx/tilesets/mart.2bpp.lz"

TilesetMartMeta::
INCBIN "tilesets/mart_metatiles.bin"

TilesetMartColl::
INCLUDE "tilesets/mart_collision.asm"

TilesetTowerGFX::
INCBIN "gfx/tilesets/tower.2bpp.lz"

TilesetTowerMeta::
INCBIN "tilesets/tower_metatiles.bin"

TilesetTowerColl::
INCLUDE "tilesets/tower_collision.asm"

TilesetRadioTowerGFX::
INCBIN "gfx/tilesets/radio_tower.2bpp.lz"

TilesetRadioTowerMeta::
INCBIN "tilesets/radio_tower_metatiles.bin"

TilesetRadioTowerColl::
INCLUDE "tilesets/radio_tower_collision.asm"

TilesetWarehouseMeta::
INCBIN "tilesets/warehouse_metatiles.bin"

TilesetWarehouseColl::
INCLUDE "tilesets/warehouse_collision.asm"


SECTION "Tileset Data 7", ROMX

TilesetPokeCenterGFX::
INCBIN "gfx/tilesets/pokecenter.2bpp.lz"

TilesetPokeCenterMeta::
INCBIN "tilesets/pokecenter_metatiles.bin"

TilesetPokeCenterColl::
INCLUDE "tilesets/pokecenter_collision.asm"

TilesetRuinsMeta::
INCBIN "tilesets/ruins_metatiles.bin"

TilesetRuinsColl::
INCLUDE "tilesets/ruins_collision.asm"

TilesetAlphMeta::
INCBIN "tilesets/alph_metatiles.bin"

TilesetAlphColl::
INCLUDE "tilesets/alph_collision.asm"


SECTION "Tileset Data 8", ROMX

TilesetCaveGFX::
INCBIN "gfx/tilesets/cave.2bpp.lz"

TilesetQuietCaveGFX::
INCBIN "gfx/tilesets/quiet_cave.2bpp.lz"

TilesetCaveMeta::
TilesetQuietCaveMeta::
INCBIN "tilesets/cave_metatiles.bin"

TilesetCaveColl::
TilesetQuietCaveColl::
INCLUDE "tilesets/cave_collision.asm"

TilesetForestGFX::
INCBIN "gfx/tilesets/forest.2bpp.lz"

TilesetForestMeta::
INCBIN "tilesets/forest_metatiles.bin"

TilesetForestColl::
INCLUDE "tilesets/forest_collision.asm"

TilesetValenciaGFX::
INCBIN "gfx/tilesets/valencia.2bpp.lz"


SECTION "Tileset Data 9", ROMX

TilesetJohto2GFX::
INCBIN "gfx/tilesets/johto2.2bpp.lz"

TilesetJohto2Meta::
INCBIN "tilesets/johto2_metatiles.bin"

TilesetJohto2Coll::
INCLUDE "tilesets/johto2_collision.asm"

TilesetJohto3GFX::
INCBIN "gfx/tilesets/johto3.2bpp.lz"

TilesetJohto3Meta::
INCBIN "tilesets/johto3_metatiles.bin"

TilesetJohto3Coll::
INCLUDE "tilesets/johto3_collision.asm"

TilesetSafariGFX::
INCBIN "gfx/tilesets/safari.2bpp.lz"

TilesetSafariMeta::
INCBIN "tilesets/safari_metatiles.bin"

TilesetSafariColl::
INCLUDE "tilesets/safari_collision.asm"


SECTION "Tileset Data 10", ROMX

TilesetHouse2GFX::
INCBIN "gfx/tilesets/house2.2bpp.lz"

TilesetHouse2Meta::
INCBIN "tilesets/house2_metatiles.bin"

TilesetHouse2Coll::
INCLUDE "tilesets/house2_collision.asm"


SECTION "Tileset Data 11", ROMX

TilesetGym3GFX::
INCBIN "gfx/tilesets/gym3.2bpp.lz"

TilesetGym3Meta::
INCBIN "tilesets/gym3_metatiles.bin"

TilesetGym3Coll::
INCLUDE "tilesets/gym3_collision.asm"

TilesetWarehouseGFX::
INCBIN "gfx/tilesets/warehouse.2bpp.lz"

TilesetPokemonMansionGFX::
INCBIN "gfx/tilesets/pokemon_mansion.2bpp.lz"

TilesetPokemonMansionMeta::
INCBIN "tilesets/pokemon_mansion_metatiles.bin"

TilesetPokemonMansionColl::
INCLUDE "tilesets/pokemon_mansion_collision.asm"

TilesetKanto1Coll::
INCLUDE "tilesets/kanto1_collision.asm"


SECTION "Tileset Data 12", ROMX

TilesetBattleTowerGFX::
INCBIN "gfx/tilesets/battle_tower.2bpp.lz"

TilesetBattleTowerMeta::
INCBIN "tilesets/battle_tower_metatiles.bin"

TilesetBattleTowerColl::
INCLUDE "tilesets/battle_tower_collision.asm"

TilesetTunnelGFX::
INCBIN "gfx/tilesets/tunnel.2bpp.lz"

TilesetTunnelMeta::
INCBIN "tilesets/tunnel_metatiles.bin"

TilesetTunnelColl::
INCLUDE "tilesets/tunnel_collision.asm"

TilesetDecorGFX::
INCBIN "gfx/tilesets/decor.2bpp.lz"

TilesetDecorMeta::
INCBIN "tilesets/decor_metatiles.bin"

TilesetDecorColl::
INCLUDE "tilesets/decor_collision.asm"

TilesetShamoutiGFX::
INCBIN "gfx/tilesets/shamouti.2bpp.lz"

TilesetShamoutiMeta::
INCBIN "tilesets/shamouti_metatiles.bin"

TilesetShamoutiColl::
INCLUDE "tilesets/shamouti_collision.asm"


SECTION "Tileset Data 13", ROMX

TilesetMuseumGFX::
INCBIN "gfx/tilesets/museum.2bpp.lz"

TilesetHotelGFX::
INCBIN "gfx/tilesets/hotel.2bpp.lz"

TilesetHotelMeta::
INCBIN "tilesets/hotel_metatiles.bin"

TilesetHotelColl::
INCLUDE "tilesets/hotel_collision.asm"


SECTION "Tileset Data 14", ROMX

TilesetLabGFX::
INCBIN "gfx/tilesets/lab.2bpp.lz"

TilesetLabMeta::
INCBIN "tilesets/lab_metatiles.bin"

TilesetLabColl::
INCLUDE "tilesets/lab_collision.asm"

TilesetFarawayGFX::
INCBIN "gfx/tilesets/faraway.2bpp.lz"

TilesetFarawayMeta::
INCBIN "tilesets/faraway_metatiles.bin"

TilesetFarawayColl::
INCLUDE "tilesets/faraway_collision.asm"

TilesetValenciaMeta::
INCBIN "tilesets/valencia_metatiles.bin"


SECTION "Tileset Data 15", ROMX

TilesetRuinsGFX::
TilesetAlphGFX::
INCBIN "gfx/tilesets/ruins.2bpp.lz"

TilesetJohto4GFX::
INCBIN "gfx/tilesets/johto4.2bpp.lz"

TilesetJohto4Meta::
INCBIN "tilesets/johto4_metatiles.bin"

TilesetJohto4Coll::
INCLUDE "tilesets/johto4_collision.asm"


SECTION "Tileset Data 16", ROMX

TilesetKanto2GFX::
INCBIN "gfx/tilesets/kanto2.2bpp.lz"

TilesetKanto2Meta::
INCBIN "tilesets/kanto2_metatiles.bin"

TilesetKanto2Coll::
INCLUDE "tilesets/kanto2_collision.asm"
