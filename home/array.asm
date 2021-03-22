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

ArrayIsUnique:
; Check if any of the (single-byte) indexes referred to by hl is identical.
; a is size of array, b is 1 if index value 0 should be ignored, 0 otherwise,
; c is distance between array indexes. Returns z if all elements are unique,
; otherwise nz. Preserves a, bc, de, hl.
	push hl
	push de
	push bc
	push af
	and a
	jr z, .done
	dec a
	jr z, .done

	ld e, a
.outer_loop
	push hl
	ld d, e
	ld a, [hl]
	bit 0, b
	jr z, .inner_loop
	and a
	jr z, .next
.inner_loop
	push bc
	ld b, 0
	add hl, bc
	pop bc
	cp [hl]
	jr z, .identical
	dec d
	jr nz, .inner_loop
.next
	pop hl
	push bc
	ld b, 0
	add hl, bc
	pop bc
	dec e
	jr nz, .outer_loop
	jr .done
.identical
	pop hl
	or 1
	; fallthrough
.done
	pop bc
	ld a, b
	jp PopBCDEHL

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
