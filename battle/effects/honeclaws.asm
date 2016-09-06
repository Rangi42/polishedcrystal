BattleCommand_HoneClaws:
; honeclaws

	ld bc, PlayerStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .go
	ld bc, EnemyStatLevels

.go

; If no stats can be increased, don't.

; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

; Accuracy
	inc bc
	inc bc
	inc bc
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise

.raise

; Raise Attack and Accuracy.

	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	call BattleCommand_AttackUp
	call BattleCommand_StatUpMessage
	call ResetMiss
	call BattleCommand_AccuracyUp
	jp BattleCommand_StatUpMessage

.cantraise

; Can't raise either stat.

	ld b, ABILITY + 1
	call GetStatName
	call AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jp StdBattleTextBox
