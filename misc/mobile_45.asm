Function115d99: ; 115d99
	ld de, GFX_11601a
	ld hl, VTiles0 tile $60
	lb bc, BANK(GFX_11601a), $14
	call Get2bpp
	xor a
	ld [wc305], a
	ld [wc306], a
	ld [wc309], a
	ld [wc30a], a
	ld [wc30b], a
	ld [wc30c], a
	ld a, $10
	ld [wc307], a
	ld a, $18
	ld [wc308], a
	ret

; 115dc3

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

GFX_11601a:: ; 11601a
INCBIN "gfx/unknown/11601a.2bpp"

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
