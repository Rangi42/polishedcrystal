BattleCommand_lockon:
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_LOCK_ON, [hl]
	res SUBSTATUS_LOCK_ON, [hl]
	jr nz, .failed
	set SUBSTATUS_LOCK_ON, [hl]
	farcall AnimateCurrentMove
	ld hl, TookAimEffectText
	jmp StdBattleTextbox

.failed
	farcall AnimateFailedMove
	farjp PrintButItFailed
