INCLUDE "data/pokemon/menu_icon_pals.asm"

LoadOverworldMonIcon:
	; c = species
	ld a, [wCurIcon]
	ld c, a
	; b = form
	ld a, [wCurIconForm]
	ld b, a
	; bc = index
	call GetCosmeticSpeciesAndFormIndex
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

	ld a, [wd265]
	ld [wCurPartySpecies], a
	call GetMenuMonIconPalette
	jp ProcessMenuMonIconColor

LoadFlyMonColor:
	push hl
	push de
	push bc
	push af

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld a, MON_SHINY
	call GetPartyParamLocation
	call GetMenuMonIconPalette
	jp ProcessMenuMonIconColor

LoadPartyMenuMonIconColors:
	push hl
	push de
	push bc
	push af

	ld a, [wPartyCount]
	sub c
	ld [wCurPartyMon], a

	ld d, 0
	ld e, a

	push af
	ld hl, wPartyMon1Item
	call GetPartyLocation
	ld a, [hl]
	ld [wCurIconMonHasItemOrMail], a
	pop af

	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_species
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
.got_species
	ld [wCurPartySpecies], a
	ld a, MON_SHINY
	call GetPartyParamLocation
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
	jp PopAFBCDEHL

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
	and BASEMON_MASK
	ld b, a

	; check shininess at hl
	ld a, [hl]
	and SHINY_MASK
	push af

	; bc = index
	call GetCosmeticSpeciesAndFormIndex
	dec bc
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

	jp PopBCDEHL

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
InitScreenMonIcon:
	push de

	ld a, MON_FORM ; aka MON_IS_EGG
	call GetPartyParamLocation
	ld a, [hl]
	and BASEMON_MASK
	ld [wCurIconForm], a
	bit MON_IS_EGG_F, [hl]
	ld a, [wd265]
	jr z, .got_species
	ld a, EGG
.got_species
	ld [wd265], a
	ld [wCurIcon], a

	dec hl ; MON_SHINY = MON_FORM - 1
	call SetMenuMonIconColor

	xor a
	call GetIconGFX

	pop de
	ld a, SPRITE_ANIM_INDEX_PARTY_MON
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_NULL

	jp PopBCDEHL

LoadTradeAnimationMonIcon:
	call SetMenuMonIconColor
	ld a, [wd265]
	ld [wCurIcon], a
	ld a, $62
	ld [wCurIconTile], a
	jp GetMemIconGFX

InitPartyMenuIcon:
	ld a, [wCurIconTile]
	push af
	ldh a, [hObjectStructIndexBuffer]
	ld e, a
	ld d, 0
	ld hl, wPartyMon1IsEgg ; aka wPartyMon1Form
	push de
	call GetPartyLocation
	pop de
	ld a, [hl]
	bit MON_IS_EGG_F, a
	jr nz, .egg
	and BASEMON_MASK
	ld [wCurIconForm], a
	ld hl, wPartySpecies
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
	call InitSpriteAnimStruct
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
	ld hl, SPRITEANIMSTRUCT_0D
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
	call GetPartyParamLocation
	and BASEMON_MASK
	ld [wCurIconForm], a
	ld a, [wCurPartyMon]
	ld hl, wPartySpecies
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wd265], a
	ld [wCurIcon], a
	pop de
	ld a, e
	ret

PokegearFlyMap_GetMonIcon:
; Load species icon into VRAM at tile a
	call Fly_PrepMonIcon
	jp GetIconGFX

FlyFunction_GetMonIcon:
	call Fly_PrepMonIcon
	jp GetIcon_a

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

HeldItemIcons:
INCBIN "gfx/icons/mail.2bpp"
INCBIN "gfx/icons/item.2bpp"

GetIcon_a:
; Load icon graphics into VRAM starting from tile a.
	ld l, a
	ld h, 0

GetIcon:
; Load icon graphics into VRAM starting from tile hl.

; One tile is 16 bytes long.
rept 4
	add hl, hl
endr

	ld de, vTiles0
	add hl, de
	push hl

	push hl
	call LoadOverworldMonIcon
	ld h, d
	ld l, e
	pop de

	call DecompressRequest2bpp
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
