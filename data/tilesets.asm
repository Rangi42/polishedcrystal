INCLUDE "constants.asm"


SECTION "Tileset Headers", ROMX

tileset: MACRO
	dba \1GFX0, \1GFX1, \1GFX2
	dba \1Meta, \1Coll, \1Attr
	dw \1Anim
ENDM

Tilesets::
; entries correspond to TILESET_* constants (see constants/tileset_constants.asm)
	table_width TILESET_LENGTH, Tilesets
	tileset TilesetJohto1
	tileset TilesetJohto2
	tileset TilesetJohto3
	tileset TilesetJohto4
	tileset TilesetKanto1
	tileset TilesetKanto2
	tileset TilesetShamouti
	tileset TilesetValencia
	tileset TilesetFaraway
	tileset TilesetHouse1
	tileset TilesetHouse2
	tileset TilesetHouse3
	tileset TilesetPokeCenter
	tileset TilesetPokeCom
	tileset TilesetMart
	tileset TilesetGate
	tileset TilesetGym1
	tileset TilesetGym2
	tileset TilesetGym3
	tileset TilesetPort
	tileset TilesetLab
	tileset TilesetFacility
	tileset TilesetMansion
	tileset TilesetGameCorner
	tileset TilesetDecor
	tileset TilesetMuseum
	tileset TilesetHotel
	tileset TilesetTower
	tileset TilesetBattleTower
	tileset TilesetRadioTower
	tileset TilesetLighthouse
	tileset TilesetWarehouse
	tileset TilesetCave
	tileset TilesetQuietCave
	tileset TilesetIcePath
	tileset TilesetTunnel
	tileset TilesetForest
	tileset TilesetPark
	tileset TilesetSafari
	tileset TilesetRuins
	tileset TilesetAlph
	tileset TilesetPokemonMansion
	tileset TilesetBattleFactory
	assert_table_length NUM_TILESETS


SECTION "Tileset Data - johto_traditional", ROMX

TilesetJohto1GFX0::
INCBIN "gfx/tilesets/johto_traditional.2bpp.vram0.lz"

TilesetJohto1GFX1::
INCBIN "gfx/tilesets/johto_traditional.2bpp.vram1.lz"

TilesetJohto1Meta::
INCBIN "data/tilesets/johto_traditional_metatiles.bin.lz"

TilesetJohto1Attr::
INCBIN "data/tilesets/johto_traditional_attributes.bin.lz"

TilesetJohto1Coll::
INCBIN "data/tilesets/johto_traditional_collision.bin.lz"


SECTION "Tileset Data - johto_modern", ROMX

TilesetJohto2GFX0::
INCBIN "gfx/tilesets/johto_modern.2bpp.vram0.lz"

TilesetJohto2GFX1::
INCBIN "gfx/tilesets/johto_modern.2bpp.vram1.lz"

TilesetJohto2Meta::
INCBIN "data/tilesets/johto_modern_metatiles.bin.lz"

TilesetJohto2Attr::
INCBIN "data/tilesets/johto_modern_attributes.bin.lz"

TilesetJohto2Coll::
INCBIN "data/tilesets/johto_modern_collision.bin.lz"


SECTION "Tileset Data - battle_tower_outside", ROMX

TilesetJohto3GFX0::
INCBIN "gfx/tilesets/battle_tower_outside.2bpp.vram0.lz"

TilesetJohto3GFX1::
INCBIN "gfx/tilesets/battle_tower_outside.2bpp.vram1.lz"

TilesetJohto3Meta::
INCBIN "data/tilesets/battle_tower_outside_metatiles.bin.lz"

TilesetJohto3Attr::
INCBIN "data/tilesets/battle_tower_outside_attributes.bin.lz"

TilesetJohto3Coll::
INCBIN "data/tilesets/battle_tower_outside_collision.bin.lz"


SECTION "Tileset Data - johto_overcast", ROMX

TilesetJohto4GFX0::
INCBIN "gfx/tilesets/johto_overcast.2bpp.vram0.lz"

TilesetJohto4GFX1::
INCBIN "gfx/tilesets/johto_overcast.2bpp.vram1.lz"

TilesetJohto4Meta::
INCBIN "data/tilesets/johto_overcast_metatiles.bin.lz"

TilesetJohto4Attr::
INCBIN "data/tilesets/johto_overcast_attributes.bin.lz"

TilesetJohto4Coll::
INCBIN "data/tilesets/johto_overcast_collision.bin.lz"


SECTION "Tileset Data - kanto", ROMX

TilesetKanto1GFX0::
INCBIN "gfx/tilesets/kanto.2bpp.vram0.lz"

TilesetKanto1GFX1::
INCBIN "gfx/tilesets/kanto.2bpp.vram1.lz"

TilesetKanto1Meta::
INCBIN "data/tilesets/kanto_metatiles.bin.lz"

TilesetKanto1Attr::
INCBIN "data/tilesets/kanto_attributes.bin.lz"

TilesetKanto1Coll::
INCBIN "data/tilesets/kanto_collision.bin.lz"


SECTION "Tileset Data - indigo_plateau", ROMX

TilesetKanto2GFX0::
INCBIN "gfx/tilesets/indigo_plateau.2bpp.vram0.lz"

TilesetKanto2GFX1::
INCBIN "gfx/tilesets/indigo_plateau.2bpp.vram1.lz"

TilesetKanto2Meta::
INCBIN "data/tilesets/indigo_plateau_metatiles.bin.lz"

TilesetKanto2Attr::
INCBIN "data/tilesets/indigo_plateau_attributes.bin.lz"

TilesetKanto2Coll::
INCBIN "data/tilesets/indigo_plateau_collision.bin.lz"


SECTION "Tileset Data - shamouti_island", ROMX

TilesetShamoutiGFX0::
INCBIN "gfx/tilesets/shamouti_island.2bpp.vram0.lz"

TilesetShamoutiGFX1::
INCBIN "gfx/tilesets/shamouti_island.2bpp.vram1.lz"

TilesetShamoutiMeta::
INCBIN "data/tilesets/shamouti_island_metatiles.bin.lz"

TilesetShamoutiAttr::
INCBIN "data/tilesets/shamouti_island_attributes.bin.lz"

TilesetShamoutiColl::
INCBIN "data/tilesets/shamouti_island_collision.bin.lz"


SECTION "Tileset Data - valencia_island", ROMX

TilesetValenciaGFX0::
INCBIN "gfx/tilesets/valencia_island.2bpp.vram0.lz"

TilesetValenciaGFX1::
INCBIN "gfx/tilesets/valencia_island.2bpp.vram1.lz"

TilesetValenciaMeta::
INCBIN "data/tilesets/valencia_island_metatiles.bin.lz"

TilesetValenciaAttr::
INCBIN "data/tilesets/valencia_island_attributes.bin.lz"

TilesetValenciaColl::
INCBIN "data/tilesets/valencia_island_collision.bin.lz"


SECTION "Tileset Data - faraway_island", ROMX

TilesetFarawayGFX0::
INCBIN "gfx/tilesets/faraway_island.2bpp.vram0.lz"

TilesetFarawayGFX1::
INCBIN "gfx/tilesets/faraway_island.2bpp.vram1.lz"

TilesetFarawayMeta::
INCBIN "data/tilesets/faraway_island_metatiles.bin.lz"

TilesetFarawayAttr::
INCBIN "data/tilesets/faraway_island_attributes.bin.lz"

TilesetFarawayColl::
INCBIN "data/tilesets/faraway_island_collision.bin.lz"


SECTION "Tileset Data - johto_house", ROMX

TilesetHouse1GFX0::
INCBIN "gfx/tilesets/johto_house.2bpp.vram0.lz"

TilesetHouse1GFX1::
INCBIN "gfx/tilesets/johto_house.2bpp.vram1.lz"

TilesetHouse1Meta::
INCBIN "data/tilesets/johto_house_metatiles.bin.lz"

TilesetHouse1Attr::
INCBIN "data/tilesets/johto_house_attributes.bin.lz"

TilesetHouse1Coll::
INCBIN "data/tilesets/johto_house_collision.bin.lz"


SECTION "Tileset Data - kanto_house", ROMX

TilesetHouse2GFX0::
INCBIN "gfx/tilesets/kanto_house.2bpp.vram0.lz"

TilesetHouse2GFX1::
INCBIN "gfx/tilesets/kanto_house.2bpp.vram1.lz"

TilesetHouse2Meta::
INCBIN "data/tilesets/kanto_house_metatiles.bin.lz"

TilesetHouse2Attr::
INCBIN "data/tilesets/kanto_house_attributes.bin.lz"

TilesetHouse2Coll::
INCBIN "data/tilesets/kanto_house_collision.bin.lz"


SECTION "Tileset Data - traditional_house", ROMX

TilesetHouse3GFX0::
INCBIN "gfx/tilesets/traditional_house.2bpp.vram0.lz"

TilesetHouse3GFX1::
INCBIN "gfx/tilesets/traditional_house.2bpp.vram1.lz"

TilesetHouse3Meta::
INCBIN "data/tilesets/traditional_house_metatiles.bin.lz"

TilesetHouse3Attr::
INCBIN "data/tilesets/traditional_house_attributes.bin.lz"

TilesetHouse3Coll::
INCBIN "data/tilesets/traditional_house_collision.bin.lz"


SECTION "Tileset Data - pokecenter", ROMX

TilesetPokeCenterGFX0::
INCBIN "gfx/tilesets/pokecenter.2bpp.vram0.lz"

TilesetPokeCenterGFX1::
INCBIN "gfx/tilesets/pokecenter.2bpp.vram1.lz"

TilesetPokeCenterMeta::
INCBIN "data/tilesets/pokecenter_metatiles.bin.lz"

TilesetPokeCenterAttr::
INCBIN "data/tilesets/pokecenter_attributes.bin.lz"

TilesetPokeCenterColl::
INCBIN "data/tilesets/pokecenter_collision.bin.lz"


SECTION "Tileset Data - pokecom_center", ROMX

TilesetPokeComGFX0::
INCBIN "gfx/tilesets/pokecom_center.2bpp.vram0.lz"

TilesetPokeComGFX1::
INCBIN "gfx/tilesets/pokecom_center.2bpp.vram1.lz"

TilesetPokeComMeta::
INCBIN "data/tilesets/pokecom_center_metatiles.bin.lz"

TilesetPokeComAttr::
INCBIN "data/tilesets/pokecom_center_attributes.bin.lz"

TilesetPokeComColl::
INCBIN "data/tilesets/pokecom_center_collision.bin.lz"


SECTION "Tileset Data - mart", ROMX

TilesetMartGFX0::
INCBIN "gfx/tilesets/mart.2bpp.vram0.lz"

TilesetMartGFX1::
INCBIN "gfx/tilesets/mart.2bpp.vram1.lz"

TilesetMartMeta::
INCBIN "data/tilesets/mart_metatiles.bin.lz"

TilesetMartAttr::
INCBIN "data/tilesets/mart_attributes.bin.lz"

TilesetMartColl::
INCBIN "data/tilesets/mart_collision.bin.lz"


SECTION "Tileset Data - gate", ROMX

TilesetGateGFX0::
INCBIN "gfx/tilesets/gate.2bpp.vram0.lz"

TilesetGateGFX1::
INCBIN "gfx/tilesets/gate.2bpp.vram1.lz"

TilesetGateMeta::
INCBIN "data/tilesets/gate_metatiles.bin.lz"

TilesetGateAttr::
INCBIN "data/tilesets/gate_attributes.bin.lz"

TilesetGateColl::
INCBIN "data/tilesets/gate_collision.bin.lz"


SECTION "Tileset Data - gym", ROMX

TilesetGym1GFX0::
INCBIN "gfx/tilesets/gym.2bpp.vram0.lz"

TilesetGym1GFX1::
INCBIN "gfx/tilesets/gym.2bpp.vram1.lz"

TilesetGym1Meta::
INCBIN "data/tilesets/gym_metatiles.bin.lz"

TilesetGym1Attr::
INCBIN "data/tilesets/gym_attributes.bin.lz"

TilesetGym1Coll::
INCBIN "data/tilesets/gym_collision.bin.lz"


SECTION "Tileset Data - magnet_train", ROMX

TilesetGym2GFX0::
INCBIN "gfx/tilesets/magnet_train.2bpp.vram0.lz"

TilesetGym2GFX1::
INCBIN "gfx/tilesets/magnet_train.2bpp.vram1.lz"

TilesetGym2Meta::
INCBIN "data/tilesets/magnet_train_metatiles.bin.lz"

TilesetGym2Attr::
INCBIN "data/tilesets/magnet_train_attributes.bin.lz"

TilesetGym2Coll::
INCBIN "data/tilesets/magnet_train_collision.bin.lz"


SECTION "Tileset Data - champions_room", ROMX

TilesetGym3GFX0::
INCBIN "gfx/tilesets/champions_room.2bpp.vram0.lz"

TilesetGym3GFX1::
INCBIN "gfx/tilesets/champions_room.2bpp.vram1.lz"

TilesetGym3Meta::
INCBIN "data/tilesets/champions_room_metatiles.bin.lz"

TilesetGym3Attr::
INCBIN "data/tilesets/champions_room_attributes.bin.lz"

TilesetGym3Coll::
INCBIN "data/tilesets/champions_room_collision.bin.lz"


SECTION "Tileset Data - port", ROMX

TilesetPortGFX0::
INCBIN "gfx/tilesets/port.2bpp.vram0.lz"

TilesetPortGFX1::
INCBIN "gfx/tilesets/port.2bpp.vram1.lz"

TilesetPortMeta::
INCBIN "data/tilesets/port_metatiles.bin.lz"

TilesetPortAttr::
INCBIN "data/tilesets/port_attributes.bin.lz"

TilesetPortColl::
INCBIN "data/tilesets/port_collision.bin.lz"


SECTION "Tileset Data - lab", ROMX

TilesetLabGFX0::
INCBIN "gfx/tilesets/lab.2bpp.vram0.lz"

TilesetLabGFX1::
INCBIN "gfx/tilesets/lab.2bpp.vram1.lz"

TilesetLabMeta::
INCBIN "data/tilesets/lab_metatiles.bin.lz"

TilesetLabAttr::
INCBIN "data/tilesets/lab_attributes.bin.lz"

TilesetLabColl::
INCBIN "data/tilesets/lab_collision.bin.lz"


SECTION "Tileset Data - facility", ROMX

TilesetFacilityGFX0::
INCBIN "gfx/tilesets/facility.2bpp.vram0.lz"

TilesetFacilityGFX1::
INCBIN "gfx/tilesets/facility.2bpp.vram1.lz"

TilesetFacilityMeta::
INCBIN "data/tilesets/facility_metatiles.bin.lz"

TilesetFacilityAttr::
INCBIN "data/tilesets/facility_attributes.bin.lz"

TilesetFacilityColl::
INCBIN "data/tilesets/facility_collision.bin.lz"


SECTION "Tileset Data - celadon_mansion", ROMX

TilesetMansionGFX0::
INCBIN "gfx/tilesets/celadon_mansion.2bpp.vram0.lz"

TilesetMansionGFX1::
INCBIN "gfx/tilesets/celadon_mansion.2bpp.vram1.lz"

TilesetMansionMeta::
INCBIN "data/tilesets/celadon_mansion_metatiles.bin.lz"

TilesetMansionAttr::
INCBIN "data/tilesets/celadon_mansion_attributes.bin.lz"

TilesetMansionColl::
INCBIN "data/tilesets/celadon_mansion_collision.bin.lz"


SECTION "Tileset Data - game_corner", ROMX

TilesetGameCornerGFX0::
INCBIN "gfx/tilesets/game_corner.2bpp.vram0.lz"

TilesetGameCornerGFX1::
INCBIN "gfx/tilesets/game_corner.2bpp.vram1.lz"

TilesetGameCornerMeta::
INCBIN "data/tilesets/game_corner_metatiles.bin.lz"

TilesetGameCornerAttr::
INCBIN "data/tilesets/game_corner_attributes.bin.lz"

TilesetGameCornerColl::
INCBIN "data/tilesets/game_corner_collision.bin.lz"


SECTION "Tileset Data - home_decor_store", ROMX

TilesetDecorGFX0::
INCBIN "gfx/tilesets/home_decor_store.2bpp.vram0.lz"

TilesetDecorGFX1::
INCBIN "gfx/tilesets/home_decor_store.2bpp.vram1.lz"

TilesetDecorMeta::
INCBIN "data/tilesets/home_decor_store_metatiles.bin.lz"

TilesetDecorAttr::
INCBIN "data/tilesets/home_decor_store_attributes.bin.lz"

TilesetDecorColl::
INCBIN "data/tilesets/home_decor_store_collision.bin.lz"


SECTION "Tileset Data - museum", ROMX

TilesetMuseumGFX0::
INCBIN "gfx/tilesets/museum.2bpp.vram0.lz"

TilesetMuseumGFX1::
INCBIN "gfx/tilesets/museum.2bpp.vram1.lz"

TilesetMuseumMeta::
INCBIN "data/tilesets/museum_metatiles.bin.lz"

TilesetMuseumAttr::
INCBIN "data/tilesets/museum_attributes.bin.lz"

TilesetMuseumColl::
INCBIN "data/tilesets/museum_collision.bin.lz"


SECTION "Tileset Data - hotel", ROMX

TilesetHotelGFX0::
INCBIN "gfx/tilesets/hotel.2bpp.vram0.lz"

TilesetHotelGFX1::
INCBIN "gfx/tilesets/hotel.2bpp.vram1.lz"

TilesetHotelMeta::
INCBIN "data/tilesets/hotel_metatiles.bin.lz"

TilesetHotelAttr::
INCBIN "data/tilesets/hotel_attributes.bin.lz"

TilesetHotelColl::
INCBIN "data/tilesets/hotel_collision.bin.lz"


SECTION "Tileset Data - sprout_tower", ROMX

TilesetTowerGFX0::
INCBIN "gfx/tilesets/sprout_tower.2bpp.vram0.lz"

TilesetTowerGFX1::
INCBIN "gfx/tilesets/sprout_tower.2bpp.vram1.lz"

TilesetTowerMeta::
INCBIN "data/tilesets/sprout_tower_metatiles.bin.lz"

TilesetTowerAttr::
INCBIN "data/tilesets/sprout_tower_attributes.bin.lz"

TilesetTowerColl::
INCBIN "data/tilesets/sprout_tower_collision.bin.lz"


SECTION "Tileset Data - battle_tower_inside", ROMX

TilesetBattleTowerGFX0::
INCBIN "gfx/tilesets/battle_tower_inside.2bpp.vram0.lz"

TilesetBattleTowerGFX1::
INCBIN "gfx/tilesets/battle_tower_inside.2bpp.vram1.lz"

TilesetBattleTowerMeta::
INCBIN "data/tilesets/battle_tower_inside_metatiles.bin.lz"

TilesetBattleTowerAttr::
INCBIN "data/tilesets/battle_tower_inside_attributes.bin.lz"

TilesetBattleTowerColl::
INCBIN "data/tilesets/battle_tower_inside_collision.bin.lz"


SECTION "Tileset Data - radio_tower", ROMX

TilesetRadioTowerGFX0::
INCBIN "gfx/tilesets/radio_tower.2bpp.vram0.lz"

TilesetRadioTowerGFX1::
INCBIN "gfx/tilesets/radio_tower.2bpp.vram1.lz"

TilesetRadioTowerMeta::
INCBIN "data/tilesets/radio_tower_metatiles.bin.lz"

TilesetRadioTowerAttr::
INCBIN "data/tilesets/radio_tower_attributes.bin.lz"

TilesetRadioTowerColl::
INCBIN "data/tilesets/radio_tower_collision.bin.lz"


SECTION "Tileset Data - lighthouse", ROMX

TilesetLighthouseGFX0::
INCBIN "gfx/tilesets/lighthouse.2bpp.vram0.lz"

TilesetLighthouseGFX1::
INCBIN "gfx/tilesets/lighthouse.2bpp.vram1.lz"

TilesetLighthouseMeta::
INCBIN "data/tilesets/lighthouse_metatiles.bin.lz"

TilesetLighthouseAttr::
INCBIN "data/tilesets/lighthouse_attributes.bin.lz"

TilesetLighthouseColl::
INCBIN "data/tilesets/lighthouse_collision.bin.lz"


SECTION "Tileset Data - underground", ROMX

TilesetWarehouseGFX0::
INCBIN "gfx/tilesets/underground.2bpp.vram0.lz"

TilesetWarehouseGFX1::
INCBIN "gfx/tilesets/underground.2bpp.vram1.lz"

TilesetWarehouseMeta::
INCBIN "data/tilesets/underground_metatiles.bin.lz"

TilesetWarehouseAttr::
INCBIN "data/tilesets/underground_attributes.bin.lz"

TilesetWarehouseColl::
INCBIN "data/tilesets/underground_collision.bin.lz"


SECTION "Tileset Data - cave", ROMX

TilesetCaveGFX0::
INCBIN "gfx/tilesets/cave.2bpp.vram0.lz"

TilesetCaveGFX1::
INCBIN "gfx/tilesets/cave.2bpp.vram1.lz"

TilesetQuietCaveGFX0::
INCBIN "gfx/tilesets/quiet_cave.2bpp.vram0.lz"

TilesetQuietCaveGFX1::
INCBIN "gfx/tilesets/quiet_cave.2bpp.vram1.lz"

TilesetCaveMeta::
TilesetQuietCaveMeta::
INCBIN "data/tilesets/cave_metatiles.bin.lz"

TilesetCaveAttr::
TilesetQuietCaveAttr::
INCBIN "data/tilesets/cave_attributes.bin.lz"

TilesetCaveColl::
TilesetQuietCaveColl::
INCBIN "data/tilesets/cave_collision.bin.lz"


SECTION "Tileset Data - ice_path", ROMX

TilesetIcePathGFX0::
INCBIN "gfx/tilesets/ice_path.2bpp.vram0.lz"

TilesetIcePathGFX1::
INCBIN "gfx/tilesets/ice_path.2bpp.vram1.lz"

TilesetIcePathMeta::
INCBIN "data/tilesets/ice_path_metatiles.bin.lz"

TilesetIcePathAttr::
INCBIN "data/tilesets/ice_path_attributes.bin.lz"

TilesetIcePathColl::
INCBIN "data/tilesets/ice_path_collision.bin.lz"


SECTION "Tileset Data - tunnel", ROMX

TilesetTunnelGFX0::
INCBIN "gfx/tilesets/tunnel.2bpp.vram0.lz"

TilesetTunnelGFX1::
INCBIN "gfx/tilesets/tunnel.2bpp.vram1.lz"

TilesetTunnelMeta::
INCBIN "data/tilesets/tunnel_metatiles.bin.lz"

TilesetTunnelAttr::
INCBIN "data/tilesets/tunnel_attributes.bin.lz"

TilesetTunnelColl::
INCBIN "data/tilesets/tunnel_collision.bin.lz"


SECTION "Tileset Data - forest", ROMX

TilesetForestGFX0::
INCBIN "gfx/tilesets/forest.2bpp.vram0.lz"

TilesetForestGFX1::
INCBIN "gfx/tilesets/forest.2bpp.vram1.lz"

TilesetForestMeta::
INCBIN "data/tilesets/forest_metatiles.bin.lz"

TilesetForestAttr::
INCBIN "data/tilesets/forest_attributes.bin.lz"

TilesetForestColl::
INCBIN "data/tilesets/forest_collision.bin.lz"


SECTION "Tileset Data - park", ROMX

TilesetParkGFX0::
INCBIN "gfx/tilesets/park.2bpp.vram0.lz"

TilesetParkGFX1::
INCBIN "gfx/tilesets/park.2bpp.vram1.lz"

TilesetParkMeta::
INCBIN "data/tilesets/park_metatiles.bin.lz"

TilesetParkAttr::
INCBIN "data/tilesets/park_attributes.bin.lz"

TilesetParkColl::
INCBIN "data/tilesets/park_collision.bin.lz"


SECTION "Tileset Data - safari_zone", ROMX

TilesetSafariGFX0::
INCBIN "gfx/tilesets/safari_zone.2bpp.vram0.lz"

TilesetSafariGFX1::
INCBIN "gfx/tilesets/safari_zone.2bpp.vram1.lz"

TilesetSafariMeta::
INCBIN "data/tilesets/safari_zone_metatiles.bin.lz"

TilesetSafariAttr::
INCBIN "data/tilesets/safari_zone_attributes.bin.lz"

TilesetSafariColl::
INCBIN "data/tilesets/safari_zone_collision.bin.lz"


SECTION "Tileset Data - ruins_of_alph", ROMX

TilesetRuinsGFX0::
TilesetAlphGFX0::
INCBIN "gfx/tilesets/ruins_of_alph.2bpp.vram0.lz"

TilesetRuinsGFX1::
TilesetAlphGFX1::
INCBIN "gfx/tilesets/ruins_of_alph.2bpp.vram1.lz"

TilesetRuinsMeta::
INCBIN "data/tilesets/ruins_of_alph_metatiles.bin.lz"

TilesetRuinsAttr::
INCBIN "data/tilesets/ruins_of_alph_attributes.bin.lz"

TilesetRuinsColl::
INCBIN "data/tilesets/ruins_of_alph_collision.bin.lz"


SECTION "Tileset Data - alph_word_room", ROMX

TilesetAlphMeta::
INCBIN "data/tilesets/alph_word_room_metatiles.bin.lz"

TilesetAlphAttr::
INCBIN "data/tilesets/alph_word_room_attributes.bin.lz"

TilesetAlphColl::
INCBIN "data/tilesets/alph_word_room_collision.bin.lz"


SECTION "Tileset Data - pokemon_mansion", ROMX

TilesetPokemonMansionGFX0::
INCBIN "gfx/tilesets/pokemon_mansion.2bpp.vram0.lz"

TilesetPokemonMansionGFX1::
INCBIN "gfx/tilesets/pokemon_mansion.2bpp.vram1.lz"

TilesetPokemonMansionMeta::
INCBIN "data/tilesets/pokemon_mansion_metatiles.bin.lz"

TilesetPokemonMansionAttr::
INCBIN "data/tilesets/pokemon_mansion_attributes.bin.lz"

TilesetPokemonMansionColl::
INCBIN "data/tilesets/pokemon_mansion_collision.bin.lz"


SECTION "Tileset Data - battle_factory", ROMX

TilesetBattleFactoryGFX0::
INCBIN "gfx/tilesets/battle_factory.2bpp.vram0.lz"

TilesetBattleFactoryGFX1::
INCBIN "gfx/tilesets/battle_factory.2bpp.vram1.lz"

TilesetBattleFactoryMeta::
INCBIN "data/tilesets/battle_factory_metatiles.bin.lz"

TilesetBattleFactoryAttr::
INCBIN "data/tilesets/battle_factory_attributes.bin.lz"

TilesetBattleFactoryColl::
INCBIN "data/tilesets/battle_factory_collision.bin.lz"


SECTION "Tileset Data - GFX2", ROMX

; None of the tilesets need "★" GFX, so consolidate them here.
TilesetJohto1GFX2::
TilesetJohto2GFX2::
TilesetJohto3GFX2::
TilesetJohto4GFX2::
TilesetKanto1GFX2::
TilesetKanto2GFX2::
TilesetShamoutiGFX2::
TilesetValenciaGFX2::
TilesetFarawayGFX2::
TilesetHouse1GFX2::
TilesetHouse2GFX2::
TilesetHouse3GFX2::
TilesetPokeCenterGFX2::
TilesetPokeComGFX2::
TilesetMartGFX2::
TilesetGateGFX2::
TilesetGym1GFX2::
TilesetGym2GFX2::
TilesetGym3GFX2::
TilesetPortGFX2::
TilesetLabGFX2::
TilesetFacilityGFX2::
TilesetMansionGFX2::
TilesetGameCornerGFX2::
TilesetDecorGFX2::
TilesetMuseumGFX2::
TilesetHotelGFX2::
TilesetTowerGFX2::
TilesetBattleTowerGFX2::
TilesetRadioTowerGFX2::
TilesetLighthouseGFX2::
TilesetWarehouseGFX2::
TilesetCaveGFX2::
TilesetQuietCaveGFX2::
TilesetIcePathGFX2::
TilesetTunnelGFX2::
TilesetForestGFX2::
TilesetParkGFX2::
TilesetSafariGFX2::
TilesetRuinsGFX2::
TilesetAlphGFX2::
TilesetPokemonMansionGFX2::
TilesetBattleFactoryGFX2::
	db $ff ; Compressed data is terminated with $ff.
