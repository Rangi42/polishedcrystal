BattleCommand_imprison:
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVarAddr
	bit SUBSTATUS_IMPRISON, a
	jr nz, .failed

	set SUBSTATUS_IMPRISON, [hl]
	farcall AnimateCurrentMove
	ld hl, SealedMovesText
	jmp StdBattleTextbox

.failed
	farjp ButItFailed
