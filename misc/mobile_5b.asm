Function16c0fa: ; 16c0fa
	push af
	ld a, [wd002]
	inc a
	ld [wd002], a
	xor a
	ld [wd003], a
	pop af
	ret
; 16c108

Tilemap_16c633:
INCBIN "gfx/unknown/16c633.tilemap"

Tilemap_16c79b:
INCBIN "gfx/unknown/16c79b.tilemap"

Unknown_16c903:
	RGB 31, 31, 31
	RGB 04, 10, 20
	RGB 16, 19, 25
	RGB 25, 27, 29

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

; 16c943

Function16c943: ; 16c943
	ld a, [wd003]
	and a
	jr nz, .asm_16c95e
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld a, $ff
	ld bc, $0008
	ld hl, UnknBGPals
	call ByteFill
	pop af
	ld [rSVBK], a

.asm_16c95e
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld e, $0
	ld a, $0
.asm_16c969
	ld hl, Unknown_16c903
	call Function16cab6
	call Function16cabb
	ld d, a
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cabb
	cp d
	jr z, .asm_16c991
	ld b, $1
.asm_16c981
	dec a
	cp d
	jr z, .asm_16c988
	dec b
	jr nz, .asm_16c981

.asm_16c988
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cadc

.asm_16c991
	ld hl, Unknown_16c903
	call Function16cab6
	call Function16cad8
	ld d, a
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cad8
	cp d
	jr z, .asm_16c9b9
	ld b, $1
.asm_16c9a9
	dec a
	cp d
	jr z, .asm_16c9b0
	dec b
	jr nz, .asm_16c9a9

.asm_16c9b0
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cb08

.asm_16c9b9
	ld hl, Unknown_16c903
	call Function16cab6
	call Function16cac4
	ld d, a
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cac4
	cp d
	jr z, .asm_16c9e1
	ld b, $1
.asm_16c9d1
	dec a
	cp d
	jr z, .asm_16c9d8
	dec b
	jr nz, .asm_16c9d1

.asm_16c9d8
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cae8

.asm_16c9e1
rept 2
	inc e
endr
	ld a, e
	cp $8
	jr nz, .asm_16c969
	callba ApplyPals
	call SetPalettes
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	ld a, [wd003]
	cp $1f
	jr z, .asm_16ca09
	pop af
	ld [rSVBK], a
	ld e, $0
	pop af
	ld [rSVBK], a
	and a
	ret

.asm_16ca09
	pop af
	ld [rSVBK], a
	pop af
	ld [rSVBK], a
	scf
	ret
; 16ca11

Function16ca11: ; 16ca11
	ld a, [wd003]
	and a
	jr nz, .asm_16ca1d
	callba ApplyPals

.asm_16ca1d
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld e, $0
	ld a, $0
.asm_16ca28
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cabb
	cp $1f
	jr z, .asm_16ca48
	ld b, $1
.asm_16ca37
	inc a
	cp $1f
	jr z, .asm_16ca3f
	dec b
	jr nz, .asm_16ca37

.asm_16ca3f
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cadc

.asm_16ca48
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cad8
	cp $1f
	jr z, .asm_16ca68
	ld b, $1
.asm_16ca57
	inc a
	cp $1f
	jr z, .asm_16ca5f
	dec b
	jr nz, .asm_16ca57

.asm_16ca5f
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cb08

.asm_16ca68
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cac4
	cp $1f
	jr z, .asm_16ca88
	ld b, $1
.asm_16ca77
	inc a
	cp $1f
	jr z, .asm_16ca7f
	dec b
	jr nz, .asm_16ca77

.asm_16ca7f
	ld hl, UnknBGPals
	call Function16cab6
	call Function16cae8

.asm_16ca88
rept 2
	inc e
endr
	ld a, e
	cp $8
	jr nz, .asm_16ca28
	callba ApplyPals
	call SetPalettes
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	ld a, [wd003]
	cp $1f
	jr z, .asm_16caae
	pop af
	ld [rSVBK], a
	pop af
	ld [rSVBK], a
	and a
	ret

.asm_16caae
	pop af
	ld [rSVBK], a
	pop af
	ld [rSVBK], a
	scf
	ret
; 16cab6

Function16cab6: ; 16cab6
	ld b, $0
	ld c, e
	add hl, bc
	ret
; 16cabb

Function16cabb: ; 16cabb
	inc hl
	ld a, [hl]
	srl a
	srl a
	and $1f
	ret
; 16cac4

Function16cac4: ; 16cac4
	inc hl
	ld a, [hld]
	and $3
	ld b, a
	ld a, [hl]
	sla a
	rl b
	sla a
	rl b
	sla a
	rl b
	ld a, b
	ret
; 16cad8

Function16cad8: ; 16cad8
	ld a, [hl]
	and $1f
	ret
; 16cadc

Function16cadc: ; 16cadc
	sla a
	sla a
	ld b, a
	inc hl
	ld a, [hl]
	and $83
	or b
	ld [hl], a
	ret
; 16cae8

Function16cae8: ; 16cae8
	ld c, a
	srl a
	srl a
	srl a
	ld b, a
	inc hl
	ld a, [hl]
	and $fc
	or b
	ld [hld], a
	ld a, c
	sla a
	sla a
	sla a
	sla a
	sla a
	ld b, a
	ld a, [hl]
	and $1f
	or b
	ld [hl], a
	ret
; 16cb08

Function16cb08: ; 16cb08
	ld b, a
	ld a, [hl]
	and $e0
	or b
	ld [hl], a
	ret
; 16cb0f

Function16cb0f: ; 16cb0f
	xor a
	ld [Buffer1], a
	ld [Buffer2], a
	xor a
	ld [wd1ec], a
	ld a, $70
	ld [wd1ee], a
	ld a, $4
	ld [wd1ed], a
	ld a, $a0
	ld [wd1ef], a
	xor a
	ld [wd1f0], a
	ret
; 16cb2e

Function16cb40: ; 16cb40
	ld hl, wd1ec
	inc [hl]
	ld a, [hl]
	cp $18
	ret c
	xor a
	ld [hl], a
	ld a, [wd1ef]
	cp $a0
	jr nz, .asm_16cb57
	ld a, $a7
	ld [wd1ef], a
	ret

.asm_16cb57
	ld a, $a0
	ld [wd1ef], a
	ret
; 16cb5d

Function16cb5d: ; 16cb5d
	ld a, [hli]
	and a
	ret z
.asm_16cb60
	push af
	ld a, [wd1ee]
	add [hl]
	add $10
	ld [de], a
	inc hl
	inc de
	ld a, [wd1ed]
	add [hl]
	add $8
	ld [de], a
	inc hl
	inc de
	ld a, [wd1ef]
	add [hl]
	ld [de], a
	inc hl
	inc de
	ld a, [wd1f0]
	or [hl]
	ld [de], a
	inc hl
	inc de
	pop af
	dec a
	jr nz, .asm_16cb60
	ret
; 16cb86

Unknown_16cb86:
	db 7
	db  0,  0, 0, 1
	db  8,  0, 1, 1
	db  8,  8, 2, 0
	db  8, 16, 3, 0
	db 16,  0, 4, 1
	db 16,  8, 5, 0
	db 16, 16, 6, 0
; 16cba3

Function16cba3: ; 16cba3
	xor a
	ld [wd1f1], a
	ld [wd1f2], a
	ld [wd1f3], a
	ret
; 16cbae

Function16cbba: ; 16cbba
	ld hl, wd1f2
	inc [hl]
	ld a, [hl]
	cp $c
	ret c
	xor a
	ld [hl], a
	ld a, [wd1f3]
	inc a
	cp $4
	jr c, .asm_16cbcd
	xor a

.asm_16cbcd
	ld [wd1f3], a
	ret
; 16cbd1

Function16cbd1: ; 16cbd1
	ld a, [wd1f3]
	ld c, a
	ld b, 0
	ld hl, Unknown_16cbfb
	add hl, bc
	ld a, [hl]
	ld bc, 2
	ld hl, Unknown_16cfa3
	call AddNTimes
	ld de, UnknBGPals + 1 palettes + 4
	ld bc, 2
	ld a, $5
	call FarCopyWRAM
	callba ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 16cbfb

Unknown_16cbfb:
	db 0, 1, 2, 1, 0, 1, 2
; 16cc02

Function16cc18: ; 16cc18
	ld hl, VTiles1
	ld de, GFX_16cca3
	lb bc, BANK(GFX_16cca3), $2e
	call Get2bpp
	ret
; 16cc25

Function16cc25: ; 16cc25
	ld hl, Unknown_16cfa9
	ld de, UnknBGPals + 1 palettes
	call .CopyPal
	ld hl, Unknown_16cfb1
	ld de, UnknOBPals
	call .CopyPal
	ld hl, Unknown_16cfb9
	ld de, UnknOBPals + 1 palettes
	call .CopyPal
	ret
; 16cc41

.CopyPal: ; 16cc41
	ld bc, 1 palettes
	ld a, $5
	jp FarCopyWRAM
; 16cc49

Function16cc49: ; 16cc49
	hlcoord 4, 15
	ld a, $80
	call Function16cc5a
	hlcoord 4, 16
	ld a, $90
	call Function16cc5a
	ret
; 16cc5a

Function16cc5a: ; 16cc5a
	ld c, $10
.asm_16cc5c
	ld [hli], a
	inc a
	dec c
	jr nz, .asm_16cc5c
	ret
; 16cc62

Function16cc62: ; 16cc62
	hlcoord 0, 15, AttrMap
	ld bc, $0028
	ld a, $1
	call ByteFill
	ret
; 16cc6e

Function16cc6e: ; 16cc6e
	hlbgcoord 0, 0, VBGMap1
	jr Function16cc73

Function16cc73:
	ld a, [rVBK]
	push af
	ld a, $0
	ld [rVBK], a
	push hl
	decoord 0, 0
	call Function16cc90
	pop hl
	ld a, $1
	ld [rVBK], a
	decoord 0, 0, AttrMap
	call Function16cc90
	pop af
	ld [rVBK], a
	ret
; 16cc90

Function16cc90: ; 16cc90
	ld bc, $1214
.asm_16cc93
	push bc
.asm_16cc94
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .asm_16cc94
	ld bc, $000c
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_16cc93
	ret
; 16cca3

GFX_16cca3:
INCBIN "gfx/unknown/16cca3.2bpp"

Unknown_16cfa3:
	RGB 31, 31, 31
	RGB 25, 27, 29
	RGB 16, 19, 25

Unknown_16cfa9:
	RGB 31, 31, 31
	RGB 25, 27, 29
	RGB 31, 31, 31
	RGB 07, 07, 07


Unknown_16cfb1:
	RGB 31, 31, 31
	RGB 13, 09, 18
	RGB 26, 21, 16
	RGB 07, 07, 07


Unknown_16cfb9:
	RGB 31, 31, 31
	RGB 18, 05, 02
	RGB 27, 11, 12
	RGB 07, 07, 07

; 16cfc1
