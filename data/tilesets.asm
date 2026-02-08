SECTION "Tileset Headers", ROMX

MACRO tileset
	dbas \1Meta, \1Coll, \1Attr
	dba \1GFX0, \1GFX1, \1GFX2
	dw \1Anim ; BANK(_AnimateTileset)
ENDM

Tilesets::
; entries correspond to TILESET_* constants (see constants/tileset_constants.asm)
	table_width TILESET_LENGTH
	tileset TilesetJohto1
	tileset TilesetJohto2
	tileset TilesetJohto3
	tileset TilesetJohto4
	tileset TilesetJohto5
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
	tileset TilesetSnowtopMountain
	tileset TilesetHiddenGrotto
	assert_table_length NUM_TILESETS


SECTION "Tileset Graphics - johto common vram0", ROMX

TilesetJohto1GFX0::
TilesetJohto2GFX0::
TilesetJohto3GFX0::
TilesetJohto4GFX0::
TilesetJohto5GFX0:: INCBIN "gfx/tilesets/johto_common.2bpp.lzp"


SECTION "Tileset Graphics - johto traditional vram1", ROMX

TilesetJohto1GFX1::
TilesetJohto5GFX1:: INCBIN "gfx/tilesets/johto_traditional.johto_common.2bpp.vram0.lzp"


SECTION "Tileset Graphics - johto traditional vram2", ROMX

TilesetJohto1GFX2::
TilesetJohto5GFX2:: INCBIN "gfx/tilesets/johto_traditional.johto_common.2bpp.vram1.lzp"


SECTION "Tileset Data - johto traditional", ROMX

TilesetJohto1Meta:: INCBIN "data/tilesets/johto_traditional_metatiles.bin.lzp"
TilesetJohto1Attr:: INCBIN "data/tilesets/johto_traditional_attributes.bin.lzp"
TilesetJohto1Coll:: INCBIN "data/tilesets/johto_traditional_collision.bin.lzp"


SECTION "Tileset Graphics - johto modern vram1", ROMX

TilesetJohto2GFX1:: INCBIN "gfx/tilesets/johto_modern.johto_common.2bpp.vram0.lzp"


SECTION "Tileset Graphics - johto modern vram2", ROMX

TilesetJohto2GFX2:: INCBIN "gfx/tilesets/johto_modern.johto_common.2bpp.vram1.lzp"


SECTION "Tileset Data - johto modern", ROMX

TilesetJohto2Meta:: INCBIN "data/tilesets/johto_modern_metatiles.bin.lzp"
TilesetJohto2Attr:: INCBIN "data/tilesets/johto_modern_attributes.bin.lzp"
TilesetJohto2Coll:: INCBIN "data/tilesets/johto_modern_collision.bin.lzp"


SECTION "Tileset Graphics - johto overcast vram1", ROMX

TilesetJohto3GFX1:: INCBIN "gfx/tilesets/johto_overcast.johto_common.2bpp.vram0.lzp"


SECTION "Tileset Graphics - johto overcast vram2", ROMX

TilesetJohto3GFX2:: INCBIN "gfx/tilesets/johto_overcast.johto_common.2bpp.vram1.lzp"


SECTION "Tileset Data - johto overcast", ROMX

TilesetJohto3Meta:: INCBIN "data/tilesets/johto_overcast_metatiles.bin.lzp"
TilesetJohto3Attr:: INCBIN "data/tilesets/johto_overcast_attributes.bin.lzp"
TilesetJohto3Coll:: INCBIN "data/tilesets/johto_overcast_collision.bin.lzp"


SECTION "Tileset Graphics - battle tower outside vram1", ROMX

TilesetJohto4GFX1:: INCBIN "gfx/tilesets/battle_tower_outside.johto_common.2bpp.lzp"


SECTION "Tileset Data - battle tower outside", ROMX

TilesetJohto4Meta:: INCBIN "data/tilesets/battle_tower_outside_metatiles.bin.lzp"
TilesetJohto4Attr:: INCBIN "data/tilesets/battle_tower_outside_attributes.bin.lzp"
TilesetJohto4Coll:: INCBIN "data/tilesets/battle_tower_outside_collision.bin.lzp"


SECTION "Tileset Data - ecruteak shrine", ROMX

TilesetJohto5Meta:: INCBIN "data/tilesets/ecruteak_shrine_metatiles.bin.lzp"
TilesetJohto5Attr:: INCBIN "data/tilesets/ecruteak_shrine_attributes.bin.lzp"
TilesetJohto5Coll:: INCBIN "data/tilesets/ecruteak_shrine_collision.bin.lzp"


SECTION "Tileset Graphics - kanto common vram0", ROMX

TilesetKanto1GFX0::
TilesetKanto2GFX0:: INCBIN "gfx/tilesets/kanto_common.2bpp.lzp"


SECTION "Tileset Graphics - kanto vram1", ROMX

TilesetKanto1GFX1:: INCBIN "gfx/tilesets/kanto.kanto_common.2bpp.lzp"


SECTION "Tileset Data - kanto", ROMX

TilesetKanto1Meta:: INCBIN "data/tilesets/kanto_metatiles.bin.lzp"
TilesetKanto1Attr:: INCBIN "data/tilesets/kanto_attributes.bin.lzp"
TilesetKanto1Coll:: INCBIN "data/tilesets/kanto_collision.bin.lzp"


SECTION "Tileset Graphics - indigo plateau vram1", ROMX

TilesetKanto2GFX1:: INCBIN "gfx/tilesets/indigo_plateau.kanto_common.2bpp.lzp"


SECTION "Tileset Data - indigo plateau", ROMX

TilesetKanto2Meta:: INCBIN "data/tilesets/indigo_plateau_metatiles.bin.lzp"
TilesetKanto2Attr:: INCBIN "data/tilesets/indigo_plateau_attributes.bin.lzp"
TilesetKanto2Coll:: INCBIN "data/tilesets/indigo_plateau_collision.bin.lzp"


SECTION "Tileset Graphics - shamouti island vram0", ROMX

TilesetShamoutiGFX0:: INCBIN "gfx/tilesets/shamouti_island.2bpp.vram0.lzp"


SECTION "Tileset Graphics - shamouti island vram1", ROMX

TilesetShamoutiGFX1:: INCBIN "gfx/tilesets/shamouti_island.2bpp.vram1.lzp"


SECTION "Tileset Data - shamouti island", ROMX

TilesetShamoutiMeta:: INCBIN "data/tilesets/shamouti_island_metatiles.bin.lzp"
TilesetShamoutiAttr:: INCBIN "data/tilesets/shamouti_island_attributes.bin.lzp"
TilesetShamoutiColl:: INCBIN "data/tilesets/shamouti_island_collision.bin.lzp"


SECTION "Tileset Graphics - valencia island vram0", ROMX

TilesetValenciaGFX0:: INCBIN "gfx/tilesets/valencia_island.2bpp.vram0.lzp"


SECTION "Tileset Graphics - valencia island vram1", ROMX

TilesetValenciaGFX1:: INCBIN "gfx/tilesets/valencia_island.2bpp.vram1.lzp"


SECTION "Tileset Data - valencia island", ROMX

TilesetValenciaMeta:: INCBIN "data/tilesets/valencia_island_metatiles.bin.lzp"
TilesetValenciaAttr:: INCBIN "data/tilesets/valencia_island_attributes.bin.lzp"
TilesetValenciaColl:: INCBIN "data/tilesets/valencia_island_collision.bin.lzp"


SECTION "Tileset Graphics - faraway island vram0", ROMX

TilesetFarawayGFX0:: INCBIN "gfx/tilesets/faraway_island.2bpp.vram0.lzp"


SECTION "Tileset Graphics - faraway island vram1", ROMX

TilesetFarawayGFX1:: INCBIN "gfx/tilesets/faraway_island.2bpp.vram1.lzp"


SECTION "Tileset Data - faraway island", ROMX

TilesetFarawayMeta:: INCBIN "data/tilesets/faraway_island_metatiles.bin.lzp"
TilesetFarawayAttr:: INCBIN "data/tilesets/faraway_island_attributes.bin.lzp"
TilesetFarawayColl:: INCBIN "data/tilesets/faraway_island_collision.bin.lzp"


SECTION "Tileset Graphics - johto house vram0", ROMX

TilesetHouse1GFX0:: INCBIN "gfx/tilesets/johto_house.2bpp.vram0.lzp"


SECTION "Tileset Graphics - johto house vram1", ROMX

TilesetHouse1GFX1:: INCBIN "gfx/tilesets/johto_house.2bpp.vram1.lzp"


SECTION "Tileset Data - johto house", ROMX

TilesetHouse1Meta:: INCBIN "data/tilesets/johto_house_metatiles.bin.lzp"
TilesetHouse1Attr:: INCBIN "data/tilesets/johto_house_attributes.bin.lzp"
TilesetHouse1Coll:: INCBIN "data/tilesets/johto_house_collision.bin.lzp"


SECTION "Tileset Graphics - kanto house vram0", ROMX

TilesetHouse2GFX0:: INCBIN "gfx/tilesets/kanto_house.2bpp.vram0.lzp"


SECTION "Tileset Graphics - kanto house vram1", ROMX

TilesetHouse2GFX1:: INCBIN "gfx/tilesets/kanto_house.2bpp.vram1.lzp"


SECTION "Tileset Data - kanto house", ROMX

TilesetHouse2Meta:: INCBIN "data/tilesets/kanto_house_metatiles.bin.lzp"
TilesetHouse2Attr:: INCBIN "data/tilesets/kanto_house_attributes.bin.lzp"
TilesetHouse2Coll:: INCBIN "data/tilesets/kanto_house_collision.bin.lzp"


SECTION "Tileset Graphics - traditional house vram0", ROMX

TilesetHouse3GFX0:: INCBIN "gfx/tilesets/traditional_house.2bpp.vram0.lzp"


SECTION "Tileset Graphics - traditional house vram1", ROMX

TilesetHouse3GFX1:: INCBIN "gfx/tilesets/traditional_house.2bpp.vram1.lzp"


SECTION "Tileset Data - traditional house", ROMX

TilesetHouse3Meta:: INCBIN "data/tilesets/traditional_house_metatiles.bin.lzp"
TilesetHouse3Attr:: INCBIN "data/tilesets/traditional_house_attributes.bin.lzp"
TilesetHouse3Coll:: INCBIN "data/tilesets/traditional_house_collision.bin.lzp"


SECTION "Tileset Graphics - pokecenter vram0", ROMX

TilesetPokeCenterGFX0:: INCBIN "gfx/tilesets/pokecenter.2bpp.vram0.lzp"


SECTION "Tileset Graphics - pokecenter vram1", ROMX

TilesetPokeCenterGFX1:: INCBIN "gfx/tilesets/pokecenter.2bpp.vram1.lzp"


SECTION "Tileset Data - pokecenter", ROMX

TilesetPokeCenterMeta:: INCBIN "data/tilesets/pokecenter_metatiles.bin.lzp"
TilesetPokeCenterAttr:: INCBIN "data/tilesets/pokecenter_attributes.bin.lzp"
TilesetPokeCenterColl:: INCBIN "data/tilesets/pokecenter_collision.bin.lzp"


SECTION "Tileset Graphics - pokecom center vram0", ROMX

TilesetPokeComGFX0:: INCBIN "gfx/tilesets/pokecom_center.2bpp.vram0.lzp"


SECTION "Tileset Graphics - pokecom center vram1", ROMX

TilesetPokeComGFX1:: INCBIN "gfx/tilesets/pokecom_center.2bpp.vram1.lzp"


SECTION "Tileset Data - pokecom center", ROMX

TilesetPokeComMeta:: INCBIN "data/tilesets/pokecom_center_metatiles.bin.lzp"
TilesetPokeComAttr:: INCBIN "data/tilesets/pokecom_center_attributes.bin.lzp"
TilesetPokeComColl:: INCBIN "data/tilesets/pokecom_center_collision.bin.lzp"


SECTION "Tileset Graphics - mart vram0", ROMX

TilesetMartGFX0:: INCBIN "gfx/tilesets/mart.2bpp.vram0.lzp"


SECTION "Tileset Graphics - mart vram1", ROMX

TilesetMartGFX1:: INCBIN "gfx/tilesets/mart.2bpp.vram1.lzp"


SECTION "Tileset Data - mart", ROMX

TilesetMartMeta:: INCBIN "data/tilesets/mart_metatiles.bin.lzp"
TilesetMartAttr:: INCBIN "data/tilesets/mart_attributes.bin.lzp"
TilesetMartColl:: INCBIN "data/tilesets/mart_collision.bin.lzp"


SECTION "Tileset Graphics - gate vram0", ROMX

TilesetGateGFX0:: INCBIN "gfx/tilesets/gate.2bpp.vram0.lzp"


SECTION "Tileset Graphics - gate vram1", ROMX

TilesetGateGFX1:: INCBIN "gfx/tilesets/gate.2bpp.vram1.lzp"


SECTION "Tileset Data - gate", ROMX

TilesetGateMeta:: INCBIN "data/tilesets/gate_metatiles.bin.lzp"
TilesetGateAttr:: INCBIN "data/tilesets/gate_attributes.bin.lzp"
TilesetGateColl:: INCBIN "data/tilesets/gate_collision.bin.lzp"


SECTION "Tileset Graphics - gym vram0", ROMX

TilesetGym1GFX0:: INCBIN "gfx/tilesets/gym.2bpp.vram0.lzp"


SECTION "Tileset Graphics - gym vram1", ROMX

TilesetGym1GFX1:: INCBIN "gfx/tilesets/gym.2bpp.vram1.lzp"


SECTION "Tileset Data - gym", ROMX

TilesetGym1Meta:: INCBIN "data/tilesets/gym_metatiles.bin.lzp"
TilesetGym1Attr:: INCBIN "data/tilesets/gym_attributes.bin.lzp"
TilesetGym1Coll:: INCBIN "data/tilesets/gym_collision.bin.lzp"


SECTION "Tileset Graphics - magnet train vram0", ROMX

TilesetGym2GFX0:: INCBIN "gfx/tilesets/magnet_train.2bpp.vram0.lzp"


SECTION "Tileset Graphics - magnet train vram1", ROMX

TilesetGym2GFX1:: INCBIN "gfx/tilesets/magnet_train.2bpp.vram1.lzp"


SECTION "Tileset Data - magnet train", ROMX

TilesetGym2Meta:: INCBIN "data/tilesets/magnet_train_metatiles.bin.lzp"
TilesetGym2Attr:: INCBIN "data/tilesets/magnet_train_attributes.bin.lzp"
TilesetGym2Coll:: INCBIN "data/tilesets/magnet_train_collision.bin.lzp"


SECTION "Tileset Graphics - champions room vram0", ROMX

TilesetGym3GFX0:: INCBIN "gfx/tilesets/champions_room.2bpp.vram0.lzp"


SECTION "Tileset Graphics - champions room vram1", ROMX

TilesetGym3GFX1:: INCBIN "gfx/tilesets/champions_room.2bpp.vram1.lzp"


SECTION "Tileset Data - champions room", ROMX

TilesetGym3Meta:: INCBIN "data/tilesets/champions_room_metatiles.bin.lzp"
TilesetGym3Attr:: INCBIN "data/tilesets/champions_room_attributes.bin.lzp"
TilesetGym3Coll:: INCBIN "data/tilesets/champions_room_collision.bin.lzp"


SECTION "Tileset Graphics - port vram0", ROMX

TilesetPortGFX0:: INCBIN "gfx/tilesets/port.2bpp.vram0.lzp"


SECTION "Tileset Graphics - port vram1", ROMX

TilesetPortGFX1:: INCBIN "gfx/tilesets/port.2bpp.vram1.lzp"


SECTION "Tileset Data - port", ROMX

TilesetPortMeta:: INCBIN "data/tilesets/port_metatiles.bin.lzp"
TilesetPortAttr:: INCBIN "data/tilesets/port_attributes.bin.lzp"
TilesetPortColl:: INCBIN "data/tilesets/port_collision.bin.lzp"


SECTION "Tileset Graphics - lab vram0", ROMX

TilesetLabGFX0:: INCBIN "gfx/tilesets/lab.2bpp.vram0.lzp"


SECTION "Tileset Graphics - lab vram1", ROMX

TilesetLabGFX1:: INCBIN "gfx/tilesets/lab.2bpp.vram1.lzp"


SECTION "Tileset Data - lab", ROMX

TilesetLabMeta:: INCBIN "data/tilesets/lab_metatiles.bin.lzp"
TilesetLabAttr:: INCBIN "data/tilesets/lab_attributes.bin.lzp"
TilesetLabColl:: INCBIN "data/tilesets/lab_collision.bin.lzp"


SECTION "Tileset Graphics - facility vram0", ROMX

TilesetFacilityGFX0:: INCBIN "gfx/tilesets/facility.2bpp.vram0.lzp"


SECTION "Tileset Graphics - facility vram1", ROMX

TilesetFacilityGFX1:: INCBIN "gfx/tilesets/facility.2bpp.vram1.lzp"


SECTION "Tileset Data - facility", ROMX

TilesetFacilityMeta:: INCBIN "data/tilesets/facility_metatiles.bin.lzp"
TilesetFacilityAttr:: INCBIN "data/tilesets/facility_attributes.bin.lzp"
TilesetFacilityColl:: INCBIN "data/tilesets/facility_collision.bin.lzp"


SECTION "Tileset Graphics - celadon mansion vram0", ROMX

TilesetMansionGFX0:: INCBIN "gfx/tilesets/celadon_mansion.2bpp.vram0.lzp"


SECTION "Tileset Graphics - celadon mansion vram1", ROMX

TilesetMansionGFX1:: INCBIN "gfx/tilesets/celadon_mansion.2bpp.vram1.lzp"


SECTION "Tileset Data - celadon mansion", ROMX

TilesetMansionMeta:: INCBIN "data/tilesets/celadon_mansion_metatiles.bin.lzp"
TilesetMansionAttr:: INCBIN "data/tilesets/celadon_mansion_attributes.bin.lzp"
TilesetMansionColl:: INCBIN "data/tilesets/celadon_mansion_collision.bin.lzp"


SECTION "Tileset Graphics - game corner vram0", ROMX

TilesetGameCornerGFX0:: INCBIN "gfx/tilesets/game_corner.2bpp.vram0.lzp"


SECTION "Tileset Graphics - game corner vram1", ROMX

TilesetGameCornerGFX1:: INCBIN "gfx/tilesets/game_corner.2bpp.vram1.lzp"


SECTION "Tileset Data - game corner", ROMX

TilesetGameCornerMeta:: INCBIN "data/tilesets/game_corner_metatiles.bin.lzp"
TilesetGameCornerAttr:: INCBIN "data/tilesets/game_corner_attributes.bin.lzp"
TilesetGameCornerColl:: INCBIN "data/tilesets/game_corner_collision.bin.lzp"


SECTION "Tileset Graphics - home decor store vram0", ROMX

TilesetDecorGFX0:: INCBIN "gfx/tilesets/home_decor_store.2bpp.vram0.lzp"


SECTION "Tileset Graphics - home decor store vram1", ROMX

TilesetDecorGFX1:: INCBIN "gfx/tilesets/home_decor_store.2bpp.vram1.lzp"


SECTION "Tileset Data - home decor store", ROMX

TilesetDecorMeta:: INCBIN "data/tilesets/home_decor_store_metatiles.bin.lzp"
TilesetDecorAttr:: INCBIN "data/tilesets/home_decor_store_attributes.bin.lzp"
TilesetDecorColl:: INCBIN "data/tilesets/home_decor_store_collision.bin.lzp"


SECTION "Tileset Graphics - museum vram0", ROMX

TilesetMuseumGFX0:: INCBIN "gfx/tilesets/museum.2bpp.vram0.lzp"


SECTION "Tileset Graphics - museum vram1", ROMX

TilesetMuseumGFX1:: INCBIN "gfx/tilesets/museum.2bpp.vram1.lzp"


SECTION "Tileset Data - museum", ROMX

TilesetMuseumMeta:: INCBIN "data/tilesets/museum_metatiles.bin.lzp"
TilesetMuseumAttr:: INCBIN "data/tilesets/museum_attributes.bin.lzp"
TilesetMuseumColl:: INCBIN "data/tilesets/museum_collision.bin.lzp"


SECTION "Tileset Graphics - hotel vram0", ROMX

TilesetHotelGFX0:: INCBIN "gfx/tilesets/hotel.2bpp.vram0.lzp"


SECTION "Tileset Graphics - hotel vram1", ROMX

TilesetHotelGFX1:: INCBIN "gfx/tilesets/hotel.2bpp.vram1.lzp"


SECTION "Tileset Data - hotel", ROMX

TilesetHotelMeta:: INCBIN "data/tilesets/hotel_metatiles.bin.lzp"
TilesetHotelAttr:: INCBIN "data/tilesets/hotel_attributes.bin.lzp"
TilesetHotelColl:: INCBIN "data/tilesets/hotel_collision.bin.lzp"


SECTION "Tileset Graphics - sprout tower vram0", ROMX

TilesetTowerGFX0:: INCBIN "gfx/tilesets/sprout_tower.2bpp.vram0.lzp"


SECTION "Tileset Graphics - sprout tower vram1", ROMX

TilesetTowerGFX1:: INCBIN "gfx/tilesets/sprout_tower.2bpp.vram1.lzp"


SECTION "Tileset Data - sprout tower", ROMX

TilesetTowerMeta:: INCBIN "data/tilesets/sprout_tower_metatiles.bin.lzp"
TilesetTowerAttr:: INCBIN "data/tilesets/sprout_tower_attributes.bin.lzp"
TilesetTowerColl:: INCBIN "data/tilesets/sprout_tower_collision.bin.lzp"


SECTION "Tileset Graphics - battle tower inside vram0", ROMX

TilesetBattleTowerGFX0:: INCBIN "gfx/tilesets/battle_tower_inside.2bpp.vram0.lzp"


SECTION "Tileset Graphics - battle tower inside vram1", ROMX

TilesetBattleTowerGFX1:: INCBIN "gfx/tilesets/battle_tower_inside.2bpp.vram1.lzp"


SECTION "Tileset Data - battle tower inside", ROMX

TilesetBattleTowerMeta:: INCBIN "data/tilesets/battle_tower_inside_metatiles.bin.lzp"
TilesetBattleTowerAttr:: INCBIN "data/tilesets/battle_tower_inside_attributes.bin.lzp"
TilesetBattleTowerColl:: INCBIN "data/tilesets/battle_tower_inside_collision.bin.lzp"


SECTION "Tileset Graphics - radio tower vram0", ROMX

TilesetRadioTowerGFX0:: INCBIN "gfx/tilesets/radio_tower.2bpp.vram0.lzp"


SECTION "Tileset Graphics - radio tower vram1", ROMX

TilesetRadioTowerGFX1:: INCBIN "gfx/tilesets/radio_tower.2bpp.vram1.lzp"


SECTION "Tileset Data - radio tower", ROMX

TilesetRadioTowerMeta:: INCBIN "data/tilesets/radio_tower_metatiles.bin.lzp"
TilesetRadioTowerAttr:: INCBIN "data/tilesets/radio_tower_attributes.bin.lzp"
TilesetRadioTowerColl:: INCBIN "data/tilesets/radio_tower_collision.bin.lzp"


SECTION "Tileset Graphics - lighthouse vram0", ROMX

TilesetLighthouseGFX0:: INCBIN "gfx/tilesets/lighthouse.2bpp.vram0.lzp"


SECTION "Tileset Graphics - lighthouse vram1", ROMX

TilesetLighthouseGFX1:: INCBIN "gfx/tilesets/lighthouse.2bpp.vram1.lzp"


SECTION "Tileset Data - lighthouse", ROMX

TilesetLighthouseMeta:: INCBIN "data/tilesets/lighthouse_metatiles.bin.lzp"
TilesetLighthouseAttr:: INCBIN "data/tilesets/lighthouse_attributes.bin.lzp"
TilesetLighthouseColl:: INCBIN "data/tilesets/lighthouse_collision.bin.lzp"


SECTION "Tileset Graphics - underground vram0", ROMX

TilesetWarehouseGFX0:: INCBIN "gfx/tilesets/underground.2bpp.vram0.lzp"


SECTION "Tileset Graphics - underground vram1", ROMX

TilesetWarehouseGFX1:: INCBIN "gfx/tilesets/underground.2bpp.vram1.lzp"


SECTION "Tileset Data - underground", ROMX

TilesetWarehouseMeta:: INCBIN "data/tilesets/underground_metatiles.bin.lzp"
TilesetWarehouseAttr:: INCBIN "data/tilesets/underground_attributes.bin.lzp"
TilesetWarehouseColl:: INCBIN "data/tilesets/underground_collision.bin.lzp"


SECTION "Tileset Graphics - cave vram0", ROMX

TilesetCaveGFX0:: INCBIN "gfx/tilesets/cave.2bpp.vram0.lzp"


SECTION "Tileset Graphics - cave vram1", ROMX

TilesetCaveGFX1:: INCBIN "gfx/tilesets/cave.2bpp.vram1.lzp"


SECTION "Tileset Data - cave", ROMX

TilesetCaveMeta:: INCBIN "data/tilesets/cave_metatiles.bin.lzp"
TilesetCaveAttr:: INCBIN "data/tilesets/cave_attributes.bin.lzp"
TilesetCaveColl:: INCBIN "data/tilesets/cave_collision.bin.lzp"


SECTION "Tileset Graphics - quiet cave vram0", ROMX

TilesetQuietCaveGFX0:: INCBIN "gfx/tilesets/quiet_cave.2bpp.vram0.lzp"


SECTION "Tileset Graphics - quiet cave vram1", ROMX

TilesetQuietCaveGFX1:: INCBIN "gfx/tilesets/quiet_cave.2bpp.vram1.lzp"


SECTION "Tileset Data - quiet cave", ROMX

TilesetQuietCaveMeta:: INCBIN "data/tilesets/quiet_cave_metatiles.bin.lzp"
TilesetQuietCaveAttr:: INCBIN "data/tilesets/quiet_cave_attributes.bin.lzp"
TilesetQuietCaveColl:: INCBIN "data/tilesets/quiet_cave_collision.bin.lzp"


SECTION "Tileset Graphics - ice path vram0", ROMX

TilesetIcePathGFX0:: INCBIN "gfx/tilesets/ice_path.2bpp.vram0.lzp"


SECTION "Tileset Graphics - ice path vram1", ROMX

TilesetIcePathGFX1:: INCBIN "gfx/tilesets/ice_path.2bpp.vram1.lzp"


SECTION "Tileset Data - ice path", ROMX

TilesetIcePathMeta:: INCBIN "data/tilesets/ice_path_metatiles.bin.lzp"
TilesetIcePathAttr:: INCBIN "data/tilesets/ice_path_attributes.bin.lzp"
TilesetIcePathColl:: INCBIN "data/tilesets/ice_path_collision.bin.lzp"


SECTION "Tileset Graphics - tunnel vram0", ROMX

TilesetTunnelGFX0:: INCBIN "gfx/tilesets/tunnel.2bpp.vram0.lzp"


SECTION "Tileset Graphics - tunnel vram1", ROMX

TilesetTunnelGFX1:: INCBIN "gfx/tilesets/tunnel.2bpp.vram1.lzp"


SECTION "Tileset Data - tunnel", ROMX

TilesetTunnelMeta:: INCBIN "data/tilesets/tunnel_metatiles.bin.lzp"
TilesetTunnelAttr:: INCBIN "data/tilesets/tunnel_attributes.bin.lzp"
TilesetTunnelColl:: INCBIN "data/tilesets/tunnel_collision.bin.lzp"


SECTION "Tileset Graphics - forest vram0", ROMX

TilesetForestGFX0:: INCBIN "gfx/tilesets/forest.2bpp.vram0.lzp"


SECTION "Tileset Graphics - forest vram1", ROMX

TilesetForestGFX1:: INCBIN "gfx/tilesets/forest.2bpp.vram1.lzp"


SECTION "Tileset Data - forest", ROMX

TilesetForestMeta:: INCBIN "data/tilesets/forest_metatiles.bin.lzp"
TilesetForestAttr:: INCBIN "data/tilesets/forest_attributes.bin.lzp"
TilesetForestColl:: INCBIN "data/tilesets/forest_collision.bin.lzp"


SECTION "Tileset Graphics - park vram0", ROMX

TilesetParkGFX0:: INCBIN "gfx/tilesets/park.2bpp.vram0.lzp"


SECTION "Tileset Graphics - park vram1", ROMX

TilesetParkGFX1:: INCBIN "gfx/tilesets/park.2bpp.vram1.lzp"


SECTION "Tileset Data - park", ROMX

TilesetParkMeta:: INCBIN "data/tilesets/park_metatiles.bin.lzp"
TilesetParkAttr:: INCBIN "data/tilesets/park_attributes.bin.lzp"
TilesetParkColl:: INCBIN "data/tilesets/park_collision.bin.lzp"


SECTION "Tileset Graphics - safari zone vram0", ROMX

TilesetSafariGFX0:: INCBIN "gfx/tilesets/safari_zone.2bpp.vram0.lzp"


SECTION "Tileset Graphics - safari zone vram1", ROMX

TilesetSafariGFX1:: INCBIN "gfx/tilesets/safari_zone.2bpp.vram1.lzp"


SECTION "Tileset Data - safari zone", ROMX

TilesetSafariMeta:: INCBIN "data/tilesets/safari_zone_metatiles.bin.lzp"
TilesetSafariAttr:: INCBIN "data/tilesets/safari_zone_attributes.bin.lzp"
TilesetSafariColl:: INCBIN "data/tilesets/safari_zone_collision.bin.lzp"


SECTION "Tileset Graphics - ruins of alph vram0", ROMX

TilesetRuinsGFX0::
TilesetAlphGFX0:: INCBIN "gfx/tilesets/ruins_of_alph.2bpp.vram0.lzp"


SECTION "Tileset Graphics - ruins of alph vram1", ROMX

TilesetRuinsGFX1::
TilesetAlphGFX1:: INCBIN "gfx/tilesets/ruins_of_alph.2bpp.vram1.lzp"


SECTION "Tileset Data - ruins of alph", ROMX

TilesetRuinsMeta:: INCBIN "data/tilesets/ruins_of_alph_metatiles.bin.lzp"
TilesetRuinsAttr:: INCBIN "data/tilesets/ruins_of_alph_attributes.bin.lzp"
TilesetRuinsColl:: INCBIN "data/tilesets/ruins_of_alph_collision.bin.lzp"


SECTION "Tileset Data - alph word room", ROMX

TilesetAlphMeta:: INCBIN "data/tilesets/alph_word_room_metatiles.bin.lzp"
TilesetAlphAttr:: INCBIN "data/tilesets/alph_word_room_attributes.bin.lzp"
TilesetAlphColl:: INCBIN "data/tilesets/alph_word_room_collision.bin.lzp"


SECTION "Tileset Graphics - pokemon mansion vram0", ROMX

TilesetPokemonMansionGFX0:: INCBIN "gfx/tilesets/pokemon_mansion.2bpp.vram0.lzp"


SECTION "Tileset Graphics - pokemon mansion vram1", ROMX

TilesetPokemonMansionGFX1:: INCBIN "gfx/tilesets/pokemon_mansion.2bpp.vram1.lzp"


SECTION "Tileset Data - pokemon mansion", ROMX

TilesetPokemonMansionMeta:: INCBIN "data/tilesets/pokemon_mansion_metatiles.bin.lzp"
TilesetPokemonMansionAttr:: INCBIN "data/tilesets/pokemon_mansion_attributes.bin.lzp"
TilesetPokemonMansionColl:: INCBIN "data/tilesets/pokemon_mansion_collision.bin.lzp"


SECTION "Tileset Graphics - battle factory vram0", ROMX

TilesetBattleFactoryGFX0:: INCBIN "gfx/tilesets/battle_factory.2bpp.vram0.lzp"


SECTION "Tileset Graphics - battle factory vram1", ROMX

TilesetBattleFactoryGFX1:: INCBIN "gfx/tilesets/battle_factory.2bpp.vram1.lzp"


SECTION "Tileset Data - battle factory", ROMX

TilesetBattleFactoryMeta:: INCBIN "data/tilesets/battle_factory_metatiles.bin.lzp"
TilesetBattleFactoryAttr:: INCBIN "data/tilesets/battle_factory_attributes.bin.lzp"
TilesetBattleFactoryColl:: INCBIN "data/tilesets/battle_factory_collision.bin.lzp"


SECTION "Tileset Graphics - snowtop mountain vram0", ROMX

TilesetSnowtopMountainGFX0:: INCBIN "gfx/tilesets/snowtop_mountain.2bpp.vram0.lzp"


SECTION "Tileset Graphics - snowtop mountain vram1", ROMX

TilesetSnowtopMountainGFX1:: INCBIN "gfx/tilesets/snowtop_mountain.2bpp.vram1.lzp"


SECTION "Tileset Data - snowtop mountain", ROMX

TilesetSnowtopMountainMeta:: INCBIN "data/tilesets/snowtop_mountain_metatiles.bin.lzp"
TilesetSnowtopMountainAttr:: INCBIN "data/tilesets/snowtop_mountain_attributes.bin.lzp"
TilesetSnowtopMountainColl:: INCBIN "data/tilesets/snowtop_mountain_collision.bin.lzp"


SECTION "Tileset Graphics - hidden grotto vram0", ROMX

TilesetHiddenGrottoGFX0:: INCBIN "gfx/tilesets/hidden_grotto.2bpp.vram0.lzp"


SECTION "Tileset Graphics - hidden grotto vram1", ROMX

TilesetHiddenGrottoGFX1:: INCBIN "gfx/tilesets/hidden_grotto.2bpp.vram1.lzp"


SECTION "Tileset Data - hidden grotto", ROMX

TilesetHiddenGrottoMeta:: INCBIN "data/tilesets/hidden_grotto_metatiles.bin.lzp"
TilesetHiddenGrottoAttr:: INCBIN "data/tilesets/hidden_grotto_attributes.bin.lzp"
TilesetHiddenGrottoColl:: INCBIN "data/tilesets/hidden_grotto_collision.bin.lzp"


SECTION "Tileset Graphics - Terminator vram2", ROMX

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
TilesetSnowtopMountainGFX2::
TilesetHiddenGrottoGFX2::
	db $ff ; Compressed data is terminated with $ff.
