PlaceVWFString::
; Place string de at hl with flags in b and offset in c.
	; Read input in home to allow de to be in ROMX.
	ld a, [de]
	farcall _PlaceVWFString
	ret z
	bit VWF_SINGLE_F, b
	ret nz
	jr PlaceVWFString

GetVWFLength::
; Returns length of string de in a.
	push de
	push bc
	ld c, 0
.loop
	ld a, [de]
	farcall _GetVWFLength
	jr nz, .loop
	ld a, c
	pop bc
	pop de
	ret
