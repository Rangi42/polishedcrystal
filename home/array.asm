IsInByteArray::
	ld de, 1
IsInArray::
; Find value a for every de bytes in array hl.
; Return index in b, and carry if found.
	ld b, 0
	ld c, a
.loop
	ld a, [hl]
	cp c
	scf
	ret z
	cp -1 ; clears carry
	ret z
	inc b
	add hl, de
	jr .loop

SkipNames::
; Skip a names.
	ld bc, NAME_LENGTH
	; fallthrough
_AddNTimes::
; Add bc * a to hl. Don't optimize this for space.
	and a
	ret z

	push bc
.loop
	rra ; and a from below and above resets carry
	jr nc, .noadd
	add hl, bc
.noadd
	sla c
	rl b
	and a
	jr nz, .loop
	pop bc
	ret

GetHourIntervalValue::
	ldh a, [hHours]
GetIntervalValue::
; Input: hl = sorted array of db start, value; a = key
; Output: a = first value where key < start
.loop
	cp [hl]
	inc hl
	jr c, .done
	inc hl
	jr .loop
.done
	ld a, [hl]
	ret
