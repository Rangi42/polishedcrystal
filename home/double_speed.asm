; The CGB hardware introduces Double Speed Mode.
; While active, the clock speed is doubled.

; The hardware can switch between normal speed
; and double speed at any time, but LCD output
; collapses during the switch.

;NormalSpeed::
;	ld hl, rKEY1
;	bit 7, [hl]
;	jr nz, SwitchSpeed
;	ret

DoubleSpeed::
	ld hl, rKEY1
	bit 7, [hl]
	ret nz
	; fallthrough

SwitchSpeed::
	set 0, [hl]
	xor a
	ldh [rIF], a
	ldh [rIE], a
	ld a, $30
	ldh [rJOYP], a
	stop ; rgbasm adds a nop after this instruction by default
	ret
