BattleCommand_thunderaccuracy:
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	inc hl
	call GetWeatherAfterOpponentUmbrella
	cp WEATHER_RAIN
	jr z, .rain
	cp WEATHER_SUN
	ret nz
	ld [hl], 50 percent + 1
	ret

.rain
	ld [hl], 100 percent
	ret
