BattleCommand_mirrormove:
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	jr z, .failed
	ld d, a

	call GetMoveIndexFromID
	assert HIGH(STRUGGLE) == 0
	ld a, h
	and a
	jr nz, .cphl_struggle_mm
	ld a, l
	cp LOW(STRUGGLE)
.cphl_struggle_mm
	jr z, .failed
	ld a, h
	cp HIGH(MIRROR_MOVE)
	jr c, .cphl_mirror_move
	jr nz, .cphl_mirror_move
	ld a, l
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
