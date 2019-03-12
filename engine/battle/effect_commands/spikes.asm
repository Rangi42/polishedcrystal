BattleCommand_spikes:
	ld a, [hBattleTurn]
	and a
	ld hl, wEnemyScreens
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
	ld a, [hl]
	and SCREENS_SPIKES
	cp SCREENS_SPIKES
	jp z, FailSpikes
	ld a, SCREENS_SPIKES / 3
	add [hl]
	ld [hl], a

	call AnimateCurrentMove

	ld hl, SpikesText
	jp StdBattleTextBox

BattleCommand_toxicspikes:
	ld a, [hBattleTurn]
	and a
	ld hl, wEnemyScreens
	jr z, .got_screens
	ld hl, wPlayerScreens
.got_screens
	ld a, [hl]
	and SCREENS_TOXIC_SPIKES
	cp (SCREENS_TOXIC_SPIKES / 3) * 2
	jp z, FailSpikes
	ld a, SCREENS_TOXIC_SPIKES / 3
	add [hl]
	ld [hl], a

	call AnimateCurrentMove

	ld hl, ToxicSpikesText
	jp StdBattleTextBox

.failed
	jp FailSpikes
