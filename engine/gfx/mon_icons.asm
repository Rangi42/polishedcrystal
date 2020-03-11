INCLUDE "data/pokemon/menu_icon_pals.asm"

LoadOverworldMonIcon:
	ld [wCurIcon], a
	ld l, a
	ld h, 0
	add hl, hl
	ld de, IconPointers
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
; Extended icon bank routine by com3tiin
; http://www.pokecommunity.com/showthread.php?t=338470
GetMonIconBank:
	ld a, [wCurIcon]
	cp TAUROS ; first mon in Icons2
	lb bc, BANK(Icons1), 8
	ret c
	ld b, BANK(Icons2)
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

SetMenuMonIconColor_NoShiny:
	push hl
	push de
	push bc
	push af

	ld a, [wd265]
	ld [wCurPartySpecies], a
	and a
	call GetMenuMonIconPalette.got_shininess
	jr ProcessMenuMonIconColor

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

GetMonIconPalette::
	push af
	ld a, [wCurIcon]
	and a
	jr GetMenuMonIconPalette.got_species

GetMenuMonIconPalette::
	ld a, [wCurPartySpecies]
	cp GYARADOS
	jr nz, .not_red_gyarados

	inc hl ; Form is in the byte after Shiny
	ld a, [hl]
	dec hl
	and FORM_MASK
	cp GYARADOS_RED_FORM
	jr nz, .not_red_gyarados
	xor a ; PAL_OW_RED
	jr .done

.not_red_gyarados
; check shininess at hl
	ld a, [hl]
	and SHINY_MASK
	jr z, .not_shiny
	scf
	jr .got_shininess
.not_shiny
	and a
.got_shininess:
	push af
	ld a, [wCurPartySpecies]
.got_species:
	dec a
	ld c, a
	ld b, 0
	ld hl, MenuMonIconColors
	add hl, bc
	ld e, [hl]
	pop af
	ld a, e
	jr c, .shiny
	swap a
.shiny
	and $f
.done
	ld l, a
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
	jr c, .mail
	ld a, SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_ITEM
	jr .okay

.mail
	ld a, SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_MAIL
.okay
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ret

LoadNamingScreenMonIcon:
	push hl
	push de
	push bc

	ld hl, wTempMonIsEgg
	bit MON_IS_EGG_F, [hl]
	ld a, [wd265]
	jr z, .got_species
	ld a, EGG
.got_species
	ld [wd265], a
	ld hl, wTempMonShiny
	call SetMenuMonIconColor

	ld a, [wd265]
	ld [wCurIcon], a
	xor a
	call GetIconGFX
	depixel 4, 4, 4, 0
	ld a, SPRITE_ANIM_INDEX_PARTY_MON
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_NULL

	jp PopBCDEHL

LoadMoveMenuMonIcon:
	push hl
	push de
	push bc

	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	ld a, [wd265]
	jr z, .got_species
	ld a, EGG
.got_species
	ld [wd265], a
	ld a, MON_SHINY
	call GetPartyParamLocation
	call SetMenuMonIconColor

	ld a, [wd265]
	ld [wCurIcon], a
	xor a
	call GetIconGFX
	depixel 3, 4, 2, 4
	ld a, SPRITE_ANIM_INDEX_PARTY_MON
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_NULL

	jp PopBCDEHL

LoadTradeAnimationMonIcon:
	push hl
	push de
	push bc

	call SetMenuMonIconColor_NoShiny

	ld a, [wd265]
	ld [wCurIcon], a
	ld a, $62
	ld [wCurIconTile], a
	call GetMemIconGFX

	jp PopBCDEHL

InitPartyMenuIcon:
	ld a, [wCurIconTile]
	push af
	ldh a, [hObjectStructIndexBuffer]
	ld e, a
	ld d, 0
	ld hl, wPartyMon1IsEgg
	push de
	call GetPartyLocation
	pop de
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_icon
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
.got_icon
	ld [wCurIcon], a
	call GetMemIconGFX
	ldh a, [hObjectStructIndexBuffer]
; y coord
rept 4
	add a
endr
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

PokegearFlyMap_GetMonIcon:
; Load species icon into VRAM at tile a
	push de
	ld a, [wd265]
	ld [wCurIcon], a
	pop de
	ld a, e
	jp GetIconGFX

FlyFunction_GetMonIcon:
	push de
	ld a, [wd265]
	ld [wCurIcon], a
	pop de
	ld a, e
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

; The icons are contiguous, in order and of the same
; size, so the pointer table is somewhat redundant.
	ld a, [wCurIcon]
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	ld de, IconPointers
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de
	call GetMonIconBank
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
	jr z, .loadwithtwo
	ld a, SPRITE_ANIM_SEQ_NULL
	jr .ok

.loadwithtwo
	ld a, SPRITE_ANIM_SEQ_PARTY_MON_SWITCH

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
	jr z, .is_switchmon
	ld a, SPRITE_ANIM_SEQ_PARTY_MON_SELECTED
	jr .join_back

.is_switchmon
	ld a, SPRITE_ANIM_SEQ_PARTY_MON_SWITCH
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
