BattleCommand_mirrormove:
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	jr z, .failed
	ld d, a

	call GetMoveIndexFromID
	ld a, h
	assert HIGH(STRUGGLE) == 0
	and a
	jr nz, .cphl_struggle
	ld a, l
	assert LOW(STRUGGLE) != 0
	cp LOW(STRUGGLE)
.cphl_struggle
	jr z, .failed
	ld a, h
	assert HIGH(MIRROR_MOVE) != 0
	cp HIGH(MIRROR_MOVE)
	jr c, .cphl_mirror_move
	jr nz, .cphl_mirror_move
	ld a, l
	assert LOW(MIRROR_MOVE) != 0
	cp LOW(MIRROR_MOVE)
.cphl_mirror_move
	jr z, .failed

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], d
	farcall UpdateMoveData
	farjp ResetTurn

.failed
	farjp ButItFailed
