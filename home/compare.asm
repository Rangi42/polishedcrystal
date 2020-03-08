StringCmp::
; Compare c bytes at de and hl.
; Return z if they all match, c if hl>de.
.loop
	ld a, [de]
	cp [hl]
	ret nz
	inc de
	inc hl
	dec c
	jr nz, .loop
	ret
