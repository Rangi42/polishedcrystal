BattleCommand_sleeptalk:
	call ClearLastMove
	ld a, [wAttackMissed]
	and a
	jr nz, .fail
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves + 1
	ld a, [wPlayerDisableCount]
	jr z, .got_moves
	ld hl, wEnemyMonMoves + 1
	ld a, [wEnemyDisableCount]
.got_moves
	swap a
	and $f
	dec a
	ld d, a
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	jr z, .fail
	ld a, [hl]
	and a
	jr z, .fail
	call .safely_check_has_usable_move
	jr c, .fail
	dec hl
.sample_move
	push hl
	call BattleRandom
	and %11 ; NUM_MOVES - 1
	cp d
	jr z, .sample_move
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .sample_move
	ld e, a
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp e
	jr z, .sample_move
	ld a, e
	call .check_two_turn_move
	jr z, .sample_move
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld a, e
	ld [hl], a
	call CheckUserIsCharging
	jr nz, .charging
	ld a, [wKickCounter]
	push af
	call BattleCommand_lowersub
	pop af
	ld [wKickCounter], a
.charging
	call LoadMoveAnim
	call UpdateMoveData
	jmp ResetTurn

.fail
	call AnimateFailedMove
	jmp TryPrintButItFailed

.safely_check_has_usable_move
	push hl
	push de
	push bc
	call .check_has_usable_move
	jmp PopBCDEHL

.check_has_usable_move
	dec hl
	push hl
	ld c, d
	ld b, 0
	add hl, bc
	ld b, [hl]
	pop hl
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld c, a
	dec hl
	ld d, NUM_MOVES
.loop2
	ld a, [hl]
	and a
	jr z, .carry

	cp c
	jr z, .nope
	cp b
	jr z, .nope

	call .check_two_turn_move
	jr nz, .no_carry

.nope
	inc hl
	dec d
	jr nz, .loop2

.carry
	scf
	ret

.no_carry
	and a
	ret

.check_two_turn_move
	push hl
	push de
	push bc

	ld b, a
	farcall GetMoveEffect
	ld a, b

	pop bc
	pop de
	pop hl

	cp EFFECT_SOLAR_BEAM
	ret z
	cp EFFECT_FLY
	ret
