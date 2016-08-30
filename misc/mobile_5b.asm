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

Function16cc5a: ; 16cc5a
	ld c, $10
.asm_16cc5c
	ld [hli], a
	inc a
	dec c
	jr nz, .asm_16cc5c
	ret
; 16cc62

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
