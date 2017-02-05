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
	cp TILESET_POKECOM_CENTER
	jp z, .pokecom_center
	cp TILESET_BATTLE_TOWER
	jp z, .battle_tower
	cp TILESET_ICE_PATH
	jp z, .ice_path
	cp TILESET_HOUSE_1
	jp z, .house
	cp TILESET_GATE
	jp z, .gate
	cp TILESET_RADIO_TOWER
	jp z, .radio_tower
	cp TILESET_CELADON_MANSION
	jp z, .celadon_mansion
	cp TILESET_POKECENTER
	jp z, .pokecenter
	cp TILESET_FARAWAY_ISLAND
	jp z, .faraway_island
	cp TILESET_SHAMOUTI_ISLAND
	jp z, .shamouti_island
	cp TILESET_ILEX_FOREST
	jp z, .maybe_yellow_forest
	cp TILESET_TRAIN_STATION
	jp z, .maybe_viridian_gym
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
	jp .do_nothing

.pokecom_center
	call LoadPokeComPalette
	scf
	ret

.battle_tower
	call LoadBattleTowerPalette
	scf
	ret

.ice_path
	ld a, [wPermission] ; permission
	and 7
	cp 3 ; Hall of Fame
	jp z, .do_nothing
	call LoadIcePathPalette
	scf
	ret

.house
	call LoadHousePalette
	scf
	ret

.gate
	call LoadGatePalette
	scf
	ret

.radio_tower
	call LoadRadioTowerPalette
	scf
	ret

.celadon_mansion
	call LoadCeladonMansionPalette
	scf
	ret

.pokecenter
	ld a, [MapGroup]
	cp GROUP_CELADON_HOTEL
	jr nz, .ok
	ld a, [MapNumber]
	cp MAP_CELADON_HOTEL
	jp z, .do_nothing
.ok
	call LoadPokeCenterPalette
	scf
	ret

.faraway_island
	call LoadFarawayIslandPalette
	scf
	ret

.shamouti_island
	call LoadShamoutiIslandPalette
	scf
	ret

.maybe_yellow_forest
	ld a, [MapGroup]
	cp GROUP_YELLOW_FOREST
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_YELLOW_FOREST
	jp nz, .do_nothing
	call LoadYellowForestPalette
	scf
	ret

.maybe_viridian_gym
	ld a, [MapGroup]
	cp GROUP_VIRIDIAN_GYM
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_VIRIDIAN_GYM
	jp nz, .do_nothing
	call LoadViridianGymPalette
	scf
	ret

.maybe_mystri_or_tower
	ld a, [MapGroup]
	cp GROUP_MYSTRI_STAGE
	jp nz, .maybe_embedded_tower
	ld a, [MapNumber]
	cp MAP_MYSTRI_STAGE
	jp nz, .maybe_embedded_tower
	call LoadMystriStagePalette
	scf
	ret

.maybe_embedded_tower
	ld a, [MapGroup]
	cp GROUP_EMBEDDED_TOWER
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_EMBEDDED_TOWER
	jp nz, .do_nothing
	call LoadEmbeddedTowerPalette
	scf
	ret

.maybe_goldenrod_dept_store_roof
	ld a, [MapGroup]
	cp GROUP_GOLDENROD_DEPT_STORE_ROOF
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_GOLDENROD_DEPT_STORE_ROOF
	jp nz, .do_nothing
	call LoadGoldenrodDeptStoreRoofPalette
	scf
	ret

.maybe_celadon_home_decor_store_4f
	ld a, [MapGroup]
	cp GROUP_CELADON_HOME_DECOR_STORE_4F
	jp nz, .do_nothing
	ld a, [MapNumber]
	cp MAP_CELADON_HOME_DECOR_STORE_4F
	jp nz, .do_nothing
	call LoadCeladonHomeDecorStore4FPalette
	scf
	ret

.maybe_special_johto_1
	ld a, [MapGroup]
	cp GROUP_VIOLET_CITY
	jr nz, .not_violet_city
	ld a, [MapNumber]
	cp MAP_VIOLET_CITY
	jr z, .violet_ecruteak
.not_violet_city
	ld a, [MapGroup]
	cp GROUP_ECRUTEAK_CITY
	jr nz, .not_ecruteak_city
	ld a, [MapNumber]
	cp MAP_ECRUTEAK_CITY
	jr z, .violet_ecruteak
.not_ecruteak_city
	ld a, [MapGroup]
	cp GROUP_BELLCHIME_TRAIL
	jr nz, .not_bellchime_trail
	ld a, [MapNumber]
	cp MAP_BELLCHIME_TRAIL
	jr z, .bellchime_trail
.not_bellchime_trail
	jp .do_nothing

.violet_ecruteak
	call LoadVioletEcruteakPalette
	scf
	ret

.bellchime_trail
	call LoadBellchimeTrailPalette
	scf
	ret

.maybe_special_cave
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
	ld c, a
	call GetWorldMapLocation
	cp CINNABAR_VOLCANO
	jr z, .cinnabar_volcano
	cp CERULEAN_CAVE
	jr z, .cerulean_cave
	cp SILVER_CAVE
	jr z, .silver_cave
	cp NAVEL_ROCK
	jr z, .navel_rock
	jp .do_nothing

.cinnabar_volcano
	call LoadCinnabarVolcanoPalette
	scf
	ret

.cerulean_cave
	call LoadCeruleanCavePalette
	scf
	ret

.silver_cave
	call LoadSilverCavePalette
	scf
	ret

.navel_rock
	ld a, [MapGroup]
	cp GROUP_NAVEL_ROCK_ROOF
	jr nz, .navel_rock_day
	ld a, [MapNumber]
	cp MAP_NAVEL_ROCK_ROOF
	jr nz, .navel_rock_day
	call LoadNavelRockTimePalette
	scf
	ret

.navel_rock_day
	call LoadNavelRockPalette
	scf
	ret

.do_nothing
	and a
	ret
; 494f2

LoadPokeComPalette: ; 494f2
	ld a, $5
	ld de, UnknBGPals
	ld hl, PokeComPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret
; 49501

PokeComPalette: ; 49501
INCLUDE "tilesets/pokecom.pal"
; 49541

LoadBattleTowerPalette: ; 49541
	ld a, $5
	ld de, UnknBGPals
	ld hl, BattleTowerPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret
; 49550

BattleTowerPalette: ; 49550
INCLUDE "tilesets/battle_tower.pal"
; 49590

LoadIcePathPalette: ; 49590
	ld a, $5
	ld de, UnknBGPals
	ld hl, IcePathPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret
; 4959f

IcePathPalette: ; 4959f
INCLUDE "tilesets/ice_path.pal"
; 495df

LoadHousePalette: ; 495df
	ld a, $5
	ld de, UnknBGPals
	ld hl, HousePalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret
; 495ee

HousePalette: ; 495ee
INCLUDE "tilesets/house.pal"
; 4962e

LoadGatePalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, GatePalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

GatePalette:
INCLUDE "tilesets/gate.pal"

LoadRadioTowerPalette: ; 4962e
	ld a, $5
	ld de, UnknBGPals
	ld hl, RadioTowerPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret
; 4963d

RadioTowerPalette: ; 4963d
INCLUDE "tilesets/radio_tower.pal"
; 4967d

LoadCeladonMansionPalette: ; 496c5
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, CeladonMansionPalette
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	ret
; 4963d

CeladonMansionPalette:
INCLUDE "tilesets/celadon_mansion.pal"

LoadPokeCenterPalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, PokeCenterPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

PokeCenterPalette:
INCLUDE "tilesets/pokecenter.pal"

LoadFarawayIslandPalette:
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, FarawayIslandPalette
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

FarawayIslandPalette:
INCLUDE "tilesets/faraway_island.pal"

LoadShamoutiIslandPalette:
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, ShamoutiIslandPalette
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

ShamoutiIslandPalette:
INCLUDE "tilesets/shamouti_island.pal"

LoadYellowForestPalette:
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, YellowForestPalette
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

YellowForestPalette:
INCLUDE "tilesets/yellow_forest.pal"

LoadViridianGymPalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, ViridianGymPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

ViridianGymPalette:
INCLUDE "tilesets/viridian_gym.pal"

LoadMystriStagePalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, MystriStagePalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

MystriStagePalette:
INCLUDE "tilesets/mystri_stage.pal"

LoadEmbeddedTowerPalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, EmbeddedTowerPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

EmbeddedTowerPalette:
INCLUDE "tilesets/embedded_tower.pal"

LoadGoldenrodDeptStoreRoofPalette:
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, GoldenrodDeptStoreRoofPalette
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

GoldenrodDeptStoreRoofPalette:
INCLUDE "tilesets/goldenrod_dept_store_roof.pal"

LoadCeladonHomeDecorStore4FPalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, CeladonHomeDecorStore4FPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

CeladonHomeDecorStore4FPalette:
INCLUDE "tilesets/celadon_home_decor_store_4f.pal"

LoadVioletEcruteakPalette:
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, VioletEcruteakPalette
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

VioletEcruteakPalette:
INCLUDE "tilesets/violet_ecruteak.pal"

LoadBellchimeTrailPalette:
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, BellchimeTrailPalette
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

BellchimeTrailPalette:
INCLUDE "tilesets/bellchime_trail.pal"

LoadCinnabarVolcanoPalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, CinnabarVolcanoPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

CinnabarVolcanoPalette:
INCLUDE "tilesets/cinnabar_volcano.pal"

LoadCeruleanCavePalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, CeruleanCavePalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

CeruleanCavePalette:
INCLUDE "tilesets/cerulean_cave.pal"

LoadSilverCavePalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, SilverCavePalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

SilverCavePalette:
INCLUDE "tilesets/silver_cave.pal"

LoadNavelRockPalette:
	ld a, $5
	ld de, UnknBGPals
	ld hl, NavelRockPalette
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

LoadNavelRockTimePalette:
	ld a, [TimeOfDayPal]
	and 3
	ld bc, 8 palettes
	ld hl, NavelRockPalette
	call AddNTimes
	ld a, $5
	ld de, UnknBGPals
	ld bc, 8 palettes
	call FarCopyWRAM
	ret

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

.vermilion_gym:
	ld a, $5
	ld de, UnknOBPals + 6 palettes
	ld hl, VermilionGymOBPalette_Tree
	ld bc, 1 palettes
	call FarCopyWRAM
	ret

.not_vermilion_gym:
	ld a, [MapGroup]
	cp GROUP_FARAWAY_ISLAND
	jr nz, .not_faraway_island
	ld a, [MapNumber]
	cp MAP_FARAWAY_ISLAND
	jr nz, .not_faraway_island

.faraway_island:
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

.faraway_jungle:
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
