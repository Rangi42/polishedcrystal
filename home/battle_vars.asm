GetBattleVar::
	push hl
	call GetBattleVarAddr
	pop hl
	ret

GetBattleVarAddr::
; Get variable from pair a, depending on whose turn it is.
; There are 22 variable pairs.
	push bc

	ld hl, BattleVarPairs
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc

	ld a, [hli]
	ld h, [hl]
	ld l, a

; Enemy turn uses the second byte instead.
; This lets battle variable calls be side-neutral.
	ldh a, [hBattleTurn]
	and a
	jr z, .getvar
	inc hl

.getvar
; var id
	ld a, [hl]
	ld c, a
	ld b, 0

	ld hl, BattleVarLocations
	add hl, bc
	add hl, bc

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [hl]

	pop bc
	ret

BattleVarPairs:
; entries correspond to BATTLE_VARS_* constants
	table_width 2, BattleVarPairs
	dw .Substatus1
	dw .Substatus2
	dw .Substatus3
	dw .Substatus4
	dw .Substatus1Opp
	dw .Substatus2Opp
	dw .Substatus3Opp
	dw .Substatus4Opp
	dw .Ability
	dw .AbilityOpp
	dw .Status
	dw .StatusOpp
	dw .Animation
	dw .Effect
	dw .Power
	dw .Accuracy
	dw .Type
	dw .Category
	dw .CurMove
	dw .CurMoveOpp
	dw .LastCounter
	dw .LastCounterOpp
	dw .LastMove
	dw .LastMoveOpp
	assert_table_length NUM_BATTLE_VARS

;                   player                 enemy
.Substatus1:     db PLAYER_SUBSTATUS_1,    ENEMY_SUBSTATUS_1
.Substatus1Opp:  db ENEMY_SUBSTATUS_1,     PLAYER_SUBSTATUS_1
.Substatus2:     db PLAYER_SUBSTATUS_2,    ENEMY_SUBSTATUS_2
.Substatus2Opp:  db ENEMY_SUBSTATUS_2,     PLAYER_SUBSTATUS_2
.Substatus3:     db PLAYER_SUBSTATUS_3,    ENEMY_SUBSTATUS_3
.Substatus3Opp:  db ENEMY_SUBSTATUS_3,     PLAYER_SUBSTATUS_3
.Substatus4:     db PLAYER_SUBSTATUS_4,    ENEMY_SUBSTATUS_4
.Substatus4Opp:  db ENEMY_SUBSTATUS_4,     PLAYER_SUBSTATUS_4
.Ability:        db PLAYER_ABILITY,        ENEMY_ABILITY
.AbilityOpp:     db ENEMY_ABILITY,         PLAYER_ABILITY
.Status:         db PLAYER_STATUS,         ENEMY_STATUS
.StatusOpp:      db ENEMY_STATUS,          PLAYER_STATUS
.Animation:      db PLAYER_MOVE_ANIMATION, ENEMY_MOVE_ANIMATION
.Effect:         db PLAYER_MOVE_EFFECT,    ENEMY_MOVE_EFFECT
.Power:          db PLAYER_MOVE_POWER,     ENEMY_MOVE_POWER
.Accuracy:       db PLAYER_MOVE_ACCURACY,  ENEMY_MOVE_ACCURACY
.Type:           db PLAYER_MOVE_TYPE,      ENEMY_MOVE_TYPE
.Category:       db PLAYER_MOVE_CATEGORY,  ENEMY_MOVE_CATEGORY
.CurMove:        db PLAYER_CUR_MOVE,       ENEMY_CUR_MOVE
.CurMoveOpp:     db ENEMY_CUR_MOVE,        PLAYER_CUR_MOVE
.LastCounter:    db PLAYER_COUNTER_MOVE,   ENEMY_COUNTER_MOVE
.LastCounterOpp: db ENEMY_COUNTER_MOVE,    PLAYER_COUNTER_MOVE
.LastMove:       db PLAYER_LAST_MOVE,      ENEMY_LAST_MOVE
.LastMoveOpp:    db ENEMY_LAST_MOVE,       PLAYER_LAST_MOVE

BattleVarLocations:
; entries correspond to PLAYER_* and ENEMY_* constants
	table_width 2 + 2, BattleVarLocations
	dw wPlayerSubStatus1,             wEnemySubStatus1
	dw wPlayerSubStatus2,             wEnemySubStatus2
	dw wPlayerSubStatus3,             wEnemySubStatus3
	dw wPlayerSubStatus4,             wEnemySubStatus4
	dw wPlayerAbility,                wEnemyAbility
	dw wBattleMonStatus,              wEnemyMonStatus
	dw wPlayerMoveStructAnimation,    wEnemyMoveStructAnimation
	dw wPlayerMoveStructEffect,       wEnemyMoveStructEffect
	dw wPlayerMoveStructPower,        wEnemyMoveStructPower
	dw wPlayerMoveStructAccuracy,     wEnemyMoveStructAccuracy
	dw wPlayerMoveStructType,         wEnemyMoveStructType
	dw wPlayerMoveStructCategory,     wEnemyMoveStructCategory
	dw wCurPlayerMove,                wCurEnemyMove
	dw wLastPlayerCounterMove,        wLastEnemyCounterMove
	dw wLastPlayerMove,               wLastEnemyMove
	assert_table_length NUM_BATTLE_VAR_LOCATION_PAIRS
