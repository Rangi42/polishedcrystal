BattleCommand_counter:
	; Doesn't work if the target is immune to this move's type
	call BattleCommand_resettypematchup
	ld a, [wTypeMatchup]
	and a
	ret z

	ld a, ATKFAIL_GENERIC
	ld [wAttackMissed], a

	; Only works if countering of the same move category
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp PHYSICAL
	ld a, 1 << PHYSICAL
	jr z, .got_cat
	ld a, 1 << SPECIAL
.got_cat
	call HasOpponentDamagedUs
	ret z

	; TODO: is this necessary? if it is, then Avalanche is broken because it
	; uses HasOpponentDamagedUs only (it can't check wCurDamage).
	ld hl, wCurDamage
	ld a, [hli]
	or [hl]
	ret z

	; Don't double damage twice for Parental Bond
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	jr nz, .got_damage

	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	adc a
	ld [hl], a
	jr nc, .got_damage
	ld a, $ff
	ld [hli], a
	ld [hl], a

.got_damage
	xor a
	ld [wAttackMissed], a
	ret
