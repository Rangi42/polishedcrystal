PrintMonTypes:
; Print one or both types of [wCurSpecies]
; on the stats screen at hl.
; PrintMonTypes is only called for the stats screen,
; so assume that the full data is in wTempMon and
; wBaseData already.

	push hl
	ld a, [wBaseType1]
	call .Print

	; Single-typed monsters really
	; have two of the same type.
	ld a, [wBaseType1]
	ld b, a
	ld a, [wBaseType2]
	cp b
	pop hl
	ret z

	ld bc, SCREEN_WIDTH
	add hl, bc

.Print:
	ld b, a

	push hl
	add a
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl

	rst PlaceString
	ret

GetTypeName:
; Copy the name of type [wNamedObjectIndex] to StringBuffer1.

	ld a, [wNamedObjectIndex]
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
	ld bc, MOVE_NAME_LENGTH
	rst CopyBytes
	ret

INCLUDE "data/types/names.asm"
