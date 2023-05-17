SimpleMultiply::
; Return a * c.
	and a
	ret z

	push bc
	ld b, a
	xor a
.loop
	add c
	dec b
	jr nz, .loop
	pop bc
	ret

SimpleDivide::
; Divide a by c. Return quotient b and remainder a.
	inc c
	dec c
	jr z, .div0
	ld b, 0
.loop
	inc b
	sub c
	jr nc, .loop
	dec b
	add c
	ret
.div0
	ld a, ERR_DIV_ZERO
	jmp Crash

MultiplyAndDivide::
; a = $xy: multiply multiplicands by x, then divide by y
; Used for damage modifiers, catch rate modifiers, etc.
	push bc
	ld b, a

	ldh a, [hROMBank]
	push af
	ld a, BANK(Multiply)
	rst Bankswitch

	ld a, b
	swap a
	and $f
	ld c, LOW(hMultiplier)
	ldh [c], a
	call Multiply ; far-ok
	ld a, b
	and $f
	ldh [c], a
	ld b, 4
	call Divide ; far-ok

	pop af
	rst Bankswitch
	pop bc
	ret
