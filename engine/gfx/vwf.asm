DEF FIRST_VWF_CHAR EQU ' ' ; first printable character
DEF FAILSAFE_VWF_CHAR EQU '.'

_BuildAppendVFWTextFunction::
; Build a function to write pixels in hAppendVWFText.
; - nothing:        or [hl] / ld [hld], a / ld [hl], a / ret
; - invert:        xor [hl] / ld [hld], a / ld [hl], a / ret
; - opaque:         or [hl] / ld [hld], a /              ret
; - invert+opaque: xor [hl] / ld [hld], a /              ret
	push af
	push hl
	ld hl, hAppendVWFText
	bit VWF_INVERT_F, b
	ld a, $ae ; xor [hl]
	jr nz, .invert
	ld a, $b6 ; or [hl]
.invert
	ld [hli], a
	ld a, $32 ; ld [hld], a
	ld [hli], a
	bit VWF_OPAQUE_F, b
	jr nz, .opaque
	ld a, $77 ; ld [hl], a
	ld [hli], a
.opaque
	ld [hl], $c9 ; ret
	pop hl
	pop af
	ret

_PlaceNextVWFChar::
; Place character a (just read from [de]) at hl with flags in b and offset in c.
; Advances de to the next character.
; Returns z if the character is the string terminator.
; Preserves the value of b.
	inc de
	cp '@'
	ret z

	push bc
	push de

	push hl
	sub FIRST_VWF_CHAR
	jr nc, .valid
	ld a, FAILSAFE_VWF_CHAR - FIRST_VWF_CHAR
.valid
	; get VWFWidths + a
	ld e, a
	ld d, 0
	ld hl, VWFWidths
	add hl, de
	ld b, [hl] ; b = width in pixels
	; get VWFCharacterGFX + a * TILE_1BPP_SIZE
	ld h, d
	ld l, e
	add hl, hl ; * 2
	add hl, hl ; * 4
	add hl, hl ; * 8
	ld de, VWFCharacterGFX
	add hl, de
	ld d, h ; de = 1bpp tile gfx
	ld e, l
	pop hl

	push hl

	push bc
	; one tile is 16 bytes, advance hl by bc>>3 tiles
	ld b, 0
	ld a, c
	and %11111000
	add a
	rl b
	ld c, a
	add hl, bc
	pop bc

	push bc
	ld a, c
	and %00000111
	ld c, a
	ld a, 8
.insert_loop
	push af
	ld a, [de]
	inc de
	push de
	ld d, a
	ld e, 0
	push bc
	inc c
.shift_loop
	dec c
	jr z, .shift_done
	srl d
	rr e
	jr .shift_loop
.shift_done
	pop bc
	inc hl
	push hl
	ld a, d
	call hAppendVWFText
	ld a, e
	ld de, 1 tiles + 1
	add hl, de
	call hAppendVWFText
	pop hl
	pop de
	pop af
	inc hl
	dec a
	jr nz, .insert_loop
	pop bc

	ld a, b
	add c
	ld c, a

	pop hl
	pop de
	pop af ; from push bc

	ld b, a
	or 1
	ret

_GetNextVWFLength::
; Returns length of character a (just read from [de]) in c.
; Advances de to the next character.
	inc de
	cp '@'
	ret z

	push hl
	push de
	sub FIRST_VWF_CHAR
	jr nc, .valid
	ld a, FAILSAFE_VWF_CHAR - FIRST_VWF_CHAR
.valid
	; get VWFWidths + a
	ld e, a
	ld d, 0
	ld hl, VWFWidths
	add hl, de
	ld a, [hl] ; b = width in pixels
	add c
	ld c, a
	pop de
	pop hl
	or 1
	ret

VWFWidths:
INCBIN "gfx/font/space.vwf.widths"
INCBIN "gfx/font/vwf.vwf.widths"

VWFCharacterGFX:
INCBIN "gfx/font/space.vwf.1bpp"
INCBIN "gfx/font/vwf.vwf.1bpp"
