BattleCommand_Spikes:
	ld a, [hBattleTurn]
	and a
	ld hl, EnemyScreens
	jr z, .got_screens
	ld hl, PlayerScreens
.got_screens
	and SCREENS_SPIKES
	cp SCREENS_SPIKES
	jp z, FailSpikes
	ld a, SCREENS_SPIKES / 3
	add [hl]
	ld [hl], a

	call AnimateCurrentMove

	ld hl, SpikesText
	jp StdBattleTextBox

BattleCommand_ToxicSpikes:
	ld a, [hBattleTurn]
	and a
	ld hl, EnemyScreens
	jr z, .got_screens
	ld hl, PlayerScreens
.got_screens
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
