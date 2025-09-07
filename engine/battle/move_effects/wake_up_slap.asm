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

BattleCommand_wakeopponent:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	ld b, a
	and SLP_MASK
	ret z
	ld a, b
	and ~SLP_MASK
	ld [hl], a
	call RefreshBattleHuds
	call SwitchTurn
	ld hl, WokeUpText
	call StdBattleTextbox
	jmp SwitchTurn
