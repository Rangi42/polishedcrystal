InitName::
; If the string pointed to by hl is empty (defined as "zero or more spaces
; followed by a null"), then initialize it to the string pointed to by de.
; Intended for names, so this function is limited to ten-character strings.
	ld c, NAME_LENGTH - 1
	push hl
	push bc
.loop
	ld a, [hli]
	cp '@'
	jr z, .blank
	cp ' '
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
	inc hl ; skip '<FAR>'

	ldh a, [hROMBank]
	push af

	ld a, [hli]
	ld d, a
	res 7, d
	ld a, [hli]
	ld e, a
	ld a, [hli]
	rst Bankswitch

	ld l, e
	ld h, d
	call PrepareToDecompressRadioText

.loop
	call DecompressStringToRAM
	cp '@'
	jr z, .loop ; <DONE> terminates radio lines, not @

	pop af
	rst Bankswitch
	ret

PrepareToDecompressRadioText:
	ld de, wRadioCompressedText
	push de
	ld bc, SCREEN_WIDTH * 2
	rst CopyBytes
	pop hl
	ld de, wRadioText
	ld a, [hli]
	ld [de], a
	inc de
	ret
