BattleCommand_curl:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_CURLED, [hl]
	ret
