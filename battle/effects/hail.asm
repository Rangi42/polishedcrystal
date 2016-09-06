BattleCommand_StartHail:
; starthail

	ld a, [Weather]
	cp WEATHER_HAIL
	jr z, .failed

	ld a, WEATHER_HAIL
	ld [Weather], a
	ld a, 5
	ld [WeatherCount], a
	call AnimateCurrentMove
	ld hl, HailStartedText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
