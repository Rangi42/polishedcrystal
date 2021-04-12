GetLandmarkCoords:
; Return coordinates (d, e) of landmark e.
	push hl
	ld l, e
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, Landmarks
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	ret

GetLandmarkName::
; Copy the name of landmark e to wStringBuffer1.
	push hl
	push de
	push bc

	ld l, e
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, Landmarks + 2
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld de, wStringBuffer1
	ld c, 23
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy

	jmp PopBCDEHL

INCLUDE "data/maps/landmarks.asm"
