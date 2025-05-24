BattleCommand_firstturn:
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerTurnsTaken
	jr z, .ok
	assert wPlayerTurnsTaken - 1 == wEnemyTurnsTaken
	dec hl
.ok
	ld a, [hl]
	dec a
	ret z
.failed
	call AnimateFailedMove
	call TryPrintButItFailed
	jmp EndMoveEffect
