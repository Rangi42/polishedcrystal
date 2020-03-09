BattleCommand_gyroball:
	push bc
	push de
	call SwitchTurn
	farcall GetSpeed
	push bc
	call SwitchTurn
	farcall GetSpeed
	pop de
	; User speed in BC, target speed in DE

	; This is counterintuitive (the logical choice is to set speed to 1),
	; but is how it's done in VII...
	ld a, b
	or c
	ld a, 1
	jr z, .got_power

	; We can't divide numbers >255, so scale down speed in that case
.scaledown_loop
	ld a, b
	and a
	jr z, .scaledown_ok
	srl b
	rr c
	srl d
	rr e
	jr .scaledown_loop
.scaledown_ok
	; Base Power = 25 * (Target Speed / User Speed), capped at 150
	xor a
	ldh [hMultiplicand + 0], a
	ld a, d
	ldh [hMultiplicand + 1], a
	ld a, e
	ldh [hMultiplicand + 2], a
	ld a, 25
	ldh [hMultiplier], a
	call Multiply

	ld a, c
	ldh [hDivisor], a
	ld b, 4
	call Divide

	; Cap at min 1, max 150
	ld hl, hMultiplicand
	ld a, [hli]
	or [hl]
	ld a, 150
	jr nz, .got_power
	inc hl
	ld a, [hl]
	and a
	jr nz, .nonzero_power
	ld a, 1
	jr .got_power

.nonzero_power
	cp 151
	jr c, .got_power

	ld a, 150
.got_power
	pop de
	ld d, a
	pop bc
	ret
