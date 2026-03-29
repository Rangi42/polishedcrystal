BattleCommand_sketch:
	call ClearLastMove

	; Don't sketch during a link battle
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	call AnimateFailedMove
	jmp PrintNothingHappened

.not_linked
	; If the opponent has a substitute up, fail.
	call CheckSubstituteOpp
	jmp nz, .fail

	; If the user is transformed, fail.
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_TRANSFORMED, [hl]
	jr nz, .fail

	; Get the battle move structs.
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves
	jr z, .get_last_move
	ld hl, wEnemyMonMoves
.get_last_move
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	ld [wTypeMatchup], a
	ld b, a

	; Fail if move is invalid or is Struggle. Sketch is implicitly checked below.
	and a
	jr z, .fail
	inc a ; cp STRUGGLE
	jr z, .fail

	; Fail if user already knows that move (which will always include Sketch)
	push hl
	call .UserKnowsMove
	jr nc, .pop_hl_and_fail

	; Also check move within party (pointless now, but causes problems when
	; Mimic is reintroduced)
	ld a, MON_MOVES
	call UserPartyAttr
	call .UserKnowsMove
	jr nc, .pop_hl_and_fail

	; We now have the move in b ready to be written. Get move PP into c.
	push bc
	ld a, b
	dec a
	ld hl, Moves + MOVE_PP
	call GetMoveAttr
	pop bc
	ld c, a
	pop hl

	; Retrieve currently disabled/encored move, since we might overwrite it
	; if one of them are Sketch.
	farcall GetDisableEncoreMoves
	push de

	; Get move index to overwrite.
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurMoveNum]
	jr z, .got_move_num
	ld a, [wCurEnemyMoveNum]
.got_move_num
	; hl points to the move list in the battle struct. Get the right index.
	push af
	add l
	ld l, a
	adc h
	sub l
	ld h, a

	; Now set move ID and PP.
	ld [hl], b
	ld de, wBattleMonPP - wBattleMonMoves
	add hl, de
	ld [hl], c

	; Do the same thing for the party struct if, and only if, we have Sketch.
	ld a, MON_MOVES
	call UserPartyAttr
	pop af
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	cp SKETCH
	jr nz, .finished_overwriting_sketch

	ld [hl], b
	ld de, MON_PP - MON_MOVES
	add hl, de
	ld [hl], c

.finished_overwriting_sketch
	call GetMoveName
	call AnimateCurrentMove
	pop de
	farcall SetDisableEncoreMoves

	ld hl, SketchedText
	jmp StdBattleTextbox

.pop_hl_and_fail
	pop hl
.fail
	call AnimateFailedMove
	jmp PrintDidntAffect

.UserKnowsMove:
; Returns carry if user doesn't know the move.
	ld c, NUM_MOVES
.knowsmove_loop
	ld a, [hli]
	cp b
	ret z
	dec c
	jr nz, .knowsmove_loop
	scf
	ret
