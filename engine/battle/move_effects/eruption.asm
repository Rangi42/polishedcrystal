BattleCommand_eruption:
	ld a, [wAttackMissed]
	and a
	ret nz

	call GetMaxHP
	; Max HP in bc
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP
.got_hp
	ld d, [hl]
	inc hl
	ld e, [hl]
.truncate_loop
	ld a, b
	and a
	jr z, .done_truncating
	srl b
	rr c
	srl d
	rr e
	jr .truncate_loop
.done_truncating
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, e
	ldh [hMultiplicand + 2], a
	ld a, 150
	ldh [hMultiplier], a
	farcall Multiply
	ld a, c
	ldh [hDivisor], a
	ld b, 4
	farcall Divide
	ldh a, [hQuotient + 2]
	and a
	ld b, a
	jr nz, .got_power
	inc b ; b = 1
.got_power
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
	ld [hl], b
.done
; Get the rest of the damage formula variables based on the new power.
	push af
	farcall BattleCommand_damagestats ; damagestats
	pop af
	ret
