TMHMPocket:
	ld a, TRUE
	ldh [hInMenu], a
	call TMHM_PocketLoop
	ld a, FALSE
	ldh [hInMenu], a
	ret nc
	call PlaceHollowCursor
	ld a, [wCurTMHM]
	scf
	ret

TMHM_PocketLoop:
	xor a
	ldh [hBGMapMode], a
	call TMHM_DisplayPocketItems
	ld a, 2
	ld [w2DMenuCursorInitY], a
	ld a, 7
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 5
	sub d
	inc a
	cp 6
	jr nz, .okay
	dec a
.okay
	ld [w2DMenuNumRows], a
	ld a, $c
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, A_BUTTON | B_BUTTON | START | D_UP | D_DOWN | D_LEFT | D_RIGHT
	ld [wMenuJoypadFilter], a
	ld a, [wTMHMPocketCursor]
	and $7f
	inc a
	ld [wMenuCursorY], a
	ld a, $1
	ld [wMenuCursorX], a
	jr TMHM_ShowTMMoveDescription

TMHM_JoypadLoop:
	call DoMenuJoypadLoop
	ld b, a
	push hl
	ld hl, wTMHMPocketCursor
	ld a, $80
	and [hl]
	ld [hl], a
	ld a, [wMenuCursorY]
	dec a
	or [hl]
	ld [hl], a
	pop hl
	xor a
	ldh [hBGMapMode], a
	ld a, [w2DMenuFlags2]
	bit 7, a
	jmp nz, TMHM_ScrollPocket
	ld a, b
	ld [wMenuJoypad], a
	bit START_F, a
	jr nz, TMHM_SortMenu
	bit A_BUTTON_F, a
	jr nz, TMHM_ChooseTMorHM
	bit B_BUTTON_F, a
	jr nz, TMHM_ExitPack
	and D_RIGHT | D_LEFT
	ret nz
TMHM_ShowTMMoveDescription:
	call TMHM_GetCurrentTMHM
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wCurTMHM]
	cp NUM_TMS + NUM_HMS + 1
	jr nc, .Cancel
	ld [wTempTMHM], a
	predef GetTMHMMove
	farcall LoadTMHMIconPalette
	call SetPalettes
	ld a, [wTempTMHM]
	ld [wCurMove], a
	hlcoord 1, 14
	call PrintMoveDesc
	farcall LoadTMHMIcon
	jr TMHM_JoypadLoop

.Cancel:
	farcall ClearTMHMIcon
	jr TMHM_JoypadLoop

TMHM_SortMenu:
	or 1
	ret

TMHM_ChooseTMorHM:
	call TMHM_PlaySFX_ReadText2
	call CountTMsHMs ; This stores the count to wNumSetBits.
	ld a, [wMenuCursorY]
	dec a
	ld b, a
	ld a, [wTMHMPocketScrollPosition]
	add b
	ld b, a
	ld a, [wNumSetBits]
	cp b
	jr z, _TMHM_ExitPack ; our cursor was hovering over CANCEL
TMHM_GetCurrentTMHM:
	call TMHM_GetCurrentPocketPosition
	ld a, [wMenuCursorY]
	ld b, a
.loop
	inc c
	ld a, c
	cp NUM_TMS + NUM_HMS + 1
	jr nc, .okay
	call InnerCheckTMHM
	jr z, .loop
	dec b
	jr nz, .loop
	ld a, c
.okay
	call TMHM_GetAlpha
	ld [wCurTMHM], a
	ret

TMHM_ExitPack:
	call TMHM_PlaySFX_ReadText2
_TMHM_ExitPack:
	ld a, $2
	ld [wMenuJoypad], a
TMHM_ExitPocket:
	and a
	ret

TMHM_ScrollPocket:
	ld a, b
	bit 7, a
	jr nz, .skip
	ld hl, wTMHMPocketScrollPosition
	ld a, [hl]
	and a
	jmp z, TMHM_JoypadLoop
	dec [hl]
	call TMHM_DisplayPocketItems
	jmp TMHM_ShowTMMoveDescription

.skip
	call TMHM_GetCurrentPocketPosition
	ld b, 5
.loop
	inc c
	ld a, c
	cp NUM_TMS + NUM_HMS + 1
	jmp nc, TMHM_JoypadLoop
	call InnerCheckTMHM
	jr z, .loop
	dec b
	jr nz, .loop
	ld hl, wTMHMPocketScrollPosition
	inc [hl]
	call TMHM_DisplayPocketItems
	jmp TMHM_ShowTMMoveDescription

TMHM_DisplayPocketItems:
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jmp z, Tutorial_TMHMPocket

	hlcoord 5, 2
	lb bc, 10, 15
	call ClearBox
	call TMHM_GetCurrentPocketPosition
	ld d, $5
.loop2
	inc c
	ld a, c
	cp NUM_TMS + NUM_HMS + 1
	jr nc, .NotTMHM
	call InnerCheckTMHM
	jr z, .loop2
	ld b, a
	ld a, c
	call TMHM_GetAlpha
	ld [wTempTMHM], a
	push hl
	push de
	push bc
	call TMHMPocket_GetCurrentLineCoord
	push hl
	ld a, [wTempTMHM]
	cp NUM_TMS + 1
	jr nc, .HM
	ld de, wTempTMHM
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	jr .okay

.HM:
	push af
	sub NUM_TMS
	ld [wTempTMHM], a
	ld a, "H"
	ld [hli], a
	ld de, wTextDecimalByte
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	call PrintNum
	pop af
	ld [wTempTMHM], a
.okay
	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName
	pop hl
	ld bc, 3
	add hl, bc
	push hl
	rst PlaceString
	pop hl
	pop bc
	pop de
	pop hl
	dec d
	jr nz, .loop2
	ret

.NotTMHM:
	call TMHMPocket_GetCurrentLineCoord
	inc hl
	inc hl
	inc hl
	push de
	ld de, TMHM_String_Cancel
	rst PlaceString
	pop de
	ret

TMHMPocket_GetCurrentLineCoord:
	hlcoord 5, 0
	ld bc, 2 * SCREEN_WIDTH
	ld a, 6
	sub d
	ld e, a
	; AddNTimes
.loop
	add hl, bc
	dec e
	jr nz, .loop
	ret

TMHM_String_Cancel:
	db "Cancel@"

TMHM_GetCurrentPocketPosition:
	ld a, [wTMHMPocketScrollPosition]
	ld b, a
	inc b
	ld c, -1
.loop
	inc c
	ld a, c
	call InnerCheckTMHM
	jr z, .loop
	dec b
	jr nz, .loop
	dec c
	ret

Tutorial_TMHMPocket:
	hlcoord 9, 3
	push de
	ld de, TMHM_String_Cancel
	rst PlaceString
	pop de
	ret

TMHM_PlaySFX_ReadText2:
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret

CountTMsHMs:
	ld hl, wTMsHMs
	ld b, wTMsHMsEnd - wTMsHMs
	jmp CountSetBits

TMHM_CheckSorting:
; Returns z if we should sort TMs numerically, nz if alphabetically
	push hl
	ld hl, wTMHMPocketCursor
	bit 7, [hl]
	pop hl
	ret

TMHM_GetAlpha:
; If alpha mode is enabled, convert ordered alphanumeric to internal TM number
	call TMHM_CheckSorting
	ret z
	push bc
	ld c, a
	ld b, 0
	dec c
	ld hl, TMHMListAlpha
	add hl, bc
	ld a, [hl]
	pop bc
	inc a
	ret

InnerCheckTMHM:
	and a
	ret z
	call TMHM_GetAlpha
	push bc
	push de
	dec a
	ld e, a
	ld d, 0
	ld b, CHECK_FLAG
	ld hl, wTMsHMs
	call FlagAction
	ld a, c
	pop de
	pop bc
	and a
	ret

PrintMoveDesc:
	push hl
	ld hl, MoveDescriptions
	ld a, [wCurSpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	rst PlaceString
	ret

AskTeachTMHM:
	ld hl, wOptions1
	ld a, [hl]
	push af
	res NO_TEXT_SCROLL, [hl]
	ld hl, wForgettingMove
	set LEARNING_TM_F, [hl]
	ld a, [wCurTMHM]
	ld [wTempTMHM], a
	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName
	call CopyName1
	ld hl, Text_BootedTM ; Booted up a TM
	ld a, [wCurTMHM]
	cp HM01 + 1 ; off by one error?
	jr c, .TM

	; allow full PP restore for HMs
	ld hl, wForgettingMove
	res LEARNING_TM_F, [hl]
	ld hl, Text_BootedHM ; Booted up an HM
.TM:
	call PrintText
	ld de, SFX_CHOOSE_PC_OPTION
	call WaitPlaySFX
	call TextCommand_PROMPT_BUTTON
	ld hl, Text_ItContained
	call PrintText
	call YesNoBox
	pop bc
	ld a, b
	ld [wOptions1], a
	ld hl, wForgettingMove
	res LEARNING_TM_F, [hl]
	ret

ChooseMonToLearnTMHM:
	ld hl, wStringBuffer2
	ld de, wTMHMMoveNameBackup
	ld bc, 12
	rst CopyBytes
	call ClearBGPalettes
ChooseMonToLearnTMHM_NoRefresh:
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
	ld a, [wPutativeTMHMMove]
	and a
	ld a, PARTYMENUACTION_TEACH_TMHM
	jr nz, .got_text
	ld a, PARTYMENUACTION_MOVE_RELEARNER
.got_text
	ld [wPartyMenuActionText], a
.loopback
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	farcall PartyMenuSelect
	ret c
	push af
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	pop bc ; now contains the former contents of af
	jr nz, .egg
	push bc
	ld hl, wTMHMMoveNameBackup
	ld de, wStringBuffer2
	ld bc, 12
	rst CopyBytes
	pop af ; now contains the original contents of af
	ret

.egg
	push hl
	push de
	push bc
	push af
	ld de, SFX_WRONG
	call PlaySFX
	call WaitSFX
	pop af
	pop bc
	pop de
	pop hl
	jr .loopback

TeachTMHM:
	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	predef CanLearnTMHMMove

	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	pop bc

	ld a, c
	and a
	jr nz, .compatible
	push de
	ld de, SFX_WRONG
	call PlaySFX
	pop de
	ld hl, Text_TMHMNotCompatible
	call PrintText
	jr .nope

.compatible
	call KnowsMove
	jr c, .nope

	predef LearnMove
	ld a, b
	and a
	jr z, .nope

	ld a, [wCurTMHM]
	call IsHM
	ret c

	ld c, HAPPINESS_LEARNMOVE
	predef ChangeHappiness
	jr .learned_move

.nope
	and a
	ret

.learned_move
	scf
	ret

_GetTMHMName::
; Get TM/HM name by item id wNamedObjectIndex.
	push hl
	push de
	push bc
	ld a, [wNamedObjectIndex]
	push af

; TM/HM prefix
	cp HM01
	push af
	jr c, .TM

	ld hl, .HMText
	ld bc, .HMTextEnd - .HMText
	jr .asm_34a1

.TM:
	ld hl, .TMText
	ld bc, .TMTextEnd - .TMText

.asm_34a1
	ld de, wStringBuffer1
	rst CopyBytes

; TM/HM number
	ld a, [wNamedObjectIndex]
	ld c, a

; HM numbers start from 51, not 1
	pop af
	ld a, c
	jr c, .asm_34b9
	sub NUM_TMS
.asm_34b9
	inc a

; Divide and mod by 10 to get the top and bottom digits respectively
	ld b, "0"
.mod10
	sub 10
	jr c, .asm_34c2
	inc b
	jr .mod10
.asm_34c2
	add 10

	push af
	ld a, b
	ld [de], a
	inc de
	pop af

	ld b, "0"
	add b
	ld [de], a

; End the string
	inc de
	ld a, "@"
	ld [de], a

	pop af
	ld [wNamedObjectIndex], a
	pop bc
	pop de
	pop hl
	ld de, wStringBuffer1
	ret

.TMText:
	db "TM"
.TMTextEnd:
	db "@"

.HMText:
	db "HM"
.HMTextEnd:
	db "@"

IsHM::
	cp HM01
	jr c, .NotHM
	scf
	ret
.NotHM:
	and a
	ret

KnowsMove:
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, .Text_knows
	call PrintText
	scf
	ret

.Text_knows:
	; knows @ .
	text_far _KnowsMoveText
	text_end

Text_BootedTM:
	; Booted up a TM.
	text_far _BootedTMText
	text_end

Text_BootedHM:
	; Booted up an HM.
	text_far _BootedHMText
	text_end

Text_ItContained:
	; It contained @ . Teach @ to a #MON?
	text_far _ContainedMoveText
	text_end

Text_TMHMNotCompatible:
	; is not compatible with @ . It can't learn @ .
	text_far _TMHMNotCompatibleText
	text_end

INCLUDE "data/moves/tmhm_order.asm"
