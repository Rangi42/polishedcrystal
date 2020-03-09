BattleCommand_hiddenpower:
	ld a, [wAttackMissed]
	and a
	ret nz
	farjp HiddenPowerDamageStats
