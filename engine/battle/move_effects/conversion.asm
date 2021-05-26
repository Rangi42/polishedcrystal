BattleCommand_conversion:
; In vanilla later generations, we change type into what is in the first slot.
; However, since we can swap moves during battle here, and the alternative
; (don't allow it, or remember what used to be our first move) is unintuitive.
; As a result, we buff Conversion instead. It might actually make the move
; useful, too.
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves
	ld de, wBattleMonType1
	jr z, .got_moves
	ld hl, wEnemyMonMoves
	ld de, wEnemyMonType1
.got_moves
	push de
	ld c, 0
	ld de, wStringBuffer3
.loop
	push hl
	ld b, 0
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .okay
	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_TYPE
	call GetMoveAttr
	ld [de], a
	inc de
	pop bc
	pop hl
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .loop
.okay
	ld a, $ff
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	pop de
	ld hl, wStringBuffer3
.loop2
	ld a, [hl]
	cp -1
	jr z, .fail
	cp UNKNOWN_T
	jr z, .next
	ld a, [de]
	cp [hl]
	jr z, .next
	inc de
	ld a, [de]
	dec de
	cp [hl]
	jr nz, .choose_move
.next
	inc hl
	jr .loop2

.fail
	call AnimateFailedMove
	jmp PrintButItFailed

.choose_move
	push de
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

	; Choose what move's type to change into
	call BattleCommand_movedelay
	pop de
.player_choose_move
	push de
	ld hl, ChangeIntoTypeText
	call StdBattleTextbox

	ld a, [wCurMoveNum]
	ld d, a
	ld a, [wCurPlayerMove]
	ld e, a
	push de

	xor a
	ld [wCurMoveNum], a
	ld a, 2
	ld [wMoveSelectionMenuType], a
	farcall MoveSelectionScreen
	ld a, [wMenuCursorY]
	ld [wCurMoveNum], a

	call UpdateBattleHuds
	call Call_LoadTempTileMapToTileMap

	ld a, [wLinkMode]
	and a
	jr z, .player_link_done
	farcall LinkBattleSendReceiveAction
.player_link_done
	ld a, [wCurMoveNum]
	ld b, a
	pop de
	ld a, d
	ld [wCurMoveNum], a
	ld a, e
	ld [wCurPlayerMove], a

	push bc
	call UpdateMoveData
	pop bc
	ld a, b
	jr .validate_choice
.enemy
	ld a, [wLinkMode]
	and a
	jr nz, .enemy_link
	ld a, [wBattleMode]
	dec a
	jr z, .enemy_wild

	; Check trainer AI. If "Smart" mode is disabled, change randomly.
	; Otherwise, try to be intelligent about our choice.
	ld hl, TrainerClassAttributes + TRNATTR_AI_MOVE_WEIGHTS

	; If we have a battle in BattleTower just load the Attributes of the first wTrainerClass (Falkner)
	; so we have always the same AI, regardless of the loaded class of trainer
	ld a, [wInBattleTowerBattle]
	and a
	jr nz, .battle_tower_skip

	ld a, [wTrainerClass]
	dec a
	ld b, 0
	ld c, a
	ld a, NUM_TRAINER_ATTRIBUTES
	rst AddNTimes

.battle_tower_skip
	lb bc, CHECK_FLAG, AI_SMART
	ld d, BANK(TrainerClassAttributes)
	predef FlagPredef
	jr z, .not_smart
	farcall AI_Conversion
	jr .validate_choice

.enemy_link
	farcall LinkBattleSendReceiveAction
	ld a, [wBattleAction]
	cp 4
	jr c, .validate_choice

	farjp LinkBattleError
	jr .validate_choice
.not_smart
.enemy_wild
	call BattleRandom
	and %11 ; NUM_MOVES - 1
.validate_choice
	pop de
	ld c, a
	ld b, 0
	ld hl, wStringBuffer3
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .invalid_selection
	cp UNKNOWN_T
	jr z, .invalid_selection
	ld a, [de]
	cp [hl]
	jr z, .invalid_selection
	inc de
	ld a, [de]
	dec de
	cp [hl]
	jr z, .invalid_selection
	ld a, [hl]
	ld [de], a
	inc de
	ld [de], a
	ld [wNamedObjectIndex], a
	farcall GetTypeName
	call AnimateCurrentMove
	ld hl, TransformedTypeText
	jmp StdBattleTextbox
.invalid_selection
	; If the player chose an invalid move, give an appropriate message.
	; Otherwise, just loop back to move selection.
	ldh a, [hBattleTurn]
	and a
	ld hl, InvalidTypeChangeText
	push de
	call z, StdBattleTextbox
	pop de

	; skip move delay after the first selection
	ldh a, [hBattleTurn]
	and a
	jmp z, .player_choose_move
	jmp .choose_move
