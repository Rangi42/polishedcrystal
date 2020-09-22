BattleCommand_roost:
; Remove the flying type until endturn
	; Do nothing if HP is full (error message is handled later)
	farcall CheckFullHP
	ret z

	call CheckIfUserIsFlyingType
	ret nz

	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonType1
	jr z, .got_types
	ld hl, wEnemyMonType1
.got_types
	; Check if both types are flying
	ld a, [hli]
	cp FLYING
	jr nz, .not_double_flying
	ld a, [hld]
	cp FLYING
	jr z, .normalize
.not_double_flying
	ld [hl], UNKNOWN_T
	jr .types_ok
.normalize
	; Pure Flying types become Normal
	ld a, NORMAL
	ld [hli], a
	ld [hl], a
.types_ok
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_ROOST, [hl]
	ret
