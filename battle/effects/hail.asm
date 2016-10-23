BattleCommand_StartHail:
; starthail

	ld a, [Weather]
	cp WEATHER_HAIL
	jr z, .failed

	ld a, WEATHER_HAIL
	ld [Weather], a
	ld a, ICY_ROCK
	call GetItemBoostedDuration
	ld [WeatherCount], a
	call AnimateCurrentMove
	ld hl, HailStartedText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
