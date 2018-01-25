DisplayUsedMoveText: ; 105db0
; battle command 03

	ld a, [hBattleTurn]
	and a
	jr nz, .start

	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	call UpdateUsedMoves

.start
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	ld d, h
	ld e, l

	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld [wd265], a

	push hl
	farcall CheckUserIsCharging
	pop hl
	jr nz, .charging

	; update last move
	ld a, [wd265]
	ld [hl], a
	ld [de], a

.charging
	; check obedience
	ld hl, UsedMoveText
	ld a, [AlreadyDisobeyed]
	and a
	jr z, .ok
	ld hl, UsedMoveInsteadText
.ok
	call StdBattleTextBox
	jp WaitBGMap
; 105db9


UpdateUsedMoves: ; 105ed0
; append move a to PlayerUsedMoves unless it has already been used

	push bc
; start of list
	ld hl, PlayerUsedMoves
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
	ld hl, PlayerUsedMoves + 1
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
	ld [PlayerUsedMoves + 3], a
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
; 105ef6
