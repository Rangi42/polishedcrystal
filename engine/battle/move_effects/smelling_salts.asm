BattleCommand_smellingsalt:
    ld a, BATTLE_VARS_STATUS_OPP
    call GetBattleVarAddr
    and (1 << PAR)
    ret z
    ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
    add a
    ld [hl], a
    ret