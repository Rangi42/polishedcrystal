BattleCommand_curse:
	ld de, wBattleMonType1
	ld bc, wPlayerStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .go
	ld de, wEnemyMonType1
	ld bc, wEnemyStatLevels

.go

; Curse is different for Ghost-types.

	ld a, [de]
	cp GHOST
	jr z, .ghost
	inc de
	ld a, [de]
	cp GHOST
	jr z, .ghost


; If no stats can be increased, don't.

; Attack
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

; Defense
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise

.raise

; Raise Attack and Defense, and lower Speed.

	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	ld b, SPEED
	call ForceLowerStat
	call SwitchTurn
	call BattleCommand_statdownmessage
	call ResetMiss
	call SwitchTurn
	call BattleCommand_attackup
	call BattleCommand_statupmessage
	call ResetMiss
	call BattleCommand_defenseup
	jp BattleCommand_statupmessage


.ghost

; Cut HP in half and put a curse on the opponent.

	call CheckHiddenOpponent
	jr nz, .failed

	call CheckSubstituteOpp
	jr nz, .failed

	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_CURSE, [hl]
	jr nz, .failed

	set SUBSTATUS_CURSE, [hl]
	call AnimateCurrentMove
	ld hl, GetHalfMaxHP
	call CallBattleCore
	ld hl, SubtractHPFromUser
	call CallBattleCore
	call UpdateUserInParty
	ld hl, PutACurseText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed


.cantraise

; Can't raise either stat.

	ld b, MULTIPLE_STATS + 1
	call GetStatName
	call AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jp StdBattleTextBox
