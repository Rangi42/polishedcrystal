GetTypeName:
; Copy the name of type [wNamedObjectIndex] to StringBuffer1.

	ld a, [wNamedObjectIndex]
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	ld e, [hl]
	add hl, de
	ld de, wStringBuffer1
	ld bc, MOVE_NAME_LENGTH
	rst CopyBytes
	ret

INCLUDE "data/types/names.asm"
