BattleCommand_toxic:
	call CanPoisonTargetVerbose
	ret nz
	ldh a, [hBattleTurn]
	and a
	ld de, wEnemyToxicCount
	jr z, .ok
	ld de, wPlayerToxicCount
.ok
	xor a
	ld [de], a
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set TOX, [hl]
	jr ApplyPoison