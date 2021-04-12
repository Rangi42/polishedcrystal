BattleCommand_suckerpunch:
	call CheckOpponentWentFirst
	jr nz, .failed

	; Now we know that the opponent did pick a move
	call SwitchTurn
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	push af
	call SwitchTurn
	pop af
	cp STATUS
	ret nz
.failed
	call AnimateFailedMove
	call TryPrintButItFailed
	jmp EndMoveEffect
