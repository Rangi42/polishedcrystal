PlaceVWFString::
; Place string de at hl with flags in b and offset in c.
; Read while in ROM0 so [de] can be from any ROMX bank.
	farcall _BuildAppendVFWTextFunction
.loop
	ld a, [de]
	farcall _PlaceNextVWFChar
	ret z
	bit VWF_SINGLE_F, b
	jr z, .loop
	ret

GetVWFLength::
; Returns length of string de in a.
; Read while in ROM0 so [de] can be from any ROMX bank.
	push de
	push bc
	ld c, 0
.loop
	ld a, [de]
	farcall _GetNextVWFLength
	jr nz, .loop
	ld a, c
	pop bc
	pop de
	ret
