FarIsInByteArray:
; Find value c in array a:hl.
	call StackCallInBankA
.Function:
	ld a, c
	; fallthrough
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

IsInWordArray_NextItem:
	add hl, de
IsInWordArray::
; Same as IsInArray, but for word values. The value is input in bc; index not returned.
	ld a, [hli]
	and [hl]
	inc a
	ret z
	ld a, [hld]
	cp b
	jr nz, IsInWordArray_NextItem
	ld a, [hl]
	cp c
	jr nz, IsInWordArray_NextItem
	scf
	ret

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

SortItems:
; Sorts an array with a size up to a terminator sorting index of -1.
; Assumes that the sorting function performs an insertion swap as opposed to
; a pure swap.
; Input: hl = sorting index callback (in b: item index, out a: sort index)
; de = sorting function (swapping index a and b)
	xor a
	ld b, a
.outer_loop
	call _hl_
	ld c, a
	inc a
	ret z
.inner_loop
	inc b
	call _hl_
	inc a
	ret z
	dec a
	cp c
	ld c, a
	jr nc, .inner_loop
	push bc
	ld b, 0
.insertion_loop
	call _hl_
	cp c
	jr nc, .do_sort
	inc b
	jr .insertion_loop
.do_sort
	ld a, b
	pop bc
	push bc
	push hl
	push de
	call _de_
	pop de
	pop hl
	pop bc
	jr .outer_loop
