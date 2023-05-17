Cosine::
; Return d * cos(a) in hl
	add $10 ; 90 degrees
Sine::
; A simple sine function.
; Return d * sin(a) in hl.

; a is a signed 6-bit value.
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
	ld e, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
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
; sample sin(x) from x=0 to x<0.5 turns (pi radians)
for x, 32
	dw sin(x * 0.5 / 32)
endr
