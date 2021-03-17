BattleCommand_counter:
	ld a, 1
	ld [wAttackMissed], a

	; Doesn't work if the target is immune to this mvoe's type
	call BattleCommand_resettypematchup
	ld a, [wTypeMatchup]
	and a
	ret z

	call CheckOpponentWentFirst
	ret z

	; Only works if countering of the same move category
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp PHYSICAL
	ld a, 1 << PHYSICAL
	jr z, .got_cat
	ld a, 1 << SPECIAL
.got_cat
	push bc
	ld b, a
	ldh a, [hBattleTurn]
	and a
	ld a, b
	pop bc
	jr nz, .got_cat_opp_side
	swap a
.got_cat_opp_side
	ld hl, wMoveState
	and [hl]
	ret z

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
