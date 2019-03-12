loadmapblock: MACRO
	ld a, [de]
	inc de
	and a
	jr nz, .notMapBorderBlock\@
	ld a, [hMapBorderBlock]
.notMapBorderBlock\@
ENDM

nocarry: MACRO
	jr nc, .noCarry\@
	dec h
.noCarry\@
ENDM

addmapwidthoffset: MACRO
	ld a, [hMapWidthPlus6]
	add e
	ld e, a
	jr nc, .noCarry\@
	inc d
.noCarry\@
ENDM

_LoadMapPart::
	ld a, [rSVBK]
	push af
	ld a, [wOverworldMapAnchor]
	ld e, a
	ld a, [wOverworldMapAnchor + 1]
	ld d, a
	ld a, [wMapBorderBlock]
	ld [hMapBorderBlock], a
	ld a, [wMapWidth]
	inc a
	ld [hMapWidthPlus6], a
	ld c, a
	ld a, [wMetatileStandingY]
	add a
	ld b, a
	ld a, [wMetatileStandingX]
	or b
	ld b, a
	ld a, BANK(wDecompressedMetatiles)
	ld [rSVBK], a
	push de
	push bc
	call .Function1
	pop bc
	pop de
	ld a, c
	ld [hMapWidthPlus6], a
	ld a, BANK(wDecompressedAttributes)
	ld [rSVBK], a
	call .Function2
	pop af
	ld [rSVBK], a
	ret

function_macro: MACRO
.Function\1:
	ld a, b
	and a
	jp z, .BlockY0BlockX0\@
	dec a
	jp z, .BlockY0BlockX1\@
	coord hl, 0, 0, \2
	dec a
	jp z, .BlockY1BlockX0\@
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

	coord hl, 2, 0, \2
	ld bc, SCREEN_WIDTH - 4
	call .LoadOneRowOf4BottomHalfBlocks\@
	coord hl, 18, 0, \2
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
	addmapwidthoffset

	coord hl, 0, 2, \2
	ld bc, SCREEN_WIDTH - 1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	coord hl, 0, 6, \2
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	coord hl, 0, 10, \2
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	coord hl, 0, 14, \2

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
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
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
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
	loadmapblock
; Next metatile
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
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
	add (wDecompressedMetatiles >> 8)
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
	ld a, [hMapWidthPlus6]
	add e
	ld e, a
	ret nc
	inc d
	ret

.BlockY0BlockX0\@:
	coord hl, 0, 0, \2
	ld bc, SCREEN_WIDTH - 4
	call .LoadOneRowOf5Blocks\@
	coord hl, 0, 4, \2
	call .LoadOneRowOf5Blocks\@
	coord hl, 0, 8, \2
	call .LoadOneRowOf5Blocks\@
	coord hl, 0, 12, \2
	call .LoadOneRowOf5Blocks\@
	coord hl, 0, 16, \2

; LoadOneRowOf5UpperHalfBlocks
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 1) - 1
	ld l, a
	nocarry
.LoadOneRowOf4UpperHalfBlocks\@:
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 1) - 1
	ld l, a
	nocarry
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 1) - 1
	ld l, a
	nocarry
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 1) - 1
	ld l, a
	nocarry
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	addmapwidthoffset
	coord hl, 0, 2, \2
	call .LoadOneRowOf5Blocks\@
	coord hl, 0, 6, \2
	call .LoadOneRowOf5Blocks\@
	coord hl, 0, 10, \2
	call .LoadOneRowOf5Blocks\@
	coord hl, 0, 14, \2

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
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
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
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
; Next metatile
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, l
	sub (SCREEN_WIDTH * 3) - 1
	ld l, a
	nocarry
	loadmapblock
; Next metatile
	push de
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	ld a, [hMapWidthPlus6]
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
	add (wDecompressedMetatiles >> 8)
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

	ld a, l
	sub (SCREEN_WIDTH * 1) - 1
	ld l, a
	nocarry
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
	add (wDecompressedMetatiles >> 8)
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

	ld a, l
	sub (SCREEN_WIDTH * 1) - 1
	ld l, a
	nocarry
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	add 8
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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

	ld a, l
	sub (SCREEN_WIDTH * 1) - 1
	ld l, a
	nocarry
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	add 8
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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

	ld a, l
	sub (SCREEN_WIDTH * 1) - 1
	ld l, a
	nocarry
	loadmapblock
	push de
	swap a
	ld d, a
	and $f0
	add 8
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	coord hl, 0, 0, \2
	ld bc, SCREEN_WIDTH - 1
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	coord hl, 0, 4, \2
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	coord hl, 0, 8, \2
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@
	coord hl, 0, 12, \2
	call .LoadOneRowOf5BlocksFromHalfRightMetatile\@

; LoadOneQuarterUpperRightMetatile
	coord hl, 0, 16, \2
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

	coord hl, 2, 16, \2
	ld bc, SCREEN_WIDTH - 4
	call .LoadOneRowOf4UpperHalfBlocks\@
	coord hl, 18, 16, \2

; LoadOneQuarterUpperLeftMetatile
	ld a, [de]
	and a
	jr nz, .notMapBorderBlock3\@
	ld a, [hMapBorderBlock]
.notMapBorderBlock3\@
	swap a
	ld d, a
	and $f0

; fallthrough
.LoadOneQuarterMetatile\@:
	ld e, a
	ld a, d
	and $f
	add (wDecompressedMetatiles >> 8)
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
	add l
	ld l, a
	jr nc, .noCarry\@
	inc h
.noCarry\@
	ld a, [de]
	inc e
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ret
ENDM

	function_macro 1, wTileMap
	function_macro 2, wAttrMap
