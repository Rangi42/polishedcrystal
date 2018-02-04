SpecialHoOhChamber: ; 0x8addb
	ld hl, PartySpecies
	ld a, [hl]
	ld [CurPartySpecies], a
	ld [CurSpecies], a
	call GetBaseData
	ld a, [BaseType1]
	cp FAIRY
	jr z, .open
	ld a, [BaseType2]
	cp FAIRY
	ret nz

.open
	call GetSecondaryMapHeaderPointer
	eventflagset EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	ret
; 0x8adef

SpecialOmanyteChamber: ; 8adef
	eventflagcheck EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	ret nz

	ld a, WATER_STONE
	ld [CurItem], a
	ld hl, NumItems
	call CheckItem
	jr c, .open

	ld a, [PartyCount]
	ld b, a
	inc b
.loop
	dec b
	ret z
	ld a, b
	dec a
	ld [CurPartyMon], a
	push bc
	ld a, MON_ITEM
	call GetPartyParamLocation
	pop bc
	ld a, [hl]
	cp WATER_STONE
	jr nz, .loop

.open
	call GetSecondaryMapHeaderPointer
	eventflagset EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	ret
; 8ae30

SpecialAerodactylChamber: ; 8ae30
	call GetSecondaryMapHeaderPointer
	ld a, h
	cp RuinsofAlphAerodactylChamber_SecondMapHeader / $100
	jr nz, .nope
	ld a, l
	cp RuinsofAlphAerodactylChamber_SecondMapHeader % $100
	jr nz, .nope

	eventflagset EVENT_WALL_OPENED_IN_AERODACTYL_CHAMBER
	scf
	ret

.nope
	and a
	ret
; 8ae4e

SpecialKabutoChamber: ; 8ae4e
	call GetSecondaryMapHeaderPointer
	ld a, h
	cp RuinsofAlphKabutoChamber_SecondMapHeader / $100
	ret nz
	ld a, l
	cp RuinsofAlphKabutoChamber_SecondMapHeader % $100
	ret nz

	eventflagset EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	ret
; 8ae68

Special_DisplayUnownWords: ; 8ae68
	ld a, [ScriptVar]
	ld hl, UnownWallMenuDataHeaders
	and a
	jr z, .load

	lb de, $0, $5
.loop
	add hl, de
	dec a
	jr nz, .loop

.load
	call LoadMenuDataHeader
	xor a
	ld [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call ApplyTilemap
	call MenuBoxCoord2Tile
	inc hl
	ld de, $14
	add hl, de
	add hl, de
	ld a, [ScriptVar]
	ld c, a
	ld de, UnownWallWords
	and a
	jr z, .copy
.loop2
	ld a, [de]
	inc de
	cp $ff
	jr nz, .loop2
	dec c
	jr nz, .loop2

.copy
	call .CopyWord
	ld bc, AttrMap - TileMap
	add hl, bc
	call .FillAttr
	call WaitBGMap2
	call JoyWaitAorB
	call PlayClickSFX
	jp CloseWindow
; 8aebc

.FillAttr: ; 8aee9
	ld a, [de]
	cp $ff
	ret z
	ld a, TILE_BANK | PAL_BG_BROWN
	call .PlaceSquare
	inc hl
	inc hl
	inc de
	jr .FillAttr
; 8aefd

.PlaceSquare: ; 8aefd
	push hl
	ld [hli], a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	ld [hl], a
	pop hl
	ret
; 8af09

.CopyWord: ; 8af09
	push hl
	push de
.word_loop
	ld a, [de]
	cp $ff
	jr z, .word_done
	ld c, a
	call .ConvertChar
	inc hl
	inc hl
	inc de
	jr .word_loop

.word_done
	pop de
	pop hl
	ret
; 8af1c

.ConvertChar: ; 8af1c
	push hl
	ld a, c
	ld [hli], a
	inc a
	ld [hld], a
	dec a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld c, $10
	add c
	ld [hli], a
	inc a
	ld [hl], a
	pop hl
	ret
; 8af6b

INCLUDE "data/events/unown_walls.asm"
