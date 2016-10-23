BattleCommand_StartSandstorm: ; 376f8
; startsandstorm

	ld a, [Weather]
	cp WEATHER_SANDSTORM
	jr z, .failed

	ld a, WEATHER_SANDSTORM
	ld [Weather], a
	ld a, SMOOTH_ROCK
	call GetItemBoostedDuration
	ld [WeatherCount], a
	call AnimateCurrentMove
	ld hl, SandstormBrewedText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
; 37718
