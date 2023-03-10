_Predef::
; Call predefined function on the stack.
; Preserves a, bc, de, hl.
	ldh [hFarCallSavedA], a
	ld a, h
	ldh [hFarCallSavedH], a
	ld a, l
	ldh [hFarCallSavedL], a
	pop hl
	ld a, [hli]
	bit 7, a
	jr nz, .jump
	push hl
.jump
	ld l, a
	ldh a, [hROMBank]
	push af
	ld a, BANK(PredefPointers)
	rst Bankswitch
	push de
	ld a, l
	and $7f
	ld e, a
	ld d, 0
	ld hl, PredefPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, d
	pop de
	and a
	jmp nz, _DoFarCall_BankInA
	pop af
	push af
	jmp _DoFarCall_BankInA
