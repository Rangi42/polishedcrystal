; Functions dealing with palettes.

UpdateCGBPals::
; any pals to update?
	ldh a, [hCGBPalUpdate]
	and a
	ret z

ForceUpdateCGBPals::
; update bgp data from wBGPals
; update obp data from wOBPals
; return carry if successful

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals)
	ldh [rSVBK], a

	ld hl, wBGPals

; copy 8 pals to bgpd
	ld a, %10000000 ; auto increment, index 0
	ldh [rBGPI], a
	lb bc, 4, rBGPD % $100 ; 4 = NUM_PALS / 2
.bgp
rept 2 palettes
	ld a, [hli]
	ld [$ff00+c], a
endr

	dec b
	jr nz, .bgp

; hl is now 5:d0c0 wOBPals

; copy 8 pals to obpd
	ld a, %10000000 ; auto increment, index 0
	ldh [rOBPI], a
	lb bc, 4, rOBPD % $100 ; 4 = NUM_PALS / 2
.obp
rept 2 palettes
	ld a, [hli]
	ld [$ff00+c], a
endr

	dec b
	jr nz, .obp

	pop af
	ldh [rSVBK], a

; clear pal update queue
	xor a
	ldh [hCGBPalUpdate], a

	scf
	ret

DmgToCgbBGPals::
; exists to forego reinserting cgb-converted image data

; input: a -> bgp

	ldh [rBGP], a
	push af

	push hl
	push de
	push bc
	ldh a, [rSVBK]
	push af

	ld a, 5 ; gfx
	ldh [rSVBK], a

; copy & reorder bg pal buffer
	ld hl, wBGPals ; to
	ld de, wUnknBGPals ; from
; order
	ldh a, [rBGP]
	ld b, a
; all pals
	ld c, 8
	call CopyPals
; request pal update
	ld a, 1
	ldh [hCGBPalUpdate], a

	pop af
	ldh [rSVBK], a
	pop bc
	pop de
	pop hl
	pop af
	ret

DmgToCgbObjPals::
; exists to forego reinserting cgb-converted image data

; input: d -> obp1
;        e -> obp2

	ld a, e
	ldh [rOBP0], a
	ld a, d
	ldh [rOBP1], a

	push hl
	push de
	push bc
	ldh a, [rSVBK]
	push af

	ld a, 5
	ldh [rSVBK], a

; copy & reorder obj pal buffer
	ld hl, wOBPals ; to
	ld de, wUnknOBPals ; from
; order
	ldh a, [rOBP0]
	ld b, a
; all pals
	ld c, 8
	call CopyPals
; request pal update
	ld a, 1
	ldh [hCGBPalUpdate], a

	pop af
	ldh [rSVBK], a
	pop bc
	pop de
	pop hl
	ret

DmgToCgbObjPal0::
	ldh [rOBP0], a
	push af
	push hl
	push de
	push bc

	ldh a, [rSVBK]
	push af
	ld a, 5 ; gfx
	ldh [rSVBK], a

	ld hl, wOBPals
	ld de, wUnknOBPals
	ldh a, [rOBP0]
	ld b, a
	ld c, 1
	call CopyPals
	ld a, 1
	ldh [hCGBPalUpdate], a

	pop af
	ldh [rSVBK], a

	pop bc
	pop de
	pop hl
	pop af
	ret

DmgToCgbObjPal1::
	ldh [rOBP1], a
	push af
	push hl
	push de
	push bc

	ldh a, [rSVBK]
	push af
	ld a, 5 ; gfx
	ldh [rSVBK], a

	ld hl, wOBPals palette 1
	ld de, wUnknOBPals palette 1
	ldh a, [rOBP1]
	ld b, a
	ld c, 1
	call CopyPals
	ld a, 1
	ldh [hCGBPalUpdate], a

	pop af
	ldh [rSVBK], a

	pop bc
	pop de
	pop hl
	pop af
	ret

CopyPals::
; copy c palettes in order b from de to hl

	push bc
	ld c, 4 ; NUM_PAL_COLORS
.loop
	push de
	push hl

; get pal color
	ld a, b
	and %11 ; color
; 2 bytes per color
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]

; dest
	pop hl
; write color
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
; next pal color
	srl b
	srl b
; source
	pop de
; done pal?
	dec c
	jr nz, .loop

; de += 8 (next pal)
	ld a, 1 palettes ; NUM_PAL_COLORS * 2 ; bytes per pal
	add e
	jr nc, .ok
	inc d
.ok
	ld e, a

; how many more pals?
	pop bc
	dec c
	jr nz, CopyPals
	ret

ClearVBank1::
	ld a, 1
	ldh [rVBK], a

	ld hl, vTiles0
	ld bc, VRAM_End - vTiles0
	xor a
	call ByteFill

	xor a
	ldh [rVBK], a
	ret

Special_ReloadSpritesNoPalettes::
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals)
	ldh [rSVBK], a
	ld hl, wBGPals
	ld bc, $40 + $10
	xor a
	call ByteFill
	pop af
	ldh [rSVBK], a
	ld a, 1
	ldh [hCGBPalUpdate], a
	jp DelayFrame
