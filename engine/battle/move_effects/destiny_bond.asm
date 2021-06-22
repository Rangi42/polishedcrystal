BattleCommand_destinybond:
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_DESTINY_BOND, [hl]
	res SUBSTATUS_DESTINY_BOND, [hl]
	jr nz, .failed
	set SUBSTATUS_DESTINY_BOND, [hl]
	call AnimateCurrentMove
	ld hl, DestinyBondEffectText
	jmp StdBattleTextbox

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
