BattleCommand_growth:
	lb bc, ATTACK, SP_ATTACK
	call GetWeatherAfterUserUmbrella
	cp WEATHER_SUN
	jr nz, .got_stats_to_raise
	lb bc, ($10 | ATTACK), ($10 | SP_ATTACK)
.got_stats_to_raise
	push bc
	call ForceRaiseStat
	pop bc
	ld b, c
	jmp ForceRaiseStat
