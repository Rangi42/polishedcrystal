BattleCommand_mirrormove:
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	jr z, .failed
	ld d, a

	call GetMoveIndexFromID
	cphl STRUGGLE
	jr z, .failed
	cphl MIRROR_MOVE
	jr z, .failed

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], d
	farcall UpdateMoveData
	farjp ResetTurn

.failed
	farjp ButItFailed
