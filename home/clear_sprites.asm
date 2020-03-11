ClearSprites::
; Erase OAM data
	ld hl, wVirtualOAM
	ld b, wVirtualOAMEnd - wVirtualOAM
	xor a
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

HideSprites::
; Set all OAM y-positions to 160 to hide them offscreen
	ld hl, wVirtualOAM
	ld de, 4 ; length of an OAM struct
	ld b, (wVirtualOAMEnd - wVirtualOAM) / 4 ; number of OAM structs
	ld a, 160 ; y
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret
