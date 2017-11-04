LoadBlindingFlashPalette:: ; 49409
	ld a, $5
	ld de, UnknBGPals palette PAL_BG_TEXT
	ld hl, BlindingFlashPalette
	ld bc, 1 palettes
	jp FarCopyWRAM
; 49418

BlindingFlashPalette: ; 49418
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 08, 19, 28
	RGB 05, 05, 16
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc
; 49420

LoadSpecialMapPalette: ; 494ac
	GLOBAL GenericMart_BlockData
	call GetMapHeaderTimeOfDayNybble
	cp PALETTE_DARK
	jr nz, .not_dark
	ld a, [StatusFlags]
	bit 2, a ; Flash
	jp z, .do_nothing
.not_dark

	ld a, [wTileset]

	ld hl, PokeComPalette
	cp TILESET_POKECOM_CENTER
	jp z, .load_eight_bg_palettes
	ld hl, BattleTowerPalette
	cp TILESET_BATTLE_TOWER_INSIDE
	jp z, .load_eight_bg_palettes
	ld hl, GatePalette
	cp TILESET_GATE
	jp z, .load_eight_bg_palettes
	ld hl, HotelPalette
	cp TILESET_HOTEL
	jp z, .load_eight_bg_palettes
	ld hl, QuietCavePalette
	cp TILESET_QUIET_CAVE
	jp z, .load_eight_bg_palettes
	ld hl, RuinsPalette
	cp TILESET_RUINS_OF_ALPH
	jp z, .load_eight_bg_palettes
	cp TILESET_ALPH_WORD_ROOM
	jp z, .load_eight_bg_palettes

	ld hl, SafariZonePalette
	cp TILESET_SAFARI_ZONE
	jp z, .load_eight_time_of_day_bg_palettes
	ld hl, FarawayIslandPalette
	cp TILESET_FARAWAY_ISLAND
	jp z, .load_eight_time_of_day_bg_palettes
	ld hl, ShamoutiIslandPalette
	cp TILESET_SHAMOUTI_ISLAND
	jp z, .load_eight_time_of_day_bg_palettes
	ld hl, ValenciaIslandPalette
	cp TILESET_VALENCIA_ISLAND
	jp z, .load_eight_time_of_day_bg_palettes

	cp TILESET_POKECENTER
	jp z, .pokecenter
	cp TILESET_ICE_PATH
	jp z, .ice_path_or_hall_of_fame
	cp TILESET_RADIO_TOWER
	jp z, .radio_towers
	cp TILESET_GYM
	jp z, .maybe_elite_room
	cp TILESET_MAGNET_TRAIN
	jp z, .maybe_viridian_gym
	cp TILESET_CHAMPIONS_ROOM
	jp z, .maybe_lances_room
	cp TILESET_PORT
	jp z, .maybe_cerulean_gym
	cp TILESET_GAME_CORNER
	jp z, .maybe_saffron_gym
	cp TILESET_UNDERGROUND
	jp z, .maybe_fuchsia_gym
	cp TILESET_TRADITIONAL_HOUSE
	jp z, .maybe_charcoal_kiln
	cp TILESET_LAB
	jp z, .maybe_lab_or_dragon_shrine
	cp TILESET_TUNNEL
	jp z, .maybe_lightning_island_or_magnet_tunnel
	cp TILESET_SPROUT_TOWER
	jp z, .maybe_mystri_or_tower
	ld hl, CinnabarLabPalette
	cp TILESET_POKEMON_MANSION
	jp z, .maybe_cinnabar_lab
	cp TILESET_CELADON_MANSION
	jp z, .maybe_celadon_mansion_roof
	cp TILESET_MART
	jp z, .maybe_goldenrod_dept_store_roof
	cp TILESET_LIGHTHOUSE
	jp z, .maybe_olivine_lighthouse_roof
	cp TILESET_HOME_DECOR_STORE
	jp z, .maybe_celadon_home_decor_store_4f
	cp TILESET_JOHTO_TRADITIONAL
	jp z, .maybe_special_johto_1
	cp TILESET_FOREST
	jp z, .maybe_special_forest
	cp TILESET_CAVE
	jp z, .maybe_special_cave

	call GetOvercastIndex
	and a
	jp z, .maybe_sinjoh_ruins
	ld hl, OvercastBGPalette
	jp .load_eight_time_of_day_bg_palettes

.do_nothing
	and a
	ret
; 494f2

.pokecenter
	ld a, [MapGroup]
	cp GROUP_POKECENTER_2F
	jr nz, .ok
	ld a, [MapNumber]
	cp MAP_POKECENTER_2F
	jr nz, .ok
	ld a, [BackupMapGroup]
	cp GROUP_SHAMOUTI_POKECENTER_1F
	jr nz, .normal_pokecenter
	ld a, [BackupMapNumber]
	cp MAP_SHAMOUTI_POKECENTER_1F
	jr nz, .normal_pokecenter
	jr .shamouti_pokecenter
.ok
	ld a, [MapGroup]
	cp GROUP_SHAMOUTI_POKECENTER_1F
	jr nz, .normal_pokecenter
	ld a, [MapNumber]
	cp MAP_SHAMOUTI_POKECENTER_1F
	jr nz, .normal_pokecenter
.shamouti_pokecenter
	ld hl, ShamoutiPokeCenterPalette
	jp .load_eight_bg_palettes

.normal_pokecenter
	ld hl, PokeCenterPalette
.load_eight_bg_palettes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM

; replace green with Poké Mart blue for maps using Mart.blk
	ld a, [MapBlockDataBank]
	cp BANK(GenericMart_BlockData)
	jr nz, .not_mart
	ld a, [MapBlockDataPointer]
	cp GenericMart_BlockData % $100
	jr nz, .not_mart
	ld a, [MapBlockDataPointer + 1]
	cp GenericMart_BlockData / $100
	jr nz, .not_mart
	ld hl, MartBluePalette
	ld a, $5
	ld de, UnknBGPals palette PAL_BG_GREEN
	ld bc, 1 palettes
	call FarCopyWRAM
.not_mart

	scf
	ret

.ice_path_or_hall_of_fame
	ld hl, LancesRoomPalette
	ld a, [wPermission] ; permission
	and 7
	cp INDOOR ; Hall of Fame
	jp z, .load_eight_bg_palettes
	ld hl, IcePathPalette
	jp .load_eight_bg_palettes

.radio_towers
	ld hl, RadioTowerPalette
	ld a, [MapGroup]
	cp GROUP_RADIO_TOWER_1F
	jp z, .load_eight_bg_palettes
	ld hl, HauntedRadioTowerPalette
	ld a, [MapNumber]
	cp MAP_HAUNTED_RADIO_TOWER_2F
	jp z, .load_eight_bg_palettes
	cp MAP_HAUNTED_RADIO_TOWER_3F
	jp z, .load_eight_bg_palettes
	ld hl, HauntedPokemonTowerPalette
	cp MAP_HAUNTED_RADIO_TOWER_4F
	jp z, .load_eight_bg_palettes
	cp MAP_HAUNTED_RADIO_TOWER_5F
	jp z, .load_eight_bg_palettes
	cp MAP_HAUNTED_RADIO_TOWER_6F
	jp z, .load_eight_bg_palettes
	ld hl, RadioTowerPalette
	jp .load_eight_bg_palettes

.maybe_elite_room
	ld a, [MapGroup]
	cp GROUP_WILLS_ROOM ; same as GROUP_KOGAS_ROOM, GROUP_BRUNOS_ROOM, and GROUP_KARENS_ROOM
	jp nz, .do_nothing
	ld a, [MapNumber]
	ld hl, WillsRoomPalette
	cp MAP_WILLS_ROOM
	jp z, .load_eight_bg_palettes
	ld hl, KogasRoomPalette
	cp MAP_KOGAS_ROOM
	jp z, .load_eight_bg_palettes
	ld hl, BrunosRoomPalette
	cp MAP_BRUNOS_ROOM
	jp z, .load_eight_bg_palettes
	ld hl, KarensRoomPalette
	cp MAP_KARENS_ROOM
	jp z, .load_eight_bg_palettes
	jp .do_nothing

.maybe_lances_room
	ld a, [MapGroup]
	cp GROUP_LANCES_ROOM
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_LANCES_ROOM
	jp nz, .do_nothing
	ld hl, LancesRoomPalette
	jp .load_eight_bg_palettes

.maybe_cerulean_gym
	ld a, [MapGroup]
	cp GROUP_CERULEAN_GYM
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_CERULEAN_GYM
	jp nz, .do_nothing
	ld hl, CeruleanGymPalette
	jp .load_eight_bg_palettes

.maybe_saffron_gym
	ld hl, GameCornerPalette
	ld a, [MapGroup]
	cp GROUP_SAFFRON_GYM
	jp nz, .load_eight_bg_palettes
	ld a, [MapNumber]
	cp MAP_SAFFRON_GYM
	jp nz, .load_eight_bg_palettes
	ld hl, SaffronGymPalette
	jp .load_eight_bg_palettes

.maybe_fuchsia_gym
	ld a, [MapGroup]
	cp GROUP_FUCHSIA_GYM
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_FUCHSIA_GYM
	jp nz, .do_nothing
	ld hl, FuchsiaGymPalette
	jp .load_eight_bg_palettes

.maybe_charcoal_kiln
	ld a, [MapGroup]
	cp GROUP_CHARCOAL_KILN
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_CHARCOAL_KILN
	jp nz, .do_nothing
	ld hl, CharcoalKilnPalette
	jp .load_eight_bg_palettes

.maybe_lab_or_dragon_shrine
	ld a, [MapGroup]
	cp GROUP_OAKS_LAB
	jp nz, .not_oaks_lab
	ld a, [MapNumber]
	cp MAP_OAKS_LAB
	jp nz, .not_oaks_lab
	ld hl, OaksLabPalette
	jp .load_eight_bg_palettes

.not_oaks_lab
	ld a, [MapGroup]
	cp GROUP_IVYS_LAB
	jp nz, .not_ivys_lab
	ld a, [MapNumber]
	cp MAP_IVYS_LAB
	jp nz, .not_ivys_lab
	ld hl, IvysLabPalette
	jp .load_eight_bg_palettes

.not_ivys_lab
	ld a, [MapGroup]
	cp GROUP_DRAGON_SHRINE
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_DRAGON_SHRINE
	jp nz, .do_nothing
	ld hl, DragonShrinePalette
	jp .load_eight_bg_palettes

.maybe_lightning_island_or_magnet_tunnel
	ld a, [MapGroup]
	cp GROUP_LIGHTNING_ISLAND
	jr nz, .not_lightning_island
	ld a, [MapNumber]
	cp MAP_LIGHTNING_ISLAND
	jr nz, .not_lightning_island
	ld hl, LightningIslandPalette
	jp .load_eight_bg_palettes

.not_lightning_island
	ld a, [MapGroup]
	cp GROUP_MAGNET_TUNNEL_INSIDE
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_MAGNET_TUNNEL_INSIDE
	jp nz, .do_nothing
	ld hl, MagnetTunnelPalette
	jp .load_eight_bg_palettes

.maybe_viridian_gym
	ld a, [MapGroup]
	cp GROUP_VIRIDIAN_GYM
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_VIRIDIAN_GYM
	jp nz, .do_nothing
	ld hl, ViridianGymPalette
	jp .load_eight_bg_palettes

.maybe_mystri_or_tower
	ld a, [MapGroup]
	cp GROUP_MYSTRI_STAGE
	jr nz, .maybe_embedded_tower
	ld a, [MapNumber]
	cp MAP_MYSTRI_STAGE
	jr nz, .maybe_embedded_tower
	ld hl, MystriStagePalette
	jp .load_eight_bg_palettes

.maybe_embedded_tower
	ld a, [MapGroup]
	cp GROUP_EMBEDDED_TOWER
	jr nz, .maybe_tin_tower_roof
	ld a, [MapNumber]
	cp MAP_EMBEDDED_TOWER
	jr nz, .maybe_tin_tower_roof
	ld hl, EmbeddedTowerPalette
	jp .load_eight_bg_palettes

.maybe_tin_tower_roof
	ld a, [MapGroup]
	cp GROUP_TIN_TOWER_ROOF
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_TIN_TOWER_ROOF
	jp nz, .do_nothing
	ld hl, TinTowerRoofPalette
	jp .load_eight_time_of_day_bg_palettes

.maybe_cinnabar_lab
	ld a, [MapGroup]
	cp GROUP_CINNABAR_LAB
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_CINNABAR_LAB
	jp nz, .do_nothing
	ld hl, CinnabarLabPalette
	jp .load_eight_bg_palettes

.maybe_celadon_mansion_roof
	ld a, [MapGroup]
	cp GROUP_CELADON_MANSION_ROOF
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_CELADON_MANSION_ROOF
	jp nz, .do_nothing
	ld hl, CeladonMansionRoofPalette
	jp .load_eight_time_of_day_bg_palettes

.maybe_goldenrod_dept_store_roof
	ld hl, MartPalette
	ld a, [MapGroup]
	cp GROUP_GOLDENROD_DEPT_STORE_ROOF
	jp nz, .load_eight_bg_palettes
	ld a, [MapNumber]
	cp MAP_GOLDENROD_DEPT_STORE_ROOF
	jp nz, .load_eight_bg_palettes
	ld hl, GoldenrodDeptStoreRoofPalette
	jp .load_eight_time_of_day_bg_palettes

.maybe_olivine_lighthouse_roof
	ld a, [MapGroup]
	cp GROUP_OLIVINE_LIGHTHOUSE_ROOF
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_OLIVINE_LIGHTHOUSE_ROOF
	jp nz, .do_nothing
	ld hl, GoldenrodDeptStoreRoofPalette
	jp .load_eight_time_of_day_bg_palettes

.maybe_celadon_home_decor_store_4f
	ld a, [MapGroup]
	cp GROUP_CELADON_HOME_DECOR_STORE_4F
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_CELADON_HOME_DECOR_STORE_4F
	jp nz, .do_nothing
	ld hl, CeladonHomeDecorStore4FPalette
	jp .load_eight_bg_palettes

.maybe_sinjoh_ruins
	ld a, [MapGroup]
	cp GROUP_SINJOH_RUINS
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_SINJOH_RUINS
	jp nz, .do_nothing
	ld hl, SinjohRuinsPalette
	jp .load_eight_time_of_day_bg_palettes

.maybe_special_johto_1
	ld hl, VioletEcruteakPalette
	ld a, [MapGroup]
	cp GROUP_VIOLET_CITY
	jr nz, .not_violet_city
	ld a, [MapNumber]
	cp MAP_VIOLET_CITY
	jp z, .load_eight_time_of_day_bg_palettes
.not_violet_city
	ld a, [MapGroup]
	cp GROUP_ECRUTEAK_CITY
	jr nz, .not_ecruteak_city
	ld a, [MapNumber]
	cp MAP_ECRUTEAK_CITY
	jp z, .load_eight_time_of_day_bg_palettes
.not_ecruteak_city
	ld a, [MapGroup]
	cp GROUP_SILVER_CAVE_OUTSIDE
	jr nz, .not_silver_cave_outside
	ld a, [MapNumber]
	cp MAP_SILVER_CAVE_OUTSIDE
	jp z, .load_eight_time_of_day_bg_palettes
	cp MAP_ROUTE_28
	jp z, .load_eight_time_of_day_bg_palettes
.not_silver_cave_outside
	ld hl, BellchimeTrailPalette
	ld a, [MapGroup]
	cp GROUP_BELLCHIME_TRAIL
	jr nz, .not_bellchime_trail
	ld a, [MapNumber]
	cp MAP_BELLCHIME_TRAIL
	jp z, .load_eight_time_of_day_bg_palettes
.not_bellchime_trail
	jp .do_nothing

.maybe_special_forest
	ld a, [MapGroup]
	cp GROUP_YELLOW_FOREST
	jr nz, .not_yellow_forest
	ld a, [MapNumber]
	cp MAP_YELLOW_FOREST
	jr nz, .not_yellow_forest
	ld hl, YellowForestPalette
	jp .load_eight_time_of_day_bg_palettes

.not_yellow_forest
	ld a, [MapGroup]
	cp GROUP_MURKY_SWAMP
	jr nz, .not_murky_swamp
	ld a, [MapNumber]
	cp MAP_MURKY_SWAMP
	jr nz, .not_murky_swamp
	ld hl, MurkySwampPalette
	jp .load_eight_bg_palettes

.not_murky_swamp
	ld a, [MapGroup]
	cp GROUP_HIDDEN_TREE_GROTTO
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_HIDDEN_TREE_GROTTO
	jp nz, .do_nothing
	ld hl, HiddenTreeGrottoPalette
	jp .load_eight_bg_palettes

.maybe_special_cave
	ld a, [MapGroup]
	cp GROUP_HIDDEN_CAVE_GROTTO
	jr nz, .not_hidden_cave_grotto
	ld a, [MapNumber]
	cp MAP_HIDDEN_CAVE_GROTTO
	jr nz, .not_hidden_cave_grotto
	ld hl, HiddenCaveGrottoPalette
	jp .load_eight_bg_palettes

.not_hidden_cave_grotto
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
	ld c, a
	call GetWorldMapLocation
	ld hl, DimCavePalette
	cp DIM_CAVE
	jp z, .load_eight_bg_palettes
	ld hl, CinnabarVolcanoPalette
	cp CINNABAR_VOLCANO
	jp z, .load_eight_bg_palettes
	ld hl, CeruleanCavePalette
	cp CERULEAN_CAVE
	jp z, .load_eight_bg_palettes
	ld hl, SilverCavePalette
	cp SILVER_CAVE
	jp z, .load_eight_bg_palettes
	ld hl, DarkCavePalette
	cp MT_MORTAR
	jp z, .load_eight_bg_palettes
	cp DARK_CAVE
	jp z, .load_eight_bg_palettes
	ld hl, WhirlIslandsPalette
	cp WHIRL_ISLANDS
	jp z, .load_eight_bg_palettes
	ld hl, ScaryCavePalette
	cp SCARY_CAVE
	jp z, .load_eight_bg_palettes
	cp NAVEL_ROCK
	jp nz, .do_nothing
	ld hl, NavelRockPalette
	ld a, [MapGroup]
	cp GROUP_NAVEL_ROCK_ROOF
	jp nz, .load_eight_bg_palettes
	ld a, [MapNumber]
	cp MAP_NAVEL_ROCK_ROOF
	jp nz, .load_eight_bg_palettes
.load_eight_time_of_day_bg_palettes
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	scf
	ret

PokeComPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/pokecom.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

BattleTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/battle_tower.pal"
else
rept 5
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

IcePathPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/ice_path.pal"
else
rept 2
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

GatePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/gate.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

HotelPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/hotel.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

QuietCavePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/quiet_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

RuinsPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/ruins.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

SafariZonePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/safari_zone.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

PokeCenterPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/pokecenter.pal"
else
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

ShamoutiPokeCenterPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/shamouti_pokecenter.pal"
else
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

FarawayIslandPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/faraway_island.pal"
else
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 6
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

ShamoutiIslandPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/shamouti_island.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

ValenciaIslandPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/valencia_island.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

RadioTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/radio_tower.pal"
else
rept 2
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc


HauntedRadioTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/haunted_radio_tower.pal"
else
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

HauntedPokemonTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/haunted_pokemon_tower.pal"
else
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

WillsRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/wills_room.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

KogasRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/kogas_room.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

BrunosRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/brunos_room.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

KarensRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/karens_room.pal"
else
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

LancesRoomPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/lances_room.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

CeruleanGymPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/cerulean_gym.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

SaffronGymPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/saffron_gym.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

ViridianGymPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/viridian_gym.pal"
else
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

FuchsiaGymPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/fuchsia_gym.pal"
else
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

GameCornerPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/game_corner.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

CharcoalKilnPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/charcoal_kiln.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

OaksLabPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/oaks_lab.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

IvysLabPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/ivys_lab.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

DragonShrinePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/dragon_shrine.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

LightningIslandPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/lightning_island.pal"
else
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

MagnetTunnelPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/magnet_tunnel.pal"
else
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

MystriStagePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/mystri_stage.pal"
else
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

EmbeddedTowerPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/embedded_tower.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

TinTowerRoofPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/tin_tower_roof.pal"
else
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

CinnabarLabPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/cinnabar_lab.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

CeladonMansionRoofPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/celadon_mansion_roof.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

MartPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/mart.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

GoldenrodDeptStoreRoofPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/goldenrod_dept_store_roof.pal"
else
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 6
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

CeladonHomeDecorStore4FPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/celadon_home_decor_store_4f.pal"
else
rept 4
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

SinjohRuinsPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/sinjoh_ruins.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

VioletEcruteakPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/violet_ecruteak.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

BellchimeTrailPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/bellchime_trail.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

YellowForestPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/yellow_forest.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

MurkySwampPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/murky_swamp.pal"
else
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

HiddenTreeGrottoPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/hidden_tree_grotto.pal"
else
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

HiddenCaveGrottoPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/hidden_cave_grotto.pal"
else
rept 7
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

DimCavePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/dim_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

WhirlIslandsPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/whirl_islands.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

ScaryCavePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/scary_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

CinnabarVolcanoPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/cinnabar_volcano.pal"
else
	MONOCHROME_RGB_FOUR_NIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	MONOCHROME_RGB_FOUR_NIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

CeruleanCavePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/cerulean_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

SilverCavePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/silver_cave.pal"
else
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

DarkCavePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/dark_cave.pal"
else
rept 4
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
rept 2
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

NavelRockPalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/navel_rock.pal"
else
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 5
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 5
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR_NIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 5
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

OvercastBGPalette:
if DEF(HGSS)
INCLUDE "tilesets/palettes/hgss/ob.pal"
else
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/bg_overcast.pal"
else
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 7
	MONOCHROME_RGB_FOUR
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 4
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	MONOCHROME_RGB_FOUR_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc
endc

OvercastOBPalette:
if DEF(HGSS)
INCLUDE "tilesets/palettes/hgss/ob_overcast.pal"
else
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/ob_overcast.pal"
else
rept 5
	MONOCHROME_RGB_FOUR_OW
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
rept 5
	MONOCHROME_RGB_FOUR_OW
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
rept 5
	MONOCHROME_RGB_FOUR_OW_NIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
rept 5
	MONOCHROME_RGB_FOUR_OW_DARKNESS
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 2
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
endr
endc
endc

MartBluePalette:
if !DEF(MONOCHROME)
	RGB 20, 27, 28
	RGB 06, 22, 25
	RGB 04, 17, 19
	RGB 07, 07, 07
else
	MONOCHROME_RGB_FOUR
endc

LinkTrade_Layout_FillBox: ; 49336
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret
; 49346

_InitLinkTradePalMap: ; 49797
	hlcoord 0, 0, AttrMap
	lb bc, 16, 2
	ld a, $4
	call LinkTrade_Layout_FillBox
	ld a, $3
	ldcoord_a 0, 1, AttrMap
	ldcoord_a 0, 14, AttrMap
	hlcoord 2, 0, AttrMap
	lb bc, 8, 18
	ld a, $5
	call LinkTrade_Layout_FillBox
	hlcoord 2, 8, AttrMap
	lb bc, 8, 18
	ld a, $6
	call LinkTrade_Layout_FillBox
	hlcoord 0, 16, AttrMap
	lb bc, 2, SCREEN_WIDTH
	ld a, $4
	call LinkTrade_Layout_FillBox
	ld a, $3
	lb bc, 6, 1
	hlcoord 6, 1, AttrMap
	call LinkTrade_Layout_FillBox
	ld a, $3
	lb bc, 6, 1
	hlcoord 17, 1, AttrMap
	call LinkTrade_Layout_FillBox
	ld a, $3
	lb bc, 6, 1
	hlcoord 6, 9, AttrMap
	call LinkTrade_Layout_FillBox
	ld a, $3
	lb bc, 6, 1
	hlcoord 17, 9, AttrMap
	call LinkTrade_Layout_FillBox
	ld a, $2
	hlcoord 2, 16, AttrMap
	ld [hli], a
	ld a, $7
rept 3
	ld [hli], a
endr
	ld a, $2
	ld [hl], a
	hlcoord 2, 17, AttrMap
	ld a, $3
	ld bc, 6
	jp ByteFill
; 49811

LoadLinkTradePalette: ; 49811
	ld a, $5
	ld de, UnknBGPals palette 2
	ld hl, LinkTradePalette
	ld bc, 6 palettes
	call FarCopyWRAM
	farjp ApplyPals
; 49826

LinkTradePalette:
if !DEF(MONOCHROME)
INCLUDE "tilesets/palettes/link_trade.pal"
else
rept 8
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
endr
endc

InitLinkTradePalMap: ; 49856
	jp _InitLinkTradePalMap
; 4985a

LoadSpecialMapOBPalette:
	call GetOvercastIndex
	and a
	jr z, .not_overcast
	ld hl, OvercastOBPalette
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	call AddNTimes
	ld a, $5
	ld de, UnknOBPals
	ld bc, 8 palettes
	jp FarCopyWRAM

.not_overcast
	ld a, [wTileset]
	cp TILESET_SHAMOUTI_ISLAND
	jr z, .load_bg_tree_palette
	cp TILESET_SAFARI_ZONE
	jr nz, .not_shamouti_or_safari
.load_bg_tree_palette
	ld hl, UnknBGPals palette PAL_BG_GREEN
.load_tree_palette:
	ld de, UnknOBPals palette PAL_OW_TREE
.load_single_palette:
	ld a, $5
	ld bc, 1 palettes
	jp FarCopyWRAM

.not_shamouti_or_safari:
	cp TILESET_FARAWAY_ISLAND
	jr nz, .not_faraway
	ld hl, UnknBGPals palette 1 ; grass
	jr .load_tree_palette

.not_faraway:
	ld a, [MapGroup]
	cp GROUP_MURKY_SWAMP
	jr nz, .not_murky_swamp
	ld a, [MapNumber]
	cp MAP_MURKY_SWAMP
	jr z, .load_bg_tree_palette

.not_murky_swamp:
	ld a, [MapGroup]
	cp GROUP_VERMILION_GYM
	jr nz, .not_vermilion_gym
	ld a, [MapNumber]
	cp MAP_VERMILION_GYM
	jr nz, .not_vermilion_gym
	ld hl, VermilionGymOBPalette_Tree
	jr .load_tree_palette

.not_vermilion_gym:
	ld a, [MapGroup]
	cp GROUP_LIGHTNING_ISLAND
	jr nz, .not_lightning_island
	ld a, [MapNumber]
	cp MAP_LIGHTNING_ISLAND
	jr nz, .not_lightning_island
	ld hl, LightningIslandOBPalette_Tree
	jr .load_tree_palette

.not_lightning_island:
	ld a, [MapGroup]
	cp GROUP_ROCK_TUNNEL_2F
	jr nz, .not_rock_tunnel_2f
	ld a, [MapNumber]
	cp MAP_ROCK_TUNNEL_2F
	jr nz, .not_rock_tunnel_2f
	ld hl, RockTunnelOBPalette_Tree
	jr .load_tree_palette

.not_rock_tunnel_2f:
	ld a, [MapGroup]
	cp GROUP_LYRAS_HOUSE_2F
	jr nz, .not_lyras_house_2f
	ld a, [MapNumber]
	cp MAP_LYRAS_HOUSE_2F
	jr nz, .not_lyras_house_2f
	ld hl, LyrasHouse2FOBPalette_Rock
	jr .load_rock_palette

.not_lyras_house_2f:
	ld a, [MapGroup]
	cp GROUP_MOUNT_MOON_SQUARE
	jr nz, .not_mount_moon_square
	ld a, [MapNumber]
	cp MAP_MOUNT_MOON_SQUARE
	jr nz, .not_mount_moon_square
	ld hl, UnknBGPals palette PAL_BG_GRAY
	jr .load_rock_palette

.not_mount_moon_square:
	ld a, [MapGroup]
	cp GROUP_MAGNET_TUNNEL_INSIDE
	jr nz, .not_magnet_tunnel
	ld a, [MapNumber]
	cp MAP_MAGNET_TUNNEL_INSIDE
	jr nz, .not_magnet_tunnel
	ld hl, UnknBGPals palette PAL_BG_GRAY
	jr .load_rock_palette

.not_magnet_tunnel
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
	ld c, a
	call GetWorldMapLocation
	cp CINNABAR_VOLCANO
	jr z, .load_bg_rock_palette
	cp DIM_CAVE
	jr z, .load_bg_rock_palette
	cp ICE_PATH
	jr z, .load_bg_rock_palette
	cp SEAFOAM_ISLANDS
	jr z, .load_bg_rock_palette
	cp WHIRL_ISLANDS
	ret z
.load_bg_rock_palette
	ld hl, UnknBGPals palette PAL_BG_BROWN
.load_rock_palette
	ld de, UnknOBPals palette PAL_OW_ROCK
	jp .load_single_palette

VermilionGymOBPalette_Tree:
if !DEF(MONOCHROME)
	RGB 27, 31, 27
	RGB 31, 31, 30
	RGB 19, 24, 31
	RGB 05, 10, 27
else
	MONOCHROME_RGB_FOUR_OW
endc

LightningIslandOBPalette_Tree:
if !DEF(MONOCHROME)
	RGB 19, 15, 10
	RGB 31, 31, 31
	RGB 31, 27, 01
	RGB 31, 16, 01
else
	MONOCHROME_RGB_FOUR_OW
endc

RockTunnelOBPalette_Tree:
if !DEF(MONOCHROME)
	RGB 15, 14, 24
	RGB 31, 30, 31
	RGB 24, 18, 31
	RGB 12, 08, 18
else
	MONOCHROME_RGB_FOUR_OW
endc

LyrasHouse2FOBPalette_Rock:
if !DEF(MONOCHROME)
	RGB 30, 28, 26
	RGB 30, 28, 02
	RGB 08, 14, 24
	RGB 07, 07, 07
else
	MONOCHROME_RGB_FOUR
endc
