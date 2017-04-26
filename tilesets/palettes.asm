LoadBlindingFlashPalette:: ; 49409
	ld a, $5
	ld de, UnknBGPals + 7 palettes
	ld hl, BlindingFlashPalette
	ld bc, 1 palettes
	call FarCopyWRAM
	ret
; 49418

BlindingFlashPalette: ; 49418
	RGB 31, 31, 31
	RGB 08, 19, 28
	RGB 05, 05, 16
	RGB 00, 00, 00
; 49420

LoadSpecialMapPalette: ; 494ac
	ld a, [wTileset]
	ld hl, PokeComPalette
	cp TILESET_POKECOM_CENTER
	jp z, .load_eight_bg_palettes
	ld hl, BattleTowerPalette
	cp TILESET_BATTLE_TOWER
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
	cp TILESET_HO_OH_WORD_ROOM
	jp z, .load_eight_bg_palettes
	cp TILESET_KABUTO_WORD_ROOM
	jp z, .load_eight_bg_palettes
	cp TILESET_OMANYTE_WORD_ROOM
	jp z, .load_eight_bg_palettes
	cp TILESET_AERODACTYL_WORD_ROOM
	jp z, .load_eight_bg_palettes
	ld hl, CeladonMansionPalette
	cp TILESET_CELADON_MANSION
	jp z, .load_eight_time_of_day_bg_palettes
	ld hl, FarawayIslandPalette
	cp TILESET_FARAWAY_ISLAND
	jp z, .load_eight_time_of_day_bg_palettes
	ld hl, ShamoutiIslandPalette
	cp TILESET_SHAMOUTI_ISLAND
	jp z, .load_eight_time_of_day_bg_palettes
	cp TILESET_POKECENTER
	jp z, .pokecenter
	cp TILESET_ICE_PATH
	jp z, .ice_path_or_hall_of_fame
	cp TILESET_RADIO_TOWER
	jp z, .radio_towers
	cp TILESET_FOREST
	jp z, .maybe_yellow_forest_or_murky_swamp
	cp TILESET_GYM_1
	jp z, .maybe_elite_room
	cp TILESET_GYM_2
	jp z, .maybe_viridian_gym
	cp TILESET_OLIVINE_GYM
	jp z, .maybe_lances_room
	cp TILESET_PORT
	jp z, .maybe_cerulean_gym
	cp TILESET_GAME_CORNER
	jp z, .maybe_saffron_gym
	cp TILESET_UNDERGROUND
	jp z, .maybe_fuchsia_gym
	cp TILESET_TRADITIONAL
	jp z, .maybe_charcoal_kiln
	cp TILESET_LAB
	jp z, .maybe_oaks_lab
	cp TILESET_SPROUT_TOWER
	jp z, .maybe_mystri_or_tower
	cp TILESET_MART
	jp z, .maybe_goldenrod_dept_store_roof
	cp TILESET_HOME_DECOR_STORE
	jp z, .maybe_celadon_home_decor_store_4f
	cp TILESET_JOHTO_1
	jp z, .maybe_special_johto_1
	cp TILESET_CAVE
	jp z, .maybe_special_cave
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
	scf
	ret

.ice_path_or_hall_of_fame
	ld hl, LancesRoomPalette
	ld a, [wPermission] ; permission
	and 7
	cp 3 ; Hall of Fame
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

.maybe_yellow_forest_or_murky_swamp
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
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_MURKY_SWAMP
	jp nz, .do_nothing
	ld hl, MurkySwampPalette
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

.maybe_oaks_lab
	ld a, [MapGroup]
	cp GROUP_OAKS_LAB
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_OAKS_LAB
	jp nz, .do_nothing
	ld hl, OaksLabPalette
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
	jp nz, .maybe_embedded_tower
	ld a, [MapNumber]
	cp MAP_MYSTRI_STAGE
	jp nz, .maybe_embedded_tower
	ld hl, MystriStagePalette
	jp .load_eight_bg_palettes

.maybe_embedded_tower
	ld a, [MapGroup]
	cp GROUP_EMBEDDED_TOWER
	jp nz, .maybe_tin_tower_roof
	ld a, [MapNumber]
	cp MAP_EMBEDDED_TOWER
	jp nz, .maybe_tin_tower_roof
	ld hl, MystriStagePalette
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

.maybe_goldenrod_dept_store_roof
	ld a, [MapGroup]
	cp GROUP_GOLDENROD_DEPT_STORE_ROOF
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_GOLDENROD_DEPT_STORE_ROOF
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

.maybe_special_cave
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
	ld c, a
	call GetWorldMapLocation
	ld hl, DimCavePalette
	cp DIM_CAVE
	jp z, .load_eight_bg_palettes
	ld hl, ScaryCavePalette
	cp SCARY_CAVE
	jr nz, .not_scary_cave
	ld a, [MapNumber]
	cp MAP_SCARY_CAVE_SHIPWRECK
	jp z, .do_nothing
	jp .load_eight_bg_palettes
.not_scary_cave
	ld hl, CinnabarVolcanoPalette
	cp CINNABAR_VOLCANO
	jp z, .load_eight_bg_palettes
	ld hl, CeruleanCavePalette
	cp CERULEAN_CAVE
	jp z, .load_eight_bg_palettes
	ld hl, SilverCavePalette
	cp SILVER_CAVE
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

PokeComPalette: ; 49501
INCLUDE "tilesets/pokecom.pal"
; 49541

BattleTowerPalette: ; 49550
INCLUDE "tilesets/battle_tower.pal"
; 49590

IcePathPalette: ; 4959f
INCLUDE "tilesets/ice_path.pal"
; 495df

GatePalette:
INCLUDE "tilesets/gate.pal"

HotelPalette:
INCLUDE "tilesets/hotel.pal"

QuietCavePalette:
INCLUDE "tilesets/quiet_cave.pal"

RuinsPalette:
INCLUDE "tilesets/ruins.pal"

CeladonMansionPalette:
INCLUDE "tilesets/celadon_mansion.pal"

PokeCenterPalette:
INCLUDE "tilesets/pokecenter.pal"

ShamoutiPokeCenterPalette:
INCLUDE "tilesets/shamouti_pokecenter.pal"

FarawayIslandPalette:
INCLUDE "tilesets/faraway_island.pal"

ShamoutiIslandPalette:
INCLUDE "tilesets/shamouti_island.pal"

RadioTowerPalette: ; 4963d
INCLUDE "tilesets/radio_tower.pal"
; 4967d

HauntedRadioTowerPalette:
INCLUDE "tilesets/haunted_radio_tower.pal"

HauntedPokemonTowerPalette:
INCLUDE "tilesets/haunted_pokemon_tower.pal"

YellowForestPalette:
INCLUDE "tilesets/yellow_forest.pal"

MurkySwampPalette:
INCLUDE "tilesets/murky_swamp.pal"

WillsRoomPalette:
INCLUDE "tilesets/wills_room.pal"

KogasRoomPalette:
INCLUDE "tilesets/kogas_room.pal"

BrunosRoomPalette:
INCLUDE "tilesets/brunos_room.pal"

KarensRoomPalette:
INCLUDE "tilesets/karens_room.pal"

LancesRoomPalette:
INCLUDE "tilesets/lances_room.pal"

CeruleanGymPalette:
INCLUDE "tilesets/cerulean_gym.pal"

SaffronGymPalette:
INCLUDE "tilesets/saffron_gym.pal"

ViridianGymPalette:
INCLUDE "tilesets/viridian_gym.pal"

FuchsiaGymPalette:
INCLUDE "tilesets/fuchsia_gym.pal"

GameCornerPalette:
INCLUDE "tilesets/game_corner.pal"

CharcoalKilnPalette:
INCLUDE "tilesets/charcoal_kiln.pal"

OaksLabPalette:
INCLUDE "tilesets/oaks_lab.pal"

MystriStagePalette:
INCLUDE "tilesets/mystri_stage.pal"

EmbeddedTowerPalette:
INCLUDE "tilesets/embedded_tower.pal"

TinTowerRoofPalette:
INCLUDE "tilesets/tin_tower_roof.pal"

GoldenrodDeptStoreRoofPalette:
INCLUDE "tilesets/goldenrod_dept_store_roof.pal"

CeladonHomeDecorStore4FPalette:
INCLUDE "tilesets/celadon_home_decor_store_4f.pal"

VioletEcruteakPalette:
INCLUDE "tilesets/violet_ecruteak.pal"

BellchimeTrailPalette:
INCLUDE "tilesets/bellchime_trail.pal"

DimCavePalette:
INCLUDE "tilesets/dim_cave.pal"

ScaryCavePalette:
INCLUDE "tilesets/scary_cave.pal"

CinnabarVolcanoPalette:
INCLUDE "tilesets/cinnabar_volcano.pal"

CeruleanCavePalette:
INCLUDE "tilesets/cerulean_cave.pal"

SilverCavePalette:
INCLUDE "tilesets/silver_cave.pal"

NavelRockPalette:
INCLUDE "tilesets/navel_rock.pal"

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
	call ByteFill
	ret
; 49811

LoadLinkTradePalette: ; 49811
	ld a, $5
	ld de, UnknBGPals + $10
	ld hl, LinkTradePalette
	ld bc, 6 palettes
	call FarCopyWRAM
	farcall ApplyPals
	ret
; 49826

LinkTradePalette:
INCLUDE "tilesets/link_trade.pal"

InitLinkTradePalMap: ; 49856
	call _InitLinkTradePalMap
	ret
; 4985a

LoadSpecialMapOBPalette:
	ld a, [MapGroup]
	cp GROUP_VERMILION_GYM
	jr nz, .not_vermilion_gym
	ld a, [MapNumber]
	cp MAP_VERMILION_GYM
	jr nz, .not_vermilion_gym
	ld a, $5
	ld de, UnknOBPals + 6 palettes
	ld hl, VermilionGymOBPalette_Tree
	ld bc, 1 palettes
	call FarCopyWRAM
	ret

.not_vermilion_gym:
	ld a, [MapGroup]
	cp GROUP_MURKY_SWAMP
	jr nz, .not_murky_swamp
	ld a, [MapNumber]
	cp MAP_MURKY_SWAMP
	jr nz, .not_murky_swamp
	ld a, $5
	ld de, UnknOBPals + 6 palettes
	ld hl, MurkySwampOBPalette_Tree
	ld bc, 1 palettes
	call FarCopyWRAM
	ret

.not_murky_swamp:
	ld a, [MapGroup]
	cp GROUP_FARAWAY_ISLAND
	jr nz, .not_faraway_island
	ld a, [MapNumber]
	cp MAP_FARAWAY_ISLAND
	jr nz, .not_faraway_island
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 1 palettes
	ld hl, FarawayIslandOBPalette_Tree
	call AddNTimes
	ld a, $5
	ld de, UnknOBPals + 6 palettes
	ld bc, 1 palettes
	call FarCopyWRAM
	ret

.not_faraway_island:
	ld a, [MapGroup]
	cp GROUP_FARAWAY_JUNGLE
	jr nz, .not_faraway_jungle
	ld a, [MapNumber]
	cp MAP_FARAWAY_JUNGLE
	jr nz, .not_faraway_jungle
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 1 palettes
	ld hl, FarawayJungleOBPalette_Tree
	call AddNTimes
	ld a, $5
	ld de, UnknOBPals + 6 palettes
	ld bc, 1 palettes
	call FarCopyWRAM
	ret

.not_faraway_jungle:
	ret

VermilionGymOBPalette_Tree:
	RGB 31, 31, 31
	RGB 31, 31, 30
	RGB 19, 24, 31
	RGB 05, 10, 27

MurkySwampOBPalette_Tree:
	RGB 12, 19, 18
	RGB 07, 14, 13
	RGB 04, 08, 07
	RGB 00, 00, 00

FarawayIslandOBPalette_Tree:
	RGB 31, 31, 31
	RGB 09, 23, 30
	RGB 08, 13, 25
	RGB 07, 07, 13

	RGB 31, 31, 31
	RGB 09, 23, 30
	RGB 08, 13, 25
	RGB 07, 07, 13

	RGB 15, 14, 24
	RGB 05, 10, 27
	RGB 05, 06, 22
	RGB 03, 03, 05

FarawayJungleOBPalette_Tree:
	RGB 19, 31, 16
	RGB 13, 24, 12
	RGB 00, 17, 07
	RGB 07, 11, 07

	RGB 19, 31, 16
	RGB 13, 24, 12
	RGB 00, 17, 07
	RGB 07, 11, 07

	RGB 11, 14, 14
	RGB 08, 11, 11
	RGB 00, 08, 06
	RGB 03, 05, 03
