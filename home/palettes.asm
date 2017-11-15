; Functions dealing with palettes.


UpdateCGBPals:: ; c33
; any pals to update?
	ld a, [hCGBPalUpdate]
	and a
	ret z

ForceUpdateCGBPals:: ; c37
; update bgp data from BGPals
; update obp data from OBPals
; return carry if successful

	ld a, [rSVBK]
	push af
	ld a, BANK(BGPals)
	ld [rSVBK], a

	ld hl, BGPals ; 5:d080

; copy 8 pals to bgpd
	ld a, %10000000 ; auto increment, index 0
	ld [rBGPI], a
	lb bc, 4, rBGPD % $100 ; 4 = NUM_PALS / 2
.bgp
rept 2 palettes
	ld a, [hli]
	ld [$ff00+c], a
endr

	dec b
	jr nz, .bgp

; hl is now 5:d0c0 OBPals

; copy 8 pals to obpd
	ld a, %10000000 ; auto increment, index 0
	ld [rOBPI], a
	lb bc, 4, rOBPD % $100 ; 4 = NUM_PALS / 2
.obp
rept 2 palettes
	ld a, [hli]
	ld [$ff00+c], a
endr

	dec b
	jr nz, .obp

	pop af
	ld [rSVBK], a

; clear pal update queue
	xor a
	ld [hCGBPalUpdate], a

	scf
	ret
; c9f


DmgToCgbBGPals:: ; c9f
; exists to forego reinserting cgb-converted image data

; input: a -> bgp

	ld [rBGP], a
	push af

	push hl
	push de
	push bc
	ld a, [rSVBK]
	push af

	ld a, 5 ; gfx
	ld [rSVBK], a

; copy & reorder bg pal buffer
	ld hl, BGPals ; to
	ld de, UnknBGPals ; from
; order
	ld a, [rBGP]
	ld b, a
; all pals
	ld c, 8
	call CopyPals
; request pal update
	ld a, 1
	ld [hCGBPalUpdate], a

	pop af
	ld [rSVBK], a
	pop bc
	pop de
	pop hl
	pop af
	ret
; ccb


DmgToCgbObjPals:: ; ccb
; exists to forego reinserting cgb-converted image data

; input: d -> obp1
;        e -> obp2

	ld a, e
	ld [rOBP0], a
	ld a, d
	ld [rOBP1], a

	push hl
	push de
	push bc
	ld a, [rSVBK]
	push af

	ld a, 5
	ld [rSVBK], a

; copy & reorder obj pal buffer
	ld hl, OBPals ; to
	ld de, UnknOBPals ; from
; order
	ld a, [rOBP0]
	ld b, a
; all pals
	ld c, 8
	call CopyPals
; request pal update
	ld a, 1
	ld [hCGBPalUpdate], a

	pop af
	ld [rSVBK], a
	pop bc
	pop de
	pop hl
	ret
; cf8


DmgToCgbObjPal0:: ; cf8
	ld [rOBP0], a
	push af
	push hl
	push de
	push bc

	ld a, [rSVBK]
	push af
	ld a, 5 ; gfx
	ld [rSVBK], a

	ld hl, OBPals
	ld de, UnknOBPals
	ld a, [rOBP0]
	ld b, a
	ld c, 1
	call CopyPals
	ld a, 1
	ld [hCGBPalUpdate], a

	pop af
	ld [rSVBK], a

	pop bc
	pop de
	pop hl
	pop af
	ret
; d24

DmgToCgbObjPal1:: ; d24
	ld [rOBP1], a
	push af
	push hl
	push de
	push bc

	ld a, [rSVBK]
	push af
	ld a, 5 ; gfx
	ld [rSVBK], a

	ld hl, OBPals palette 1
	ld de, UnknOBPals palette 1
	ld a, [rOBP1]
	ld b, a
	ld c, 1
	call CopyPals
	ld a, 1
	ld [hCGBPalUpdate], a

	pop af
	ld [rSVBK], a

	pop bc
	pop de
	pop hl
	pop af
	ret
; d50



CopyPals:: ; d50
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
; d79


ClearVBank1:: ; d79
	ld a, 1
	ld [rVBK], a

	ld hl, VTiles0
	ld bc, VRAM_End - VTiles0
	xor a
	call ByteFill

	xor a
	ld [rVBK], a
	ret
; d90


Special_ReloadSpritesNoPalettes:: ; d91
	ld a, [rSVBK]
	push af
	ld a, BANK(BGPals)
	ld [rSVBK], a
	ld hl, BGPals
	ld bc, $40 + $10
	xor a
	call ByteFill
	pop af
	ld [rSVBK], a
	ld a, 1
	ld [hCGBPalUpdate], a
	jp DelayFrame
; db1


FarCallSwapTextboxPalettes:: ; db1
	homecall SwapTextboxPalettes
	ret
; dbd

FarCallScrollBGMapPalettes:: ; dbd
	homecall ScrollBGMapPalettes
	ret
; dc9
