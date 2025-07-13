BattleCommand_throatchop:
	ld a, [wAttackMissed]
	and a
	ret nz

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyThroatChopEmbargoCount
	jr z, .got
	ld hl, wPlayerThroatChopEmbargoCount
.got
	ld a, [hl]
	and a, $0F
	or a, $20
	ld [hl], a
	ret
