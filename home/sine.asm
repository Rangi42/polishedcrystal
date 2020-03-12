Cosine::
; Return d * cos(a) in hl
	add $10 ; 90 degrees
Sine::
; Return d * sin(a) in hl
; a is a signed 6-bit value.
	ld e, a
	farjp _Sine
