LoadIndirectPointer::
	; in: a:hl: indirect table, bc: index
	; out: a:hl: pointer to element, b: copy of a, c: clobbered, de: preserved, zero flag: set if pointer is null
	push de
	ld d, a
	ldh a, [hROMBank]
	push af
	ld a, d
	rst Bankswitch
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	add a, a
	jr nc, .loop
	res 7, d
	dec bc
	ld a, b
	and c
	inc a
	jr nz, .loop
.null
	ld hl, 0
	ld b, h
.done
	pop af
	rst Bankswitch
	pop de
	ld a, h
	or l
	ld a, b
	ret

.next
	inc hl
	inc hl
	inc hl
	cpl
	inc a
	add a, c
	ld c, a
	jr c, .loop ;subtracting by addition has the carry flipped
	dec b
.loop
	ld a, [hli]
	and a
	jr z, .null
	inc b
	dec b
	jr nz, .next
	cp c
	jr c, .next
	jr z, .next

	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .done ;no point in setting them to zero if they already are
	ld a, c
	ld c, e
	ld e, b
	ld b, d
	call AddNTimes
	ld b, e
	jr .done

LoadDoubleIndirectPointer::
	; for indirect tables of near pointers to data, used for structures of varying size
	; same calling convention as LoadIndirectPointer
	call LoadIndirectPointer
	call nz, GetFarWord
	ld a, b
	ret
