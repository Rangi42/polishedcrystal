MAX_ROLLOUT_COUNT EQU 5

BattleCommand_rolloutpower:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	ret nz

	ld hl, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_rollout_count
	ld hl, wEnemyRolloutCount

.got_rollout_count
	ld a, [wAttackMissed]
	and a
	jr z, .hit

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_ROLLOUT, [hl]
	ret

.hit
	inc [hl]
	ld a, [hl]
	ld b, a
	cp MAX_ROLLOUT_COUNT
	jr c, .not_done_with_rollout

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_ROLLOUT, [hl]
	jr .done_with_substatus_flag

.not_done_with_rollout
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_ROLLOUT, [hl]

.done_with_substatus_flag
	; ld a, BATTLE_VARS_SUBSTATUS4
	; call GetBattleVar
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
