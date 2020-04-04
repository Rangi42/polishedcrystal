BattleCommand_minimize:
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	set SUBSTATUS_MINIMIZED, [hl]
	ret
