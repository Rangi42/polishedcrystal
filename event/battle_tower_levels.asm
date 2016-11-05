BattleTowerSetLevelGroup: ; 118121
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
	call JoyTextDelay
	call ChooseLevelGroup
	call Function115dd3
	call Function11619d
	call DelayFrame
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
