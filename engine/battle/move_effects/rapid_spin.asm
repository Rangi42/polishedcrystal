BattleCommand_clearhazards:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	jr z, .not_leeched
	res SUBSTATUS_LEECH_SEED, [hl]
	ld hl, ShedLeechSeedText
	call StdBattleTextbox
.not_leeched
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerHazards
	ld de, wPlayerWrapCount
	jr z, .got_screens_wrap
	ld hl, wEnemyHazards
	ld de, wEnemyWrapCount
.got_screens_wrap
	push de
	ld a, [hl]
	and HAZARDS_SPIKES
	jr z, .no_spikes
	cpl
	and [hl]
	ld [hl], a
	push hl
	ld hl, BlewSpikesText
	call StdBattleTextbox
	pop hl
.no_spikes
	ld a, [hl]
	and HAZARDS_TOXIC_SPIKES
	jr z, .no_toxic_spikes
	xor a
	ld [hl], a
	ld hl, BlewToxicSpikesText
	call StdBattleTextbox
.no_toxic_spikes
	pop de
	ld a, [de]
	and a
	ret z
	xor a
	ld [de], a
	ld hl, ReleasedByText
	jmp StdBattleTextbox
