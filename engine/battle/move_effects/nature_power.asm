BattleCommand_naturepower:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	farcall GetEnvironmentNaturePower
	call GetMoveIDFromIndex
	push af
	ld [wNamedObjectIndex], a
	call GetMoveName
	ld hl, NaturePowerTurnedInto
	call StdBattleTextbox

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	pop af
	ld [hl], a
	farcall UpdateMoveData
	farjp ResetTurn

.failed
	farjp ButItFailed
