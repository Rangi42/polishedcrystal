LearnMove: ; 6508
	call LoadTileMapToTempTileMap
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes

.loop
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld d, h
	ld e, l
	ld b, NUM_MOVES
	xor a
	ld [wForgettingMove], a
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
	jp c, .cancel

	push hl
	push de
	ld [wd265], a

	ld b, a
	ld a, [wBattleMode]
	and a
	jr z, .not_disabled
	ld a, [wDisabledMove]
	cp b
	jr nz, .not_disabled
	xor a
	ld [wDisabledMove], a
	ld [wPlayerDisableCount], a
.not_disabled

	call GetMoveName
	ld hl, Text_1_2_and_Poof ; 1, 2 and…
	call PrintText
	pop de
	pop hl

	ld a, TRUE
	ld [wForgettingMove], a

.learn
	ld a, [wPutativeTMHMMove]
	ld [hl], a
	ld bc, MON_PP - MON_MOVES
	add hl, bc

	push hl
	push de
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop de
	pop hl
	ld b, a

; Are we forgetting a move?
	ld a, [wForgettingMove]
	and a
	jr z, .pp_ok
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
	jp z, .learned

	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jp nz, .learned

	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	jp nz, .learned

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
	jp .learned

.cancel
	ld hl, Text_StopLearning ; Stop learning <MOVE>?
	call PrintText
	call YesNoBox
	jp c, .loop

	ld hl, Text_DidNotLearn ; <MON> did not learn <MOVE>.
	call PrintText
	ld b, 0
	ret

.learned
	ld hl, Text_LearnedMove ; <MON> learned <MOVE>!
	call PrintText
	ld b, 1
	ret
; 65d3

ForgetMove: ; 65d3
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
; 666b

Text_LearnedMove: ; 666b
; <MON> learned <MOVE>!
	text_jump UnknownText_0x1c5660
	db "@"
; 6670

Text_ForgetWhich: ; 6670
; Which move should be forgotten?
	text_jump UnknownText_0x1c5678
	db "@"
; 6675

Text_StopLearning: ; 6675
; Stop learning <MOVE>?
	text_jump UnknownText_0x1c5699
	db "@"
; 667a

Text_DidNotLearn: ; 667a
; <MON> did not learn <MOVE>.
	text_jump UnknownText_0x1c56af
	db "@"
; 667f

Text_TryingToLearn: ; 667f
; <MON> is trying to learn <MOVE>. But <MON> can't learn more than
; four moves. Delete an older move to make room for <MOVE>?
	text_jump UnknownText_0x1c56c9
	db "@"
; 6684

Text_1_2_and_Poof: ; 6684
	text_jump UnknownText_0x1c5740 ; 1, 2 and…
	start_asm
	push de
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	pop de
	ld hl, .PoofForgot
	ret

.PoofForgot:
; Poof! <MON> forgot <MOVE>. And…
	text_jump UnknownText_0x1c574e
	db "@"
; 669a
