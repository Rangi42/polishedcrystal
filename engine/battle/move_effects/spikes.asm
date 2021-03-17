BattleCommand_spikes:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyHazards
	jr z, .got_hazards
	ld hl, wPlayerHazards
.got_hazards
	ld a, [hl]
	and HAZARDS_SPIKES
	cp HAZARDS_SPIKES
	jp z, FailSpikes
	ld a, HAZARDS_SPIKES / 3
	add [hl]
	ld [hl], a

	call AnimateCurrentMove

	ld hl, SpikesText
	jp StdBattleTextbox

BattleCommand_toxicspikes:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyHazards
	jr z, .got_screens
	ld hl, wPlayerHazards
.got_screens
	ld a, [hl]
	and HAZARDS_TOXIC_SPIKES
	cp (HAZARDS_TOXIC_SPIKES / 3) * 2
	jp z, FailSpikes
	ld a, HAZARDS_TOXIC_SPIKES / 3
	add [hl]
	ld [hl], a

	call AnimateCurrentMove

	ld hl, ToxicSpikesText
	jp StdBattleTextbox

.failed
	jp FailSpikes
