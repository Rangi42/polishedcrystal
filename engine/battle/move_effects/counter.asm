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

	; Don't double damage twice for Parental Bond
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	jr nz, .got_damage

	ld hl, wCurDamage + 1
	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	adc a

	; Carry means overflow, deal $ff** damage.
	ld [hl], $ff
	jr c, .got_damage

	; Ensure that we deal at least 1 damage.
	ld [hli], a
	or [hl]
	jr nz, .got_damage
	inc [hl] ; damage = 1
.got_damage
	xor a
	ld [wAttackMissed], a
	ret
