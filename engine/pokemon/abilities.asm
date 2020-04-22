PrintAbility:
; Print ability b at hl.
	ld l, b
	ld h, 0
	ld bc, AbilityNames
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 3, 13
	rst PlaceString
	ret

BufferAbility:
	ld de, wStringBuffer1
_BufferAbility:
; Buffer name for b into wStringBuffer1
	ld l, b
	ld h, 0
	ld bc, AbilityNames
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp "@"
	ret z
	jr .loop

PrintAbilityDescription:
; Print ability description for b
; we can't use PlaceString, because it would linebreak with an empty line inbetween
	ld l, b
	ld h, 0
	ld bc, AbilityDescriptions
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 1, 15
	rst PlaceString
	ret

INCLUDE "data/abilities/names.asm"

INCLUDE "data/abilities/descriptions.asm"
