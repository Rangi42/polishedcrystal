BattleCommand_ohko:
	farcall ResetDamage
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and %01111111
	jr z, .no_effect

	; OHKO moves fail on higher level targets
	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wEnemyMonLevel]
	ld c, a
	ldh a, [hBattleTurn]
	and a
	jr z, .got_levels
	ld a, c
	ld c, b
	ld b, a
.got_levels
	ld a, b
	sub a, c
	jr c, .failed

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	call GetMoveIndexFromID
	ld a, h
	assert HIGH(SHEER_COLD) != 0
	cp HIGH(SHEER_COLD)
	jr c, .cphl_sheer_cold
	jr nz, .cphl_sheer_cold
	ld a, l
	assert LOW(SHEER_COLD) != 0
	cp LOW(SHEER_COLD)
.cphl_sheer_cold
	jr nz, .ok
	; Sheer Cold fails on ice types
	ld a, ICE
	farcall CheckIfTargetIsSomeType
	jr z, .no_effect
.ok
	ld a, -1
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ret

.no_effect
	ld a, ATKFAIL_IMMUNE
	jr .set_fail
.failed
	ld a, ATKFAIL_GENERIC
	; fallthrough
.set_fail
	ld [wAttackMissed], a
	ret