BattleCommand_toxic:
	ld a, 1 << PSN | 1 << TOX
	call _BattleCommand_poison
	ret nz

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyToxicCount
	jr z, .ok
	ld hl, wPlayerToxicCount
.ok
	ld [hl], 0
	ret
