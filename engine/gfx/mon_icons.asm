INCLUDE "data/pokemon/menu_icon_pals.asm"

LoadOverworldMonIcon:
	; c = species
	ld a, [wCurIconSpecies]
	ld c, a
	; b = form
	ld a, [wCurIconForm]
	ld b, a
	; bc = index
	; fallthrough
_LoadOverworldMonIcon:
	call GetCosmeticSpeciesAndFormIndex
	inc bc
	ld hl, IconPointers
	add hl, bc
	add hl, bc
	add hl, bc
	; b = icon bank
	ld a, [hli]
	ld b, a
	; de = icon pointer
	ld a, [hli]
	ld d, [hl]
	ld e, a
	; c = tile count
	ld c, 8
	ret

SetMenuMonIconColor:
	push hl
	push de
	push bc
	push af

	ld a, [wTempIconSpecies]
	ld [wCurPartySpecies], a
	call GetMenuMonIconPalette
	jr ProcessMenuMonIconColor

LoadFlyMonColor:
	push hl
	push de
	push bc
	push af

	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld [wCurPartySpecies], a
	ld a, MON_SHINY
	call GetPartyParamLocationAndValue
	call GetMenuMonIconPalette
	jr ProcessMenuMonIconColor

LoadPartyMenuMonIconColors:
	push hl
	push de
	push bc
	push af

	ld a, [wPartyCount]
	sub c
	ld [wCurPartyMon], a

	ld a, MON_ITEM
	call GetPartyParamLocationAndValue
	ld [wCurIconMonHasItemOrMail], a

	ld de, MON_IS_EGG - MON_ITEM
	add hl, de
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_species
	ld de, MON_SPECIES - MON_IS_EGG
	add hl, de
	ld a, [hl]
.got_species
	ld [wCurPartySpecies], a
	ld a, MON_SHINY
	call GetPartyParamLocationAndValue
	call GetMenuMonIconPalette
	push af

	ld hl, wVirtualOAM + 3
	ld a, [wCurPartyMon]
	swap a

	ld d, 0
	ld e, a

	add hl, de
	pop af

	ld de, 4
	ld [hl], a
	add hl, de
	ld [hl], a
	add hl, de
	push hl
	add hl, de
	ld [hl], a
	pop hl
	ld d, a
	ld a, [wCurIconMonHasItemOrMail]
	and a
	ld a, PAL_OW_RED ; same color for item or mail
	jr nz, .ok
	ld a, d
.ok
	ld [hl], a
	jr ProcessMenuMonIconColor.finish

ProcessMenuMonIconColor:
	ld hl, wVirtualOAM + 3
	ld c, 4
	ld de, 4

.colorIcon
	ld [hl], a
	add hl, de
	dec c
	jr nz, .colorIcon

.finish
	jmp PopAFBCDEHL

GetMenuMonIconTruePalette:
; Returns icon col1/col2 palette in bcde (col0/col3 as white/black is implicit)
; with species+form in bc and shininess in a.
if DEF(MONOCHROME)
	ld bc, PAL_MONOCHROME_WHITE
	ld de, PAL_MONOCHROME_LIGHT
	ret
else
	and SHINY_MASK
	push af
	call GetCosmeticSpeciesAndFormIndex
	ld hl, MenuMonIconColors
	add hl, bc
	ld c, [hl]
	pop af
	jr nz, .shiny
	swap c
.shiny
	ld a, c
	and $f
if DEF(NOIR)
	ld bc, palred 21 + palgreen 21 + palblue 21
	and a ; PAL_OW_RED
	ld de, palred 13 + palgreen 13 + palblue 13
	ret z
	dec a ; PAL_OW_BLUE
	ld de, palred 11 + palgreen 11 + palblue 11
	ret z
	dec a ; PAL_OW_GREEN
	ld de, palred 15 + palgreen 15 + palblue 15
	ret z
	dec a ; PAL_OW_BROWN
	ld de, palred 10 + palgreen 10 + palblue 10
	ret z
	dec a ; PAL_OW_PURPLE
	ld de, palred 09 + palgreen 09 + palblue 09
	ret z
	dec a ; PAL_OW_GRAY
	ld de, palred 13 + palgreen 13 + palblue 13
	ret z
	dec a ; PAL_OW_PINK
	ld de, palred 16 + palgreen 16 + palblue 16
	ret z
	; PAL_OW_TEAL
	ld de, palred 16 + palgreen 16 + palblue 16
else
	ld bc, palred 31 + palgreen 19 + palblue 10
	and a ; PAL_OW_RED
	ld de, palred 31 + palgreen 07 + palblue 01
	ret z
	dec a ; PAL_OW_BLUE
	ld de, palred 10 + palgreen 09 + palblue 31
	ret z
	dec a ; PAL_OW_GREEN
	ld de, palred 07 + palgreen 23 + palblue 03
	ret z
	dec a ; PAL_OW_BROWN
	ld de, palred 15 + palgreen 10 + palblue 03
	ret z
	dec a ; PAL_OW_PURPLE
	ld de, palred 18 + palgreen 04 + palblue 18
	ret z
	dec a ; PAL_OW_GRAY
	ld de, palred 13 + palgreen 13 + palblue 13
	ret z
	dec a ; PAL_OW_PINK
	ld de, palred 31 + palgreen 10 + palblue 11
	ret z
	; PAL_OW_TEAL
	ld de, palred 03 + palgreen 23 + palblue 21
endc
	ret
endc

GetOverworldMonIconPalette::
	ld a, [wCurIcon]
	ld hl, wCurIconShiny
	jr _GetMonIconPalette

GetMenuMonIconPalette:
	ld a, [wCurPartySpecies]
_GetMonIconPalette:
	; c = species
	ld c, a
	; b = form
	inc hl ; Form is in the byte after Shiny
	ld a, [hld]
	and SPECIESFORM_MASK
	ld b, a

	; check shininess at hl
	ld a, [hl]
	and SHINY_MASK
	push af

	; bc = index
	call GetCosmeticSpeciesAndFormIndex
	ld hl, MenuMonIconColors
	add hl, bc
	ld c, [hl]

	pop af
	jr nz, .shiny
	swap c
.shiny
	ld a, c
	and $f
	ret

LoadPartyMenuMonIcon:
	call LoadPartyMenuMonIconColors
	push hl
	push de
	push bc

	call InitPartyMenuIcon
	call .SpawnItemIcon
	call SetPartyMonIconAnimSpeed

	jmp PopBCDEHL

.SpawnItemIcon:
	ldh a, [hObjectStructIndexBuffer]
	ld hl, wPartyMon1Item
	call GetPartyLocation
	ld a, [hl]
	and a
	ret z
	ld d, a
	call ItemIsMail
	; a = carry ? SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_MAIL : SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_ITEM
	assert SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_MAIL + 1 == SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_ITEM
	sbc a
	add SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_ITEM
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ret

LoadNamingScreenMonIcon:
	push hl
	push de
	push bc

	depixel 4, 4, 4, 0
	jr InitScreenMonIcon

LoadMoveMenuMonIcon:
	push hl
	push de
	push bc

	depixel 3, 4, 2, 4
	push de
	ld hl, wTempMonForm
	ld a, [hl]
	jr _InitScreenMonIcon
InitScreenMonIcon:
	push de

	ld a, MON_FORM ; aka MON_IS_EGG
	call GetPartyParamLocationAndValue
_InitScreenMonIcon:
	and SPECIESFORM_MASK
	ld [wCurIconForm], a
	bit MON_IS_EGG_F, [hl]
	ld a, [wTempIconSpecies]
	jr z, .got_species
	ld a, EGG
.got_species
	ld [wTempIconSpecies], a
	ld [wCurIcon], a

	dec hl ; MON_SHINY = MON_FORM - 1
	call SetMenuMonIconColor

	xor a
	call GetIconGFX

	pop de
	ld a, SPRITE_ANIM_INDEX_PARTY_MON
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_NULL

	jmp PopBCDEHL

InitPartyMenuIcon:
	ld a, [wCurIconTile]
	push af
	ldh a, [hObjectStructIndexBuffer]
	assert wPartyMon1IsEgg == wPartyMon1Form
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	ld a, [hl]
	bit MON_IS_EGG_F, a
	jr nz, .egg
	and SPECIESFORM_MASK
	ld [wCurIconForm], a
	ld de, MON_SPECIES - MON_FORM
	add hl, de
	ld a, [hl]
	jr .got_icon
.egg
	xor a
	ld [wCurIconForm], a
	dec a ; ld a, EGG
.got_icon
	ld [wCurIcon], a
	call GetMemIconGFX
	ldh a, [hObjectStructIndexBuffer]
; y coord
	swap a ; a *= 16, assuming a < 16 since [hObjectStructIndexBuffer] < NUM_OBJECT_STRUCTS EQU 13
	add $1c
	ld d, a
; x coord
	ld e, $10
; type is partymon icon
	ld a, SPRITE_ANIM_INDEX_PARTY_MON
	call _InitSpriteAnimStruct
	pop af
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], a
	ret

SetPartyMonIconAnimSpeed:
	push bc
	call .getspeed
	pop bc
	ld hl, SPRITEANIMSTRUCT_DURATIONOFFSET
	add hl, bc
	ld [hl], a
	rlca
	rlca
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ret

.getspeed
	ldh a, [hObjectStructIndexBuffer]
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .egg
	ldh a, [hObjectStructIndexBuffer]
	ld b, a
	farcall PlacePartymonHPBar
	call GetHPPal
.gotindex
	ld e, d
	ld d, 0
	ld hl, .speeds
	add hl, de
	ld a, [hl]
	ret

.egg
	ldh a, [hObjectStructIndexBuffer]
	ld hl, wPartyMon1Happiness
	call GetPartyLocation
	ld a, [hl]
; same happiness thresholds as EggStatsScreen
	ld d, 0
	cp $6
	jr c, .gotindex
	inc d ; 1
	cp $b
	jr c, .gotindex
	inc d ; 2
	jr .gotindex

.speeds
	db $00, $40, $80

Fly_PrepMonIcon:
	push de
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	and SPECIESFORM_MASK
	ld [wCurIconForm], a
	ld de, MON_SPECIES - MON_FORM
	add hl, de
	ld a, [hl]
	ld [wTempIconSpecies], a
	ld [wCurIcon], a
	pop de
	ld a, e
	ret

PokegearFlyMap_GetMonIcon:
; Load species icon into VRAM at tile a
	call Fly_PrepMonIcon
	jr GetIconGFX

FlyFunction_GetMonIcon:
	call Fly_PrepMonIcon
	jr GetIcon_a

LoadTradeAnimationMonIcon:
	call SetMenuMonIconColor
	ld a, [wTempIconSpecies]
	ld [wCurIcon], a
	ld a, $62
	ld [wCurIconTile], a
	; fallthrough

GetMemIconGFX:
	ld a, [wCurIconTile]
GetIconGFX:
	call GetIcon_a
	ld de, $80 ; 8 tiles
	add hl, de
	ld de, HeldItemIcons
	lb bc, BANK(HeldItemIcons), 2
	call Request2bpp
	ld a, [wCurIconTile]
	add 10
	ld [wCurIconTile], a
	ret

GetIcon_a:
; Load icon graphics into VRAM starting from tile a.
	ld l, a
	ld h, 0
	; fallthrough
GetIcon:
	ld c, 8
	; fallthrough
DoGetIcon:
; Load icon graphics into VRAM starting from tile hl.

; One tile is 16 bytes long.
rept 4
	add hl, hl
endr

	ld de, vTiles0
	add hl, de
	push hl

	push hl
	ld a, c
	push af
	call LoadOverworldMonIcon
	pop af
	ld c, a
	ld h, d
	ld l, e
	pop de
	call DecompressRequest2bpp
	pop hl
	ret

GetStorageIcon_a:
; Load frame 1 icon graphics into VRAM starting from tile a
	ld l, a ; no-optimize hl|bc|de = a * 16 (rept)
	ld h, 0
rept 4
	add hl, hl
endr
	ld de, vTiles0
	add hl, de
	; fallthrough
GetStorageIcon:
	push hl

	push hl
	ld a, 4
	push af
	call LoadOverworldMonIcon
	pop af
	ld c, a
	ld h, d
	ld l, e
	pop de
	push de
	push bc
	call FarDecompressWRA6InB
	pop bc
	pop hl
	ld de, wDecompressScratch
	farcall BillsPC_SafeRequest2bppInWRA6
	pop hl
	ret

FreezeMonIcons:
	ld hl, wSpriteAnimationStructs
	ld e, PARTY_LENGTH
	ld a, [wMenuCursorY]
	ld d, a
.loop
	ld a, [hl]
	and a
	jr z, .next
	cp d
	ld a, SPRITE_ANIM_SEQ_PARTY_MON_SWITCH
	jr z, .ok
	xor a ; SPRITE_ANIM_SEQ_NULL
.ok
	push hl
	ld c, l
	ld b, h
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], a
	pop hl

.next
	ld bc, $10
	add hl, bc
	dec e
	jr nz, .loop
	ret

UnfreezeMonIcons:
	ld hl, wSpriteAnimationStructs
	ld e, PARTY_LENGTH
.loop
	ld a, [hl]
	and a
	jr z, .next
	push hl
	ld c, l
	ld b, h
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_PARTY_MON
	pop hl
.next
	ld bc, $10
	add hl, bc
	dec e
	jr nz, .loop
	ret

HoldSwitchmonIcon:
	ld hl, wSpriteAnimationStructs
	ld e, PARTY_LENGTH
	ld a, [wSwitchMon]
	ld d, a
.loop
	ld a, [hl]
	and a
	jr z, .next
	cp d
	ld a, SPRITE_ANIM_SEQ_PARTY_MON_SELECTED
	jr nz, .join_back
	assert SPRITE_ANIM_SEQ_PARTY_MON_SELECTED - 1 == SPRITE_ANIM_SEQ_PARTY_MON_SWITCH
	dec a
.join_back
	push hl
	ld c, l
	ld b, h
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], a
	pop hl
.next
	ld bc, $10
	add hl, bc
	dec e
	jr nz, .loop
	ret

HeldItemIcons:
INCBIN "gfx/icons/mail.2bpp"
INCBIN "gfx/icons/item.2bpp"
