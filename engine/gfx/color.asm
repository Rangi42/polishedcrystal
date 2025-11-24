INCLUDE "engine/gfx/cgb_layouts.asm"

CheckShininess:
; Check if a mon is shiny by personality at bc.
; Return carry if shiny.
	ld a, [bc]
	and SHINY_MASK
	jr z, .NotShiny
	scf
	ret

.NotShiny:
	and a
	ret

InitPartyMenuPalettes:
	ld de, wBGPals1
	ld hl, PartyMenuBGPals
	ld c, 4 palettes
	call LoadPalettes
	call InitPartyMenuOBPals
	; fallthrough
WipeAttrMap:
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_AREA
	xor a
	rst ByteFill
	ret

ApplyHPBarPals:
	ld a, [wWhichHPBar]
	and a
	jr z, .Enemy
	dec a
	jr z, .Player
	dec a
	jr z, .PartyMenu
	ret

.Enemy:
	ld de, wBGPals2 palette PAL_BATTLE_BG_ENEMY_HP + 2
	jr .okay

.Player:
	ld de, wBGPals2 palette PAL_BATTLE_BG_PLAYER_HP + 2

.okay
	ld a, c
	add a
	add a
	add LOW(HPBarInteriorPals)
	ld l, a
	adc HIGH(HPBarInteriorPals)
	sub l
	ld h, a
	ld bc, 4
	call FarCopyColorWRAM
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

.PartyMenu:
	ld e, c
	inc e
	hlcoord 11, 1, wAttrmap
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wCurPartyMon]
.loop
	and a
	jr z, .done
	add hl, bc
	dec a
	jr .loop

.done
	lb bc, 2, 8
	ld a, e
	jmp FillBoxWithByte

LoadSummaryStatusIconPalette:
	xor a
	ld de, wTempMonStatus
	farcall GetStatusConditionIndex
	ld hl, StatusIconPals
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld de, wOBPals1 palette 5 color 2
	ld bc, 1 colors
	jmp FarCopyColorWRAM

LoadPlayerStatusIconPalette:
	ld a, [wPlayerSubStatus2]
	ld de, wBattleMonStatus
	farcall GetStatusConditionIndex
	ld hl, StatusIconPals
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld de, wBGPals1 palette PAL_BATTLE_BG_STATUS + 2
	ld bc, 2
	jmp FarCopyColorWRAM

LoadEnemyStatusIconPalette:
	ld a, [wEnemySubStatus2]
	ld de, wEnemyMonStatus
	farcall GetStatusConditionIndex
	ld hl, StatusIconPals
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld de, wBGPals1 palette PAL_BATTLE_BG_STATUS + 4
	ld bc, 2
	jmp FarCopyColorWRAM

StatusIconPals:
INCLUDE "gfx/battle/status.pal"

LoadBattleCategoryAndTypePals:
	ld a, [wPlayerMoveStruct + MOVE_CATEGORY]
	ld b, a
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	ld c, a
	ld de, wBGPals1 palette PAL_BATTLE_BG_TYPE_CAT + 2
LoadCategoryAndTypePals:
	ld hl, CategoryIconPals
	ld a, b
	add a
	add a
	push bc
	ld c, a
	ld b, 0
	add hl, bc
	ld bc, 4
	push de
	call FarCopyColorWRAM
	pop de

	ld hl, TypeIconPals
	pop bc
	ld a, c
	add a
	ld c, a
	ld b, 0
	add hl, bc
	inc de
	inc de
	inc de
	inc de
	ld bc, 2
	jmp FarCopyColorWRAM

CategoryIconPals:
	table_width COLOR_SIZE * 2
INCLUDE "gfx/battle/categories.pal"
	assert_table_length NUM_CATEGORIES

TypeIconPals:
	table_width COLOR_SIZE
INCLUDE "gfx/battle/types.pal"
	assert_table_length NUM_TYPES + 1

LoadKeyItemIconPalette:
	ld a, [wCurKeyItem]
	ld bc, KeyItemIconPalettes - COLOR_SIZE * 2
	jr LoadIconPalette

LoadExpCandyIconPalette:
	ld a, [wCurItem]
	ld hl, ExpCandyIconPalette
	jr LoadIconPaletteFromHL

ExpCandyIconPalette:
	; Exp Candy
	RGB 18, 29, 31
	RGB 03, 21, 24

LoadItemIconPalette:
	ld a, [wCurItem]
LoadItemIconPaletteFromA:
	ld bc, ItemIconPalettes
LoadIconPalette:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, bc
LoadIconPaletteFromHL:
	ld de, wBGPals1 palette 7 + 2
	ld bc, 4
	call FarCopyColorWRAM
	ld hl, BlackColor
	ld bc, 2
	jmp FarCopyColorWRAM

LoadTMHMIconPalette:
	ld a, [wTempTMHM]
	ld hl, Moves + MOVE_TYPE
	call GetMoveProperty
	ld hl, TMHMTypeIconPals
	ld c, a
	ld b, 0
rept 4
	add hl, bc
endr
	jr LoadIconPaletteFromHL

LoadSpecialItemIconPalette:
	ld a, [wCurSpecialItem]
	ld bc, SpecialItemIconPalettes
	assert POKEGEAR + 1 == NUM_SPECIAL_ITEMS
	cp POKEGEAR
	jr nz, LoadIconPalette
	ld h, a
	ld a, [wPlayerGender]
	add h
	jr LoadIconPalette

ItemIconPalettes:
CaughtBallPals:
ParkBallIconPalette:
	table_width COLOR_SIZE * 2
INCLUDE "gfx/items/items.pal"
	assert_table_length NUM_ITEMS + 1

KeyItemIconPalettes:
	table_width COLOR_SIZE * 2
INCLUDE "gfx/items/key_items.pal"
	assert_table_length NUM_KEY_ITEMS

TMHMTypeIconPals:
	table_width COLOR_SIZE * 2
INCLUDE "gfx/items/tm_hm_types.pal"
	assert_table_length NUM_TYPES

ApricornIconPalettes:
	table_width COLOR_SIZE * 2
INCLUDE "gfx/items/apricorns.pal"
	assert_table_length NUM_APRICORNS

WingIconPalettes:
	table_width COLOR_SIZE * 2
INCLUDE "gfx/items/wings.pal"
	assert_table_length NUM_WINGS

SpecialItemIconPalettes:
	table_width COLOR_SIZE * 2
INCLUDE "gfx/items/special_items.pal"
	assert_table_length NUM_SPECIAL_ITEMS + NUM_PLAYER_GENDERS - 1

LoadOneColor:
	ld c, 2
LoadColorBytes:
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, LoadColorBytes
	ret

LoadOnePalette:
; Loads a single palette from hl to de in GBC Video WRAMX
	ld c, 1 palettes
	; fallthrough
LoadPalettes:
; Load c palette bytes from hl to de in GBC Video WRAMX
	ldh a, [rWBK]
	push af
	ld a, BANK("GBC Video")
	ldh [rWBK], a
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	pop af
	ldh [rWBK], a
	ret

LoadPalette_White_Col1_Col2_Black:
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a

if !DEF(MONOCHROME)
	ld a, $ff ; RGB 31,31,31
rept 2
	ld [de], a
	inc de
endr
else
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [de], a
	inc de
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ld [de], a
	inc de
endc

	ld c, 2 * 2
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop

if !DEF(MONOCHROME)
	xor a ; RGB 00, 00, 00
rept 2
	ld [de], a
	inc de
endr
else
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [de], a
	inc de
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [de], a
	inc de
endc

	pop af
	ldh [rWBK], a
	ret

ResetBGPals:
	push hl
	push de
	push bc
	push af

	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a

	ld hl, wBGPals1
	ld c, 8
.loop
if !DEF(MONOCHROME)
	ld a, $ff ; RGB 31, 31, 31
rept 4
	ld [hli], a
endr
	xor a ; RGB 00, 00, 00
rept 4
	ld [hli], a
endr
else
rept 2
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ld [hli], a
endr
rept 2
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [hli], a
endr
endc
	dec c
	jr nz, .loop

	pop af
	ldh [rWBK], a

	jmp PopAFBCDEHL

ApplyWhiteTransparency:
; Apply transparency for colors in bc towards white.
	res 7, b ; make sure the unused 16th color bit is unset
if !DEF(MONOCHROME)
	res 2, b
	ld a, c
	and LOW(palred 30 + palgreen 30 + palblue 30)
	srl b
	rra
	add LOW(palred 16 + palgreen 16 + palblue 16)
	ld c, a
	adc HIGH(palred 16 + palgreen 16 + palblue 16)
	add b
	sub c
	ld b, a
	ret
else
	assert HIGH(PAL_MONOCHROME_WHITE) != HIGH(PAL_MONOCHROME_LIGHT) && \
		HIGH(PAL_MONOCHROME_WHITE) != HIGH(PAL_MONOCHROME_DARK) && \
		HIGH(PAL_MONOCHROME_WHITE) != HIGH(PAL_MONOCHROME_BLACK) && \
		HIGH(PAL_MONOCHROME_LIGHT) != HIGH(PAL_MONOCHROME_DARK) && \
		HIGH(PAL_MONOCHROME_LIGHT) != HIGH(PAL_MONOCHROME_BLACK) && \
		HIGH(PAL_MONOCHROME_DARK) != HIGH(PAL_MONOCHROME_BLACK)
	ld a, b
	cp HIGH(PAL_MONOCHROME_BLACK)
	jr z, .dark
	cp HIGH(PAL_MONOCHROME_DARK)
	jr z, .light
	ld bc, PAL_MONOCHROME_WHITE
	ret
.light
	ld bc, PAL_MONOCHROME_LIGHT
	ret
.dark
	ld bc, PAL_MONOCHROME_DARK
	ret
endc

ApplyPals:
	ld hl, wBGPals1
	ld de, wBGPals2
	ld bc, 16 palettes
	jmp FarCopyColorWRAM

ApplyAttrMap:
	ldh a, [rLCDC]
	bit B_LCDC_ENABLE, a
	jr nz, ApplyAttrMapVBank0
	hlcoord 0, 0, wAttrmap
	debgcoord 0, 0
	ld b, SCREEN_HEIGHT
	ld a, 1
	ldh [rVBK], a
.row
	ld c, SCREEN_WIDTH
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .col
	ld a, TILEMAP_WIDTH - SCREEN_WIDTH
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	dec b
	jr nz, .row
	xor a
	ldh [rVBK], a
	ret

ApplyAttrMapVBank0::
	ldh a, [hBGMapMode]
	push af
	ld a, 2
	ldh [hBGMapMode], a
	call Delay2
	pop af
	ldh [hBGMapMode], a
	ret

ApplyPartyMenuHPPals:
	ld a, [wHPPalIndex]
	add LOW(wHPPals)
	ld l, a
	adc HIGH(wHPPals)
	sub l
	ld h, a
	ld e, [hl]
	inc e
	hlcoord 11, 2, wAttrmap
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wHPPalIndex]
.loop
	and a
	jr z, .done
	add hl, bc
	dec a
	jr .loop
.done
	lb bc, 2, 8
	ld a, e
	jmp FillBoxWithByte

InitPartyMenuOBPals:
	ld hl, PartyMenuOBPals
	ld de, wOBPals1
	ld bc, 8 palettes
	call FarCopyColorWRAM

	ld a, [wPartyCount]
	ld hl, wPartyMon1Species
	ld de, wOBPals1 palette 2 + 2
.loop
	push af
	push hl
	push de
	; a = species
	ld a, [hl]
	; bc = personality
	push hl
	ld bc, MON_PERSONALITY - MON_SPECIES
	add hl, bc
	ld b, h
	ld c, l
	; a = EGG if is egg
	inc hl
	bit MON_IS_EGG_F, [hl]
	jr z, .not_egg
	ld a, EGG
.not_egg
	; hl = palette
	call GetMonNormalOrShinyPalettePointer
	; load palette
	ld bc, 4
	call FarCopyColorWRAM
	; c = species
	pop hl
	ld c, [hl]
	; b = form
	ld de, MON_FORM - MON_SPECIES
	add hl, de
	ld b, [hl]
	; hl = DVs
	ld de, MON_DVS - MON_FORM
	add hl, de
	; vary colors by DVs
	call CopyDVsToColorVaryDVs ; clobbers hl but not bc
	pop de
	ld h, d
	ld l, e
	call VaryColorsByDVs
	; skip this black and next white to next colors
rept 4
	inc hl
endr
	ld d, h
	ld e, l
	pop hl
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop af
	dec a
	jr nz, .loop
	ret

PartyMenuOBPals:
INCLUDE "gfx/stats/party_menu_ob.pal"

InitPokegearPalettes:
; This is needed because the regular palette is dark at night.
	ld hl, PokegearOBPals
	ld de, wOBPals1
	ld bc, 3 palettes
	call FarCopyColorWRAM

	ld hl, PokegearFlyPalette
	ld de, wOBPals1 palette 3
	ld bc, 1 palettes
	jmp FarCopyColorWRAM

PokegearOBPals:
INCLUDE "gfx/icons/icons.pal"

PokegearFlyPalette:
INCLUDE "gfx/pokegear/fly.pal"

GetBattlemonBackpicPalettePointer:
	push de
	farcall GetPartyMonPersonality
	ld c, l
	ld b, h
	ld a, [wTempBattleMonSpecies]
	call GetPlayerOrMonPalettePointer
	pop de
	ret

GetEnemyFrontpicPalettePointer:
	push de
	farcall GetEnemyMonPersonality
	ld c, l
	ld b, h
	ld a, [wTempEnemyMonSpecies]
	call GetFrontpicPalettePointer
	pop de
	ret

GetPlayerOrMonPalettePointer:
	and a
	jr nz, GetMonNormalOrShinyPalettePointer

	ld hl, Lyra1Palette
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ret z

	ld a, [wPlayerGender]
	ld hl, ChrisPalette
	and a ; PLAYER_MALE
	ret z
	ld hl, KrisPalette
	dec a ; PLAYER_FEMALE
	ret z
	; PLAYER_ENBY
	ld hl, CrysPalette
	ret

GetFrontpicPalettePointer:
	and a
	jr nz, GetMonNormalOrShinyPalettePointer
	ld a, [wTrainerPal]
	and a
	jr nz, GetTrainerPalettePointer
	ld a, [wTrainerClass]

GetTrainerPalettePointer:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, TrainerPalettes - COLOR_SIZE * 2
	add hl, bc
	ret

GetPaintingPalettePointer:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, PaintingPalettes
	add hl, bc
	ret

GetMonPalettePointer:
	push af
	ld h, b
	ld l, c
	; c = species
	ld c, a
	; b = form
	inc hl ; Form is in the byte after Shiny
	ld a, [hl]
	and SPECIESFORM_MASK
	ld b, a
	pop af
_GetMonPalettePointer:
	; bc = index
	push af
	call GetSpeciesAndFormIndex
	ld h, b
	ld l, c
	inc hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, PokemonPalettes
	add hl, bc
	pop af
	ret

GetMonPalInBCDE:
; Returns (non-shiny) mon palette for species+form bc in bcde.
	call _GetMonPalettePointer
	and SHINY_MASK
	jr z, .shiny_done
	; Shiny is the pal right below.
	inc hl
	inc hl
	inc hl
	inc hl
.shiny_done
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ret

GetMonNormalOrShinyPalettePointer:
	push bc
	call GetMonPalettePointer
	pop bc
	push hl
	call CheckShininess
	pop hl
	ret nc
rept 4
	inc hl
endr
	ret

LoadPokemonPalette:
	; a = species
	ld a, [wCurPartySpecies]

	; This allows us to use the same function as with
	; GetMonNormalOrShinyPalettePointer.
	ld bc, wCurForm - 1

	; hl = palette
	call GetMonPalettePointer
	; load palette into de (set by caller)
	ld bc, 4
	jmp FarCopyColorWRAM

LoadPartyMonPalette:
	push de
	; bc = personality
	ld hl, wPartyMon1Personality
	ld a, [wCurPartyMon]
	call GetPartyLocation
	ld c, l
	ld b, h
	; a = species
	ld a, [wCurPartySpecies]
	; hl = palette
	call GetMonNormalOrShinyPalettePointer
	; load palette in de (set by caller)
	ld bc, 4
	call FarCopyColorWRAM
	; hl = DVs
	ld hl, wPartyMon1DVs
	ld a, [wCurPartyMon]
	call GetPartyLocation
	; fallthrough
_FinishLoadNicknamedMonPalette:
	; c = species, b = extspecies+form
	ld a, [wCurPartySpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	pop hl
	jmp VaryColorsByDVs

LoadTempMonPalette:
	push de
	; bc = personality
	ld bc, wTempMonPersonality
	; a = species
	ld a, [wCurPartySpecies]
	; hl = palette
	call GetMonNormalOrShinyPalettePointer
	; load palette in de (set by caller)
	ld bc, 4
	call FarCopyColorWRAM
	; hl = DVs
	ld hl, wTempMonDVs
	jr _FinishLoadNicknamedMonPalette

LoadTrainerPalette:
	ld a, [wTrainerPal]
	and a
	jr nz, .use_custom_pal
	; a = class
	ld a, [wTrainerClass]
.use_custom_pal
	; hl = palette
	call GetTrainerPalettePointer
	; load palette in BG 7
	ld de, wBGPals1 palette PAL_BG_TEXT + 2
	ld bc, 4
	jmp FarCopyColorWRAM

LoadPaintingPalette:
	; a = class
	ld a, [wTrainerClass]
	; hl = palette
	call GetPaintingPalettePointer
	; load palette in BG 7
	ld de, wBGPals1 palette PAL_BG_TEXT
	ld bc, 8
	jmp FarCopyColorWRAM

LoadSingleBadgePalette:
	; a = badge
	ld a, [wCurBadge]
	assert JOHTO_REGION == 0 && KANTO_REGION == 1
	cp NUM_JOHTO_BADGES
	; hl = palette
	ld hl, JohtoBadgePalettes
	jr c, .got_region
	ld hl, KantoBadgePalettes
	sub NUM_JOHTO_BADGES
	cp RAINBOWBADGE
	call z, .RainbowBadge
.got_region
	ld bc, 1 palettes
	push bc
	rst AddNTimes
	pop bc
	ld de, wBGPals1 palette PAL_BG_TEXT
	jmp FarCopyColorWRAM

.RainbowBadge
; Special case: Rainbow Badge uses Volcano Badge, Thunder Badge, Cascade Badge and its own palette
; BG pals 1, 4, 6 and 7 are safe to overwrite at present in Celadon Gym when the badge is received
	push af
	push hl
	ld a, CASCADEBADGE
	ld bc, 1 palettes
	push bc
	rst AddNTimes
	pop bc
	push bc
	ld de, wBGPals1 palette 1
	call FarCopyColorWRAM
	assert CASCADEBADGE + 1 == THUNDERBADGE
	pop bc
	push bc
	ld de, wBGPals1 palette 4
	call FarCopyColorWRAM
	assert THUNDERBADGE + 1 == RAINBOWBADGE
	assert VOLCANOBADGE > RAINBOWBADGE
	ld a, VOLCANOBADGE - RAINBOWBADGE
	pop bc
	push bc
	rst AddNTimes
	pop bc
	ld de, wBGPals1 palette 6
	call FarCopyColorWRAM
	hlcoord 17, 13, wAttrmap
	ld a, 6
	ld [hli], a
	ld [hl], 4
	hlcoord 17, 14, wAttrmap
	ld [hl], 1
	pop hl
	pop af
	ret

InitCGBPals::
	ld a, $1
	ldh [rVBK], a
	ld hl, vTiles0
	ld bc, $200 tiles
	xor a
	rst ByteFill
	xor a
	ldh [rVBK], a
	ld a, BGPI_AUTOINC
	ldh [rBGPI], a
	ld c, 4 * 8
if !DEF(MONOCHROME)
	ld a, $ff ; RGB 31, 31, 31
endc
.bgpals_loop
if !DEF(MONOCHROME)
	ldh [rBGPD], a
	ldh [rBGPD], a
else
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ldh [rBGPD], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ldh [rBGPD], a
endc
	dec c
	jr nz, .bgpals_loop
	ld a, OBPI_AUTOINC
	ldh [rOBPI], a
	ld c, 4 * 8
if !DEF(MONOCHROME)
	ld a, $ff ; RGB 31, 31, 31
endc
.obpals_loop
if !DEF(MONOCHROME)
	ldh [rOBPD], a
	ldh [rOBPD], a
else
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ldh [rOBPD], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ldh [rOBPD], a
endc
	dec c
	jr nz, .obpals_loop
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a
	ld hl, wBGPals1
	call .LoadWhitePals
	ld hl, wBGPals2
	call .LoadWhitePals
	pop af
	ldh [rWBK], a
	ret

.LoadWhitePals:
if !DEF(MONOCHROME)
	ld bc, 16 palettes
	ld a, $ff ; RGB 31, 31, 31
	rst ByteFill
else
	ld c, 4 * 16
.mono_loop
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ld [hli], a
	dec c
	jr nz, .mono_loop
endc
	ret

LoadMapPals:
	farcall LoadSpecialMapPalette
	jr c, .got_pals

	; Which palette group is based on whether we're outside or inside
	ld a, [wEnvironment]
	and 7
	ld e, a
	ld d, 0
	ld hl, EnvironmentColorsPointers
	add hl, de
	ld e, [hl]
	add hl, de

	; Further refine by time of day
	ld a, [wTimeOfDayPal]
	and 3
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h

	; Switch to palettes WRAM bank
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a

	ld hl, wBGPals1
	ld b, 7
.outer_loop
	ld a, [de] ; lookup index for TilesetBGPalette
	push de
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, TilesetBGPalette
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld c, 1 palettes
.inner_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .inner_loop
	pop de
	inc de
	dec b
	jr nz, .outer_loop

	pop af
	ldh [rWBK], a

.got_pals
	ld hl, wPalFlags
	bit MAP_CONNECTION_PAL_F, [hl]
	res MAP_CONNECTION_PAL_F, [hl]
	jr nz, .skip_clearing_obj_pals
	farcall ClearSavedObjPals
.skip_clearing_obj_pals

	ld a, [wMapTileset]
	cp TILESET_SNOWTOP_MOUNTAIN
	ret z

	; overcast maps have their own roof color table
	farcall GetOvercastIndex
	and a
	jr z, .not_overcast
	dec a
	ld hl, OvercastRoofPals
	jr .get_roof_color

.not_overcast
	ld a, [wEnvironment]
	cp TOWN
	jr z, .outside
	cp ROUTE
	jr z, .outside
	cp ISOLATED
	ret nz
.outside
	ld a, [wMapGroup]
	ld hl, RoofPals
.get_roof_color
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld de, 4
	ld a, [wTimeOfDayPal]
	and 3
	cp NITE
	jr c, .morn_day
	jr z, .nite
; eve
	add hl, de
.nite
	add hl, de
.morn_day
	ld de, wBGPals1 palette PAL_BG_ROOF + 2
	ld bc, 4
	jmp FarCopyColorWRAM

INCLUDE "data/maps/environment_colors.asm"

TilesetBGPalette::
	table_width 1 palettes
INCLUDE "gfx/tilesets/bg_tiles.pal"
	assert_table_length 8 * 5 + 4 ; morn, day, nite, eve, indoor, water

RoofPals:
	table_width COLOR_SIZE * 2 * 3
INCLUDE "gfx/tilesets/roofs.pal"
	assert_table_length NUM_MAP_GROUPS + 1

OvercastRoofPals:
INCLUDE "gfx/tilesets/roofs_overcast.pal"

INCLUDE "data/pokemon/palettes.asm"

INCLUDE "data/trainers/palettes.asm"

INCLUDE "data/events/paintings/palettes.asm"

INCLUDE "engine/gfx/sgb_border.asm"

INCLUDE "engine/gfx/vary_colors.asm"
