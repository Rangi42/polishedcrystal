SECTION "Tileset Headers", ROMX

MACRO tileset
	dbas \1Meta, \1Coll, \1Attr
	dba \1GFX0, \1GFX1, \1GFX2
	dw \1Anim ; BANK(_AnimateTileset)
ENDM

Tilesets::
; entries correspond to TILESET_* constants (see constants/tileset_constants.asm)
	table_width TILESET_LENGTH
	tileset TilesetJohtoTraditional
	tileset TilesetJohtoModern
	tileset TilesetJohtoOutlands
	tileset TilesetJohtoAncient
	tileset TilesetBattleTowerOutside
	tileset TilesetEcruteakShrine
	tileset TilesetKanto
	tileset TilesetIndigoPlateau
	tileset TilesetShamoutiIsland
	tileset TilesetValenciaIsland
	tileset TilesetFarawayIsland
	tileset TilesetJohtoHouse
	tileset TilesetKantoHouse
	tileset TilesetTraditionalHouse
	tileset TilesetPokeCenter
	tileset TilesetPokeComCenter
	tileset TilesetMart
	tileset TilesetGate
	tileset TilesetGym
	tileset TilesetMagnetTrain
	tileset TilesetChampionsRoom
	tileset TilesetPort
	tileset TilesetLab
	tileset TilesetFacility
	tileset TilesetMansion
	tileset TilesetGameCorner
	tileset TilesetDecor
	tileset TilesetMuseum
	tileset TilesetHotel
	tileset TilesetTower
	tileset TilesetBattleTowerInside
	tileset TilesetRadioTower
	tileset TilesetLighthouse
	tileset TilesetUnderground
	tileset TilesetCave
	tileset TilesetQuietCave
	tileset TilesetIcePath
	tileset TilesetTunnel
	tileset TilesetForest
	tileset TilesetPark
	tileset TilesetSafariZone
	tileset TilesetRuinsOfAlph
	tileset TilesetPokemonMansion
	tileset TilesetBattleFactory
	tileset TilesetSnowtopMountain
	tileset TilesetHiddenGrotto
	tileset TilesetPeaks
	assert_table_length NUM_TILESETS


SECTION "Tileset Graphics - johto common vram0", ROMX

TilesetJohtoTraditionalGFX0::
TilesetJohtoModernGFX0::
TilesetJohtoOutlandsGFX0::
TilesetJohtoAncientGFX0::
TilesetBattleTowerOutsideGFX0::
TilesetEcruteakShrineGFX0:: INCBIN "gfx/tilesets/johto_common.2bpp.lzp"


SECTION "Tileset Graphics - johto traditional vram1", ROMX

TilesetJohtoTraditionalGFX1::
TilesetEcruteakShrineGFX1:: INCBIN "gfx/tilesets/johto_traditional.johto_common.2bpp.vram0.lzp"


SECTION "Tileset Graphics - johto traditional vram2", ROMX

TilesetJohtoTraditionalGFX2::
TilesetEcruteakShrineGFX2:: INCBIN "gfx/tilesets/johto_traditional.johto_common.2bpp.vram1.lzp"


SECTION "Tileset Data - johto traditional", ROMX

TilesetJohtoTraditionalMeta:: INCBIN "data/tilesets/johto_traditional_metatiles.bin.lzp"
TilesetJohtoTraditionalAttr:: INCBIN "data/tilesets/johto_traditional_attributes.bin.lzp"
TilesetJohtoTraditionalColl:: INCBIN "data/tilesets/johto_traditional_collision.bin.lzp"


SECTION "Tileset Graphics - johto modern vram1", ROMX

TilesetJohtoModernGFX1:: INCBIN "gfx/tilesets/johto_modern.johto_common.2bpp.vram0.lzp"


SECTION "Tileset Graphics - johto modern vram2", ROMX

TilesetJohtoModernGFX2:: INCBIN "gfx/tilesets/johto_modern.johto_common.2bpp.vram1.lzp"


SECTION "Tileset Data - johto modern", ROMX

TilesetJohtoModernMeta:: INCBIN "data/tilesets/johto_modern_metatiles.bin.lzp"
TilesetJohtoModernAttr:: INCBIN "data/tilesets/johto_modern_attributes.bin.lzp"
TilesetJohtoModernColl:: INCBIN "data/tilesets/johto_modern_collision.bin.lzp"


SECTION "Tileset Graphics - johto outlands vram1", ROMX

TilesetJohtoOutlandsGFX1:: INCBIN "gfx/tilesets/johto_outlands.johto_common.2bpp.vram0.lzp"


SECTION "Tileset Data - johto outlands", ROMX

TilesetJohtoOutlandsMeta:: INCBIN "data/tilesets/johto_outlands_metatiles.bin.lzp"
TilesetJohtoOutlandsAttr:: INCBIN "data/tilesets/johto_outlands_attributes.bin.lzp"
TilesetJohtoOutlandsColl:: INCBIN "data/tilesets/johto_outlands_collision.bin.lzp"


SECTION "Tileset Graphics - johto ancient vram1", ROMX

TilesetJohtoAncientGFX1:: INCBIN "gfx/tilesets/johto_ancient.johto_common.2bpp.vram0.lzp"


SECTION "Tileset Data - johto ancient", ROMX

TilesetJohtoAncientMeta:: INCBIN "data/tilesets/johto_ancient_metatiles.bin.lzp"
TilesetJohtoAncientAttr:: INCBIN "data/tilesets/johto_ancient_attributes.bin.lzp"
TilesetJohtoAncientColl:: INCBIN "data/tilesets/johto_ancient_collision.bin.lzp"


SECTION "Tileset Graphics - battle tower outside vram1", ROMX

TilesetBattleTowerOutsideGFX1:: INCBIN "gfx/tilesets/battle_tower_outside.johto_common.2bpp.lzp"


SECTION "Tileset Data - battle tower outside", ROMX

TilesetBattleTowerOutsideMeta:: INCBIN "data/tilesets/battle_tower_outside_metatiles.bin.lzp"
TilesetBattleTowerOutsideAttr:: INCBIN "data/tilesets/battle_tower_outside_attributes.bin.lzp"
TilesetBattleTowerOutsideColl:: INCBIN "data/tilesets/battle_tower_outside_collision.bin.lzp"


SECTION "Tileset Data - ecruteak shrine", ROMX

TilesetEcruteakShrineMeta:: INCBIN "data/tilesets/ecruteak_shrine_metatiles.bin.lzp"
TilesetEcruteakShrineAttr:: INCBIN "data/tilesets/ecruteak_shrine_attributes.bin.lzp"
TilesetEcruteakShrineColl:: INCBIN "data/tilesets/ecruteak_shrine_collision.bin.lzp"


SECTION "Tileset Graphics - kanto common vram0", ROMX

TilesetKantoGFX0::
TilesetIndigoPlateauGFX0:: INCBIN "gfx/tilesets/kanto_common.2bpp.lzp"


SECTION "Tileset Graphics - kanto vram1", ROMX

TilesetKantoGFX1:: INCBIN "gfx/tilesets/kanto.kanto_common.2bpp.lzp"


SECTION "Tileset Data - kanto", ROMX

TilesetKantoMeta:: INCBIN "data/tilesets/kanto_metatiles.bin.lzp"
TilesetKantoAttr:: INCBIN "data/tilesets/kanto_attributes.bin.lzp"
TilesetKantoColl:: INCBIN "data/tilesets/kanto_collision.bin.lzp"


SECTION "Tileset Graphics - indigo plateau vram1", ROMX

TilesetIndigoPlateauGFX1:: INCBIN "gfx/tilesets/indigo_plateau.kanto_common.2bpp.lzp"


SECTION "Tileset Data - indigo plateau", ROMX

TilesetIndigoPlateauMeta:: INCBIN "data/tilesets/indigo_plateau_metatiles.bin.lzp"
TilesetIndigoPlateauAttr:: INCBIN "data/tilesets/indigo_plateau_attributes.bin.lzp"
TilesetIndigoPlateauColl:: INCBIN "data/tilesets/indigo_plateau_collision.bin.lzp"


SECTION "Tileset Graphics - shamouti island vram0", ROMX

TilesetShamoutiIslandGFX0:: INCBIN "gfx/tilesets/shamouti_island.2bpp.vram0.lzp"


SECTION "Tileset Graphics - shamouti island vram1", ROMX

TilesetShamoutiIslandGFX1:: INCBIN "gfx/tilesets/shamouti_island.2bpp.vram1.lzp"


SECTION "Tileset Data - shamouti island", ROMX

TilesetShamoutiIslandMeta:: INCBIN "data/tilesets/shamouti_island_metatiles.bin.lzp"
TilesetShamoutiIslandAttr:: INCBIN "data/tilesets/shamouti_island_attributes.bin.lzp"
TilesetShamoutiIslandColl:: INCBIN "data/tilesets/shamouti_island_collision.bin.lzp"


SECTION "Tileset Graphics - valencia island vram0", ROMX

TilesetValenciaIslandGFX0:: INCBIN "gfx/tilesets/valencia_island.2bpp.vram0.lzp"


SECTION "Tileset Graphics - valencia island vram1", ROMX

TilesetValenciaIslandGFX1:: INCBIN "gfx/tilesets/valencia_island.2bpp.vram1.lzp"


SECTION "Tileset Data - valencia island", ROMX

TilesetValenciaIslandMeta:: INCBIN "data/tilesets/valencia_island_metatiles.bin.lzp"
TilesetValenciaIslandAttr:: INCBIN "data/tilesets/valencia_island_attributes.bin.lzp"
TilesetValenciaIslandColl:: INCBIN "data/tilesets/valencia_island_collision.bin.lzp"


SECTION "Tileset Graphics - faraway island vram0", ROMX

TilesetFarawayIslandGFX0:: INCBIN "gfx/tilesets/faraway_island.2bpp.vram0.lzp"


SECTION "Tileset Graphics - faraway island vram1", ROMX

TilesetFarawayIslandGFX1:: INCBIN "gfx/tilesets/faraway_island.2bpp.vram1.lzp"


SECTION "Tileset Data - faraway island", ROMX

TilesetFarawayIslandMeta:: INCBIN "data/tilesets/faraway_island_metatiles.bin.lzp"
TilesetFarawayIslandAttr:: INCBIN "data/tilesets/faraway_island_attributes.bin.lzp"
TilesetFarawayIslandColl:: INCBIN "data/tilesets/faraway_island_collision.bin.lzp"


SECTION "Tileset Graphics - johto house vram0", ROMX

TilesetJohtoHouseGFX0:: INCBIN "gfx/tilesets/johto_house.2bpp.vram0.lzp"


SECTION "Tileset Graphics - johto house vram1", ROMX

TilesetJohtoHouseGFX1:: INCBIN "gfx/tilesets/johto_house.2bpp.vram1.lzp"


SECTION "Tileset Data - johto house", ROMX

TilesetJohtoHouseMeta:: INCBIN "data/tilesets/johto_house_metatiles.bin.lzp"
TilesetJohtoHouseAttr:: INCBIN "data/tilesets/johto_house_attributes.bin.lzp"
TilesetJohtoHouseColl:: INCBIN "data/tilesets/johto_house_collision.bin.lzp"


SECTION "Tileset Graphics - kanto house vram0", ROMX

TilesetKantoHouseGFX0:: INCBIN "gfx/tilesets/kanto_house.2bpp.vram0.lzp"


SECTION "Tileset Graphics - kanto house vram1", ROMX

TilesetKantoHouseGFX1:: INCBIN "gfx/tilesets/kanto_house.2bpp.vram1.lzp"


SECTION "Tileset Data - kanto house", ROMX

TilesetKantoHouseMeta:: INCBIN "data/tilesets/kanto_house_metatiles.bin.lzp"
TilesetKantoHouseAttr:: INCBIN "data/tilesets/kanto_house_attributes.bin.lzp"
TilesetKantoHouseColl:: INCBIN "data/tilesets/kanto_house_collision.bin.lzp"


SECTION "Tileset Graphics - traditional house vram0", ROMX

TilesetTraditionalHouseGFX0:: INCBIN "gfx/tilesets/traditional_house.2bpp.vram0.lzp"


SECTION "Tileset Graphics - traditional house vram1", ROMX

TilesetTraditionalHouseGFX1:: INCBIN "gfx/tilesets/traditional_house.2bpp.vram1.lzp"


SECTION "Tileset Data - traditional house", ROMX

TilesetTraditionalHouseMeta:: INCBIN "data/tilesets/traditional_house_metatiles.bin.lzp"
TilesetTraditionalHouseAttr:: INCBIN "data/tilesets/traditional_house_attributes.bin.lzp"
TilesetTraditionalHouseColl:: INCBIN "data/tilesets/traditional_house_collision.bin.lzp"


SECTION "Tileset Graphics - pokecenter vram0", ROMX

TilesetPokeCenterGFX0:: INCBIN "gfx/tilesets/pokecenter.2bpp.vram0.lzp"


SECTION "Tileset Graphics - pokecenter vram1", ROMX

TilesetPokeCenterGFX1:: INCBIN "gfx/tilesets/pokecenter.2bpp.vram1.lzp"


SECTION "Tileset Data - pokecenter", ROMX

TilesetPokeCenterMeta:: INCBIN "data/tilesets/pokecenter_metatiles.bin.lzp"
TilesetPokeCenterAttr:: INCBIN "data/tilesets/pokecenter_attributes.bin.lzp"
TilesetPokeCenterColl:: INCBIN "data/tilesets/pokecenter_collision.bin.lzp"


SECTION "Tileset Graphics - pokecom center vram0", ROMX

TilesetPokeComCenterGFX0:: INCBIN "gfx/tilesets/pokecom_center.2bpp.vram0.lzp"


SECTION "Tileset Graphics - pokecom center vram1", ROMX

TilesetPokeComCenterGFX1:: INCBIN "gfx/tilesets/pokecom_center.2bpp.vram1.lzp"


SECTION "Tileset Data - pokecom center", ROMX

TilesetPokeComCenterMeta:: INCBIN "data/tilesets/pokecom_center_metatiles.bin.lzp"
TilesetPokeComCenterAttr:: INCBIN "data/tilesets/pokecom_center_attributes.bin.lzp"
TilesetPokeComCenterColl:: INCBIN "data/tilesets/pokecom_center_collision.bin.lzp"


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

TilesetGymGFX0:: INCBIN "gfx/tilesets/gym.2bpp.vram0.lzp"


SECTION "Tileset Graphics - gym vram1", ROMX

TilesetGymGFX1:: INCBIN "gfx/tilesets/gym.2bpp.vram1.lzp"


SECTION "Tileset Data - gym", ROMX

TilesetGymMeta:: INCBIN "data/tilesets/gym_metatiles.bin.lzp"
TilesetGymAttr:: INCBIN "data/tilesets/gym_attributes.bin.lzp"
TilesetGymColl:: INCBIN "data/tilesets/gym_collision.bin.lzp"


SECTION "Tileset Graphics - magnet train vram0", ROMX

TilesetMagnetTrainGFX0:: INCBIN "gfx/tilesets/magnet_train.2bpp.vram0.lzp"


SECTION "Tileset Graphics - magnet train vram1", ROMX

TilesetMagnetTrainGFX1:: INCBIN "gfx/tilesets/magnet_train.2bpp.vram1.lzp"


SECTION "Tileset Data - magnet train", ROMX

TilesetMagnetTrainMeta:: INCBIN "data/tilesets/magnet_train_metatiles.bin.lzp"
TilesetMagnetTrainAttr:: INCBIN "data/tilesets/magnet_train_attributes.bin.lzp"
TilesetMagnetTrainColl:: INCBIN "data/tilesets/magnet_train_collision.bin.lzp"


SECTION "Tileset Graphics - champions room vram0", ROMX

TilesetChampionsRoomGFX0:: INCBIN "gfx/tilesets/champions_room.2bpp.vram0.lzp"


SECTION "Tileset Graphics - champions room vram1", ROMX

TilesetChampionsRoomGFX1:: INCBIN "gfx/tilesets/champions_room.2bpp.vram1.lzp"


SECTION "Tileset Data - champions room", ROMX

TilesetChampionsRoomMeta:: INCBIN "data/tilesets/champions_room_metatiles.bin.lzp"
TilesetChampionsRoomAttr:: INCBIN "data/tilesets/champions_room_attributes.bin.lzp"
TilesetChampionsRoomColl:: INCBIN "data/tilesets/champions_room_collision.bin.lzp"


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

TilesetBattleTowerInsideGFX0:: INCBIN "gfx/tilesets/battle_tower_inside.2bpp.vram0.lzp"


SECTION "Tileset Graphics - battle tower inside vram1", ROMX

TilesetBattleTowerInsideGFX1:: INCBIN "gfx/tilesets/battle_tower_inside.2bpp.vram1.lzp"


SECTION "Tileset Data - battle tower inside", ROMX

TilesetBattleTowerInsideMeta:: INCBIN "data/tilesets/battle_tower_inside_metatiles.bin.lzp"
TilesetBattleTowerInsideAttr:: INCBIN "data/tilesets/battle_tower_inside_attributes.bin.lzp"
TilesetBattleTowerInsideColl:: INCBIN "data/tilesets/battle_tower_inside_collision.bin.lzp"


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

TilesetUndergroundGFX0:: INCBIN "gfx/tilesets/underground.2bpp.vram0.lzp"


SECTION "Tileset Graphics - underground vram1", ROMX

TilesetUndergroundGFX1:: INCBIN "gfx/tilesets/underground.2bpp.vram1.lzp"


SECTION "Tileset Data - underground", ROMX

TilesetUndergroundMeta:: INCBIN "data/tilesets/underground_metatiles.bin.lzp"
TilesetUndergroundAttr:: INCBIN "data/tilesets/underground_attributes.bin.lzp"
TilesetUndergroundColl:: INCBIN "data/tilesets/underground_collision.bin.lzp"


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

TilesetSafariZoneGFX0:: INCBIN "gfx/tilesets/safari_zone.2bpp.vram0.lzp"


SECTION "Tileset Graphics - safari zone vram1", ROMX

TilesetSafariZoneGFX1:: INCBIN "gfx/tilesets/safari_zone.2bpp.vram1.lzp"


SECTION "Tileset Data - safari zone", ROMX

TilesetSafariZoneMeta:: INCBIN "data/tilesets/safari_zone_metatiles.bin.lzp"
TilesetSafariZoneAttr:: INCBIN "data/tilesets/safari_zone_attributes.bin.lzp"
TilesetSafariZoneColl:: INCBIN "data/tilesets/safari_zone_collision.bin.lzp"


SECTION "Tileset Graphics - ruins of alph vram0", ROMX

TilesetRuinsOfAlphGFX0:: INCBIN "gfx/tilesets/ruins_of_alph.2bpp.vram0.lzp"


SECTION "Tileset Graphics - ruins of alph vram1", ROMX

TilesetRuinsOfAlphGFX1:: INCBIN "gfx/tilesets/ruins_of_alph.2bpp.vram1.lzp"


SECTION "Tileset Data - ruins of alph", ROMX

TilesetRuinsOfAlphMeta:: INCBIN "data/tilesets/ruins_of_alph_metatiles.bin.lzp"
TilesetRuinsOfAlphAttr:: INCBIN "data/tilesets/ruins_of_alph_attributes.bin.lzp"
TilesetRuinsOfAlphColl:: INCBIN "data/tilesets/ruins_of_alph_collision.bin.lzp"


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


SECTION "Tileset Graphics - peaks vram0", ROMX

TilesetPeaksGFX0:: INCBIN "gfx/tilesets/peaks.2bpp.vram0.lzp"


SECTION "Tileset Graphics - peaks vram1", ROMX

TilesetPeaksGFX1:: INCBIN "gfx/tilesets/peaks.2bpp.vram1.lzp"


SECTION "Tileset Data - peaks", ROMX

TilesetPeaksMeta:: INCBIN "data/tilesets/peaks_metatiles.bin.lzp"
TilesetPeaksAttr:: INCBIN "data/tilesets/peaks_attributes.bin.lzp"
TilesetPeaksColl:: INCBIN "data/tilesets/peaks_collision.bin.lzp"


SECTION "Tileset Graphics - Terminator vram2", ROMX

TilesetJohtoOutlandsGFX2::
TilesetJohtoAncientGFX2::
TilesetBattleTowerOutsideGFX2::
TilesetKantoGFX2::
TilesetIndigoPlateauGFX2::
TilesetShamoutiIslandGFX2::
TilesetValenciaIslandGFX2::
TilesetFarawayIslandGFX2::
TilesetJohtoHouseGFX2::
TilesetKantoHouseGFX2::
TilesetTraditionalHouseGFX2::
TilesetPokeCenterGFX2::
TilesetPokeComCenterGFX2::
TilesetMartGFX2::
TilesetGateGFX2::
TilesetGymGFX2::
TilesetMagnetTrainGFX2::
TilesetChampionsRoomGFX2::
TilesetPortGFX2::
TilesetLabGFX2::
TilesetFacilityGFX2::
TilesetMansionGFX2::
TilesetGameCornerGFX2::
TilesetDecorGFX2::
TilesetMuseumGFX2::
TilesetHotelGFX2::
TilesetTowerGFX2::
TilesetBattleTowerInsideGFX2::
TilesetRadioTowerGFX2::
TilesetLighthouseGFX2::
TilesetUndergroundGFX2::
TilesetCaveGFX2::
TilesetQuietCaveGFX2::
TilesetIcePathGFX2::
TilesetTunnelGFX2::
TilesetForestGFX2::
TilesetParkGFX2::
TilesetSafariZoneGFX2::
TilesetRuinsOfAlphGFX2::
TilesetPokemonMansionGFX2::
TilesetBattleFactoryGFX2::
TilesetSnowtopMountainGFX2::
TilesetHiddenGrottoGFX2::
TilesetPeaksGFX2::
	db $ff ; Compressed data is terminated with $ff.
