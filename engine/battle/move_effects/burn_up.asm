BattleCommand_checkburnup:
	ld a, FIRE
	call CheckIfUserIsSomeType
	ret z
	ld a, ATKFAIL_GENERIC
	ld [wAttackMissed], a
	ret

BattleCommand_burnup:
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonType1
	jr z, .got_types
	ld hl, wEnemyMonType1
.got_types
	lb bc, FIRE, UNKNOWN_T

	ld a, [hl]
	cp a, b
	jr nz, .skip
	ld [hl], c
.skip
	inc hl
	ld a, [hl]
	cp a, b
	jr nz, .done
	ld [hl], c
.done
	ld hl, BurnedOutText
	jmp StdBattleTextbox
