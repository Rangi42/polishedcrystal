BattleCommand_metalburst:
	ld a, 1
	ld [wAttackMissed], a

	; Doesn't work if the target is immune to this move's type
	call BattleCommand_resettypematchup
	ld a, [wTypeMatchup]
	and a
	ret z

	; Only works if user was hit
	ld a, 1 << PHYSICAL | 1 << SPECIAL
	call HasOpponentDamagedUs
	ret z

	; TODO: is this necessary? if it is, then Avalanche is broken because it
	; uses HasOpponentDamagedUs only (it can't check wCurDamage).
	ld hl, wCurDamage
	ld a, [hli]
	or [hl]
	ret z

	; Don't boost damage twice for Parental Bond
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	jr nz, .got_damage

	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	call HalveBC

	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc a, b
	ld [hl], a
	jr nc, .got_damage
	ld a, $ff
	ld [hli], a
	ld [hl], a

.got_damage
	xor a
	ld [wAttackMissed], a
	ret
