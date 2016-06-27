BattleCommand_Growth:
; growth

	ld bc, PlayerStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .go
	ld bc, EnemyStatLevels

.go

; Sharply raise stats in sunny weather.

	ld a, [Weather]
	cp WEATHER_SUN
	jr z, .trysharplyraise


.tryraise

; If no stats can be increased, don't.

; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

; Special Attack
	inc bc
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise

.raise

; Raise Attack and Special Attack.

	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	call BattleCommand_AttackUp
	call BattleCommand_StatUpMessage
	call ResetMiss
	call BattleCommand_SpecialAttackUp
	jp BattleCommand_StatUpMessage


.trysharplyraise

; If no stats can be increased, don't.

; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .sharplyraise

; Special Attack
	inc bc
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise

.sharplyraise

; Sharply raise Attack and Special Attack.

	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	call BattleCommand_AttackUp2
	call BattleCommand_StatUpMessage
	call ResetMiss
	call BattleCommand_SpecialAttackUp2
	jp BattleCommand_StatUpMessage


.cantraise

; Can't raise either stat.

	ld b, ABILITY + 1
	call GetStatName
	call AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jp StdBattleTextBox
