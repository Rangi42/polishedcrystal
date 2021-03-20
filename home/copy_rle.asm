CopyRLE::
; Copy bytes from hl to de
; Format: value, count
; Terminated with $ff
.loop
	ld a, [hli]
	inc a
	ret z
	dec a
	ld c, [hl]
	inc hl
.load
	ld [de], a
	inc de
	dec c
	jr nz, .load
	jr .loop
