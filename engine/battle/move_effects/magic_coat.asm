BattleCommand_magiccoat:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_MAGIC_COAT, [hl]
	ret