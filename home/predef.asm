_Predef::
; Call predefined function on the stack.
; Preserves af, bc, de, hl.
	ld [wFarCallSavedA], a
	ld a, h
	ld [wFarCallHLBuffer], a
	ld a, l
	ld [wFarCallHLBuffer + 1], a
	pop hl
	ld a, [hli]
	ld [hBuffer], a
	push af
	sub $80
	jr nc, .jump
	pop af
	push hl
	jr .ok
.jump
	ld [hBuffer], a
	pop af
.ok
	ld a, [hROMBank]
	push af
	ld a, BANK(PredefPointers)
	rst Bankswitch
	push de
	ld a, [hBuffer]
	ld e, a
	ld d, 0
	ld hl, PredefPointers
	push af
	add hl, de
	add hl, de
	add hl, de
	pop af
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, d
	pop de
	push af
	and a
	jr nz, .bankswitch
	pop af
	pop af
	push af
	push af
.bankswitch
	pop af
	rst Bankswitch
	call RetrieveHLAndCallFunction
	jr ReturnFarCall
