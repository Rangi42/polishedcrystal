BattleCommand_focusenergy:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	jr nz, .already_pumped
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	call AnimateCurrentMove
	ld hl, GettingPumpedText
	jmp StdBattleTextbox

.already_pumped
	call AnimateFailedMove
	jmp PrintButItFailed
