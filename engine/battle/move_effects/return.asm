BattleCommand_happinesspower:
	push bc
	ld hl, wBattleMonHappiness
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyMonHappiness
.ok
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	ld a, 102
	ldh [hMultiplier], a
	farcall Multiply
	ld a, MAX_RETURN_HAPPINESS
	ldh [hDivisor], a
	ld b, 4
	farcall Divide
	ldh a, [hQuotient + 2]

	; Clamp to max power of 102 to ensure it doesn't go beyond canon BP
	cp 102
	jr c, .got_bp
	ld a, 102
.got_bp
	ld d, a
	pop bc
	ret
