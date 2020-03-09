BattleCommand_allstatsup:
	ld b, ATTACK
	call RaiseStatHit
	ld b, DEFENSE
	call RaiseStatHit
	ld b, SPEED
	call RaiseStatHit
	ld b, SP_ATTACK
	call RaiseStatHit
	ld b, SP_DEFENSE
	jp RaiseStatHit
