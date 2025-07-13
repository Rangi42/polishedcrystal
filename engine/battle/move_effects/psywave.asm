BattleCommand_psywave:
	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonLevel]
	jr z, .got_level
	ld a, [wEnemyMonLevel]
.got_level
	ld c, a
	ld a, 101
	call BattleRandomRange
	add a, 50
	ld b, a
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, b
	ldh [hMultiplicand + 2], a
	ld a, c
	ldh [hMultiplier], a
	farcall Multiply
	ld a, 100
	ldh [hDivisor], a
	ld b, $4
	farcall Divide
	ldh a, [hQuotient + 2]
	and a
	jr nz, .got_damage
	ld a, 1
.got_damage
	ld hl, wCurDamage + 1
	ld [hld], a
	xor a
	ld [hl], a
	ret