Timer::
; The timer interrupt.

	push af

	ldh a, [hMobile]
	bit MOBILE_NEXTBYTE_F, a
	jr z, .dont_send

	; Disable the timer
	push hl
	ld hl, rTAC
	ld [hl], 0

	; In the unlikely scenario that another timer interrupt triggered between
	; this one and disabling the timer, abort early and let the 2nd interrupt
	; do the rest.
	ld l, LOW(rIF)
	bit B_IF_TIMER, [hl]
	jr nz, .abort

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
	ld a, $bd
	ld l, LOW(rTIMA)
	ld [hl], a
	ld l, LOW(rTAC)
	ld [hl], TAC_START | TAC_65KHZ
.abort
	pop hl
.dont_send
	pop af
	reti
