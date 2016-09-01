SECTION "bank46", ROMX, BANK[$46]

Function11805e: ; 11805e (46:405e)
	ret
; 11805f

Function118121: ; 118121
	xor a
	ld [wcd38], a
	call Function1183cb
	ld a, $3
	ld [wcd33], a
	ld a, $d
	ld [wcd34], a
	ld a, $4
	ld [wc3f0], a
	ld a, [rSVBK]
	push af
	ld a, $3
	ld [rSVBK], a
.loop
	call JoyTextDelay
	call Function118473
	ld a, [wcf66]
	cp $f
	jr c, .skip
	ld a, [wcd34]
	ld [wcf66], a
.skip
	call Function11854d
	call Function11a8fa
	callba Function115dd3
	callba Function11619d
	call DelayFrame
	ld a, [wcf66]
	ld hl, wcd33
	cp [hl]
	jr nz, .loop
	xor a
	ld [w3_d000], a
	pop af
	ld [rSVBK], a
	call Function118452
	call Function118180
	call ReturnToMapFromSubmenu
	ret
; 118180

Function118180: ; 118180
	ld a, [ScriptVar]
	and a
	ret nz
	ld a, [wcd38]
	and a
	ret z
	ld a, $5
	call GetSRAMBank
	ld hl, wcd69
	ld de, $a89c
	ld bc, $0016
	call CopyBytes

	ld a, [rSVBK]
	push af
	ld a, $3
	ld [rSVBK], a

	ld hl, w3_d202
	ld de, $a8b2
	ld bc, $0096
	call CopyBytes
	pop af
	ld [rSVBK], a
	call CloseSRAM
	ret
; 1181da

Function1183cb: ; 1183cb
	di
	ld a, [rIE]
	ld [wcd32], a
	call DoubleSpeed
	xor a
	ld [rIF], a
	ld [wc300], a
	ld [wc301], a
	ld [wc302], a
	ld [wcd80], a
	ld [wcd65], a
	ld [wcd66], a
	ld [wcd67], a
	ld [wcd68], a
	ld [$c31a], a
	ld [wcd89], a
	ld [wcd8a], a
	ld [wcd8b], a
	ld [wc3ec], a
	ld [wc3ed], a
	ld [wc3ee], a
	ld [wc3ef], a
	ld hl, VramState
	ld a, [hl]
	ld [wcd7f], a
	set 1, [hl]
	ld a, $f
	ld [rIE], a
	ld a, $1
	ld [hMobileReceive], a
	ld [hMobile], a
	ei
	callba Function115d99
	callba Function11615a
	ld a, $5
	call GetSRAMBank
	xor a
	ld [$bfff], a
	call CloseSRAM
	ret
; 118440

Function118452: ; 118452
	di
	xor a
	ld [hMobileReceive], a
	ld [hMobile], a
	ld [hVBlank], a
	call NormalSpeed
	xor a
	ld [rIF], a
	ld a, [wcd32]
	ld [rIE], a
	ei
	ld a, [wcd7f]
	ld [VramState], a
	ld a, [wc300]
	ld [ScriptVar], a
	ret
; 118473

Function118473: ; 118473
	ld a, [wcd65]
	and a
	ret z
	ld a, [wcd66]
	inc a
	ld [wcd66], a
	cp 60
	ret nz
	xor a
	ld [wcd66], a
	ld a, [wcd67]
	inc a
	ld [wcd67], a
	cp 60
	ret nz
	ld a, [wcd68]
	inc a
	ld [wcd68], a
	cp 99
	jr z, .ninety_nine
	xor a
	ld [wcd67], a
	ret

.ninety_nine
	xor a
	ld [wcd65], a
	ret
; 1184a5

Function11854d: ; 11854d
	jumptable .Jumptable, wcf66
; 11855c

.Jumptable: ; 11855c
	dw Function118922
	dw Function118936
	dw Function118982
	dw Function11805e
	dw Function119ca2
	dw Function119cab
	dw Function119cb8
	dw Function119cc3
	dw Function119cdf
	dw Function119cec
	dw Function119c97
	dw Function119cab
	dw Function119cb8
	dw Function118e76
	dw Function118e87
	dw Function118e76
; 11857c

Function118805: ; 118805 (46:4805)
	ld [wc300], a
	xor a
	ld [wc301], a
	ld [wc302], a
	ld a, $a
	call Function3e32
	ld a, [wc3f0]
	ld [$c319], a
	ld a, [wcd34]
	ld [wcf66], a
	ret

Function118922: ; 118922
	ld hl, Text_WhatLevelDoYouWantToChallenge
	call Function11a9c0
	call Function119e2e

Function118936:
	ld a, [$c31a]
	and a
	ret nz
	ld hl, MenuDataHeader_119cf7
	call LoadMenuDataHeader
	call MenuBox
	call MenuBoxCoord2Tile
	call ApplyTilemap
	hlcoord 16, 8, AttrMap
	ld a, $40
	or [hl]
	ld [hl], a
	call WaitBGMap2
	ld a, $1
	ld [wcd4f], a
	ld a, $1
	ld [rSVBK], a
	ld a, [StatusFlags]
	bit 6, a ; Hall Of Fame
	jr nz, .asm_11896b
	ld hl, Strings_Ll0ToL40		; Address to list of strings with the choosable levels
	ld a, 5						; 4 levels to choose from, including 'Cancel'-option
	jr .asm_118970

.asm_11896b
	ld hl, Strings_L10ToL100	; Address to list of strings with the choosable levels
	ld a, 11					; 10 levels to choose from, including 'Cancel'-option

.asm_118970
	ld [wcd4a], a
	ld a, l
	ld [wcd4b], a
	ld a, h
	ld [wcd4c], a
	ld a, $3
	ld [rSVBK], a
	call Function119e2e

Function118982:
	hlcoord 13, 8
	ld de, String_119d07
	call PlaceString
	hlcoord 13, 10
	ld de, String_119d07
	call PlaceString
	ld a, [wcd4b]
	ld l, a
	ld a, [wcd4c]
	ld h, a
	ld d, $0
	ld a, [wcd4f]
	dec a
	rlca
	rlca
	rlca
	ld e, a
	add hl, de
	ld a, l
	ld e, a
	ld a, h
	ld d, a
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	ld bc, StringBuffer3
.asm_1189b5
	ld a, [hli]
	cp $50
	jr z, .asm_1189c4
	cp $7f
	jr z, .asm_1189c2
	ld [bc], a
	inc bc
	jr .asm_1189b5

.asm_1189c2
	ld a, $50

.asm_1189c4
	ld [bc], a
	pop af
	ld [rSVBK], a
	hlcoord 13, 9
	call PlaceString
	ld hl, hJoyPressed
	ld a, [hl]
	and $2
	jr nz, .asm_118a39
	ld a, [hl]
	and $1
	jr nz, .asm_118a01
	ld a, [hl]
	and $80
	jr nz, .asm_1189e6
	ld a, [hl]
	and $40
	jr nz, .asm_1189f2
.asm_1189e5
	ret

.asm_1189e6
	ld hl, wcd4f
	dec [hl]
	jr nz, .asm_1189e5
	ld a, [wcd4a]
	ld [hl], a
	jr .asm_1189e5

.asm_1189f2
	ld a, [wcd4a]
	ld hl, wcd4f
	inc [hl]
	cp [hl]
	jr nc, .asm_1189e5
	ld a, $1
	ld [hl], a
	jr .asm_1189e5

.asm_118a01
	call PlayClickSFX
	ld a, [wcd4f]
	ld hl, wcd4a
	cp [hl]
	jr z, .asm_118a3c
	dec a
	and $fe
	srl a
	ld [wcf65], a
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	call CloseWindow
	pop af
	ld [rSVBK], a
	ld a, [wcd38]
	and a
	jr nz, .asm_118a30
	call Function119d93
	ret c
	call Function119dd1
	ret c

.asm_118a30
	ld a, [wcd4f]
	ld [w3_d800], a
	jp Function119e2e

.asm_118a39
	call PlayClickSFX

.asm_118a3c
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	call CloseWindow
	pop af
	ld [rSVBK], a
	ld a, $7
	ld [wcf66], a
	ld a, $0
	ld [wcd46], a
	ret


	charmap " ", $20 ; revert to ascii

Function118e76: ; 118e76 (46:4e76)
	ld a, $c
	ld [wcd3c], a
	jp Function119e2e

Function118e87: ; 118e87 (46:4e87)
	ret
; 118e92 (46:4e92)

Function119471: ; 119471 (46:5471)
	push af
	ld a, [hli]
	ld [$c608], a
	ld a, [hli]
	ld [$c608 + 3], a
	ld a, [hli]
	ld [$c608 + 1], a
	ld a, [hli]
	ld [$c608 + 2], a
	ld a, [hli]
	ld [$c608 + 4], a
	ld a, [hli]
	ld [$c608 + 5], a ; $c608 + 5
	push hl
	ld a, [$c608]
	cp $ff
	jr z, .asm_1194a7
	ld a, [$c608 + 2]
	cp $ff
	jr z, .asm_1194a7
	ld a, [$c608 + 1]
	cp $ff
	jr nz, .asm_1194a7
	call Function119584
	jr c, .asm_11950c
	jr .asm_1194f0
.asm_1194a7
	ld hl, $c608
	ld de, $c608 + 3
	ld c, $3
.asm_1194af
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr c, .asm_1194f3
	jr z, .asm_1194b9
	jr nc, .asm_1194bc
.asm_1194b9
	dec c
	jr nz, .asm_1194af
.asm_1194bc
	ld c, $3
	ld hl, wcd49
	ld de, $c608
.asm_1194c4
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1194d1
	cp [hl]
	jr z, .asm_1194d1
	jr c, .asm_1194d5
	jr nc, .asm_1194f0
.asm_1194d1
	inc hl
	dec c
	jr nz, .asm_1194c4
.asm_1194d5
	ld c, $3
	ld hl, wcd49
	ld de, $c608 + 3
.asm_1194dd
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_1194ea
	cp [hl]
	jr c, .asm_1194f0
	jr z, .asm_1194ea
	jr nc, .asm_11950c
.asm_1194ea
	inc hl
	dec c
	jr nz, .asm_1194dd
	jr .asm_11950c
.asm_1194f0
	pop hl
	jr .asm_119557
.asm_1194f3
	ld c, $3
	ld hl, wcd49
	ld de, $c608
.asm_1194fb
	ld a, [de]
	inc de
	cp $ff
	jr z, .asm_119508
	cp [hl]
	jr c, .asm_11950c
	jr z, .asm_119508
	jr nc, .asm_1194d5
.asm_119508
	inc hl
	dec c
	jr nz, .asm_1194fb
.asm_11950c
	pop hl
	ld a, $1
	ld [wcd50], a
	ld a, l
	ld [$c608], a
	ld a, h
	ld [$c608 + 1], a
	ld de, wcd69
	ld c, $10
	ld b, $0
.asm_119521
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	jr nz, .asm_119528
	inc b
.asm_119528
	dec c
	jr nz, .asm_119521
	ld a, $10
	cp b
	jr z, .asm_119536
rept 4
	inc hl
endr
	jr .asm_11957a
.asm_119536
	ld a, [hli]
	cp $50
	jr nz, .asm_119552
	ld a, [hli]
	cp $33
	jr nz, .asm_119553
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [wcd83]
	cp c
	jr nz, .asm_119576
	ld a, [wcd84]
	cp b
	jr nz, .asm_119576
	jr .asm_11955b
.asm_119552
	inc hl
.asm_119553
	inc hl
	inc hl
	jr .asm_11955b
.asm_119557
	ld de, $14
	add hl, de
.asm_11955b
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	add hl, de
	pop af
	dec a
	jp nz, Function119471
	ld a, [wcd50]
	and a
	jr z, .asm_119571
	ld a, $1a
	ld [wcf66], a
	ret
.asm_119571
	ld a, $d8
	jp Function118805
.asm_119576
	ld a, $10
	jr .asm_11957c
.asm_11957a
	ld a, $f
.asm_11957c
	ld [wcf66], a
	pop af
	call Function1195c4
	ret

Function119584: ; 119584 (46:5584)
	ld a, [$c608]
	ld b, a
	ld a, [$c608 + 3]
	ld c, a
	cp b
	jr c, .asm_11959c
	ld a, [wcd49]
	cp b
	jr c, .asm_1195c2
.asm_119595
	cp c
	jr c, .asm_1195a2
	jr z, .asm_1195a2
	jr .asm_1195c2
.asm_11959c
	ld a, [wcd49]
	cp b
	jr c, .asm_119595
.asm_1195a2
	ld a, [$c608 + 2]
	ld b, a
	ld a, [$c608 + 5] ; $c608 + 5
	ld c, a
	cp b
	jr c, .asm_1195ba
	ld a, [wcd4b]
	cp b
	jr c, .asm_1195c2
.asm_1195b3
	cp c
	jr c, .asm_1195c0
	jr z, .asm_1195c0
	jr .asm_1195c2
.asm_1195ba
	ld a, [wcd4b]
	cp b
	jr c, .asm_1195b3
.asm_1195c0
	scf
	ret
.asm_1195c2
	and a
	ret

Function1195c4: ; 1195c4 (46:55c4)
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld de, $a5
	ld a, b
	cp d
	jr c, .asm_1195d9
	jr z, .asm_1195d3
	jr nc, .asm_1195f3
.asm_1195d3
	ld a, c
	cp e
	jr z, .asm_1195d9
	jr nc, .asm_1195f3
.asm_1195d9
	ld de, wcc60
	call CopyBytes
	xor a
	ld [de], a
	ld a, [$c608]
	ld l, a
	ld a, [$c608 + 1]
	ld h, a
	ld de, wcd69
	ld bc, $10
	call CopyBytes
	ret
.asm_1195f3
	ld a, $d8
	jp Function118805

SECTION "bank46_2", ROMX, BANK[$46]
; A hack to use ascii above.

Function119c97: ; 119c97
	ld hl, Text_UberRestriction
	call Function11a9c0
	call Function119e2e
	jr Function119cab

Function119ca2:
	ld hl, Text_PartyMonTopsThisLevel
	call Function11a9c0
	call Function119e2e

Function119cab:
	ld a, [$c31a]
	and a
	ret nz
	ld a, $80
	ld [wcd50], a
	call Function119e2e

Function119cb8:
	ld hl, wcd50
	dec [hl]
	ret nz
	ld a, $0
	ld [wcf66], a
	ret
; 119cc3

Function119cc3: ; 119cc3
	ld hl, Text_CancelBattleRoomChallenge
	call Function11a9c0
	call Function119e2e

Function119cdf:
	ld a, [$c31a]
	and a
	ret nz
	ld a, $f
	ld [wcd3c], a
	call Function119e2e

Function119cec:
	call Function119ed8
	ret c
	ld a, [wcd46]
	ld [wcf66], a
	ret
; 119cf7

MenuDataHeader_119cf7: ; 119cf7
	db $40 ; flags
	db  7, 12 ; start coords
	db 11, 19 ; end coords
	dw NULL
	db 0 ; default option
; 119cff

String_119d07:
	db "   ▼@"

Strings_L10ToL100: ; 119d0c
	db "  <LV>10 @@"
	db "  <LV>20 @@"
	db "  <LV>30 @@"
	db "  <LV>40 @@"
	db "  <LV>50 @@"
	db "  <LV>60 @@"
	db "  <LV>70 @@"
	db "  <LV>80 @@"
	db "  <LV>90 @@"
	db "  <LV>100@@"
	db "Cancel@@"

Strings_Ll0ToL40: ; 119d64
	db "  <LV>10 @@"
	db "  <LV>20 @@"
	db "  <LV>30 @@"
	db "  <LV>40 @@"
	db "Cancel@@"

Function119d93: ; 119d93 (46:5d93)
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	ld a, [wcd4f]
	ld c, 10
	call SimpleMultiply
	ld hl, wcd50
	ld [hl], a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, PartyMon1Level
	ld a, [PartyCount]
.party_loop
	push af
	ld a, [de]
	push hl
	push de
	pop hl
	add hl, bc
	push hl
	pop de
	pop hl
	cp [hl]
	jr z, .equal
	jr nc, .exceeds
.equal
	pop af
	dec a
	jr nz, .party_loop
	pop af
	ld [rSVBK], a
	and a
	ret

.exceeds
	pop af
	ld a, $4
	ld [wcf66], a
	pop af
	ld [rSVBK], a
	scf
	ret

Function119dd1: ; 119dd1 (46:5dd1)
	ld a, [rSVBK]
	push af
	ld a, [wcd4f]
	cp 70 / 10
	jr nc, .level_70_or_more
	ld a, $1
	ld [rSVBK], a
	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, PartySpecies
	ld a, [PartyCount]
.loop
	push af
	ld a, [de]
	cp MEWTWO
	jr z, .uber
	cp MEW
	jr z, .uber
	cp LUGIA
	jr c, .next
	cp NUM_POKEMON + 1
	jr nc, .next
.uber
	ld a, [hl]
	cp 70
	jr c, .uber_under_70
.next
	add hl, bc
	inc de
	pop af
	dec a
	jr nz, .loop
.level_70_or_more
	pop af
	ld [rSVBK], a
	and a
	ret

.uber_under_70
	pop af
	ld a, [de]
	ld [wd265], a
	call GetPokemonName
	ld hl, StringBuffer1
	ld de, wcd49
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes
	ld a, $a
	ld [wcf66], a
	pop af
	ld [rSVBK], a
	scf
	ret
; 119e2b (46:5e2b)

Function119e2e: ; 119e2e (46:5e2e)
	ld hl, wcf66
	inc [hl]
	ret
; 119e33 (46:5e33)

Function119ed8: ; 119ed8 (46:5ed8)
	ld a, [rSVBK]
	ld [wcd8c], a
	ld a, $1
	ld [rSVBK], a

	call .RunJumptable

	ld a, [wcd8c]
	ld [rSVBK], a
	ld a, $1
	ld [hBGMapMode], a
	ret

.RunJumptable:
	jumptable .Jumptable, wcd3c

.Jumptable:
	dw Function119f3f
	dw Function119f45
	dw Function119f56
	dw Function119f76
	dw Function11a970
	dw Function11a113
	dw Function11a129
	dw Function11a131
	dw Function11a13d
	dw Function11a14b
	dw Function11a16d
	dw Function11a192
	dw Function11a2e6
	dw Function11a302
	dw Function11a33a
	dw Function11a207
	dw Function11a235
	dw Function11a357
	dw Function11a36b
	dw Function11a38d
	dw Function11a3c5
	dw Function11a3d9
	dw Function11a3f9
	dw Function11a41b
	dw Function11a452
	dw Function11a47a
	dw Function11a488
	dw Function11a49e
	dw Function11a4db
	dw Function11a4e8
	dw Function11a4fe
	dw Function11a466
	dw Function11a47a
; 119f3f

Function119f3f: ; 119f3f
	call Function11a5b9
	jp Function11a5b0
; 119f45

Function119f45: ; 119f45
	hlcoord 4, 2
	ld de, String_11a661
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 119f56

Function119f56: ; 119f56
	ld a, [wcd44]
	and a
	jr z, .asm_119f62
	dec a
	ld [wcd44], a
	scf
	ret

.asm_119f62
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6aa
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 119f76

Function119f76: ; 119f76
	ld a, [wcd44]
	and a
	jr z, .asm_119f82
	dec a
	ld [wcd44], a
	scf
	ret

.asm_119f82
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a679
	call PlaceString
	call Function11a5f5
	xor a
	ld [wcd44], a
	jp Function11a5b0
; 119f98

Function11a113: ; 11a113
	call Function11a63c
	ld c, $1
	callba Function115e18
	hlcoord 4, 2
	ld de, String_11a6c8
	call PlaceString
	and a
	ret
; 11a129

Function11a129: ; 11a129
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a131

Function11a131: ; 11a131
	ld hl, wcd44
	dec [hl]
	ret nz
	ld a, [wcd3c]
	inc a
	ld [wcd3c], a

Function11a13d:
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret
; 11a14b

Function11a14b: ; 11a14b
	ld hl, wcd85
	ld a, [hl]
	cp $f3
	jr nz, .asm_11a155
	and a
	ret

.asm_11a155
	call Function11a1d6
	ret c
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6f1
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a16d

Function11a16d: ; 11a16d
	ld a, [wcd44]
	and a
	jr z, .asm_11a179
	dec a
	ld [wcd44], a
	scf
	ret

.asm_11a179
	call Function11a63c
	call Function11a1e6
	hlcoord 4, 2
	ld de, $c346
	call PlaceString
	call Function11a5f5
	xor a
	ld [wcd44], a
	jp Function11a5b0
; 11a192

Function11a192: ; 11a192
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wcd44]
	and a
	jr nz, .asm_11a1b6
	call ExitMenu
	callba ReloadMapPart
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

.asm_11a1b6
	call ExitMenu
	callba ReloadMapPart
	ld a, [wcd45]
	ld [wcf66], a
	ld [wcd80], a
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	scf
	ret
; 11a1d6

Function11a1d6: ; 11a1d6
	ld a, [wcd85]
	cp $50
	jr nz, .asm_11a1e4
	ld a, $d3
	call Function118805
	scf
	ret

.asm_11a1e4
	and a
	ret
; 11a1e6

Function11a1e6: ; 11a1e6
	ld hl, String_11a706
	ld de, $c346
	call Function11a1ff
	ld hl, wcd85
	call Function11a1ff
	ld hl, String_11a70b
	call Function11a1ff
	ld a, $50
	ld [de], a
	ret
; 11a1ff

Function11a1ff: ; 11a1ff
.asm_11a1ff
	ld a, [hli]
	cp $50
	ret z
	ld [de], a
	inc de
	jr .asm_11a1ff
; 11a207

Function11a207: ; 11a207
	ld hl, MenuDataHeader_11a2de
	call LoadMenuDataHeader
	call MenuBox
	call MenuBoxCoord2Tile
	call ApplyTilemap
	hlcoord 16, 8
	ld de, String_11a2cf
	call PlaceString
	hlcoord 16, 10
	ld de, String_11a2d3
	call PlaceString
	hlcoord 15, 8
	ld a, $ed
	ld [hl], a
	xor a
	ld [wcd44], a
	jp Function11a5b0
; 11a235

Function11a235: ; 11a235
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON
	jr nz, .asm_11a28f
	ld a, [hl]
	and B_BUTTON
	jr nz, .asm_11a2c1
	ld a, [hl]
	and D_UP
	jr nz, .asm_11a251
	ld a, [hl]
	and D_DOWN
	jr nz, .asm_11a270
.asm_11a24c
	call Function11a9f0
	scf
	ret

.asm_11a251
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	ld a, [wcd44]
	and a
	jr z, .asm_11a24c
	xor a
	ld [wcd44], a
	hlcoord 15, 8
	ld a, $ed
	ld [hl], a
	hlcoord 15, 10
	ld a, $7f
	ld [hl], a
	jr .asm_11a24c

.asm_11a270
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	ld a, [wcd44]
	and a
	jr nz, .asm_11a24c
	inc a
	ld [wcd44], a
	hlcoord 15, 8
	ld a, $7f
	ld [hl], a
	hlcoord 15, 10
	ld a, $ed
	ld [hl], a
	jr .asm_11a24c

.asm_11a28f
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	call PlayClickSFX
	ld a, [wcd44]
	and a
	jr nz, .asm_11a2c4
	call ExitMenu
	callba ReloadMapPart
	ld a, [wcd46]
	cp $0
	jr z, .asm_11a2b4
	ld a, [wcd47]
	jr .asm_11a2b7

.asm_11a2b4
	ld a, [wcd33]

.asm_11a2b7
	ld [wcf66], a
	ld a, $a
	ld [wc300], a
	scf
	ret

.asm_11a2c1
	call PlayClickSFX

.asm_11a2c4
	call ExitMenu
	callba ReloadMapPart
	and a
	ret
; 11a2cf

String_11a2cf: ; 11a2cf
	db "Yes@"
; 11a2d3

String_11a2d3: ; 11a2d3
	db "No@"
; 11a2d6

MenuDataHeader_11a2de: ; 11a2de
	db $40 ; flags
	db  7, 14 ; start coords
	db 11, 19 ; end coords
	dw NULL
	db 0 ; default option
; 11a2e6

Function11a2e6: ; 11a2e6
	call Function11a63c
	ld c, $2
	callba Function115e18
	hlcoord 4, 2
	ld de, String_11a71e
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a302

Function11a302: ; 11a302
	ld a, [wcd44]
	and a
	jr z, .asm_11a30e
	dec a
	ld [wcd44], a
	scf
	ret

.asm_11a30e
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a72a
	call PlaceString
	hlcoord 9, 4
	ld de, wcd68
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	hlcoord 14, 4
	ld de, wcd67
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a33a

Function11a33a: ; 11a33a
	ld a, [wcd44]
	and a
	jr z, .asm_11a346
	dec a
	ld [wcd44], a
	scf
	ret

.asm_11a346
	call ExitMenu
	callba ReloadMapPart
	callba Function115dc3
	and a
	ret
; 11a357

Function11a357: ; 11a357
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a743
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a36b

Function11a36b: ; 11a36b
	ld a, [wcd44]
	and a
	jr z, .asm_11a377
	dec a
	ld [wcd44], a
	scf
	ret

.asm_11a377
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a755
	call PlaceString
	call Function11a5f5
	xor a
	ld [wcd44], a
	jp Function11a5b0
; 11a38d

Function11a38d: ; 11a38d
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wcd44]
	and a
	jr nz, .asm_11a3b1
	call ExitMenu
	callba ReloadMapPart
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

.asm_11a3b1
	call ExitMenu
	callba ReloadMapPart
	ld a, [wcd45]
	ld [wcf66], a
	ld [wcd80], a
	scf
	ret
; 11a3c5

Function11a3c5: ; 11a3c5
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a762
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a3d9

Function11a3d9: ; 11a3d9
	ld a, [wcd44]
	and a
	jr z, .asm_11a3e5
	dec a
	ld [wcd44], a
	scf
	ret

.asm_11a3e5
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a779
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a3f9

Function11a3f9: ; 11a3f9
	ld a, [wcd44]
	and a
	jr z, .asm_11a405
	dec a
	ld [wcd44], a
	scf
	ret

.asm_11a405
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a755
	call PlaceString
	call Function11a5f5
	xor a
	ld [wcd44], a
	jp Function11a5b0
; 11a41b

Function11a41b: ; 11a41b
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wcd44]
	and a
	jr nz, .asm_11a43f
	call ExitMenu
	callba ReloadMapPart
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

.asm_11a43f
	call ExitMenu
	callba ReloadMapPart
	ld a, $1c
	ld [wcf66], a
	ld [wcd80], a
	scf
	ret
; 11a452

Function11a452: ; 11a452
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a791
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a466

Function11a466: ; 11a466
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a7c1
	call PlaceString
	ld a, $80
	ld [wcd44], a
	jp Function11a5b0
; 11a47a

Function11a47a: ; 11a47a
	ld a, [wcd44]
	and a
	jr z, .asm_11a486
	dec a
	ld [wcd44], a
	scf
	ret

.asm_11a486
	and a
	ret
; 11a488

Function11a488: ; 11a488
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a7ac
	call PlaceString
	call Function11a5f5
	xor a
	ld [wcd44], a
	jp Function11a5b0
; 11a49e

Function11a49e: ; 11a49e
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wcd44]
	and a
	jr nz, .asm_11a4c7
	call ExitMenu
	callba ReloadMapPart
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	ld a, $14
	ld [wcf66], a
	and a
	ret

.asm_11a4c7
	call ExitMenu
	callba ReloadMapPart
	ld a, [wcd46]
	ld [wcf66], a
	ld [wcd80], a
	scf
	ret
; 11a4db

Function11a4db: ; 11a4db
	call Function11a63c
	ld de, String_11a6db
	hlcoord 4, 2
	call PlaceString
	ret
; 11a4e8

Function11a4e8: ; 11a4e8
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a7d7
	call PlaceString
	call Function11a5f5
	xor a
	ld [wcd44], a
	jp Function11a5b0
; 11a4fe

Function11a4fe: ; 11a4fe
	call Function11a536
	ret c
	call PlayClickSFX
	ld a, [wcd44]
	and a
	jr nz, .asm_11a522
	call ExitMenu
	callba ReloadMapPart
	call Function11a63c
	hlcoord 4, 2
	ld de, String_11a6d2
	call PlaceString
	and a
	ret

.asm_11a522
	call ExitMenu
	callba ReloadMapPart
	ld a, [wcd45]
	ld [wcf66], a
	ld [wcd80], a
	scf
	ret
; 11a536

Function11a536: ; 11a536
	ld hl, hJoyPressed
	ld a, [hl]
	and $1
	jr nz, .asm_11a5a7
	ld a, [hl]
	and $2
	jr nz, .asm_11a5a2
	ld a, [hl]
	and $40
	jr nz, .asm_11a564
	ld a, [hl]
	and $80
	jr nz, .asm_11a583
.asm_11a54d
	ld a, [wcd3c]
	cp $4
	jr z, .asm_11a562
	call Function11a9f0
	jr nz, .asm_11a562
	call ExitMenu
	callba ReloadMapPart

.asm_11a562
	scf
	ret

.asm_11a564
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	ld a, [wcd44]
	and a
	jr z, .asm_11a54d
	xor a
	ld [wcd44], a
	hlcoord 15, 7
	ld a, $ed
	ld [hl], a
	hlcoord 15, 9
	ld a, $7f
	ld [hl], a
	jr .asm_11a54d

.asm_11a583
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	ld a, [wcd44]
	and a
	jr nz, .asm_11a54d
	inc a
	ld [wcd44], a
	hlcoord 15, 7
	ld a, $7f
	ld [hl], a
	hlcoord 15, 9
	ld a, $ed
	ld [hl], a
	jr .asm_11a54d

.asm_11a5a2
	ld a, $1
	ld [wcd44], a

.asm_11a5a7
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	and a
	ret
; 11a5b0

Function11a5b0: ; 11a5b0
	ld a, [wcd3c]
	inc a
	ld [wcd3c], a
	scf
	ret
; 11a5b9

Function11a5b9: ; 11a5b9
	xor a
	ld [wMenuBorderLeftCoord], a
	ld [wMenuBorderTopCoord], a
	ld a, $13
	ld [wMenuBorderRightCoord], a
	ld a, $5
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	hlcoord 0, 0, AttrMap
	ld b, $6
	ld c, $14
	hlcoord 0, 0
	ld b, $4
	ld c, $12
	call Function3eea
	callba ReloadMapPart
	call UpdateSprites
	ld c, $0
	callba Function115e18
	ld a, $1
	ld [wc305], a
	ret
; 11a5f5

Function11a5f5: ; 11a5f5
	ld a, $e
	ld [wMenuBorderLeftCoord], a
	ld a, $13
	ld [wMenuBorderRightCoord], a
	ld a, $6
	ld [wMenuBorderTopCoord], a
	ld a, $a
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	hlcoord 14, 6, AttrMap
	ld b, $5
	ld c, $6
	hlcoord 14, 6
	ld b, $3
	ld c, $4
	call Function3eea
	hlcoord 16, 7
	ld de, String_11a2cf
	call PlaceString
	hlcoord 16, 9
	ld de, String_11a2d3
	call PlaceString
	hlcoord 15, 7
	ld a, $ed
	ld [hl], a
	callba ReloadMapPart
	ret
; 11a63c

Function11a63c: ; 11a63c
	hlcoord 4, 1
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 2
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 3
	ld de, String_11a7f4
	call PlaceString
	hlcoord 4, 4
	ld de, String_11a7f4
	call PlaceString
	ret
; 11a661

String_11a661: ; 11a661
	db   "これから モバイルセンターに"
	next "でんわ", $1f, "かけます@"
; 11a679

String_11a679: ; 11a679
	db   "モバイルアダプタ", $25, "じゅんびは"
	next "できて いますか?@"
; 11a692

String_11a6aa: ; 11a6aa
	db   "でんわをかけると つうわりょう"
	next "せつぞくりょう", $4a, "かかります@"
; 11a6c8

String_11a6c8: ; 11a6c8
	db   "せつぞく しました@"
; 11a6d2

String_11a6d2: ; 11a6d2
	db   "つうしん ちゅう@"
; 11a6db

String_11a6db: ; 11a6db
	db   "つうしん ちゅう"
	next "セレクト エーでちゅうし@"
; 11a6f1

String_11a6f1: ; 11a6f1
	db   "この サービスには"
	next "つうわりょう", $25, "ほかに@"
; 11a706

String_11a706: ; 11a706
	db   "おかね", $4a, "@"
; 11a70b

String_11a70b: ; 11a70b
	db   "えん"
	next "かかります よろしい ですか?@"
; 11a71e

String_11a71e: ; 11a71e
	db   "つうしん しゅうりょう@"
; 11a72a

String_11a72a: ; 11a72a
	db   "つないだ じかん"
	next "  やく   ふん   びょう@"
; 11a743

String_11a743: ; 11a743
	db   "もっていない データが"
	next "あります!@"
; 11a755

String_11a755: ; 11a755
	db   "データ", $1f, "よみこみますか?@"
; 11a762

String_11a762: ; 11a762
	db   "おなじ データ", $1f, "よみこんだ"
	next "こと", $4a, "ありますが@"
; 11a779

String_11a779: ; 11a779
	db   "そのデータ", $24, "なくなっているか"
	next "こわれて います@"
; 11a791

String_11a791: ; 11a791
	db   "もっている データと"
	next "おなじデータしか ありません!@"
; 11a7ac

String_11a7ac: ; 11a7ac
	db   "データ", $25, "よみこみを"
	next "ちゅうし しますか?@"
; 11a7c1

String_11a7c1: ; 11a7c1
	db   "あたらしい ニュースは"
	next "ありません でした@"
; 11a7d7

String_11a7d7: ; 11a7d7
	db   "あたらしいニュース", $4a, "あります"
	next "ニュース", $1f, "よみこみますか?@"
; 11a7f4

String_11a7f4: ; 11a7f4
	db   "               @"
; 11a804

Function11a8fa: ; 11a8fa
	jumptable .Jumptable, $c31a
; 11a909

.Jumptable: ; 11a909
	dw Function11a970
	dw Function11a90f
	dw Function11a971
; 11a90f

Function11a90f: ; 11a90f
	ld a, $1
	ld [rSVBK], a
	call SpeechTextBox
	ld a, $50
	ld hl, $c320
	ld bc, $008c
	call ByteFill
	ld a, [$c31b]
	ld l, a
	ld a, [$c31c]
	ld h, a
	ld de, $c320
.asm_11a92c
	ld a, [hli]
	cp $57
	jr z, .asm_11a94f
	cp $0
	jr z, .asm_11a92c
	cp $50
	jr z, .asm_11a92c
	cp $1
	jr z, .asm_11a941
	ld [de], a
	inc de
	jr .asm_11a92c

.asm_11a941
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
.asm_11a945
	ld a, [bc]
	inc bc
	cp $50
	jr z, .asm_11a92c
	ld [de], a
	inc de
	jr .asm_11a945

.asm_11a94f
	xor a
	ld [$c31f], a
	ld a, $c320 % $100
	ld [$c31b], a
	ld a, $c320 / $100
	ld [$c31c], a
	hlcoord 1, 14
	ld a, l
	ld [$c31d], a
	ld a, h
	ld [$c31e], a
	ld hl, $c31a
	inc [hl]
	ld a, $3
	ld [rSVBK], a

Function11a970:
	ret
; 11a971

Function11a971: ; 11a971
	ld hl, $c31f
	ld a, [hJoyDown]
	and a
	jr nz, .asm_11a97f
	ld a, [hl]
	and a
	jr z, .asm_11a97f
	dec [hl]
	ret

.asm_11a97f
	ld a, [Options]
	and $7
	ld [hl], a
	ld hl, wcd8d
	ld a, [$c31b]
	ld e, a
	ld a, [$c31c]
	ld d, a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, e
	ld [$c31b], a
	ld a, d
	ld [$c31c], a
	ld a, $50
	ld [hl], a
	ld a, [$c31d]
	ld l, a
	ld a, [$c31e]
	ld h, a
	ld de, wcd8d
	call PlaceString
	ld a, c
	ld [$c31d], a
	ld a, b
	ld [$c31e], a
	ld a, [wcd8d]
	cp $50
	jr nz, .asm_11a9bf
	xor a
	ld [$c31a], a

.asm_11a9bf
	ret
; 11a9c0

Function11a9c0: ; 11a9c0
	ld a, l
	ld [$c31b], a
	ld a, h
	ld [$c31c], a
	ld a, $1
	ld [$c31a], a
	ret
; 11a9ce

Function11a9f0: ; 11a9f0
	ld a, $1
	and a
	ret
; 11a9f4

Text_PartyMonTopsThisLevel: ; 0x11aaf0
	text "A party #mon"
	line "tops this level."
	done
; 0x11ab0f

Text_UberRestriction: ; 0x11ab0f
	text_from_ram wcd49
	text " may go"
	line "only to Battle"

	para "Rooms that are"
	line "<LV>70 or higher."
	done
; 0x11ab4a

Text_CancelBattleRoomChallenge: ; 0x11ab4a
	text "Cancel your Battle"
	line "Room challenge?"
	done
; 0x11ab6e

Text_WhatLevelDoYouWantToChallenge: ; 0x11aba5
	text "What level do you"
	line "want to challenge?"
	done
; 0x11abcb

AddMobileMonToParty: ; 11b98f
	ld hl, PartyCount
	ld a, [hl]
	ld e, a
	inc [hl]

	ld a, [wMobileMonSpeciesPointerBuffer]
	ld l, a
	ld a, [wMobileMonSpeciesPointerBuffer + 1]
	ld h, a
	inc hl
	ld bc, PartySpecies
	ld d, e
.loop1
	inc bc
	dec d
	jr nz, .loop1
	ld a, e
	ld [CurPartyMon], a
	ld a, [hl]
	ld [bc], a
	inc bc
	ld a, -1
	ld [bc], a

	ld hl, PartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	ld [wMobileMonSpeciesBuffer], a
.loop2
	add hl, bc
	dec a
	and a
	jr nz, .loop2
	ld e, l
	ld d, h
	ld a, [wMobileMonStructurePointerBuffer]
	ld l, a
	ld a, [wMobileMonStructurePointerBuffer + 1]
	ld h, a
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld hl, PartyMonOT
	ld bc, NAME_LENGTH
	ld a, [wMobileMonSpeciesBuffer]
.loop3
	add hl, bc
	dec a
	and a
	jr nz, .loop3
	ld e, l
	ld d, h
	ld a, [wMobileMonOTNamePointerBuffer]
	ld l, a
	ld a, [wMobileMonOTNamePointerBuffer + 1]
	ld h, a
	ld bc, PKMN_NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, PartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	ld a, [wMobileMonSpeciesBuffer]
.loop4
	add hl, bc
	dec a
	and a
	jr nz, .loop4
	ld e, l
	ld d, h
	ld a, [wMobileMonNicknamePointerBuffer]
	ld l, a
	ld a, [wMobileMonNicknamePointerBuffer + 1]
	ld h, a
	ld bc, PKMN_NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	ld a, [wMobileMonSpeciesBuffer]
.loop5
	add hl, bc
	dec a
	and a
	jr nz, .loop5
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld e, l
	ld d, h
	ld a, [wMobileMonMailPointerBuffer]
	ld l, a
	ld a, [wMobileMonMailPointerBuffer + 1]
	ld h, a
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes

	call CloseSRAM
	ret
; 11ba38
