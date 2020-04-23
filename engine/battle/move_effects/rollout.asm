MAX_ROLLOUT_COUNT EQU 5

BattleCommand_rolloutpower:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	ret nz

	; returns user rollout count in de and substatus3 in hl
	call CheckRampageStatusAndGetRolloutCount

	ld a, [wAttackMissed]
	and a
	jr z, .hit

	res SUBSTATUS_ROLLOUT, [hl]
	ret

.hit
	bit SUBSTATUS_ROLLOUT, [hl]
	jr z, .starting_rollout
	ld a, [de]
.starting_rollout
	inc a ; ld a, 1 if zero flag set
	ld [de], a
	ld b, a
	set SUBSTATUS_ROLLOUT, [hl]
	cp MAX_ROLLOUT_COUNT
	jr c, .done_with_substatus_flag
	res SUBSTATUS_ROLLOUT, [hl]

.done_with_substatus_flag
	inc hl ; SUBSTATUS_CURLED in substatus4
	bit SUBSTATUS_CURLED, [hl]
	jr z, .not_curled
	inc b
.not_curled
.loop
	dec b
	ret z

	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .loop

	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret
