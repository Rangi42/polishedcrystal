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

BattleCommand_healparaopp:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	ld b, a
	and (1 << PAR)
	ret z
	ld a, b
	and ~(1 << PAR)
	ld [hl], a
	call RefreshBattleHuds
	ld hl, HealParalysisOpponentText
	jmp StdBattleTextbox
