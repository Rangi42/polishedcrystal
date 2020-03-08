IsInArray::
; Find value a for every de bytes in array hl.
; Return index in b, and carry if found.
	ld b, 0
	ld c, a
.loop
	ld a, [hl]
	cp -1
	ret z ; carry can never be set for "cp -1"
	cp c
	scf
	ret z
	inc b
	add hl, de
	jr .loop

SkipNames::
; Skip a names.
	ld bc, NAME_LENGTH
	and a
	ret z
.loop
	add hl, bc
	dec a
	jr nz, .loop
	ret

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
