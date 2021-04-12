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
	jmp z, FailSpikes
	ld a, HAZARDS_SPIKES / 3
	add [hl]
	ld [hl], a

	call AnimateCurrentMove

	ld hl, SpikesText
	jmp StdBattleTextbox

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
	jmp z, FailSpikes
	ld a, HAZARDS_TOXIC_SPIKES / 3
	add [hl]
	ld [hl], a

	call AnimateCurrentMove

	ld hl, ToxicSpikesText
	jmp StdBattleTextbox

.failed
	jmp FailSpikes
