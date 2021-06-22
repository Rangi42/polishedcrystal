BattleCommand_startsun:
	lb bc, WEATHER_SUN, HELD_PROLONG_SUN
	ld hl, SunGotBrightText
	jr StartWeather
BattleCommand_startrain:
	lb bc, WEATHER_RAIN, HELD_PROLONG_RAIN
	ld hl, DownpourText
	jr StartWeather
BattleCommand_startsandstorm:
	lb bc, WEATHER_SANDSTORM, HELD_PROLONG_SANDSTORM
	ld hl, SandstormBrewedText
	jr StartWeather
BattleCommand_starthail:
	lb bc, WEATHER_HAIL, HELD_PROLONG_HAIL
	ld hl, HailStartedText
StartWeather:
	ld a, [wBattleWeather]
	cp b
	jmp z, BattleEffect_ButItFailed

	ld a, b
	ld [wBattleWeather], a
	ld a, c
	call GetItemBoostedDuration
	ld [wWeatherCount], a
	call AnimateCurrentMove
	jmp StdBattleTextbox ; hl has text pointer already
