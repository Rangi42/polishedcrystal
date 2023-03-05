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
	ld a, 10
	ldh [hMultiplier], a
	farcall Multiply
	ld a, 25
	ldh [hDivisor], a
	ld b, 4
	farcall Divide
	ldh a, [hQuotient + 2]
	ld d, a
	pop bc
	ret
