AnimateDexSearchSlowpoke:
	ld hl, .FrameIDs
	ld b, 25
.loop
	ld a, [hli]

	; Wrap around
	cp $fe
	jr nz, .ok
	ld hl, .FrameIDs
	ld a, [hli]
.ok

	ld [wDexSearchSlowpokeFrame], a
	ld a, [hli]
	ld c, a
	push bc
	push hl
	call DoDexSearchSlowpokeFrame
	pop hl
	pop bc
	call DelayFrames
	dec b
	jr nz, .loop
	xor a
	ld [wDexSearchSlowpokeFrame], a
	call DoDexSearchSlowpokeFrame
	ld c, 32
	jmp DelayFrames

.FrameIDs:
	; frame ID, duration
	db 0, 7
	db 1, 7
	db 2, 7
	db 3, 7
	db 4, 7
	db -2

DoDexSearchSlowpokeFrame:
	ld a, [wDexSearchSlowpokeFrame]
	ld hl, .SpriteData
	ld de, wVirtualOAM
.loop
	ld a, [hli]
	cp -1
	ret z
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [wDexSearchSlowpokeFrame]
	ld b, a
	add a
	add b
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	jr .loop

.SpriteData:
	dsprite 11, 0,  9, 0, $00, $0
	dsprite 11, 0, 10, 0, $01, $0
	dsprite 11, 0, 11, 0, $02, $0
	dsprite 12, 0,  9, 0, $10, $0
	dsprite 12, 0, 10, 0, $11, $0
	dsprite 12, 0, 11, 0, $12, $0
	dsprite 13, 0,  9, 0, $20, $0
	dsprite 13, 0, 10, 0, $21, $0
	dsprite 13, 0, 11, 0, $22, $0
	db -1

DisplayDexEntry:
	call GetPokemonName
	hlcoord 9, 3
	rst PlaceString ; mon species
	ld a, [wTempSpecies]
	ld b, a
	call GetDexEntryPointer
	ld a, b
	push af
	hlcoord 9, 5
	call FarString ; dex species
	ld h, b
	ld l, c
	push de
; Print dex number
	hlcoord 2, 8
	ld a, "№"
	ld [hli], a
	ld a, "."
	ld [hli], a
	ld de, wTempSpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
; Check to see if we caught it.  Get out of here if we haven't.
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	pop hl
	pop bc
	ret z
; Get the height of the Pokemon.
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	inc hl
	ld a, b
	push af
	push hl
	call GetFarWord
	ld d, l
	ld e, h
	pop hl
	inc hl
	inc hl
	ld a, d
	or e
	jr z, .skip_height
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	jr z, .imperial_height

	push hl
	ld l, d
	ld h, e
	ld bc, -100
	ld e, 0
.inchloop
	ld a, h
	and a
	jr nz, .inchloop2
	ld a, l
	cp 100
	jr c, .inchdone
.inchloop2
	add hl, bc
	inc e
	jr .inchloop
.inchdone
	ld a, e
	ld e, l
	ld d, 0
	ld hl, 0
	ld bc, 12
	rst AddNTimes
	add hl, de
	ld b, h
	ld c, l
	ld de, 0.254
	call Mul16
	ld de, hTmpd
	hlcoord 11, 7
	ln bc, 0, 2, 4, 5
	call PrintNum
	pop hl
	jr .skip_height

.imperial_height
	push hl
	push de
	ld hl, sp+$0
	ld d, h
	ld e, l
	hlcoord 12, 7
	ln bc, 0, 2, 2, 4
	call PrintNum
	hlcoord 14, 7
	ld a, "′"
	ld [hli], a
	ld a, [hl]
	cp "0"
	jr nz, .imheight_ok
	ld [hl], " "
.imheight_ok
	pop af
	pop hl

.skip_height
	pop af
	push af
	inc hl
	push hl
	dec hl
	call GetFarWord
	ld d, l
	ld e, h
	ld a, e
	or d
	jr z, .skip_weight
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	jr z, .imperial_weight

	ld c, d
	ld b, e
	ld de, 0.45359237
	call Mul16
	ld de, hTmpd
	hlcoord 11, 9
	ln bc, 0, 2, 4, 5
	call PrintNum
	jr .skip_weight

.imperial_weight
	push de
	ld hl, sp+$0
	ld d, h
	ld e, l
	hlcoord 11, 9
	ln bc, 0, 2, 4, 5
	call PrintNum
	pop de

.skip_weight
; Page 1
	lb bc, 5, SCREEN_WIDTH - 2
	hlcoord 2, 11
	call ClearBox
	hlcoord 1, 10
	ld bc, SCREEN_WIDTH - 1
	ld a, $5f ; horizontal divider
	rst ByteFill
	; page number
	hlcoord 1, 9
	ld a, $55
	ld [hli], a
	ld [hl], a
	hlcoord 1, 10
	ld a, $56 ; P.
	ld [hli], a
	ld [hl], $57 ; 1
	pop de
	inc de
	pop af
	hlcoord 2, 11
	push af
	call FarString
	pop bc
	ld a, [wPokedexStatus]
	or a
	ret z

; Page 2
	push bc
	push de
	lb bc, 5, SCREEN_WIDTH - 2
	hlcoord 2, 11
	call ClearBox
	hlcoord 1, 10
	ld bc, SCREEN_WIDTH - 1
	ld a, $5f ; horizontal divider
	rst ByteFill
	; page number
	hlcoord 1, 9
	ld a, $55
	ld [hli], a
	ld [hl], a
	hlcoord 1, 10
	ld a, $56 ; P.
	ld [hli], a
	ld [hl], $58 ; 2
	pop de
	inc de
	pop af
	hlcoord 2, 11
	jmp FarString

; Metric conversion code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/main.asm
Mul16:
	;[hTmpd][hTmpe]hl = bc * de
	xor a
	ldh [hTmpd], a
	ldh [hTmpe], a
	ld hl, 0
	ld a, 16
	ldh [hProduct], a
.loop
	add hl, hl
	ldh a, [hTmpe]
	rla
	ldh [hTmpe], a
	ldh a, [hTmpd]
	rla
	ldh [hTmpd], a
	sla e
	rl d
	jr nc, .noadd
	add hl, bc
	ldh a, [hTmpe]
	adc 0
	ldh [hTmpe], a
	ldh a, [hTmpd]
	adc 0
	ldh [hTmpd], a
.noadd
	ldh a, [hProduct]
	dec a
	ldh [hProduct], a
	jr nz, .loop
	ret

GetDexEntryPointer:
; return dex entry pointer b:de
	push hl
	ld hl, PokedexDataPointerTable
	ld a, b
	dec a
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	ret

INCLUDE "data/pokemon/dex_entry_pointers.asm"
