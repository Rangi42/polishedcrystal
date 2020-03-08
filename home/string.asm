InitName::
; Intended for names, so this function is limited to ten characters.
	ld c, 10
InitString::
; Init a string of length c.
	push hl
_InitString::
; if the string pointed to by hl is empty (defined as "zero or more spaces
; followed by a null"), then initialize it to the string pointed to by de.
	push bc
.loop
	ld a, [hli]
	cp "@"
	jr z, .blank
	cp " "
	jr nz, .notblank
	dec c
	jr nz, .loop
.blank
	pop bc
	ld l, e
	ld h, d
	pop de
	ld b, 0
	inc c
	rst CopyBytes
	ret
.notblank
	pop bc
	pop hl
	ret

FarCopyRadioText::
	inc hl
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	rst Bankswitch
	ld l, e
	ld h, d
	ld de, wRadioText
	ld bc, 2 * SCREEN_WIDTH
	rst CopyBytes
	pop af
	rst Bankswitch
	ret
