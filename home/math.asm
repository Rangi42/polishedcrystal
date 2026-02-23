; Returns `a * c` in `a`
; @input `a` = First value
; @input `c` = Second value
; @output `a` -> `a * c` 
; @clobbers `a`
SimpleMultiply::
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

; Returns `a / c` in `b` and `a`.
; If `c` is `0`, the game will crash.
; @input `a` = First value
; @input `c` = Second value
; @output `a` -> `a % c`
; @output `b` -> `a / c`
; @clobbers `a`, `b`, `c`
SimpleDivide::
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

; Multiplies and divides `hMultiplicand` by the nybbles in `a`
; @input `hMultiplicand` = Value to modify
; @input `a` = $xy multiply by x, divide by y
; @output `hMultiplicand`/`hQuotient` -> Quotient
; @output `hRemainder` -> Remainder
; @clobbers `a`
MultiplyAndDivide::
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
