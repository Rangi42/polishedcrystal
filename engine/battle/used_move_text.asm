DisplayUsedMoveText:
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	ret nz

	ldh a, [hBattleTurn]
	and a
	jr nz, .start

	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	call UpdateUsedMoves

.start
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld [wMoveGrammar], a

	; Skip last move update if move was called (1=called, 2=Power Herb)
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerCharging]
	jr z, .got_charging
	ld a, [wEnemyCharging]
.got_charging
	cp 1
	jr z, .charging

	; update last move
	push hl
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	ld a, [wMoveGrammar]
	ld [hl], a
	pop hl
	ld [hl], a

.charging
	; check obedience
	ld hl, UsedMoveText
	ld a, [wAlreadyDisobeyed]
	and a
	jr z, .ok
	ld hl, UsedMoveInsteadText
.ok
	call StdBattleTextbox
	jmp ApplyTilemapInVBlank

UpdateUsedMoves:
; append move a to wPlayerUsedMoves unless it has already been used

	push bc
; start of list
	ld hl, wPlayerUsedMoves
; get move id
	ld b, a
; next count
	ld c, NUM_MOVES

.loop
; get move from the list
	ld a, [hli]
; not used yet?
	and a
	jr z, .add
; already used?
	cp b
	jr z, .quit
; next byte
	dec c
	jr nz, .loop

; if the list is full and the move hasn't already been used
; shift the list back one byte, deleting the first move used
; this can occur with struggle or a new learned move
	ld hl, wPlayerUsedMoves + 1
; 1 = 2
	ld a, [hld]
	ld [hli], a
; 2 = 3
	inc hl
	ld a, [hld]
	ld [hli], a
; 3 = 4
	inc hl
	ld a, [hld]
	ld [hl], a
; 4 = new move
	ld a, b
	ld [wPlayerUsedMoves + 3], a
	jr .quit

.add
; go back to the byte we just inced from
	dec hl
; add the new move
	ld [hl], b

.quit
; list updated
	pop bc
	ret
