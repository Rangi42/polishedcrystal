BattleCommand_auroraveil:
	ld hl, wPlayerVeils
	ldh a, [hBattleTurn]
	and a
	jr z, .got_veils_pointer
	ld hl, wEnemyVeils
.got_veils_pointer
	call GetWeatherAfterUserUmbrella
	cp WEATHER_HAIL
	jr nz, .failed

	ld a, HELD_PROLONG_SCREENS
	farcall GetItemBoostedDuration
	ld b, a

	ld a, [hl]
	and VEILS_AURORA_VEIL
	jr nz, .failed
	ld a, b
	or [hl]
	ld [hl], a
	ld hl, AuroraVeilEffectText
	farcall AnimateCurrentMove
	jmp StdBattleTextbox

.failed
	farcall ButItFailed