BattleCommand_wakeupslap:
    ld a, BATTLE_VARS_STATUS_OPP
    call GetBattleVarAddr
    and SLP_MASK
    ret z
    ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
    add a
    ld [hl], a
    ret