PrintNature:
; Print nature b at hl.
	push hl
	ld hl, NatureNames
	jr _PrintNatureProperty

PrintNatureIndicators:
; Print indicators for nature b at hl.
	push hl
	ld hl, NatureIndicators
_PrintNatureProperty:
	ld a, b
	ld e, a
	ld d, 0
	add hl, de
	ld e, [hl]
	add hl, de
	ld e, l
	ld d, h
	pop hl
	rst PlaceString
	ret

INCLUDE "data/natures.asm"
