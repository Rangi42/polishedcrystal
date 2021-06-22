MoveDeletion:
	ld hl, .IntroText
	call PrintText
	call YesNoBox
	jr c, .declined
	ld hl, .AskWhichMonText
	call PrintText
	farcall SelectMonFromParty
	jr c, .declined
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .egg
	ld a, MON_MOVES + 1
	call GetPartyParamLocation
	ld a, [hl]
	and a
	jr z, .onlyonemove
	ld hl, .AskWhichMoveText
	call PrintText
	call LoadStandardMenuHeader
	farcall ChooseMoveToDelete
	push af
	call ReturnToMapWithSpeechTextbox
	pop af
	jr z, .declined
	jr c, .declined ; no moves -- should never happen
	push af
	ld a, [wMoveScreenSelectedMove]
	ld [wNamedObjectIndex], a
	call GetMoveName
	ld hl, .ConfirmDeleteText
	call PrintText
	call YesNoBox
	pop bc
	jr c, .declined
	call .DeleteMove
	call WaitSFX
	ld de, SFX_MOVE_DELETED
	call PlaySFX
	call WaitSFX
	ld hl, .MoveDeletedText
	jmp PrintText

.egg
	ld hl, .EggText
	jmp PrintText

.declined
	ld hl, .DeclinedDeletionText
	jmp PrintText

.onlyonemove
	ld hl, .OnlyOneMoveText
	jmp PrintText

.OnlyOneMoveText:
	; That #MON knows only one move.
	text_far _MoveKnowsOneText
	text_end

.ConfirmDeleteText:
	; Oh, make it forget @ ?
	text_far _AskDeleteMoveText
	text_end

.MoveDeletedText:
	; Done! Your #MON forgot the move.
	text_far _DeleterForgotMoveText
	text_end

.EggText:
	; An EGG doesn't know any moves!
	text_far _DeleterEggText
	text_end

.DeclinedDeletionText:
	; No? Come visit me again.
	text_far _DeleterNoComeAgainText
	text_end

.AskWhichMoveText:
	; Which move should it forget, then?
	text_far _DeleterAskWhichMoveText
	text_end

.IntroText:
	; Um… Oh, yes, I'm the MOVE DELETER. I can make #MON forget moves. Shall I make a #MON forget?
	text_far _DeleterIntroText
	text_end

.AskWhichMonText:
	; Which #MON?
	text_far _DeleterAskWhichMonText
	text_end

.DeleteMove:
	ld a, b
	push bc
	dec a
	ld c, a
	ld b, 0
	ld hl, wPartyMon1Moves
	add hl, bc
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	pop bc
	push bc
	inc b
.loop
	ld a, b
	cp NUM_MOVES + 1
	jr z, .okay
	inc hl
	ld a, [hld]
	ld [hli], a
	inc b
	jr .loop

.okay
	xor a
	ld [hl], a
	pop bc

	ld a, b
	push bc
	dec a
	ld c, a
	ld b, 0
	ld hl, wPartyMon1PP
	add hl, bc
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	pop bc
	inc b
.loop2
	ld a, b
	cp NUM_MOVES + 1
	jr z, .done
	inc hl
	ld a, [hld]
	ld [hli], a
	inc b
	jr .loop2

.done
	xor a
	ld [hl], a
	ret
