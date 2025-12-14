Timer::
; The timer interrupt.
	; We don't want this interrupt to mess with LCD interrupts. Thus,
	; immediately re-allow interrupts. This will add one cycle of
	; worst-case interrupt lag, which we will have to work with.
	ei
	nop

	push af

	ldh a, [hMobile]
	bit MOBILE_NEXTBYTE_F, a
	jr z, .dont_send

	; Tell mobile serial to pay attention to this byte unless we're in standby.
	; The reason for this is to avoid a corner case when VBlank keep-alive
	; coincides with changing the value of hMobile.
	res MOBILE_NEXTBYTE_F, a
	cp MOBILE_STANDBY
	jr z, .standby
	set MOBILE_USEFUL_F, a
.standby
	ldh [hMobile], a

	; Request next byte
	ld l, LOW(rSC)
	ld [hl], SC_START | SC_FAST | SC_INTERNAL

	; Set the timer up for the next interrupt.
	ld a, MOBILE_TMA
	ld l, LOW(rTIMA)
	ld [hl], a
.dont_send
	pop af
	reti
