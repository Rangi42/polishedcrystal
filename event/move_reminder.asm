; Move Reminder code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/event/move_relearner.asm


MoveReminder:
	ld hl, Text_MoveReminderIntro
	call PrintText
	call JoyWaitAorB

	ld a, GOLD_LEAF
	ld [CurItem], a
	ld hl, NumItems
	call CheckItem
	jp nc, .no_gold_leaf

	ld hl, Text_MoveReminderPrompt
	call PrintText
	call YesNoBox
	jp c, .cancel

	ld hl, Text_MoveReminderWhichMon
	call PrintText
	call JoyWaitAorB

	ld b, $6
	farcall SelectMonFromParty
	jr c, .cancel

	ld a, [CurPartySpecies]
	cp EGG
	jr z, .egg

	call IsAPokemon
	jr c, .no_mon

	call GetRemindableMoves
	jr z, .no_moves

	ld hl, Text_MoveReminderWhichMove
	call PrintText
	call JoyWaitAorB

	call ChooseMoveToLearn
	jr c, .skip_learn

	ld a, [MenuSelection]
	ld [wd265], a
	call GetMoveName
	ld hl, StringBuffer1
	ld de, StringBuffer2
	ld bc, StringBuffer2 - StringBuffer1
	call CopyBytes
	ld b, 0
	predef LearnMove
	ld a, b
	and a
	jr z, .skip_learn

	ld a, GOLD_LEAF
	ld [CurItem], a
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld a, -1
	ld [CurItemQuantity], a
	ld hl, NumItems
	call TossItem

	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX

.skip_learn
	call CloseSubmenu
	call SpeechTextBox
.cancel
	ld hl, Text_MoveReminderCancel
	jp PrintText

.egg
	ld hl, Text_MoveReminderEgg
	jp PrintText

.no_gold_leaf
	ld hl, Text_MoveReminderNoGoldLeaf
	jp PrintText

.no_mon
	ld hl, Text_MoveReminderNoMon
	jp PrintText

.no_moves
	ld hl, Text_MoveReminderNoMoves
	jp PrintText


GetRemindableMoves:
; Get moves remindable by CurPartyMon
; Returns z if no moves can be reminded.
	GLOBAL EvosAttacksPointers, EvosAttacks
	ld hl, wd002
	xor a
	ld [hli], a
	ld [hl], $ff

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [CurPartySpecies], a

	push af
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [CurPartyLevel], a

	ld b, 0
	ld de, wd002 + 1
; based on GetEggMove in engine/breeding.asm
.loop
	ld a, [CurPartySpecies]
	dec a
	push bc
	ld b, 0
	ld c, a
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarHalfword
.skip_evos
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc hl
	and a
	jr nz, .skip_evos

.loop_moves
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc hl
	and a
	jr z, .done
	ld c, a
	ld a, [CurPartyLevel]
	cp c
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc hl
	jr c, .loop_moves

	ld c, a
	call CheckAlreadyInList
	jr c, .loop_moves
	call CheckPokemonAlreadyKnowsMove
	jr c, .loop_moves
	ld a, c
	ld [de], a
	inc de
	ld a, $ff
	ld [de], a
	pop bc
	inc b
	push bc
	jr .loop_moves

.done
	ld a, [CurPartySpecies]
	dec a
	push bc
	ld b, 0
	ld c, a
	ld hl, EvolutionMoves
	add hl, bc
	pop bc
	ld a, BANK(EvolutionMoves)
	call GetFarByte
	and a
	jr z, .no_evolution_move
	ld c, a
	call CheckAlreadyInList
	jr c, .no_evolution_move
	call CheckPokemonAlreadyKnowsMove
	jr c, .no_evolution_move
	ld a, c
	ld [de], a
	inc de
	ld a, $ff
	ld [de], a
	inc b
.no_evolution_move

	farcall GetPreEvolution
	pop bc
	jr c, .loop
	pop af
	ld [CurPartySpecies], a
	ld a, b
	ld [wd002], a
	and a
	ret


CheckAlreadyInList:
	push hl
	ld hl, wd002 + 1
.loop
	ld a, [hli]
	cp $ff
	jr z, .nope
	cp c
	jr nz, .loop
	pop hl
	scf
	ret
.nope
	pop hl
	and a
	ret


CheckPokemonAlreadyKnowsMove:
	push hl
	push bc
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	cp c
	jr z, .yes
	dec b
	jr nz, .loop
	pop bc
	pop hl
	and a
	ret
.yes
	pop bc
	pop hl
	scf
	ret


ChooseMoveToLearn:
	; Number of items stored in wd002
	; List of items stored in wd002 + 1
	call FadeToMenu
	farcall BlankScreen
	call UpdateSprites
	ld hl, .MenuDataHeader
	call CopyMenuDataHeader
	xor a
	ld [wMenuCursorBuffer], a
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	call SpeechTextBox
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .carry
	ld a, [MenuSelection]
	ld [wPutativeTMHMMove], a
	and a
	ret

.carry
	scf
	ret

.MenuDataHeader:
	db $40 ; flags
	db 01, 01 ; start coords
	db 11, 19 ; end coords
	dw .menudata2
	db 1 ; default option

.menudata2:
	db $30 ; pointers
	db 5, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wd002
	dba .PrintMoveName
	dba .PrintDetails
	dba .PrintMoveDesc

.PrintMoveName
	push de
	ld a, [MenuSelection]
	ld [wd265], a
	call GetMoveName
	pop hl
	jp PlaceString

.PrintDetails
	ld hl, StringBuffer1
	ld bc, StringBuffer2 - StringBuffer1
	ld a, " "
	call ByteFill
	ld a, [MenuSelection]
	cp $ff
	ret z
	push de
	dec a

	ld bc, MOVE_LENGTH
	ld hl, Moves + MOVE_CATEGORY
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	; bc = a * 4
	ld c, a
	add a
	add a
	ld b, 0
	ld c, a
	ld hl, AbbreviatedClasses
	add hl, bc
	ld d, h
	ld e, l
	ld hl, StringBuffer1
	ld bc, 3
	call PlaceString
	ld hl, StringBuffer1 + 3
	ld [hl], "/"

	ld a, [MenuSelection]
	dec a

	ld bc, MOVE_LENGTH
	ld hl, Moves + MOVE_TYPE
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld [wd265], a
	; bc = a * 4
	ld c, a
	add a
	add a
	ld b, 0
	ld c, a
	ld hl, AbbreviatedTypes
	add hl, bc
	ld d, h
	ld e, l
	ld hl, StringBuffer1 + 4
	ld bc, 3
	call PlaceString
	ld hl, StringBuffer1 + 4 + 3
	ld [hl], "/"

	ld a, [MenuSelection]
	dec a

	ld bc, MOVE_LENGTH
	ld hl, Moves + MOVE_POWER
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, StringBuffer1 + 8
	and a
	jr z, .no_power
	ld [EngineBuffer1], a
	ld de, EngineBuffer1
	lb bc, 1, 3
	call PrintNum
	jr .got_power
.no_power
	ld de, .ThreeDashes
	ld bc, 3
	call PlaceString
.got_power
	ld hl, StringBuffer1 + 8 + 3
	ld [hl], "/"

	ld a, [MenuSelection]
	dec a

	ld bc, MOVE_LENGTH
	ld hl, Moves + MOVE_PP
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld [EngineBuffer1], a
	ld hl, StringBuffer1 + 12
	ld de, EngineBuffer1
	lb bc, 1, 2
	call PrintNum
	ld hl, StringBuffer1 + 12 + 2
	ld [hl], "@"

	ld hl, SCREEN_WIDTH - 6
	pop de
	add hl, de
	push de
	ld de, StringBuffer1
	call PlaceString
	pop de
	ret

.ThreeDashes
	db "---@"

.PrintMoveDesc
	push de
	push hl
	hlcoord 4, 1
	ld de, .Heading
	call PlaceString
	pop hl
	call SpeechTextBox
	ld a, [MenuSelection]
	cp $ff
	pop de
	ret z
	ld [CurSpecies], a
	hlcoord 1, 14
	predef PrintMoveDesc
	ret

.Heading
	db "Cat/Typ/Pow/<BOLDP><BOLDP>@"


INCLUDE "data/types/abbreviations.asm"


Text_MoveReminderIntro:
	text_jump MoveReminderIntroText
	db "@"

Text_MoveReminderPrompt:
	text_jump MoveReminderPromptText
	db "@"

Text_MoveReminderWhichMon:
	text_jump MoveReminderWhichMonText
	db "@"

Text_MoveReminderWhichMove:
	text_jump MoveReminderWhichMoveText
	db "@"

Text_MoveReminderCancel:
	text_jump MoveReminderCancelText
	db "@"

Text_MoveReminderEgg:
	text_jump MoveReminderEggText
	db "@"

Text_MoveReminderNoGoldLeaf:
	text_jump MoveReminderNoGoldLeafText
	db "@"

Text_MoveReminderNoMon:
	text_jump MoveReminderNoMonText
	db "@"

Text_MoveReminderNoMoves:
	text_jump MoveReminderNoMovesText
	db "@"
