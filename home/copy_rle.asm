CopyRLE::
; Copy bytes from hl to de
; Format: value, count
; Terminated with b
.loop
	ld a, [hli]
	cp b
	ret z
	ld c, [hl]
	inc hl
.load
	ld [de], a
	inc de
	dec c
	jr nz, .load
	jr .loop
