PrintKeyItemDescription:
	ld hl, KeyItemDescriptions
	ld a, [wCurKeyItem]
	jr PrintDescription

PrintItemDescription:
; Print the description for item [wCurSpecies] at de.
	ld hl, ItemDescriptions
	ld a, [wCurSpecies]
PrintDescription:
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	push de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	rst PlaceString
	ret

PrintExpCandyDescription:
	ld hl, ExpCandyDescriptions
	ld a, [wCurSpecies]
	jr PrintDescription

PrintTMHMDescription:
; Print the description for TM/HM [wCurMove] at de.
	ld a, [wCurMove]
	inc a
	ld [wCurTMHM], a
	ld [wTempTMHM], a
	push de
	predef GetTMHMMove
	pop hl
	ld a, [wTempTMHM]
	ld [wCurMove], a
	predef_jump PrintMoveDesc

INCLUDE "data/items/descriptions.asm"
