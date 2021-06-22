loadmapblock: MACRO
	ld a, [de]
	inc de
	and a
	jr nz, .notMapBorderBlock\@
	ldh a, [hMapBorderBlock]
.notMapBorderBlock\@
ENDM

addmapwidthoffset: MACRO
	ldh a, [hMapWidthPlus6]
	; de += a
	add e
	ld e, a
	adc d
	sub e
	ld d, a
ENDM

subtractfromhl: MACRO
	; hl -= \1
	ld a, l
	sub \1
	ld l, a
	jr nc, .noCarry\@
	dec h
.noCarry\@
ENDM

_LoadMapPart::
	ldh a, [rSVBK]
	push af
	ld a, [wOverworldMapAnchor]
	ld e, a
	ld a, [wOverworldMapAnchor + 1]
	ld d, a
	ld a, [wMapBorderBlock]
	ldh [hMapBorderBlock], a
	ld a, [wMapWidth]
	inc a
	ldh [hMapWidthPlus6], a
	ld c, a
	ld a, [wMetatileStandingY]
	add a
	ld b, a
	ld a, [wMetatileStandingX]
	or b
	ld b, a
	ld a, BANK(wDecompressedMetatiles)
	ldh [rSVBK], a
	push de
	push bc
	call _LoadMapPart_TileMap
	pop bc
	pop de
	ld a, c
	ldh [hMapWidthPlus6], a
	ld a, BANK(wDecompressedAttributes)
	ldh [rSVBK], a
	call _LoadMapPart_AttrMap
	pop af
	ldh [rSVBK], a
	ret

loadmappart_function_macro: MACRO
	ld a, b
	and a
	jmp z, .BlockY0BlockX0\@
	dec a
	jmp z, .BlockY0BlockX1\@
	hlcoord 0, 0, \1
	dec a
	jmp z, .BlockY1BlockX0\@
; block y1, block x1

.BlockY1BlockX1\@:
; LoadOneQuarterBottomRightMetatile
.LoadOneQuarterBottomRightMetatile\@:
	loadmapblock
	ld b, d
	ld c, e
	swap a
	ld d, a
	and $f0
	add 10
	call .LoadOneQuarterMetatile\@
	ld d, b
	ld e, c

	hlcoord 2, 0, \1
	ld bc, SCREEN_WIDTH - 4
	call .LoadOneRowOf4BottomHalfBlocks\@
	hlcoord 18, 0, \1
; LoadOneQuarterBottomLeftMetatile
	loadmapblock
	ld b, d
	ld c, e
	swap a
	ld d, a
	and $f0
	add 8
	call .LoadOneQuarterMetatile\@
	ld d, b
	ld e, c

	ld hl, hMapWidthPlus6
	dec [hl]
	ldh a, [hMapWidthPlus6]
	; de += a
	add e
	ld e, a
	adc d
	sub e
	ld d, a

	hlcoord 0, 2, \1
	ld bc, SCREEN_WIDTH - 1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	hlcoord 0, 6, \1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	hlcoord 0, 10, \1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	hlcoord 0, 14, \1

.LoadOneRowOf5BlocksFromHalfRightMetatile\@:
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	inc a
	inc a
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a

	rept 3
	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	inc e
	inc e
	inc e
	ld [hl], a
	add hl, bc
	endr

	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
; LoadOneRowOf4Blocks:
	ld c, SCREEN_WIDTH - 4
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
	loadmapblock
; Next metatile
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
; LoadOneHalfLeftMetatile
	loadmapblock
	ld c, SCREEN_WIDTH - 1
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a

	rept 3
	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	inc e
	inc e
	inc e
	ld [hl], a
	add hl, bc
	endr

	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	ld [hl], a
	pop de
	ldh a, [hMapWidthPlus6]
	add e
	ld e, a
	ret nc
	inc d
	ret

.BlockY0BlockX0\@:
	hlcoord 0, 0, \1
	ld bc, SCREEN_WIDTH - 4
	call .LoadOneRowOf5Blocks\@
	hlcoord 0, 4, \1
	call .LoadOneRowOf5Blocks\@
	hlcoord 0, 8, \1
	call .LoadOneRowOf5Blocks\@
	hlcoord 0, 12, \1
	call .LoadOneRowOf5Blocks\@
	hlcoord 0, 16, \1

; LoadOneRowOf5UpperHalfBlocks
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	subtractfromhl (SCREEN_WIDTH * 1) - 1
.LoadOneRowOf4UpperHalfBlocks\@:
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	subtractfromhl (SCREEN_WIDTH * 1) - 1
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	subtractfromhl (SCREEN_WIDTH * 1) - 1
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	subtractfromhl (SCREEN_WIDTH * 1) - 1
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	ret

.BlockY1BlockX0\@:
	call .LoadOneHalfRowOf5LowerHalfBlocks\@
	ldh a, [hMapWidthPlus6]
	; de += a
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	hlcoord 0, 2, \1
	call .LoadOneRowOf5Blocks\@
	hlcoord 0, 6, \1
	call .LoadOneRowOf5Blocks\@
	hlcoord 0, 10, \1
	call .LoadOneRowOf5Blocks\@
	hlcoord 0, 14, \1

; fallthrough
.LoadOneRowOf5Blocks\@:
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
; .LoadOneRowOf4Blocks_Entrypoint:
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	subtractfromhl (SCREEN_WIDTH * 3) - 1
	loadmapblock
; Next metatile
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; rows 1 - 3
	rept 3
		rept 4
			ld a, [de]
			ld [hli], a
			inc e
		endr
		add hl, bc
	endr
; row 4
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	ldh a, [hMapWidthPlus6]
	add e
	ld e, a
	ret nc
	inc d
	ret

.LoadOneHalfRowOf5LowerHalfBlocks\@:
	ld bc, SCREEN_WIDTH - 4
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	add 8
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	subtractfromhl (SCREEN_WIDTH * 1) - 1
.LoadOneRowOf4BottomHalfBlocks\@:
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	add 8
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	subtractfromhl (SCREEN_WIDTH * 1) - 1
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	add 8
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	subtractfromhl (SCREEN_WIDTH * 1) - 1
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	add 8
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	subtractfromhl (SCREEN_WIDTH * 1) - 1
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	add 8
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a
	; copy the 4x4 metatile

; row 1
	rept 4
		ld a, [de]
		ld [hli], a
		inc e
	endr
	add hl, bc
; row 2
	rept 3
		ld a, [de]
		ld [hli], a
		inc e
	endr
	ld a, [de]
	ld [hl], a
	pop de
	; Next metatile
	ret

.BlockY0BlockX1\@:
	ld hl, hMapWidthPlus6
	dec [hl]
	hlcoord 0, 0, \1
	ld bc, SCREEN_WIDTH - 1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	hlcoord 0, 4, \1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	hlcoord 0, 8, \1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	hlcoord 0, 12, \1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@

; LoadOneQuarterUpperRightMetatile
	hlcoord 0, 16, \1
	loadmapblock
	ld b, d
	ld c, e
	swap a
	ld d, a
	and $f0
	inc a
	inc a
	call .LoadOneQuarterMetatile\@
	ld d, b
	ld e, c

	hlcoord 2, 16, \1
	ld bc, SCREEN_WIDTH - 4
	call .LoadOneRowOf4UpperHalfBlocks\@
	hlcoord 18, 16, \1

; LoadOneQuarterUpperLeftMetatile
	ld a, [de]
	and a
	jr nz, .notMapBorderBlock3\@
	ldh a, [hMapBorderBlock]
.notMapBorderBlock3\@
	swap a
	ld d, a
	and $f0

; fallthrough
.LoadOneQuarterMetatile\@:
	ld e, a
	ld a, d
	and $f
	add HIGH(wDecompressedMetatiles)
	ld d, a

	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	inc e
	inc e
	inc e
	ld [hl], a
	ld a, SCREEN_WIDTH - 1
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ret
ENDM

_LoadMapPart_TileMap:
	loadmappart_function_macro wTileMap

_LoadMapPart_AttrMap:
	loadmappart_function_macro wAttrMap
