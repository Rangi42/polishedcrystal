BattleCommand_weatherball:
	ld a, [wAttackMissed]
	and a
	ret nz

	call GetWeatherAfterUserUmbrella
	ld [wBattleAnimParam], a
	and a, a
	assert WEATHER_NONE == 0
	jr z, .done
	ld b, a
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
	ld [hl], 100

	ld a, WATER
	dec b
	assert WEATHER_RAIN == 1
	jr z, .set_type

	ld a, FIRE
	dec b
	assert WEATHER_SUN == 2
	jr z, .set_type

	ld a, ROCK
	dec b
	assert WEATHER_SANDSTORM == 3
	jr z, .set_type

	ld a, ICE
	dec b
	assert WEATHER_HAIL == 4
	jr nz, .done
.set_type
	ld b, a
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	ld [hl], b
.done
; Get the rest of the damage formula variables based on the new type and power.
	push af
	farcall BattleCommand_damagestats ; damagestats
	pop af
	ret
