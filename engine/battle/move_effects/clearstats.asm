BattleCommand_clearstats:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyStatLevels
	jr z, .ok
	ld hl, wPlayerStatLevels
.ok
	ld a, BASE_STAT_LEVEL
	ld b, NUM_LEVEL_STATS
.loop
	ld [hli], a
	dec b
	jr nz, .loop

	ld hl, ClearedStatsText
	jmp StdBattleTextbox
