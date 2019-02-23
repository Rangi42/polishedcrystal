_DoFadePalettes::
; w(BG|OB)Pals: Current palettes
; wUnkn(BG|OB)Pals: Palettes we're fading towards
; c: Fade frames
; wPalFadeMode can be 0 (fade everything), 1 (fade BG), 2 (fade OBJ)
	ld a, [rSVBK]
	push af
	push bc
	push de
	push hl
	ld a, BANK(wBGPals)
	ld [rSVBK], a

	ld a, c
	and a
	ld [wPalFadeDelay], a
	jr nz, .outer_loop
	call SetPalettes
	jp .done

.outer_loop
	ld a, [wPalFadeMode]
	and a
	ld hl, wBGPals
	ld d, 4 * 16 ; colors, palettes
	jr z, .inner_loop
	dec a
	ld d, 4 * 8
	jr z, .inner_loop
	ld hl, wOBPals
.inner_loop
	push de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld bc, wUnknBGPals - wBGPals
	add hl, bc
	ld a, [hld]
	ld b, a
	ld c, [hl]
	push bc
	ld bc, wBGPals - wUnknBGPals
	add hl, bc
	pop bc

	; de: active pals, bc: pals we're fading towards (high endian)
	push hl

	; Red
	ld a, c
	and %00011111
	ld l, a
	ld a, e
	and %00011111
	call .fadeColorStep
	ld a, e
	and %11100000
	or l
	ld e, a

	; Green
	push bc
	call .getGreen
	ld l, a
	ld b, d
	ld c, e
	call .getGreen
	pop bc
	call .fadeColorStep
	ld a, l
	rlca
	rlca
	rlca
	rlca
	rlca
	and %11100000
	ld h, a
	ld a, e
	and %00011111
	or h
	ld e, a
	srl l
	srl l
	srl l
	ld a, d
	and %01111100
	or l
	ld d, a

	; Blue
	ld a, b
	call .getBlue
	ld l, a
	ld a, d
	call .getBlue
	call .fadeColorStep
	sla l
	sla l
	ld a, d
	and %00000011
	or l
	ld d, a

	; Store changed color
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	dec d
	jr nz, .inner_loop
	ld a, 1
	ld [hCGBPalUpdate], a
	call DelayFrame
	ld a, [wPalFadeDelay]
	dec a
	ld [wPalFadeDelay], a
	jp nz, .outer_loop
.done
	pop hl
	pop de
	pop bc
	pop af
	ld [rSVBK], a
	ret

.getGreen:
	srl b
	rr c
	srl b
	rr c
	ld a, c
	rrca
.getBlue:
	rrca
	rrca
	and %00011111
	ret

.fadeColorStep:
; Perform a single color fading step
; a: active color, l: color we're fading towards
	cp l
	ret z
	ld h, a
	push bc
	ld b, 0
	jr nc, .dec
	ld h, l
	ld l, a
	inc b
.dec
	; Check color difference
	ld a, h
	sub l
	ld c, a

	ld a, [wPalFadeDelay]
	cp c
	jr c, .dist_is_big

	; Approximates linear fading
	push bc
	call SimpleDivide
	and a
	ld a, b
	pop bc
	jr z, .no_remainder
	dec a
	jr z, .change_ok

.no_remainder
	cp c
	jr z, .change_ok
	jr nc, .no_change
.change_ok
	ld a, 1
	jr .got_change
.no_change
	xor a
	jr .got_change

.dist_is_big
	push bc
	ld b, c
	ld a, [wPalFadeDelay]
	ld c, a
	ld a, b
	call SimpleDivide
	ld a, b
	pop bc
.got_change
	ld c, a
	ld a, h
	sub c
	ld h, a
	ld a, l
	add c
	ld l, a
	dec b
	pop bc
	ret z
	ld l, h
	ret
