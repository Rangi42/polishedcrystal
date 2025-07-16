BattleCommand_trumpcard:
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurMoveNum]
	ld hl, wBattleMonPP
	jr z, .got_move_num
	ld a, [wCurEnemyMoveNum]
	ld hl, wEnemyMonPP
.got_move_num
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	; got pp
	ld a, [hl]
	ld b, 200
	and a
	jr z, .got_power
	ld b, 80
	dec a
	jr z, .got_power
	ld b, 60
	dec a
	jr z, .got_power
	ld b, 50
	dec a
	jr z, .got_power
	ld b, 40
	; fallthrough
.got_power
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
	ld [hl], b
	ret
