_Multiply::
; Multiply hMultiplicand (3 bytes) by hMultiplier. Result in hProduct.
; All values are big endian.

; hMultiplier is one byte.
; performs dehl * a
	ld a, [hMultiplicand]
	ld e, a
	ld a, [hMultiplicand + 1]
	ld h, a
	ld a, [hMultiplicand + 2]
	ld l, a

	xor a
	ld d, a
	ld [hProduct], a
	ld [hProduct + 1], a
	ld [hProduct + 2], a
	ld [hProduct + 3], a
	ld a, [hMultiplier]
	and a
	ret z
.loop
	rra
	jr nc, .next

	ld c, a ; store multiplier in c

	ld a, [hProduct + 3]
	add l
	ld [hProduct + 3], a
	ld a, [hProduct + 2]
	adc h
	ld [hProduct + 2], a
	ld a, [hProduct + 1]
	adc e
	ld [hProduct + 1], a
	ld a, [hProduct]
	adc d
	ld [hProduct], a

	ld a, c ; retrieve multiplier

.next
	add hl, hl
	rl e
	rl d
	and a
	jr nz, .loop
	ret

_Divide::
; Divide hDividend length b (max 4 bytes) by hDivisor. Result in hQuotient.
; All values are big endian.
	ld a, [hDivisor]
	and a
	jr z, .div0

	ld a, [hDivisor]
	ld d, a
	ld c, hDividend % $100
	ld e, 0
	ld l, e
.loop
	push bc
	ld b, 8
	ld a, [$ff00+c]
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
	ld a, b
	cp 1
	jr z, .done
	sla l
	dec b
	jr .loop2
.done
	ld a, c
	add hMathBuffer - hDividend
	ld c, a
	ld a, l
	ld [$ff00+c], a
	pop bc
	inc c
	dec b
	jr nz, .loop

	xor a
	ld [hDividend], a
	ld [hDividend + 1], a
	ld [hDividend + 2], a
	ld [hDividend + 3], a
	ld a, e
	ld [hRemainder], a
	ld a, c
	sub hDividend % $100
	ld b, a
	ld a, c
	add hMathBuffer - hDividend - 1
	ld c, a
	ld a, [$ff00+c]
	ld [hDividend + 3], a
	dec b
	ret z
	dec c
	ld a, [$ff00+c]
	ld [hDividend + 2], a
	dec b
	ret z
	dec c
	ld a, [$ff00+c]
	ld [hDividend + 1], a
	dec b
	ret z
	dec c
	ld a, [$ff00+c]
	ld [hDividend], a
	ret
.div0
	; deliberately crash the game (maybe make a real crash handler?)
	rst 0
