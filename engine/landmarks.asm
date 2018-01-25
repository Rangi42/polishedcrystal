GetLandmarkCoords: ; 0x1ca896
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
; 0x1ca8a5


GetLandmarkName:: ; 0x1ca8a5
; Copy the name of landmark e to StringBuffer1.
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

	ld de, StringBuffer1
	ld c, 23
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy

	pop bc
	pop de
	pop hl
	ret
; 0x1ca8c3


INCLUDE "data/maps/landmarks.asm"


RegionCheck: ; 0x1caea1
; Checks if the player is in Kanto or Johto.
; If in Johto, returns 0 in e.
; If in Kanto, returns 1 in e.
; If on Shamouti Island, returns 2 in e.
	call GetCurrentLandmark
	cp SHAMOUTI_LANDMARK
	jr nc, .shamouti
	cp KANTO_LANDMARK
	jr nc, .kanto
.johto
	ld e, JOHTO_REGION
	ret

.shamouti
	ld e, ORANGE_REGION
	ret

.kanto
	ld e, KANTO_REGION
	ret
