PrintKeyItemDescription:
	ld hl, KeyItemDescriptions
	ld a, [wCurKeyItem]
	jr PrintDescription

PrintItemDescription: ; 0x1c8955
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
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	jp PlaceString
; 0x1c8987

PrintTMHMDescription:
; Print the description for TM/HM [wCurSpecies] at de.
	ld a, [wCurSpecies]
	inc a
	ld [wCurTMHM], a
	ld [wCurTMHMBuffer], a
	push de
	predef GetTMHMMove
	pop hl
	ld a, [wd265]
	ld [wCurSpecies], a
	predef PrintMoveDesc
	ret

INCLUDE "data/items/descriptions.asm"
