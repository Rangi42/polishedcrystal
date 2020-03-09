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
	and a
	ret z
.loop
	inc b
	sub c
	jr nc, .loop
	ret z
	add c
	dec b
	ret
.div0
	rst 0 ; crash

Multiply::
; Multiply hMultiplicand (3 bytes) by hMultiplier. Result in hProduct.
; All values are big endian.
	push hl
	push bc
	push de

	farcall _Multiply

	pop de
	pop bc
	pop hl
	ret

Divide::
; Divide hDividend length b (max 4 bytes) by hDivisor. Result in hQuotient.
; All values are big endian.
	push hl
	push de
	push bc

	homecall _Divide

	pop bc
	pop de
	pop hl
	ret

MultiplyAndDivide::
; a = $xy: multiply multiplicands by x, then divide by y
; Used for damage modifiers, catch rate modifiers, etc.
	push bc
	push hl
	ld b, a
	swap a
	and $f
	ld hl, hMultiplier
	ld [hl], a
	push bc
	call Multiply
	pop bc
	ld a, b
	and $f
	ld [hl], a
	ld b, 4
	call Divide
	pop hl
	pop bc
	ret
