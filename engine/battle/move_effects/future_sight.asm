BattleCommand_checkfuturesight:
	call GetFutureSightUser
	ret c
	ld b, futuresight_command
	jp SkipToBattleCommandAfter

BattleCommand_futuresight:
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerFutureSightCount
	ld bc, wCurBattleMon
	jr z, .got_future
	ld hl, wEnemyFutureSightCount
	ld bc, wCurOTMon
.got_future
	ld a, [hl]
	and a
	jr nz, .failed

	; end of turn 2 turns later (3 ticks)
	ld a, [bc]
	inc a
	swap a
	or $3
	ld [hl], a

	ld hl, ForesawAttackText
	call StdBattleTextbox
	jp EndMoveEffect

.failed
	call AnimateFailedMove
	call PrintButItFailed
	jp EndMoveEffect
