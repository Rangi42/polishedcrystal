BattleCommand_storedpower:
	ld hl, wCurDamage
	ld a, [hli]
	or [hl]
	ret z

	ld hl, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .ok  
	ld hl, wEnemyStatLevels
.ok
	lb bc, 0, 7
.loop
	ld a, [hli]
	sub BASE_STAT_LEVEL
	; Only count stat boosts
	jr c, .next
	add b
	ld b, a
.next
	dec c
	jr nz, .loop

	ld a, b
	and a
	; Do nothing if there are no boosts
	ret z

	; 0 boosts = x1
	inc a
	ldh [hMultiplier], a

	ld hl, wCurDamage
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	farcall Multiply

	ldh a, [hQuotient + 0]
	and a

	; Set max damage if overflow
	jr z, .set_damage
	ld a, $FF
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], a
	ret

.set_damage
	ldh a, [hQuotient + 1]
	ld hl, wCurDamage
	ld [hli], a
	ldh a, [hQuotient + 2]
	ld [hl], a
	ret