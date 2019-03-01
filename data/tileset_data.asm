INCLUDE "constants.asm"

tilecoll: MACRO
	db COLL_\1, COLL_\2, COLL_\3, COLL_\4
ENDM


SECTION "Tileset Data - johto_traditional", ROMX

Tileset00GFX::
TilesetJohto1GFX::
INCBIN "gfx/tilesets/johto_traditional.2bpp.lz"

Tileset00Meta::
TilesetJohto1Meta::
INCBIN "data/tilesets/johto_traditional_metatiles.bin"

Tileset00Attr::
TilesetJohto1Attr::
INCBIN "data/tilesets/johto_traditional_attributes.bin"

Tileset00Coll::
TilesetJohto1Coll::
INCLUDE "data/tilesets/johto_traditional_collision.asm"


SECTION "Tileset Data - johto_modern", ROMX

TilesetJohto2GFX::
INCBIN "gfx/tilesets/johto_modern.2bpp.lz"

TilesetJohto2Meta::
INCBIN "data/tilesets/johto_modern_metatiles.bin"

TilesetJohto2Attr::
INCBIN "data/tilesets/johto_modern_attributes.bin"

TilesetJohto2Coll::
INCLUDE "data/tilesets/johto_modern_collision.asm"


SECTION "Tileset Data - battle_tower_outside", ROMX

TilesetJohto3GFX::
INCBIN "gfx/tilesets/battle_tower_outside.2bpp.lz"

TilesetJohto3Meta::
INCBIN "data/tilesets/battle_tower_outside_metatiles.bin"

TilesetJohto3Attr::
INCBIN "data/tilesets/battle_tower_outside_attributes.bin"

TilesetJohto3Coll::
INCLUDE "data/tilesets/battle_tower_outside_collision.asm"


SECTION "Tileset Data - johto_overcast", ROMX

TilesetJohto4GFX::
INCBIN "gfx/tilesets/johto_overcast.2bpp.lz"

TilesetJohto4Meta::
INCBIN "data/tilesets/johto_overcast_metatiles.bin"

TilesetJohto4Attr::
INCBIN "data/tilesets/johto_overcast_attributes.bin"

TilesetJohto4Coll::
INCLUDE "data/tilesets/johto_overcast_collision.asm"


SECTION "Tileset Data - kanto", ROMX

TilesetKanto1GFX::
INCBIN "gfx/tilesets/kanto.2bpp.lz"

TilesetKanto1Meta::
INCBIN "data/tilesets/kanto_metatiles.bin"

TilesetKanto1Attr::
INCBIN "data/tilesets/kanto_attributes.bin"

TilesetKanto1Coll::
INCLUDE "data/tilesets/kanto_collision.asm"


SECTION "Tileset Data - indigo_plateau", ROMX

TilesetKanto2GFX::
INCBIN "gfx/tilesets/indigo_plateau.2bpp.lz"

TilesetKanto2Meta::
INCBIN "data/tilesets/indigo_plateau_metatiles.bin"

TilesetKanto2Attr::
INCBIN "data/tilesets/indigo_plateau_attributes.bin"

TilesetKanto2Coll::
INCLUDE "data/tilesets/indigo_plateau_collision.asm"


SECTION "Tileset Data - shamouti_island", ROMX

TilesetShamoutiGFX::
INCBIN "gfx/tilesets/shamouti_island.2bpp.lz"

TilesetShamoutiMeta::
INCBIN "data/tilesets/shamouti_island_metatiles.bin"

TilesetShamoutiAttr::
INCBIN "data/tilesets/shamouti_island_attributes.bin"

TilesetShamoutiColl::
INCLUDE "data/tilesets/shamouti_island_collision.asm"


SECTION "Tileset Data - valencia_island", ROMX

TilesetValenciaGFX::
INCBIN "gfx/tilesets/valencia_island.2bpp.lz"

TilesetValenciaMeta::
INCBIN "data/tilesets/valencia_island_metatiles.bin"

TilesetValenciaAttr::
INCBIN "data/tilesets/valencia_island_attributes.bin"

TilesetValenciaColl::
INCLUDE "data/tilesets/valencia_island_collision.asm"


SECTION "Tileset Data - faraway_island", ROMX

TilesetFarawayGFX::
INCBIN "gfx/tilesets/faraway_island.2bpp.lz"

TilesetFarawayMeta::
INCBIN "data/tilesets/faraway_island_metatiles.bin"

TilesetFarawayAttr::
INCBIN "data/tilesets/faraway_island_attributes.bin"

TilesetFarawayColl::
INCLUDE "data/tilesets/faraway_island_collision.asm"


SECTION "Tileset Data - johto_house", ROMX

TilesetHouse1GFX::
INCBIN "gfx/tilesets/johto_house.2bpp.lz"

TilesetHouse1Meta::
INCBIN "data/tilesets/johto_house_metatiles.bin"

TilesetHouse1Attr::
INCBIN "data/tilesets/johto_house_attributes.bin"

TilesetHouse1Coll::
INCLUDE "data/tilesets/johto_house_collision.asm"


SECTION "Tileset Data - kanto_house", ROMX

TilesetHouse2GFX::
INCBIN "gfx/tilesets/kanto_house.2bpp.lz"

TilesetHouse2Meta::
INCBIN "data/tilesets/kanto_house_metatiles.bin"

TilesetHouse2Attr::
INCBIN "data/tilesets/kanto_house_attributes.bin"

TilesetHouse2Coll::
INCLUDE "data/tilesets/kanto_house_collision.asm"


SECTION "Tileset Data - traditional_house", ROMX

TilesetHouse3GFX::
INCBIN "gfx/tilesets/traditional_house.2bpp.lz"

TilesetHouse3Meta::
INCBIN "data/tilesets/traditional_house_metatiles.bin"

TilesetHouse3Attr::
INCBIN "data/tilesets/traditional_house_attributes.bin"

TilesetHouse3Coll::
INCLUDE "data/tilesets/traditional_house_collision.asm"


SECTION "Tileset Data - pokecenter", ROMX

TilesetPokeCenterGFX::
INCBIN "gfx/tilesets/pokecenter.2bpp.lz"

TilesetPokeCenterMeta::
INCBIN "data/tilesets/pokecenter_metatiles.bin"

TilesetPokeCenterAttr::
INCBIN "data/tilesets/pokecenter_attributes.bin"

TilesetPokeCenterColl::
INCLUDE "data/tilesets/pokecenter_collision.asm"


SECTION "Tileset Data - pokecom_center", ROMX

TilesetPokeComGFX::
INCBIN "gfx/tilesets/pokecom_center.2bpp.lz"

TilesetPokeComMeta::
INCBIN "data/tilesets/pokecom_center_metatiles.bin"

TilesetPokeComAttr::
INCBIN "data/tilesets/pokecom_center_attributes.bin"

TilesetPokeComColl::
INCLUDE "data/tilesets/pokecom_center_collision.asm"


SECTION "Tileset Data - mart", ROMX

TilesetMartGFX::
INCBIN "gfx/tilesets/mart.2bpp.lz"

TilesetMartMeta::
INCBIN "data/tilesets/mart_metatiles.bin"

TilesetMartAttr::
INCBIN "data/tilesets/mart_attributes.bin"

TilesetMartColl::
INCLUDE "data/tilesets/mart_collision.asm"


SECTION "Tileset Data - gate", ROMX

TilesetGateGFX::
INCBIN "gfx/tilesets/gate.2bpp.lz"

TilesetGateMeta::
INCBIN "data/tilesets/gate_metatiles.bin"

TilesetGateAttr::
INCBIN "data/tilesets/gate_attributes.bin"

TilesetGateColl::
INCLUDE "data/tilesets/gate_collision.asm"


SECTION "Tileset Data - gym", ROMX

TilesetGym1GFX::
INCBIN "gfx/tilesets/gym.2bpp.lz"

TilesetGym1Meta::
INCBIN "data/tilesets/gym_metatiles.bin"

TilesetGym1Attr::
INCBIN "data/tilesets/gym_attributes.bin"

TilesetGym1Coll::
INCLUDE "data/tilesets/gym_collision.asm"


SECTION "Tileset Data - magnet_train", ROMX

TilesetGym2GFX::
INCBIN "gfx/tilesets/magnet_train.2bpp.lz"

TilesetGym2Meta::
INCBIN "data/tilesets/magnet_train_metatiles.bin"

TilesetGym2Attr::
INCBIN "data/tilesets/magnet_train_attributes.bin"

TilesetGym2Coll::
INCLUDE "data/tilesets/magnet_train_collision.asm"


SECTION "Tileset Data - champions_room", ROMX

TilesetGym3GFX::
INCBIN "gfx/tilesets/champions_room.2bpp.lz"

TilesetGym3Meta::
INCBIN "data/tilesets/champions_room_metatiles.bin"

TilesetGym3Attr::
INCBIN "data/tilesets/champions_room_attributes.bin"

TilesetGym3Coll::
INCLUDE "data/tilesets/champions_room_collision.asm"


SECTION "Tileset Data - port", ROMX

TilesetPortGFX::
INCBIN "gfx/tilesets/port.2bpp.lz"

TilesetPortMeta::
INCBIN "data/tilesets/port_metatiles.bin"

TilesetPortAttr::
INCBIN "data/tilesets/port_attributes.bin"

TilesetPortColl::
INCLUDE "data/tilesets/port_collision.asm"


SECTION "Tileset Data - lab", ROMX

TilesetLabGFX::
INCBIN "gfx/tilesets/lab.2bpp.lz"

TilesetLabMeta::
INCBIN "data/tilesets/lab_metatiles.bin"

TilesetLabAttr::
INCBIN "data/tilesets/lab_attributes.bin"

TilesetLabColl::
INCLUDE "data/tilesets/lab_collision.asm"


SECTION "Tileset Data - facility", ROMX

TilesetFacilityGFX::
INCBIN "gfx/tilesets/facility.2bpp.lz"

TilesetFacilityMeta::
INCBIN "data/tilesets/facility_metatiles.bin"

TilesetFacilityAttr::
INCBIN "data/tilesets/facility_attributes.bin"

TilesetFacilityColl::
INCLUDE "data/tilesets/facility_collision.asm"


SECTION "Tileset Data - celadon_mansion", ROMX

TilesetMansionGFX::
INCBIN "gfx/tilesets/celadon_mansion.2bpp.lz"

TilesetMansionMeta::
INCBIN "data/tilesets/celadon_mansion_metatiles.bin"

TilesetMansionAttr::
INCBIN "data/tilesets/celadon_mansion_attributes.bin"

TilesetMansionColl::
INCLUDE "data/tilesets/celadon_mansion_collision.asm"


SECTION "Tileset Data - game_corner", ROMX

TilesetGameCornerGFX::
INCBIN "gfx/tilesets/game_corner.2bpp.lz"

TilesetGameCornerMeta::
INCBIN "data/tilesets/game_corner_metatiles.bin"

TilesetGameCornerAttr::
INCBIN "data/tilesets/game_corner_attributes.bin"

TilesetGameCornerColl::
INCLUDE "data/tilesets/game_corner_collision.asm"


SECTION "Tileset Data - home_decor_store", ROMX

TilesetDecorGFX::
INCBIN "gfx/tilesets/home_decor_store.2bpp.lz"

TilesetDecorMeta::
INCBIN "data/tilesets/home_decor_store_metatiles.bin"

TilesetDecorAttr::
INCBIN "data/tilesets/home_decor_store_attributes.bin"

TilesetDecorColl::
INCLUDE "data/tilesets/home_decor_store_collision.asm"


SECTION "Tileset Data - museum", ROMX

TilesetMuseumGFX::
INCBIN "gfx/tilesets/museum.2bpp.lz"

TilesetMuseumMeta::
INCBIN "data/tilesets/museum_metatiles.bin"

TilesetMuseumAttr::
INCBIN "data/tilesets/museum_attributes.bin"

TilesetMuseumColl::
INCLUDE "data/tilesets/museum_collision.asm"


SECTION "Tileset Data - hotel", ROMX

TilesetHotelGFX::
INCBIN "gfx/tilesets/hotel.2bpp.lz"

TilesetHotelMeta::
INCBIN "data/tilesets/hotel_metatiles.bin"

TilesetHotelAttr::
INCBIN "data/tilesets/hotel_attributes.bin"

TilesetHotelColl::
INCLUDE "data/tilesets/hotel_collision.asm"


SECTION "Tileset Data - sprout_tower", ROMX

TilesetTowerGFX::
INCBIN "gfx/tilesets/sprout_tower.2bpp.lz"

TilesetTowerMeta::
INCBIN "data/tilesets/sprout_tower_metatiles.bin"

TilesetTowerAttr::
INCBIN "data/tilesets/sprout_tower_attributes.bin"

TilesetTowerColl::
INCLUDE "data/tilesets/sprout_tower_collision.asm"


SECTION "Tileset Data - battle_tower_inside", ROMX

TilesetBattleTowerGFX::
INCBIN "gfx/tilesets/battle_tower_inside.2bpp.lz"

TilesetBattleTowerMeta::
INCBIN "data/tilesets/battle_tower_inside_metatiles.bin"

TilesetBattleTowerAttr::
INCBIN "data/tilesets/battle_tower_inside_attributes.bin"

TilesetBattleTowerColl::
INCLUDE "data/tilesets/battle_tower_inside_collision.asm"


SECTION "Tileset Data - radio_tower", ROMX

TilesetRadioTowerGFX::
INCBIN "gfx/tilesets/radio_tower.2bpp.lz"

TilesetRadioTowerMeta::
INCBIN "data/tilesets/radio_tower_metatiles.bin"

TilesetRadioTowerAttr::
INCBIN "data/tilesets/radio_tower_attributes.bin"

TilesetRadioTowerColl::
INCLUDE "data/tilesets/radio_tower_collision.asm"


SECTION "Tileset Data - lighthouse", ROMX

TilesetLighthouseGFX::
INCBIN "gfx/tilesets/lighthouse.2bpp.lz"

TilesetLighthouseMeta::
INCBIN "data/tilesets/lighthouse_metatiles.bin"

TilesetLighthouseAttr::
INCBIN "data/tilesets/lighthouse_attributes.bin"

TilesetLighthouseColl::
INCLUDE "data/tilesets/lighthouse_collision.asm"


SECTION "Tileset Data - underground", ROMX

TilesetWarehouseGFX::
INCBIN "gfx/tilesets/underground.2bpp.lz"

TilesetWarehouseMeta::
INCBIN "data/tilesets/underground_metatiles.bin"

TilesetWarehouseAttr::
INCBIN "data/tilesets/underground_attributes.bin"

TilesetWarehouseColl::
INCLUDE "data/tilesets/underground_collision.asm"


SECTION "Tileset Data - cave", ROMX

TilesetCaveGFX::
INCBIN "gfx/tilesets/cave.2bpp.lz"

TilesetQuietCaveGFX::
INCBIN "gfx/tilesets/quiet_cave.2bpp.lz"

TilesetCaveMeta::
TilesetQuietCaveMeta::
INCBIN "data/tilesets/cave_metatiles.bin"

TilesetCaveAttr::
TilesetQuietCaveAttr::
INCBIN "data/tilesets/cave_attributes.bin"

TilesetCaveColl::
TilesetQuietCaveColl::
INCLUDE "data/tilesets/cave_collision.asm"


SECTION "Tileset Data - ice_path", ROMX

TilesetIcePathGFX::
INCBIN "gfx/tilesets/ice_path.2bpp.lz"

TilesetIcePathMeta::
INCBIN "data/tilesets/ice_path_metatiles.bin"

TilesetIcePathAttr::
INCBIN "data/tilesets/ice_path_attributes.bin"

TilesetIcePathColl::
INCLUDE "data/tilesets/ice_path_collision.asm"


SECTION "Tileset Data - tunnel", ROMX

TilesetTunnelGFX::
INCBIN "gfx/tilesets/tunnel.2bpp.lz"

TilesetTunnelMeta::
INCBIN "data/tilesets/tunnel_metatiles.bin"

TilesetTunnelAttr::
INCBIN "data/tilesets/tunnel_attributes.bin"

TilesetTunnelColl::
INCLUDE "data/tilesets/tunnel_collision.asm"


SECTION "Tileset Data - forest", ROMX

TilesetForestGFX::
INCBIN "gfx/tilesets/forest.2bpp.lz"

TilesetForestMeta::
INCBIN "data/tilesets/forest_metatiles.bin"

TilesetForestAttr::
INCBIN "data/tilesets/forest_attributes.bin"

TilesetForestColl::
INCLUDE "data/tilesets/forest_collision.asm"


SECTION "Tileset Data - park", ROMX

TilesetParkGFX::
INCBIN "gfx/tilesets/park.2bpp.lz"

TilesetParkMeta::
INCBIN "data/tilesets/park_metatiles.bin"

TilesetParkAttr::
INCBIN "data/tilesets/park_attributes.bin"

TilesetParkColl::
INCLUDE "data/tilesets/park_collision.asm"


SECTION "Tileset Data - safari_zone", ROMX

TilesetSafariGFX::
INCBIN "gfx/tilesets/safari_zone.2bpp.lz"

TilesetSafariMeta::
INCBIN "data/tilesets/safari_zone_metatiles.bin"

TilesetSafariAttr::
INCBIN "data/tilesets/safari_zone_attributes.bin"

TilesetSafariColl::
INCLUDE "data/tilesets/safari_zone_collision.asm"


SECTION "Tileset Data - ruins_of_alph", ROMX

TilesetRuinsGFX::
TilesetAlphGFX::
INCBIN "gfx/tilesets/ruins_of_alph.2bpp.lz"

TilesetRuinsMeta::
INCBIN "data/tilesets/ruins_of_alph_metatiles.bin"

TilesetRuinsAttr::
INCBIN "data/tilesets/ruins_of_alph_attributes.bin"

TilesetRuinsColl::
INCLUDE "data/tilesets/ruins_of_alph_collision.asm"


SECTION "Tileset Data - alph_word_room", ROMX

TilesetAlphMeta::
INCBIN "data/tilesets/alph_word_room_metatiles.bin"

TilesetAlphAttr::
INCBIN "data/tilesets/alph_word_room_attributes.bin"

TilesetAlphColl::
INCLUDE "data/tilesets/alph_word_room_collision.asm"


SECTION "Tileset Data - pokemon_mansion", ROMX

TilesetPokemonMansionGFX::
INCBIN "gfx/tilesets/pokemon_mansion.2bpp.lz"

TilesetPokemonMansionMeta::
INCBIN "data/tilesets/pokemon_mansion_metatiles.bin"

TilesetPokemonMansionAttr::
INCBIN "data/tilesets/pokemon_mansion_attributes.bin"

TilesetPokemonMansionColl::
INCLUDE "data/tilesets/pokemon_mansion_collision.asm"
