_DepositPKMN:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	call BillsPC_InitRAM
	xor a
	ld [wBillsPC_LoadedBox], a
	call DelayFrame
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	call DelayFrame
	jr .loop
.done
	call ClearSprites
	pop af
	ldh [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions1], a
	ret

.RunJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .Init
	dw .HandleJoypad
	dw .WhatsUp
	dw .Submenu
	dw BillsPC_EndJumptableLoop

.Init:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call CopyBoxmonSpecies
	call BillsPC_BoxName
	ld de, PCString_ChooseaPKMN
	call BillsPC_PlaceString
	ld a, $5
	ld [wBillsPC_NumMonsOnScreen], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	call BillsPC_PrintBoxCountAndCapacityInsideBox
	xor a
	ld [wCurPartySpecies], a
	ld a, CGB_BILLS_PC
	call BillsPC_ApplyPalettes
	call ApplyTilemapInVBlank
	call BillsPC_UpdateSelectionCursor
	jp BillsPC_IncrementJumptableIndex

.HandleJoypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	call Withdraw_UpDown
	and a
	ret z
	call BillsPC_UpdateSelectionCursor
	xor a
	ldh [hBGMapMode], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	call BillsPC_PrintBoxCountAndCapacityInsideBox
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jp DelayFrame

.a_button
	call BillsPC_GetSelectedPokemonSpecies
	and a
	ret z
	cp -1
	jr z, .b_button
	ld a, $2
	ld [wJumptableIndex], a
	ret

.go_back
	ld hl, wJumptableIndex
	dec [hl]
	ret

.b_button
	ld a, $4
	ld [wJumptableIndex], a
	ret

.WhatsUp:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call BillsPC_GetSelectedMonPal
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	ld a, $1
	ld [wMenuCursorY], a
	jp BillsPC_IncrementJumptableIndex

.Submenu:
	ld hl, BillsPCDepositMenuDataHeader
	call CopyMenuHeader
	ld a, [wMenuCursorY]
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	jp c, BillsPCDepositFuncCancel
	ld a, [wMenuCursorY]
	dec a
	and $3
	call StackJumpTable

BillsPCDepositJumptable:
	dw BillsPCDepositFuncDeposit ; Deposit Pokemon
	dw BillsPCDepositFuncStats ; Pokemon Stats
	dw BillsPCDepositFuncRelease ; Release Pokemon
	dw BillsPCDepositFuncCancel ; Cancel

BillsPCDepositFuncDeposit:
	call BillsPC_CheckMail_PreventBlackout
	jp c, BillsPCDepositFuncCancel
	call DepositPokemon
	jr c, .box_full
	xor a
	ld [wJumptableIndex], a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ret

.box_full
	ld de, PCString_WhatsUp
	jp BillsPC_PlaceString

BillsPCDepositFuncStats:
	call LoadStandardMenuHeader
	call BillsPC_StatsScreen
	call ExitMenu
	call PCMonInfo
	jp BillsPC_GetSelectedMonPal

BillsPCDepositFuncRelease:
	call BillsPC_CheckMail_PreventBlackout
	jr c, BillsPCDepositFuncCancel
	call BillsPC_IsMonAnEgg
	jr c, BillsPCDepositFuncCancel
	ld a, [wMenuCursorY]
	push af
	ld de, PCString_ReleasePKMN
	call BillsPC_PlaceString
	call LoadStandardMenuHeader
	lb bc, 14, 11
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	dec a
	call ExitMenu
	and a
	jr nz, .failed_release
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromPartyOrBox
	call ReleasePKMN_ByePKMN
	xor a
	ld [wJumptableIndex], a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	pop af
	ret

.failed_release
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	pop af
	ld [wMenuCursorY], a
	ret

BillsPCDepositFuncCancel:
	xor a
	ld [wJumptableIndex], a
	ret

BillsPCDepositMenuDataHeader:
	db $40 ; flags
	db 04, 09 ; start coords
	db 13, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Deposit@"
	db "Stats@"
	db "Release@"
	db "Cancel@"

_WithdrawPKMN:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	call BillsPC_InitRAM
	ld a, NUM_BOXES + 1
	ld [wBillsPC_LoadedBox], a
	call DelayFrame
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	call DelayFrame
	jr .loop
.done
	call ClearSprites
	pop af
	ldh [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions1], a
	ret

.RunJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .Init
	dw .Joypad
	dw .PrepSubmenu
	dw BillsPC_Withdraw
	dw BillsPC_EndJumptableLoop

.Init:
	ld a, NUM_BOXES + 1
	ld [wBillsPC_LoadedBox], a
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call CopyBoxmonSpecies
	call BillsPC_BoxName
	ld de, PCString_ChooseaPKMN
	call BillsPC_PlaceString
	ld a, $5
	ld [wBillsPC_NumMonsOnScreen], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	call BillsPC_PrintBoxCountAndCapacityInsideBox
	xor a
	ld [wCurPartySpecies], a
	ld a, CGB_BILLS_PC
	call BillsPC_ApplyPalettes
	call ApplyTilemapInVBlank
	call BillsPC_UpdateSelectionCursor
	jp BillsPC_IncrementJumptableIndex

.Joypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	call Withdraw_UpDown
	and a
	ret z
	call BillsPC_UpdateSelectionCursor
	xor a
	ldh [hBGMapMode], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	call BillsPC_PrintBoxCountAndCapacityInsideBox
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jp DelayFrame

.a_button
	call BillsPC_GetSelectedPokemonSpecies
	and a
	ret z
	cp -1
	jr z, .b_button
	ld a, $2
	ld [wJumptableIndex], a
	ret

.b_button
	ld a, $4
	ld [wJumptableIndex], a
	ret

.PrepSubmenu:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call BillsPC_GetSelectedMonPal
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	ld a, $1
	ld [wMenuCursorY], a
	jp BillsPC_IncrementJumptableIndex

BillsPC_Withdraw:
	ld hl, .MenuDataHeader
	call CopyMenuHeader
	ld a, [wMenuCursorY]
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	jp c, .cancel
	ld a, [wMenuCursorY]
	dec a
	and 3
	call StackJumpTable

.Jumptable
	dw .withdraw ; Withdraw
	dw .stats ; Stats
	dw .release ; Release
	dw .cancel ; Cancel

.withdraw
	call BillsPC_CheckMail_PreventBlackout
	jp c, .cancel
	call TryWithdrawPokemon
	jr c, .FailedWithdraw
	xor a
	ld [wJumptableIndex], a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ret
.FailedWithdraw:
	ld de, PCString_WhatsUp
	jp BillsPC_PlaceString

.stats
	call LoadStandardMenuHeader
	call BillsPC_StatsScreen
	call ExitMenu
	call PCMonInfo
	jp BillsPC_GetSelectedMonPal

.release
	ld a, [wMenuCursorY]
	push af
	call BillsPC_IsMonAnEgg
	jr c, .FailedRelease
	ld de, PCString_ReleasePKMN
	call BillsPC_PlaceString
	call LoadStandardMenuHeader
	lb bc, 14, 11
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	dec a
	call ExitMenu
	and a
	jr nz, .FailedRelease
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromPartyOrBox
	call ReleasePKMN_ByePKMN
	xor a
	ld [wJumptableIndex], a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	pop af
	ret
.FailedRelease:
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	pop af
	ld [wMenuCursorY], a
	ret

.cancel
	xor a
	ld [wJumptableIndex], a
	ret

.MenuDataHeader:
	db $40 ; flags
	db 04, 09 ; start coords
	db 13, 19 ; end coords
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $80 ; flags
	db 4 ; items
	db "Withdraw@"
	db "Stats@"
	db "Release@"
	db "Cancel@"

_MovePKMNWithoutMail:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	call BillsPC_InitRAM
	ld a, [wCurBox]
	and $f
	inc a
	ld [wBillsPC_LoadedBox], a
	call DelayFrame
.asm_e2781
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .asm_e2793
	call .RunJumptable
	call DelayFrame
	jr .asm_e2781

.asm_e2793
	call ClearSprites
	pop af
	ldh [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions1], a
	ret

.RunJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .Init
	dw .Joypad
	dw .PrepSubmenu
	dw .MoveMonWOMailSubmenu
	dw .PrepInsertCursor
	dw .Joypad2
	dw BillsPC_EndJumptableLoop

.Init:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call CopyBoxmonSpecies
	ld de, PCString_ChooseaPKMN
	call BillsPC_PlaceString
	ld a, 5
	ld [wBillsPC_NumMonsOnScreen], a
	call BillsPC_RefreshTextboxes
	call BillsPC_MoveMonWOMail_BoxNameAndArrows
	call PCMonInfo
	call BillsPC_PrintBoxCountAndCapacityInsideBox
	xor a
	ld [wCurPartySpecies], a
	ld a, CGB_BILLS_PC
	call BillsPC_ApplyPalettes
	call ApplyTilemapInVBlank
	call BillsPC_UpdateSelectionCursor
	jp BillsPC_IncrementJumptableIndex

.Joypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	call MovePkmnWithoutMail_DPad
	jr c, .d_pad
	and a
	ret z
	call BillsPC_UpdateSelectionCursor
	xor a
	ldh [hBGMapMode], a
	call BillsPC_RefreshTextboxes
	call PCMonInfo
	call BillsPC_PrintBoxCountAndCapacityInsideBox
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jp DelayFrame

.d_pad
	xor a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ld [wJumptableIndex], a
	ret

.a_button
	call BillsPC_GetSelectedPokemonSpecies
	and a
	ret z
	cp -1
	jr z, .b_button
	ld a, $2
	ld [wJumptableIndex], a
	ret

.b_button
	ld a, $6
	ld [wJumptableIndex], a
	ret

.PrepSubmenu:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call BillsPC_GetSelectedMonPal
	ld de, PCString_WhatsUp
	call BillsPC_PlaceString
	ld a, $1
	ld [wMenuCursorY], a
	jp BillsPC_IncrementJumptableIndex

.MoveMonWOMailSubmenu:
	ld hl, .MenuDataHeader
	call CopyMenuHeader
	ld a, [wMenuCursorY]
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	jp c, .Cancel
	ld a, [wMenuCursorY]
	dec a
	and 3
	call StackJumpTable

.Jumptable2:
	dw .Move
	dw .Stats
	dw .Cancel

.Move:
	call BillsPC_CheckMail_PreventBlackout
	jp c, .Cancel
	ld a, [wBillsPC_ScrollPosition]
	ld [wBillsPC_BackupScrollPosition], a
	ld a, [wBillsPC_CursorPosition]
	ld [wBillsPC_BackupCursorPosition], a
	ld a, [wBillsPC_LoadedBox]
	ld [wBillsPC_BackupLoadedBox], a
	ld a, $4
	ld [wJumptableIndex], a
	ret

.Stats:
	call LoadStandardMenuHeader
	call BillsPC_StatsScreen
	call ExitMenu
	call PCMonInfo
	jp BillsPC_GetSelectedMonPal

.Cancel:
	xor a
	ld [wJumptableIndex], a
	ret

.MenuDataHeader:
	db $40 ; flags
	db 04, 09 ; start coords
	db 13, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Move@"
	db "Stats@"
	db "Cancel@"

.PrepInsertCursor:
	xor a
	ldh [hBGMapMode], a
	call CopyBoxmonSpecies
	ld de, PCString_MoveToWhere
	call BillsPC_PlaceString
	ld a, $5
	ld [wBillsPC_NumMonsOnScreen], a
	call BillsPC_RefreshTextboxes
	call BillsPC_MoveMonWOMail_BoxNameAndArrows
	call ClearSprites
	call BillsPC_UpdateInsertCursor
	call ApplyTilemapInVBlank
	jp BillsPC_IncrementJumptableIndex

.Joypad2:
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button_2
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button_2
	call MovePkmnWithoutMail_DPad_2
	jr c, .dpad_2
	and a
	ret z
	call BillsPC_UpdateInsertCursor
	xor a
	ldh [hBGMapMode], a
	call BillsPC_RefreshTextboxes
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jp DelayFrame

.dpad_2
	xor a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ld a, $4
	ld [wJumptableIndex], a
	ret

.a_button_2
	call BillsPC_CheckSpaceInDestination
	jr c, .no_space
	call MovePKMNWitoutMail_InsertMon
	xor a
	ld [wJumptableIndex], a
	ret

.no_space
	ld hl, wJumptableIndex
	dec [hl]
	ret

.b_button_2
	ld a, [wBillsPC_BackupScrollPosition]
	ld [wBillsPC_ScrollPosition], a
	ld a, [wBillsPC_BackupCursorPosition]
	ld [wBillsPC_CursorPosition], a
	ld a, [wBillsPC_BackupLoadedBox]
	ld [wBillsPC_LoadedBox], a
	xor a
	ld [wJumptableIndex], a
	ret

BillsPC_InitRAM:
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	call BillsPC_InitGFX
	ld hl, wBillsPCData
	ld bc, wBillsPCDataEnd - wBillsPCData
	xor a
	rst ByteFill
	xor a
	ld [wJumptableIndex], a
	ld [wBillsPC_CursorPosition], a
	ld [wBillsPC_ScrollPosition], a
	ret

BillsPC_IncrementJumptableIndex:
	ld hl, wJumptableIndex
	inc [hl]
	ret

BillsPC_EndJumptableLoop:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

_StatsScreenDPad:
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	and a
	jr z, .empty
	dec a
	cp $1
	jr z, .empty
	ld e, a
	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown
.empty
	xor a
	ret

Withdraw_UpDown:
	ld hl, hJoyLast
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	ld e, a
	and a
	jr z, .empty
	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown
.empty
	xor a
	ret

MovePkmnWithoutMail_DPad:
	ld hl, hJoyLast
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	ld e, a
	and a
	jr z, .check_left_right
	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown

.check_left_right
	ld a, [hl]
	and D_LEFT
	jr nz, BillsPC_PressLeft
	ld a, [hl]
	and D_RIGHT
	jr nz, BillsPC_PressRight
	xor a
	ret

MovePkmnWithoutMail_DPad_2:
	ld hl, hJoyLast
	ld a, [wBillsPC_NumMonsOnScreen]
	ld d, a
	ld a, [wBillsPC_NumMonsInBox]
	ld e, a
	and a
	jr z, .check_left_right

	ld a, [hl]
	and D_UP
	jr nz, BillsPC_PressUp
	ld a, [hl]
	and D_DOWN
	jr nz, BillsPC_PressDown

.check_left_right
	ld a, [hl]
	and D_LEFT
	jr nz, BillsPC_PressLeft
	ld a, [hl]
	and D_RIGHT
	jr nz, BillsPC_PressRight
	xor a
	ret

BillsPC_PressUp:
	ld hl, wBillsPC_CursorPosition
	ld a, [hl]
	and a
	jr z, .top
	dec [hl]
	jr BillsPC_UpDownDidSomething

.top
	ld hl, wBillsPC_ScrollPosition
	ld a, [hl]
	and a
	jr z, BillsPC_JoypadDidNothing
	dec [hl]
	jr BillsPC_UpDownDidSomething

BillsPC_PressDown:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	inc a
	cp e
	jr nc, BillsPC_JoypadDidNothing

	ld hl, wBillsPC_CursorPosition
	ld a, [hl]
	inc a
	cp d
	jr nc, .not_bottom
	inc [hl]
	jr BillsPC_UpDownDidSomething

.not_bottom
	ld hl, wBillsPC_ScrollPosition
	inc [hl]
	jr BillsPC_UpDownDidSomething

BillsPC_PressLeft:
	ld hl, wBillsPC_LoadedBox
	ld a, [hl]
	and a
	jr z, .wrap_around
	dec [hl]
	jr BillsPC_LeftRightDidSomething

.wrap_around
	ld [hl], NUM_BOXES
	jr BillsPC_LeftRightDidSomething

BillsPC_PressRight:
	ld hl, wBillsPC_LoadedBox
	ld a, [hl]
	cp NUM_BOXES
	jr z, .wrap_around
	inc [hl]
	jr BillsPC_LeftRightDidSomething

.wrap_around
	ld [hl], 0
	jr BillsPC_LeftRightDidSomething

BillsPC_JoypadDidNothing:
	xor a
	ret

BillsPC_UpDownDidSomething:
	ld a, TRUE
	and a
	ret

BillsPC_LeftRightDidSomething:
	scf
	ret

BillsPC_PlaceString:
	push de
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox
	pop de
	hlcoord 1, 16
	rst PlaceString
	ret

BillsPC_MoveMonWOMail_BoxNameAndArrows:
	call BillsPC_BoxName
	hlcoord 8, 1
	ld [hl], $5f
	hlcoord 19, 1
	ld [hl], $5e
	ret

BillsPC_BoxName:
	hlcoord 8, 0
	lb bc, 1, 10
	call Textbox

	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party

	cp NUM_BOXES + 1
	jr nz, .gotbox

	ld a, [wCurBox]
	inc a
.gotbox
	dec a
	ld hl, wBoxNames
	ld bc, BOX_NAME_LENGTH
	rst AddNTimes
	ld e, l
	ld d, h
	jr .print

.party
	ld de, .PartyPKMN
.print
	hlcoord 10, 1
	rst PlaceString
	ret

.PartyPKMN:
	db "Party <PK><MN>@"

PCMonInfo:
; Display a monster's pic and
; attributes when highlighting
; it in a PC menu.

; Includes the neat cascading
; effect when showing the pic.

; Example: Species, level, gender,
; whether it's holding an item.

	hlcoord 0, 0
	lb bc, 15, 8
	call ClearBox

	hlcoord 8, 14
	lb bc, 1, 3
	call ClearBox

	call BillsPC_GetSelectedPokemonSpecies
	inc a
	jr z, .no_pkmn
	dec a
	jr nz, .pkmn

.no_pkmn
	ld de, PCString_ChooseaPKMN
	jp BillsPC_PlaceString

.pkmn
	ld [wd265], a
	hlcoord 1, 4
	farcall PlaceFrontpicAtHL

	call BillsPC_LoadMonStats
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld a, [wd265]
	jr z, .not_egg
	ld a, EGG

.not_egg
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld hl, wTempMonForm
	predef GetVariant
	call GetBaseData
	ld de, vTiles2 tile $00
	predef GetFrontpic
	xor a
	ld [wBillsPC_MonHasMail], a
	ld a, [wCurPartySpecies]
	ld [wd265], a
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ret nz

	call GetBasePokemonName
	hlcoord 1, 14
	rst PlaceString

	hlcoord 1, 12
	call PrintLevel

	ld a, $3
	ld [wMonType], a
	farcall GetGender
	jr c, .skip_gender
	ld a, "♂"
	jr nz, .printgender
	ld a, "♀"
.printgender
	hlcoord 5, 12
	ld [hl], a
.skip_gender

	ld a, [wTempMonItem]
	and a
	jr nz, .has_item
	ld de, PCString_NoHeldItem
	jp BillsPC_PlaceString

.has_item
	ld d, a
	push de
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld de, wStringBuffer1
	call BillsPC_PlaceString
	pop de
	call ItemIsMail
	jr c, .mail
	ld a, $5d ; item icon
	jr .printitem
.mail
	ld a, $1
	ld [wBillsPC_MonHasMail], a
	ld a, $5c ; mail icon
.printitem
	hlcoord 7, 12
	ld [hl], a
	ret

BillsPC_LoadMonStats:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld e, a
	ld d, $0
	ld hl, wBillsPCPokemonList + 1
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jp z, .sBox
	ld b, a
	call GetBoxPointer
	ld a, b
	call GetSRAMBank
	; level
	push hl
	ld bc, sBoxMon1Level - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a
	pop hl
	; item
	push hl
	ld bc, sBoxMon1Item - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a
	pop hl
	; DVs and personality (DVs for color variation)
	push hl
	ld bc, sBoxMon1DVs - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonDVs
rept 4
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	pop hl
	; moves (for Pikachu forms)
	ld bc, sBoxMon1Moves - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonMoves
rept NUM_MOVES - 1
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	jp CloseSRAM

.party
	; level
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a
	; item
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a
	; DVs and personality (DVs for color variation)
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonDVs
rept 4
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	; moves (for Pikachu forms)
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonMoves
rept NUM_MOVES - 1
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	ret

.sBox
	ld a, BANK(sBox)
	call GetSRAMBank
	; level
	ld hl, sBoxMon1Level
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonLevel], a
	; item
	ld hl, sBoxMon1Item
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld [wTempMonItem], a
	; DVs and personality (DVs for color variation)
	ld hl, sBoxMon1DVs
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonDVs
rept 4
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	; moves (for Pikachu forms)
	ld hl, sBoxMon1Moves
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld bc, wTempMonMoves
rept NUM_MOVES - 1
	ld a, [hli]
	ld [bc], a
	inc bc
endr
	ld a, [hl]
	ld [bc], a
	jp CloseSRAM

BillsPC_RefreshTextboxes:
	hlcoord 8, 2
	lb bc, 10, 10
	call Textbox

	hlcoord 8, 2
	ld [hl], "└"
	hlcoord 19, 2
	ld [hl], "┘"

	ld a, [wBillsPC_ScrollPosition]
	ld e, a
	ld d, 0
	ld hl, wBillsPCPokemonList
	add hl, de
	add hl, de
	add hl, de
	ld e, l
	ld d, h
	hlcoord 9, 4
	ld a, [wBillsPC_NumMonsOnScreen]
.loop
	push af
	push de
	push hl
	call .PlaceNickname
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop de
	inc de
	inc de
	inc de
	pop af
	dec a
	jr nz, .loop
	ret

.CancelString:
	db "Cancel@"

.PlaceNickname:
	ld a, [de]
	and a
	ret z
	cp -1
	jr nz, .get_nickname
	ld de, .CancelString
	rst PlaceString
	ret

.get_nickname
	inc de
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	ld e, a
	ld a, b
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr z, .sBox
	push hl
	call GetBoxPointer
	ld a, b
	call GetSRAMBank
	push hl
	ld bc, sBoxMons - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	pop hl
	and a
	jr z, .boxfail
	ld bc, sBoxMonNicknames - sBox
	add hl, bc
	ld bc, MON_NAME_LENGTH
	ld a, e
	rst AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call CloseSRAM
	pop hl
	ld de, wStringBuffer1
	rst PlaceString
	ret

.boxfail
	call CloseSRAM
	pop hl
	jr .placeholder_string

.party
	push hl
	ld hl, wPartySpecies
	ld d, $0
	add hl, de
	ld a, [hl]
	and a
	jr z, .partyfail
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, e
	rst AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	pop hl
	ld de, wStringBuffer1
	rst PlaceString
	ret

.partyfail
	pop hl
	jr .placeholder_string

.sBox
	push hl
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBoxSpecies
	ld d, $0
	add hl, de
	ld a, [hl]
	and a
	jr z, .sBoxFail
	ld hl, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, e
	rst AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call CloseSRAM
	pop hl
	ld de, wStringBuffer1
	rst PlaceString
	ret

.sBoxFail
	call CloseSRAM
	pop hl
.placeholder_string
	ld de, .Placeholder
	rst PlaceString
	ret

.Placeholder:
	db "-----@"

copy_box_data: MACRO
.loop\@
	ld a, [hl]
	cp -1
	jr z, .done\@
	and a
	jr z, .done\@
	ld [de], a
	inc de
	ld a, [wBillsPC_LoadedBox]
	ld [de], a
	inc de
	ld a, [wBillsPCTempListIndex]
	ld [de], a
	inc a
	ld [wBillsPCTempListIndex], a
	inc de
	inc hl
	ld a, [wBillsPCTempBoxCount]
	inc a
	ld [wBillsPCTempBoxCount], a
	jr .loop\@

.done\@
IF \1
	call CloseSRAM
ENDC
	ld a, -1
	ld [de], a
	ld a, [wBillsPCTempBoxCount]
	inc a
	ld [wBillsPC_NumMonsInBox], a
ENDM

CopyBoxmonSpecies:
	xor a
	ld hl, wBillsPCPokemonList
	ld bc, 3 * 30
	rst ByteFill
	ld de, wBillsPCPokemonList
	xor a
	ld [wBillsPCTempListIndex], a
	ld [wBillsPCTempBoxCount], a
	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr z, .sBox
	ld b, a
	call GetBoxPointer
	ld a, b
	call GetSRAMBank
	inc hl
	copy_box_data 1
	ret

.party
	ld hl, wPartySpecies
	copy_box_data 0
	ret

.sBox
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBoxSpecies
	copy_box_data 1
	ret

BillsPC_GetSelectedMonPal:
; Sets Pokémon palette, even for eggs, and sets target mon (not EGG) to
; wCurPartySpecies.
	call BillsPC_GetSelectedPokemonSpecies
	push af

	; Get target species or EGG
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld a, EGG
	jr nz, .got_species
	pop af
	push af
.got_species
	ld [wCurPartySpecies], a
	ld a, CGB_BILLS_PC
	call BillsPC_ApplyPalettes
	pop af
	ld [wCurPartySpecies], a
	ret

BillsPC_GetSelectedPokemonSpecies:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld e, a
	ld d, $0
	ld hl, wBillsPCPokemonList
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl]
	ret

BillsPC_UpdateSelectionCursor:
	ld a, [wBillsPC_NumMonsInBox]
	and a
	jp z, ClearSprites

	ld hl, .OAM
	ld de, wVirtualOAM
.loop
	ld a, [hl]
	cp -1
	ret z
	ld a, [wBillsPC_CursorPosition]
	and $7
	swap a
	add [hl]
	inc hl
	ld [de], a
	inc de
rept 3
	ld a, [hli]
	ld [de], a
	inc de
endr
	jr .loop

.OAM:
	dsprite 4, 6, 10, 0, $00, $0
	dsprite 4, 6, 11, 0, $00, $0
	dsprite 4, 6, 12, 0, $00, $0
	dsprite 4, 6, 13, 0, $00, $0
	dsprite 4, 6, 14, 0, $00, $0
	dsprite 4, 6, 15, 0, $00, $0
	dsprite 4, 6, 16, 0, $00, $0
	dsprite 4, 6, 17, 0, $00, $0
	dsprite 4, 6, 18, 0, $00, $0
	dsprite 4, 6, 18, 7, $00, $0
	dsprite 7, 1, 10, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 11, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 12, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 13, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 14, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 15, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 16, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 17, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 18, 0, $00, $0 | Y_FLIP
	dsprite 7, 1, 18, 7, $00, $0 | Y_FLIP
	dsprite 5, 6,  9, 6, $01, $0
	dsprite 6, 1,  9, 6, $01, $0 | Y_FLIP
	dsprite 5, 6, 19, 1, $01, $0 | X_FLIP
	dsprite 6, 1, 19, 1, $01, $0 | X_FLIP | Y_FLIP
	db -1

BillsPC_UpdateInsertCursor:
	ld hl, .OAM
	ld de, wVirtualOAM
.loop
	ld a, [hl]
	cp -1
	ret z
	ld a, [wBillsPC_CursorPosition]
	and $7
	swap a
	add [hl]
	inc hl
	ld [de], a
	inc de
rept 3
	ld a, [hli]
	ld [de], a
	inc de
endr
	jr .loop

.OAM:
	dsprite 4, 7, 10, 0, $06, $0
	dsprite 5, 3, 11, 0, $00, $0 | Y_FLIP
	dsprite 5, 3, 12, 0, $00, $0 | Y_FLIP
	dsprite 5, 3, 13, 0, $00, $0 | Y_FLIP
	dsprite 5, 3, 14, 0, $00, $0 | Y_FLIP
	dsprite 5, 3, 15, 0, $00, $0 | Y_FLIP
	dsprite 5, 3, 16, 0, $00, $0 | Y_FLIP
	dsprite 5, 3, 17, 0, $00, $0 | Y_FLIP
	dsprite 5, 3, 18, 0, $00, $0 | Y_FLIP
	dsprite 4, 7, 19, 0, $07, $0
	db -1

BillsPC_CheckSpaceInDestination:
; If moving within a box, no need to be here.
	ld hl, wBillsPC_LoadedBox
	ld a, [wBillsPC_BackupLoadedBox]
	cp [hl]
	jr z, .same_box

; Exceeding box or party capacity is a big no-no.
	ld a, [wBillsPC_LoadedBox]
	and a
	ld e, MONS_PER_BOX + 1
	jr nz, .compare
	ld e, PARTY_LENGTH + 1
.compare
	ld a, [wBillsPC_NumMonsInBox]
	cp e
	jr nc, .no_room
.same_box
	and a
	ret

.no_room
	ld de, PCString_TheresNoRoom
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	scf
	ret

BillsPC_CheckMail_PreventBlackout:
	ld a, [wBillsPC_LoadedBox]
	and a
	jr nz, .Okay
	ld a, [wBillsPC_NumMonsInBox]
	cp $3
	jr c, .ItsYourLastPokemon
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	farcall CheckCurPartyMonFainted
	jr c, .AllOthersFainted
	ld a, [wBillsPC_MonHasMail]
	and a
	jr nz, .HasMail
.Okay:
	and a
	ret

.HasMail:
	ld de, PCString_RemoveMail
	jr .NotOkay

.AllOthersFainted:
	ld de, PCString_NoMoreUsablePKMN
	jr .NotOkay

.ItsYourLastPokemon:
	ld de, PCString_ItsYourLastPKMN
.NotOkay:
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	scf
	ret

BillsPC_IsMonAnEgg:
	call BillsPC_GetSelectedPokemonSpecies ; sets hl and e
	inc hl
	ld a, [hl]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr z, .sBox

	ld b, a
	call GetBoxPointer
	ld a, b
	call GetSRAMBank
	ld bc, sBoxMon1IsEgg - sBox
	add hl, bc
	jr .okay_sBox

.party
	ld hl, wPartyMon1IsEgg
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld e, a
	jr .okay_party

.sBox
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBoxMon1IsEgg

.okay_sBox
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, e
	rst AddNTimes
	ld a, [hl]
	ld e, a
	call CloseSRAM
	ld a, e
.okay_party
	bit MON_IS_EGG_F, a
	jr nz, .egg
	and a
	ret

.egg
	ld de, PCString_NoReleasingEGGS
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	scf
	ret

BillsPC_StatsScreen:
	call LowVolume
	call BillsPC_CopyMon
	ld a, $3
	ld [wMonType], a
	predef StatsScreenInit
	call BillsPC_InitGFX
	jp MaxVolume

StatsScreenDPad:
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON | B_BUTTON | D_RIGHT | D_LEFT
	ld [wMenuJoypad], a
	ret nz

	ld a, [hl]
	and D_DOWN | D_UP
	ld [wMenuJoypad], a
	ret z

	call _StatsScreenDPad
	and a
	jr z, .did_nothing
	call BillsPC_GetSelectedPokemonSpecies
	ld [wd265], a
	call BillsPC_LoadMonStats
	ld a, [wd265]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld hl, wTempMonForm
	predef GetVariant
	call GetBaseData
	jp BillsPC_CopyMon

.did_nothing
	xor a
	ld [wMenuJoypad], a
	ret

BillsPC_CopyMon:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party
	cp NUM_BOXES + 1
	jr nz, .box
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBoxSpecies
	call CopySpeciesToTemp
	ld hl, sBoxMonNicknames
	call CopyNicknameToTemp
	ld hl, sBoxMonOT
	call CopyOTNameToTemp
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	call CloseSRAM
	farjp CalcBufferMonStats

.party
	ld hl, wPartySpecies
	call CopySpeciesToTemp
	ld hl, wPartyMonNicknames
	call CopyNicknameToTemp
	ld hl, wPartyMonOT
	call CopyOTNameToTemp
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ret

.box
	ld b, a
	call GetBoxPointer
	ld a, b
	call GetSRAMBank
	push hl
	inc hl
	call CopySpeciesToTemp
	pop hl
	push hl
	ld bc, sBoxMonNicknames - sBox
	add hl, bc
	call CopyNicknameToTemp
	pop hl
	push hl
	ld bc, sBoxMonOT - sBox
	add hl, bc
	call CopyOTNameToTemp
	pop hl
	ld bc, sBoxMons - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyMonToTemp
	call CloseSRAM
	farjp CalcBufferMonStats

DepositPokemon:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNick
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef SentGetPkmnIntoFromBox
	jr c, .asm_boxisfull
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromPartyOrBox
	ld de, PCString_Stored
	call BillsPC_PlaceString
	ld l, c
	ld h, b
	ld de, wStringBuffer1
	rst PlaceString
	ld a, "!"
	ld [bc], a
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld a, EGG
	jr nz, .got_species
	ld a, [wCurPartySpecies]
.got_species
	call PlayCry
	hlcoord 0, 0
	lb bc, 15, 8
	call ClearBox
	hlcoord 8, 14
	lb bc, 1, 3
	call ClearBox
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox
	call ApplyTilemapInVBlank
	and a
	ret

.asm_boxisfull
	ld de, PCString_BoxFull
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	scf
	ret

TryWithdrawPokemon:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank
	ld a, [wCurPartyMon]
	ld hl, sBoxMonNicknames
	call GetNick
	call CloseSRAM
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef SentGetPkmnIntoFromBox
	jr c, .PartyFull
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromPartyOrBox
	ld de, PCString_Got
	call BillsPC_PlaceString
	ld l, c
	ld h, b
	ld de, wStringBuffer1
	rst PlaceString
	ld a, "!"
	ld [bc], a
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld a, EGG
	jr nz, .got_species
	ld a, [wCurPartySpecies]
.got_species
	call PlayCry
	hlcoord 0, 0
	lb bc, 15, 8
	call ClearBox
	hlcoord 8, 14
	lb bc, 1, 3
	call ClearBox
	hlcoord 0, 15
	lb bc, 1, 18
	call Textbox
	call ApplyTilemapInVBlank
	and a
	ret

.PartyFull:
	ld de, PCString_PartyFull
	call BillsPC_PlaceString
	ld de, SFX_WRONG
	call WaitPlaySFX
	call WaitSFX
	scf
	ret

ReleasePKMN_ByePKMN:
	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName

	hlcoord 0, 0
	lb bc, 15, 8
	call ClearBox
	hlcoord 8, 14
	lb bc, 1, 3
	call ClearBox
	ld de, PCString_Bye
	call BillsPC_PlaceString
	ld l, c
	ld h, b
	inc hl
	ld de, wStringBuffer1
	rst PlaceString
	ld l, c
	ld h, b
	ld [hl], "!"

	call ApplyTilemapInVBlank
	ld a, [wCurPartySpecies]
	push af
	call PlayCry
	pop af

	cp RAIKOU
	jr nz, .not_raikou
	farcall RespawnRoamingRaikou
	jr .not_suicune
.not_raikou
	cp ENTEI
	jr nz, .not_entei
	farcall RespawnRoamingEntei
	jr .not_suicune
.not_entei
	cp SUICUNE
	jr nz, .not_suicune
	farcall RespawnRoamingSuicune
.not_suicune

	ld de, PCString_ReleasedPKMN
	jp BillsPC_PlaceString

MovePKMNWitoutMail_InsertMon:
	push hl
	push de
	push bc
	push af
	ld de, .Saving_LeaveOn
	call BillsPC_PlaceString
	pop af
	pop bc
	pop de
	pop hl
	ld a, [wCurBox]
	push af
	ld bc, 0
	ld a, [wBillsPC_BackupLoadedBox]
	and a
	jr nz, .moving_from_box
	set 0, c

.moving_from_box
	ld a, [wBillsPC_LoadedBox]
	and a
	jr nz, .moving_to_box
	set 1, c

.moving_to_box
	ld hl, .Jumptable
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	pop af
	ld e, a
	farjp MovePkmnWOMail_InsertMon_SaveGame

.Saving_LeaveOn:
	db "Saving… Leave ON!@"

.Jumptable:

	dw .BoxToBox
	dw .PartyToBox
	dw .BoxToParty
	dw .PartyToParty

.BoxToBox:
	ld hl, wBillsPC_BackupLoadedBox
	ld a, [wBillsPC_LoadedBox]
	cp [hl]
	jr z, .same_box
	call .CopyFromBox
	jp .CopyToBox

.same_box
	call .CopyFromBox
	call .CheckTrivialMove
	jp .CopyToBox

.PartyToBox:
	call .CopyFromParty
	ld a, $1
	ld [wGameLogicPaused], a
	farcall SaveGameData
	farcall SaveCurrentVersion
	xor a
	ld [wGameLogicPaused], a
	jp .CopyToBox

.BoxToParty:
	call .CopyFromBox
	jp .CopyToParty

.PartyToParty:
	call .CopyFromParty
	call .CheckTrivialMove
	jp .CopyToParty

.CheckTrivialMove:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld e, a
	ld a, [wBillsPC_BackupCursorPosition]
	ld hl, wBillsPC_BackupScrollPosition
	add [hl]
	cp e
	ret nc
	ld hl, wBillsPC_CursorPosition
	ld a, [hl]
	and a
	jr z, .top_of_screen
	dec [hl]
	ret

.top_of_screen
	ld hl, wBillsPC_ScrollPosition
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.CopyFromBox:
	ld a, [wBillsPC_BackupLoadedBox]
	dec a
	ld e, a
	farcall MovePkmnWOMail_SaveGame
	ld a, [wBillsPC_BackupCursorPosition]
	ld hl, wBillsPC_BackupScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld a, $1
	call GetSRAMBank
	ld hl, sBoxSpecies
	call CopySpeciesToTemp
	ld hl, sBoxMonNicknames
	call CopyNicknameToTemp
	ld hl, sBoxMonOT
	call CopyOTNameToTemp
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyMonToTemp
	call CloseSRAM
	farcall CalcBufferMonStats
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef_jump RemoveMonFromPartyOrBox

.CopyToBox:
	ld a, [wBillsPC_LoadedBox]
	dec a
	ld e, a
	farcall MovePkmnWOMail_SaveGame
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	farjp InsertPokemonIntoBox

.CopyFromParty:
	ld a, [wBillsPC_BackupCursorPosition]
	ld hl, wBillsPC_BackupScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	ld hl, wPartySpecies
	call CopySpeciesToTemp
	ld hl, wPartyMonNicknames
	call CopyNicknameToTemp
	ld hl, wPartyMonOT
	call CopyOTNameToTemp
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyMonToTemp
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef_jump RemoveMonFromPartyOrBox

.CopyToParty:
	ld a, [wBillsPC_CursorPosition]
	ld hl, wBillsPC_ScrollPosition
	add [hl]
	ld [wCurPartyMon], a
	farjp InsertPokemonIntoParty

CopySpeciesToTemp:
	ld a, [wCurPartyMon]
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ret

CopyNicknameToTemp:
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMonNick
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ret

CopyOTNameToTemp:
	ld bc, NAME_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

CopyMonToTemp:
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld de, wBufferMon
	rst CopyBytes
	ret

GetBoxPointer:
	dec b
	ld c, b
	ld b, 0
	ld hl, .boxes
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.boxes
	;  bank, address
	dba sBox1
	dba sBox2
	dba sBox3
	dba sBox4
	dba sBox5
	dba sBox6
	dba sBox7
	dba sBox8
	dba sBox9
	dba sBox10
	dba sBox11
	dba sBox12
	dba sBox13
	dba sBox14

BillsPC_ApplyPalettes:
	call GetCGBLayout
	ld a, %11100100
	call DmgToCgbBGPals
	ld a, %11111100
	jp DmgToCgbObjPal0

BillsPC_InitGFX:
	call DisableLCD
	ld hl, vTiles2 tile $00
	ld bc, $31 tiles
	xor a
	rst ByteFill
	call LoadStandardFont
	call LoadFontsBattleExtra
	ld hl, PCMailGFX
	ld de, vTiles2 tile $5c
	ld bc, 4 tiles
	rst CopyBytes
	ld hl, PCSelectLZ
	ld de, vTiles0 tile $00
	call Decompress
	ld a, 6
	call SkipMusic
	jp EnableLCD

PCSelectLZ: INCBIN "gfx/pc/pc.2bpp.lz"
PCMailGFX:  INCBIN "gfx/pc/mail.2bpp"

PCString_ChooseaPKMN: db "Choose a <PK><MN>.@"
PCString_WhatsUp: db "What's up?@"
PCString_ReleasePKMN: db "Release <PK><MN>?@"
PCString_MoveToWhere: db "Move to where?@"
PCString_ItsYourLastPKMN: db "It's your last <PK><MN>!@"
PCString_TheresNoRoom: db "There's no room!@"
PCString_NoMoreUsablePKMN: db "No more usable <PK><MN>!@"
PCString_RemoveMail: db "Remove Mail.@"
PCString_ReleasedPKMN: db "Released <PK><MN>.@"
PCString_Bye: db "Bye,@"
PCString_Stored: db "Stored @"
PCString_Got: db "Got @"
PCString_BoxFull: db "The Box is full.@"
PCString_PartyFull: db "The party's full!@"
PCString_NoReleasingEGGS: db "No releasing Eggs!@"
PCString_NoHeldItem: db "No held item@"

_ChangeBox:
	call LoadStandardMenuHeader
	call BillsPC_ClearTilemap
.loop
	xor a
	ldh [hBGMapMode], a
	call BillsPC_PrintBoxName
	call BillsPC_PlaceChooseABoxString
	ld hl, _ChangeBox_menudataheader
	call CopyMenuHeader
	xor a
	ld [wMenuScrollPosition], a
	hlcoord 0, 4
	lb bc, 8, 9
	call Textbox
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .done
	call BillsPC_PlaceWhatsUpString
	call BillsPC_ChangeBoxSubmenu
	jr .loop
.done
	jp CloseWindow

BillsPC_ClearTilemap:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	rst ByteFill
	ret

_ChangeBox_menudataheader:
	db $40 ; flags
	db 05, 01 ; start coords
	db 12, 09 ; end coords
	dw .menudata2
	db 1 ; default option

.menudata2
	db $22 ; flags
	db 4, 0
	db 1
	dba .boxes
	dba .boxnames
	dba NULL
	dba BillsPC_PrintBoxCountAndCapacity

.boxes
	db NUM_BOXES
x = 1
rept NUM_BOXES
	db x
x = x + 1
endr
	db -1

.boxnames
	push de
	ld a, [wMenuSelection]
	dec a
	call GetBoxName
	pop hl
	rst PlaceString
	ret

GetBoxName:
	ld bc, BOX_NAME_LENGTH
	ld hl, wBoxNames
	rst AddNTimes
	ld d, h
	ld e, l
	ret

BillsPC_PrintBoxCountAndCapacity:
	hlcoord 11, 7
	lb bc, 5, 7
	call Textbox
	ld a, [wMenuSelection]
	cp -1
	ret z
	hlcoord 12, 9
	ld de, .Pokemon
	rst PlaceString
	call GetBoxCount
	ld [wd265], a
	hlcoord 13, 11
	ld de, wd265
	lb bc, 1, 2
	call PrintNum
	ld de, .out_of_20
	rst PlaceString
	ret

.Pokemon:
	db "#mon@"

.out_of_20
	; db "/20@"
	db "/"
	db "0" + MONS_PER_BOX / 10 ; "2"
	db "0" + MONS_PER_BOX % 10 ; "0"
	db "@"

BillsPC_PrintBoxCountAndCapacityInsideBox:
	hlcoord 0, 0
	lb bc, 1, 5
	call Textbox
	ld a, [wBillsPC_LoadedBox]
	and a
	jr z, .party
	ld a, [wBillsPC_NumMonsInBox]
	dec a
	ld [wd265], a
	hlcoord 1, 1
	ld de, wd265
	lb bc, 1, 2
	call PrintNum
	ld de, .out_of_20
	rst PlaceString
	ret

.party
	ld a, [wPartyCount]
	ld [wd265], a
	hlcoord 1, 1
	ld de, wd265
	lb bc, 1, 2
	call PrintNum
	ld de, .out_of_6
	rst PlaceString
	ret

.out_of_20
	; db "/20@"
	db "/"
if MONS_PER_BOX < 10
	db " "
else
	db "0" + MONS_PER_BOX / 10 ; "2"
endc
	db "0" + MONS_PER_BOX % 10 ; "0"
	db "@"

.out_of_6
	; db "/ 6@"
	db "/"
if PARTY_LENGTH < 10
	db " "
else
	db "0" + PARTY_LENGTH / 10 ; "0"
endc
	db "0" + PARTY_LENGTH % 10 ; "6"
	db "@"

GetBoxCountWithC:
	ld a, [wCurBox]
	ld b, a
	ld a, c
	ld c, b
	jr BoxSelectionJumpIn

GetBoxCount:
	ld a, [wCurBox]
	ld c, a
	ld a, [wMenuSelection]
BoxSelectionJumpIn:
	dec a
	cp c
	jr z, .activebox
	ld c, a
	ld b, 0
	ld hl, .boxbanks
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	call GetSRAMBank
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	call CloseSRAM
	ld c, a
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .newfile
	ld a, c
	ret

.newfile
	xor a
	ret

.activebox
	ld a, BANK(sBoxCount)
	ld b, a
	call GetSRAMBank
	ld hl, sBoxCount
	ld a, [hl]
	jp CloseSRAM

.boxbanks
	dba sBox1
	dba sBox2
	dba sBox3
	dba sBox4
	dba sBox5
	dba sBox6
	dba sBox7
	dba sBox8
	dba sBox9
	dba sBox10
	dba sBox11
	dba sBox12
	dba sBox13
	dba sBox14

BillsPC_PrintBoxName:
	hlcoord 0, 0
	lb bc, 2, 18
	call Textbox
	hlcoord 1, 2
	ld de, .Current
	rst PlaceString
	ld a, [wCurBox]
	and $f
	call GetBoxName
	hlcoord 11, 2
	rst PlaceString
	ret

.Current:
	db "Current@"

BillsPC_ChangeBoxSubmenu:
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	jr z, .Switch
	cp $2
	jr z, .Name
	and a
	ret

.Switch:
	ld a, [wMenuSelection]
	dec a
	ld e, a
	ld a, [wCurBox]
	cp e
	ret z
	farjp ChangeBoxSaveGame

.Name:
	ld b, $4 ; box
	ld de, wBoxNameBuffer
	farcall NamingScreen
	call ClearTileMap
	call LoadStandardFont
	call LoadFontsBattleExtra
	ld a, [wMenuSelection]
	dec a
	call GetBoxName
	ld e, l
	ld d, h
	ld hl, wBoxNameBuffer
	ld c, BOX_NAME_LENGTH - 1
	call InitString
	ld a, [wMenuSelection]
	dec a
	call GetBoxName
	ld de, wBoxNameBuffer
	jp CopyName2

.MenuDataHeader:
	db $40 ; flags
	db 04, 11 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Switch@"
	db "Name@"
	db "Quit@"

BillsPC_PlaceChooseABoxString:
	ld de, .ChooseABox
	jr BillsPC_PlaceChangeBoxString

.ChooseABox:
	db "Choose a Box.@"

BillsPC_PlaceWhatsUpString:
	ld de, .WhatsUp
	jr BillsPC_PlaceChangeBoxString

.WhatsUp:
	db "What's up?@"

BillsPC_PlaceChangeBoxString:
	push de
	hlcoord 0, 14
	lb bc, 2, 18
	call Textbox
	pop de
	hlcoord 1, 16
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret
