_Sine::
; A simple sine function.
; Return d * sin(e) in hl.

; e is a signed 6-bit value.
	ld a, e
	and %111111
	cp  %100000
	jr nc, .negative

	call .ApplySineWave
	ld a, h
	ret

.negative
	and %011111
	call .ApplySineWave
	ld a, h
	cpl
	inc a
	ret

.ApplySineWave:
	ld e, a
	ld a, d
	ld d, 0
	ld hl, .sinewave
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, 0

; Factor amplitude
.multiply
	srl a
	jr nc, .even
	add hl, de
.even
	sla e
	rl d
	and a
	jr nz, .multiply
	ret

.sinewave
; $20 samples of sin(x) from x=0 to x<32768 (pi radians)
x = 0
rept $20
	dw (sin(x) + (sin(x) & $ff)) >> 8 ; round up
x += DIV(32768, $20) ; a circle has 65536 "degrees"
endr
