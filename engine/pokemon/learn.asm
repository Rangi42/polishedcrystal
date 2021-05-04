LearnMove:
	call LoadTileMapToTempTileMap
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

.loop
	ld hl, wForgettingMove
	res FORGETTING_MOVE_F, [hl]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld d, h
	ld e, l
	ld b, NUM_MOVES
; Get the first empty move slot.  This routine also serves to
; determine whether the Pokemon learning the moves already has
; all four slots occupied, in which case one would need to be
; deleted.
.next
	ld a, [hl]
	and a
	jr z, .learn
	inc hl
	dec b
	jr nz, .next
; If we're here, we enter the routine for forgetting a move
; to make room for the new move we're trying to learn.
	push de
	call ForgetMove
	pop de
	jmp c, .cancel

	push hl
	push de
	ld [wNamedObjectIndex], a

	ld b, a
	ld a, [wPlayerDisableCount]
	and a
	jr z, .not_disabled
	swap a
	and $f
	dec a
	xor c
	jr nz, .not_disabled
	ld [wPlayerDisableCount], a

.not_disabled
	ld a, [wPlayerEncoreCount]
	and a
	jr z, .not_encored
	swap a
	and $f
	dec a
	xor c
	jr nz, .not_encored
	ld [wPlayerEncoreCount], a

.not_encored
	call GetMoveName
	ld hl, Text_1_2_and_Poof ; 1, 2 and…
	call PrintText

	ld hl, wForgettingMove
	set FORGETTING_MOVE_F, [hl]
	pop de
	pop hl

.learn
	ld a, [wPutativeTMHMMove]
	ld [hl], a
	ld bc, MON_PP - MON_MOVES
	add hl, bc

	push hl
	push de
	ld hl, Moves + MOVE_PP
	call GetMoveProperty
	pop de
	pop hl
	ld b, a

; Are we forgetting a move?
	ld a, [wForgettingMove]
	cp FORGETTING_MOVE | LEARNING_TM
	jr nz, .pp_ok
; Is the old move's current PP less than the new move's PP?
	ld a, [hl]
	cp b
	jr nc, .pp_ok
; TMs won't give free PP
	ld b, a
.pp_ok
	ld [hl], b

	ld a, [wBattleMode]
	and a
	jr z, .learned

	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .learned

	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .learned

	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, NUM_MOVES
	rst CopyBytes
	ld bc, wPartyMon1PP - (wPartyMon1Moves + NUM_MOVES)
	add hl, bc
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	rst CopyBytes
	jr .learned

.cancel
	ld hl, Text_StopLearning ; Stop learning <MOVE>?
	call PrintText
	call YesNoBox
	jmp c, .loop

	ld hl, Text_DidNotLearn ; <MON> did not learn <MOVE>.
	call PrintText
	ld b, 0
	ret

.learned
	ld hl, Text_LearnedMove ; <MON> learned <MOVE>!
	call PrintText
	ld b, 1
	ret

ForgetMove:
	push hl
	ld hl, Text_TryingToLearn
	call PrintText
	call YesNoBox
	pop hl
	ret c
	ld bc, -NUM_MOVES
	add hl, bc
	push hl
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	rst CopyBytes
	ld hl, Text_ForgetWhich
	call PrintText
	farcall ChooseMoveToForget
	jr z, .cancel
	cp 5 ; user chose the new move itself, meaning cancel
	jr z, .cancel
	dec a
	ld c, a
	ld b, 0
	ld a, [wMoveScreenSelectedMove]
	pop hl
	add hl, bc
	and a
	ret

.cancel
	pop hl
	scf
	ret

Text_LearnedMove:
; <MON> learned <MOVE>!
	text_far _LearnedMoveText
	text_end

Text_ForgetWhich:
; Which move should be forgotten?
	text_far _MoveAskForgetText
	text_end

Text_StopLearning:
; Stop learning <MOVE>?
	text_far _StopLearningMoveText
	text_end

Text_DidNotLearn:
; <MON> did not learn <MOVE>.
	text_far _DidNotLearnMoveText
	text_end

Text_TryingToLearn:
; <MON> is trying to learn <MOVE>. But <MON> can't learn more than
; four moves. Delete an older move to make room for <MOVE>?
	text_far _AskForgetMoveText
	text_end

Text_1_2_and_Poof:
	text_far Text_MoveForgetCount ; 1, 2 and…
	text_asm
	push de
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	pop de
	ld hl, .PoofForgot
	ret

.PoofForgot:
; Poof! <MON> forgot <MOVE>. And…
	text_far _MoveForgotText
	text_end
