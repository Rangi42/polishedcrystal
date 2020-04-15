FIRST_VWF_CHAR EQU " " ; first printable character
FAILSAFE_VWF_CHAR EQU "!"

_PlaceVWFString::
; Place string de at hl with flags in b and offset in c.
; Returns z usually, nz if we've doing single-character output and we haven't
; reached the string terminator (de is then advanced a character).
	ld a, b
	ldh [hVWFFlags], a

	ld a, [de]
	inc de
	cp "@"
	ret z

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
	; get VWFCharacterGFX + a * LEN_1BPP_TILE
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
	ld a, d
	push hl
	call .AppendText
	ld a, e
	ld de, 1 tiles
	add hl, de
	call .AppendText
	pop hl
	pop de
	pop af
	inc hl
	inc hl
	dec a
	jr nz, .insert_loop
	pop bc

	ld a, b
	add c
	ld c, a

	pop hl
	pop de

	ldh a, [hVWFFlags]
	ld b, a
	bit VWF_SINGLE_F, b
	ret nz

	jr _PlaceVWFString

.AppendText:
	push bc
	push hl
	ld hl, hVWFFlags
	ld b, [hl]
	pop hl
	bit VWF_INVERT_F, b
	jr nz, .xor
	; inc/dec in case text is opaque
	inc hl
	or [hl]
	dec hl
	jr .combine_done
.xor
	inc hl
	xor [hl]
	dec hl
.combine_done
	bit VWF_OPAQUE_F, b
	pop bc
	jr nz, .opaque
	ld [hli], a
	ld [hld], a
	ret
.opaque
	inc hl
	ld [hld], a
	ret

_GetVWFLength::
; Returns length of string de in a.
	push de
	push bc
	ld c, 0

.loop
	ld a, [de]
	inc de
	cp "@"
	jr z, .done

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
	jr .loop

.done
	ld a, c
	pop bc
	pop de
	ret

INCLUDE "gfx/vwf.asm"
