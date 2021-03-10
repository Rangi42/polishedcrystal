Special_MoveTutor:
	call FadeToMenu
	call ClearBGPalettes
	call ClearScreen
	call DelayFrame
	ld a, CGB_PACKPALS
	call GetCGBLayout
	xor a
	ld [wItemAttributeParamBuffer], a
	ldh a, [hScriptVar]
	and a
	ld [wPutativeTMHMMove], a
	jr z, .relearner
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	call CopyName1
.relearner
	farcall ChooseMonToLearnTMHM
	jr c, .cancel
	jr .enter_loop

.loop
	farcall ChooseMonToLearnTMHM_NoRefresh
	jr c, .cancel
.enter_loop
	call CheckCanLearnMoveTutorMove
	jr nc, .loop
	xor a
	jr .quit

.cancel
	ld a, -1
.quit
	ldh [hScriptVar], a
	jp CloseSubmenu

CheckCanLearnMoveTutorMove:
	ld hl, .MenuDataHeader
	call LoadMenuHeader

	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	and BASEMON_MASK
	ld [wCurForm], a
	predef CanLearnTMHMMove

	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop bc

	ld a, c
	and a
	jr nz, .can_learn
	push de
	ld de, SFX_WRONG
	call PlaySFX
	pop de
	ld a, BANK(Text_TMHMNotCompatible)
	ld hl, Text_TMHMNotCompatible
	call FarPrintText
	jr .didnt_learn

.can_learn
	ld a, [wPutativeTMHMMove]
	and a
	jr z, .reminder
	farcall KnowsMove
	jr c, .didnt_learn

	predef LearnMove
.perform_move_learn
	ld a, b
	and a
	jr z, .didnt_learn

	ld c, HAPPINESS_LEARNMOVE
	predef ChangeHappiness
	jr .learned

.reminder
	farcall ChooseMoveToRelearn
	jr nc, .can_remind
	push de
	ld de, SFX_WRONG
	call PlaySFX
	pop de
	ld a, BANK(MoveReminderNoMovesText)
	ld hl, MoveReminderNoMovesText
	call FarPrintText
	jr .didnt_learn

.can_remind
	jr z, .didnt_learn
	ld a, [wMoveScreenSelectedMove]
	ld [wPutativeTMHMMove], a
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	call CopyName1
	predef LearnMove
	xor a
	ld [wPutativeTMHMMove], a
	jr .perform_move_learn

.didnt_learn
	call ExitMenu
	and a
	ret

.learned
	call ExitMenu
	scf
	ret

.MenuDataHeader:
	db $40 ; flags
	db 12, 00 ; start coords
	db 17, 19 ; end coords
