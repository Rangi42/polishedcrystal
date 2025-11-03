Multiply::
; Multiply hMultiplicand (3 bytes) by hMultiplier. Result in hProduct.
; All values are big endian.
	push hl
	push de
	push bc

	call ._Multiply

	jmp PopBCDEHL

._Multiply
; Multiply hMultiplicand (3 bytes) by hMultiplier. Result in hProduct.
; All values are big endian.

; hMultiplier is one byte.
; performs dehl * a
	ldh a, [hMultiplicand]
	ld e, a
	ldh a, [hMultiplicand + 1]
	ld h, a
	ldh a, [hMultiplicand + 2]
	ld l, a

	xor a
	ld d, a
	ldh [hProduct], a
	ldh [hProduct + 1], a
	ldh [hProduct + 2], a
	ldh [hProduct + 3], a
	ldh a, [hMultiplier]
	and a
	ret z
.loop
	rra
	jr nc, .next

	ld c, a ; store multiplier in c

	ldh a, [hProduct + 3]
	add l
	ldh [hProduct + 3], a
	ldh a, [hProduct + 2]
	adc h
	ldh [hProduct + 2], a
	ldh a, [hProduct + 1]
	adc e
	ldh [hProduct + 1], a
	ldh a, [hProduct]
	adc d
	ldh [hProduct], a

	ld a, c ; retrieve multiplier

.next
	add hl, hl
	rl e
	rl d
	and a
	jr nz, .loop
	ret

Divide::
; Divide hDividend length b (max 4 bytes) by hDivisor. Result in hQuotient.
; All values are big endian.
	push hl
	push de
	push bc

	call ._Divide

	jmp PopBCDEHL

._Divide
; Divide hDividend length b (max 4 bytes) by hDivisor. Result in hQuotient.
; All values are big endian.
	ldh a, [hDivisor]
	and a
	jr z, .div0

	ldh a, [hDivisor]
	ld d, a
	ld c, LOW(hDividend)
	ld e, 0
	ld l, e
.loop
	push bc
	ld b, 8
	ldh a, [c]
	ld h, a
	ld l, 0
.loop2
	sla h
	rl e
	ld a, e
	jr c, .carry
	cp d
	jr c, .skip
.carry
	sub d
	ld e, a
	inc l
.skip
	dec b
	jr z, .done
	sla l
	jr .loop2
.done
	ld a, c
	add hMathBuffer - hDividend
	ld c, a
	ld a, l
	ldh [c], a
	pop bc
	inc c
	dec b
	jr nz, .loop

	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ldh [hDividend + 3], a
	ld a, e
	ldh [hRemainder], a
	ld a, c
	sub LOW(hDividend)
	ld b, a
	ld a, c
	add hMathBuffer - hDividend - 1
	ld c, a
	ldh a, [c]
	ldh [hDividend + 3], a
	dec b
	ret z
	dec c
	ldh a, [c]
	ldh [hDividend + 2], a
	dec b
	ret z
	dec c
	ldh a, [c]
	ldh [hDividend + 1], a
	dec b
	ret z
	dec c
	ldh a, [c]
	ldh [hDividend], a
	ret
.div0
	ld a, ERR_DIV_ZERO
	jmp Crash

Divide16::
; calculates bc / de, stores quotient in de and remainder in bc
; also stores quotient in hQuotient and remainder in hRemainder
	push hl
	call ._Divide16
	pop hl
	ret

._Divide16
	; calculates bc / de, stores quotient in de and remainder in bc
	; also stores quotient in hQuotient and remainder in hRemainder
	; does not preserve af or hl
	ld a, d
	and a
	jr z, .divisor_8_bit
	ld hl, 1
.initial_shift_loop
	bit 7, d
	jr nz, .main_division_loop
	sla e
	rl d
	sla l
	jr .initial_shift_loop
.main_division_loop
	ld a, c
	sub e
	ld a, b
	sbc d
	jr c, .remainder_smaller
	ld a, h
	add l
	ld h, a
	ld a, c
	sub e
	ld c, a
	ld a, b
	sbc d
	ld b, a
.remainder_smaller
	srl d
	rr e
	srl l
	jr nc, .main_division_loop
	ld e, h
	ld d, 0
	xor a
	ld hl, hDividend
	ld [hli], a
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, b
	ld [hli], a
	ld [hl], c
	ret
.divisor_8_bit
	ld a, e
	and a
	jr z, .division_by_zero
	ldh [hDivisor], a
	ld a, b
	ldh [hDividend], a
	ld a, c
	ldh [hDividend + 1], a
	ld b, 2
	call Divide
	ld hl, hQuotient + 1
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	ld c, [hl]
	xor a
	ld [hli], a
	ld [hl], c
	ld b, 0
	ret

.division_by_zero
	ld a, ERR_DIV_ZERO
	jmp Crash
