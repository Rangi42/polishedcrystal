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
;.loop
	call JoyTextDelay
;	call Function11854d
;	call Function11a8fa
	call ChooseLevelGroup
	call Function115dd3
	call Function11619d
	call DelayFrame
;	ld a, [wcf66]
;	ld hl, wcd33
;	cp [hl]
;	jr nz, .loop
	xor a
	ld [w3_d000], a
	pop af
	ld [rSVBK], a
	call Function118452
	call Function118180
	call ReturnToMapFromSubmenu
	ret
; 118180

ChooseLevelGroup:
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a

	; e = maximum party level [1-100]
	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [PartyCount]
	ld d, a
	ld e, 1
.loop
	add hl, bc
	ld a, [hl]
	cp e
	jr c, .ok
	ld e, a
.ok
	dec d
	ld a, d
	jr nz, .loop

	pop af
	ld [rSVBK], a

	; wBTChoiceOfLvlGroup = (e + 9) / 10 [1-10]
	ld a, 9
	add e
	ld c, 10
	call SimpleDivide
	ld a, b

	ld [wBTChoiceOfLvlGroup], a
	ld [wc300], a

	ret

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
	ei
	call Function11615a
	ld a, $5
	call GetSRAMBank
	xor a
	ld [$bfff], a
	call CloseSRAM
	ret
; 118440

Function11615a: ; 11615a
	xor a
	ld [wc30d], a
	ld [$c319], a
	ld [wc310], a
	ld [wc311], a
	ld [wc312], a
	ld [wc313], a
	ld [wc314], a
	ld [wc314 + 1], a
	ld [wc314 + 4], a
	ld [wc3f6], a
	ld [wc3f8], a
	ld [wc3f2], a
	ld [wc3f4], a
	ld a, $24
	ld [wc3f5], a
	ld a, $7
	ld [wc3f7], a
	ld a, $b0
	ld [wc30e], a
	ld [wc3f1], a
	ld a, $48
	ld [wc30f], a
	ld [wc3f3], a
	ret
; 11619d

Function118452: ; 118452
	di
	xor a
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

Function11854d: ; 11854d
	jumptable .Jumptable, wcf66
; 11855c

.Jumptable: ; 11855c
	dw Function118922
	dw Function118936
	dw Function118982
	dw JustReturn
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
	dw JustReturn
	dw Function118e76
; 11857c

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
	ld [wBTChoiceOfLvlGroup], a
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

Function118e76: ; 118e76 (46:4e76)
	ld a, $c
	ld [wcd3c], a
	jp Function119e2e

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
	jr z, .uber
	cp HO_OH
	jr z, .uber
	cp CELEBI
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
	dw JustReturn
	dw JustReturn
	dw Decrement_wcd44
	dw Decrement_wcd44
	dw JustReturn
	dw JustReturn
	dw Function11a129
	dw Decrement_wcd44
	dw JustReturn
	dw Function11a14b
	dw Decrement_wcd44
	dw RespondToInput46
	dw JustReturn
	dw Decrement_wcd44
	dw Function11a33a
	dw Function11a207
	dw Function11a235
	dw JustReturn
	dw Decrement_wcd44
	dw RespondToInput46
	dw JustReturn
	dw Decrement_wcd44
	dw Decrement_wcd44
	dw RespondToInput46
	dw JustReturn
	dw DecrementFloor_wcd44
	dw JustReturn
	dw RespondToInput46
	dw JustReturn
	dw JustReturn
	dw RespondToInput46
	dw JustReturn
	dw DecrementFloor_wcd44
; 119f3f

Function11a129: ; 11a129
	ld a, $80
	ld [wcd44], a
	jp Increment_wcd3c
; 11a131

Function11a14b: ; 11a14b
	ld hl, wcd85
	ld a, [hl]
	and a
	ret
; 11a16d

Function11a207: ; 11a207
	ld hl, MenuDataHeader_YesNo_46
	call LoadMenuDataHeader
	call MenuBox
	call MenuBoxCoord2Tile
	call ApplyTilemap
	hlcoord 16, 8
	ld de, String_Yes_46
	call PlaceString
	hlcoord 16, 10
	ld de, String_No_46
	call PlaceString
	hlcoord 15, 8
	ld a, $ed
	ld [hl], a
	xor a
	ld [wcd44], a
	jp Increment_wcd3c
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
	farcall ReloadMapPart
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
	farcall ReloadMapPart
	and a
	ret
; 11a2cf

String_Yes_46: ; 11a2cf
	db "Yes@"
; 11a2d3

String_No_46: ; 11a2d3
	db "No@"
; 11a2d6

MenuDataHeader_YesNo_46: ; 11a2de
	db $40 ; flags
	db  7, 14 ; start coords
	db 11, 19 ; end coords
	dw NULL
	db 0 ; default option
; 11a2e6

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
	farcall ReloadMapPart
	call Function115dc3
	and a
	ret
; 11a357

Decrement_wcd44: ; 11a36b
	ld a, [wcd44]
	dec a
	ld [wcd44], a
	scf
	ret

DecrementFloor_wcd44: ; 11a47a
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

RespondToInput46: ; 11a536
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON
	jr nz, .press_a
	ld a, [hl]
	and B_BUTTON
	jr nz, .press_b
	ld a, [hl]
	and D_UP
	jr nz, .press_up
	ld a, [hl]
	and D_DOWN
	jr nz, .press_down
.asm_11a54d
	ld a, [wcd3c]
	cp $4
	jr z, .asm_11a562
	call Function11a9f0
	jr nz, .asm_11a562
	call ExitMenu
	farcall ReloadMapPart

.asm_11a562
	scf
	ret

.press_up
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

.press_down
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

.press_b
	ld a, $1
	ld [wcd44], a

.press_a
	xor a
	ld [wcd8a], a
	ld [wcd8b], a
	and a
	ret
; 11a5b0

Increment_wcd3c: ; 11a5b0
	ld a, [wcd3c]
	inc a
	ld [wcd3c], a
	scf
	ret
; 11a5b9

Function11a8fa: ; 11a8fa
	jumptable .Jumptable, $c31a
; 11a909

.Jumptable: ; 11a909
	dw JustReturn
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

JustReturn:
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




Function115dc3: ; 115dc3
	xor a
	ld [wc305], a
	ld a, $a0
	ld hl, Sprites + 31 * 4
	ld bc, 8 * 4
	call ByteFill
	ret

; 115dd3

Function115dd3: ; 115dd3
	ld a, [wc305]
	and a
	ret z
	ld a, $a0
	ld hl, Sprites + 31 * 4
	ld bc, 8 * 4
	call ByteFill
	call Function115e22
	ld a, [wc309]
	sla a
	ld c, a
	ld b, 0
	ld hl, Unknown_115e86
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	push de
	pop hl
	ld de, Sprites + 31 * 4
	ld a, [wc307]
	ld c, a
	ld a, [wc308]
	ld b, a
	ld a, [hli]
.asm_115e04
	push af
	ld a, [hli]
	add b
	ld [de], a
	inc de
	ld a, [hli]
	add c
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	pop af
	dec a
	jr nz, .asm_115e04
	ret

; 115e18

Function115e22: ; 115e22
	ld hl, wc30c
	dec [hl]
	ret nz
	ld hl, wc30b
	inc [hl]

Unknown_115e86:
	dw Unknown_115ea6
	dw Unknown_115eb7
	dw Unknown_115ecc
	dw Unknown_115ee1
	dw Unknown_115ef6
	dw Unknown_115f13
	dw Unknown_115f30
	dw Unknown_115f4d
	dw Unknown_115f6a
	dw Unknown_115f87
	dw Unknown_115f9c
	dw Unknown_115fb1
	dw Unknown_115fc6
	dw Unknown_115fdb
	dw Unknown_115ff0
	dw Unknown_116005

Unknown_115ea6: ; 115ea6
	db 4
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115eb7: ; 115eb7
	db 5
	dsprite   0, 0,   1, 0, $64, $00
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115ecc: ; 115ecc
	db 5
	dsprite   0, 0,   1, 0, $65, $00
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115ee1: ; 115ee1
	db 5
	dsprite   0, 0,   1, 0, $66, $00
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115ef6: ; 115ef6
	db 7
	dsprite   0, 0,   0, 0, $67, $01
	dsprite   1, 0,   0, 0, $68, $01
	dsprite   2, 0,   0, 0, $6d, $00
	dsprite   2, 0,   1, 0, $69, $00
	dsprite   2, 0,   2, 0, $6a, $00
	dsprite   3, 0,   1, 0, $6b, $00
	dsprite   3, 0,   2, 0, $6c, $00

Unknown_115f13: ; 115f13
	db 7
	dsprite   0, 0,   0, 0, $67, $01
	dsprite   1, 0,   0, 0, $68, $01
	dsprite   2, 0,   0, 0, $6e, $00
	dsprite   2, 0,   1, 0, $69, $00
	dsprite   2, 0,   2, 0, $6a, $00
	dsprite   3, 0,   1, 0, $6b, $00
	dsprite   3, 0,   2, 0, $6c, $00

Unknown_115f30: ; 115f30
	db 7
	dsprite   0, 0,   0, 0, $67, $01
	dsprite   1, 0,   0, 0, $68, $01
	dsprite   2, 0,   0, 0, $6f, $00
	dsprite   2, 0,   1, 0, $69, $00
	dsprite   2, 0,   2, 0, $6a, $00
	dsprite   3, 0,   1, 0, $6b, $00
	dsprite   3, 0,   2, 0, $6c, $00

Unknown_115f4d: ; 115f4d
	db 7
	dsprite   0, 0,   0, 0, $67, $01
	dsprite   1, 0,   0, 0, $68, $01
	dsprite   2, 0,   0, 0, $70, $00
	dsprite   2, 0,   1, 0, $69, $00
	dsprite   2, 0,   2, 0, $6a, $00
	dsprite   3, 0,   1, 0, $6b, $00
	dsprite   3, 0,   2, 0, $6c, $00

Unknown_115f6a: ; 115f6a
	db 7
	dsprite   0, 0,   0, 0, $67, $01
	dsprite   1, 0,   0, 0, $68, $01
	dsprite   2, 0,   0, 0, $71, $00
	dsprite   2, 0,   1, 0, $69, $00
	dsprite   2, 0,   2, 0, $6a, $00
	dsprite   3, 0,   1, 0, $6b, $00
	dsprite   3, 0,   2, 0, $6c, $00

Unknown_115f87: ; 115f87
	db 5
	dsprite   0, 0,   1, 0, $72, $00
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115f9c: ; 115f9c
	db 5
	dsprite   0, 0,   1, 0, $73, $00
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115fb1: ; 115fb1
	db 5
	dsprite   0, 1,   1, 0, $64, $60
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115fc6: ; 115fc6
	db 5
	dsprite   0, 1,   1, 0, $65, $60
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115fdb: ; 115fdb
	db 5
	dsprite   0, 1,   1, 0, $66, $60
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_115ff0: ; 115ff0
	db 5
	dsprite   0, 1,   1, 0, $72, $60
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01

Unknown_116005: ; 116005
	db 5
	dsprite   0, 1,   1, 0, $73, $60
	dsprite   1, 0,   0, 0, $60, $01
	dsprite   1, 0,   1, 0, $61, $01
	dsprite   2, 0,   0, 0, $62, $01
	dsprite   2, 0,   1, 0, $63, $01
; 11601a

Function11619d: ; 11619d
	ld a, [wc30d]
	and a
	ret z
	ld a, [$c319]
	cp $2
	jr c, .asm_1161b4
	ld a, $a0
	ld hl, Sprites
	ld bc, $0064
	call ByteFill

.asm_1161b4
	ret

; 1161b8
