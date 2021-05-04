Pack:
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
	ld a, [wLastPocket]
	call InitPackBuffers
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	jr .loop

.done
	call SFXDelay2
	ld a, [wCurPocket]
	ld [wLastPocket], a
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ret

.RunJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .InitGFX            ;  0
	dw .InitItemsPocket    ;  1
	dw .ItemsPocketMenu    ;  2
	dw .InitMedicinePocket ;  3
	dw .MedicinePocketMenu ;  4
	dw .InitBallsPocket    ;  5
	dw .BallsPocketMenu    ;  6
	dw .InitTMHMPocket     ;  7
	dw .TMHMPocketMenu     ;  8
	dw .InitBerriesPocket  ;  9
	dw .BerriesPocketMenu  ; 10
	dw .InitKeyItemsPocket ; 11
	dw .KeyItemsPocketMenu ; 12
	dw Pack_QuitNoScript   ; 13
	dw Pack_QuitRunScript  ; 14

.InitGFX:
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	ld a, [wPackJumptableIndex]
	ld [wJumptableIndex], a
	jmp Pack_InitColors

.InitItemsPocket:
	ld a, ITEM - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.ItemsPocketMenu:
	ld hl, ItemsPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wItemsPocketScrollPosition]
	call PackScrollingMenu
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	lb bc, $b, $3 ; Key Items, Medicine
	call Pack_InterpretJoypad
	ret c
	jmp .ItemMedsBallsBerries_LoadSubmenu

.InitMedicinePocket:
	ld a, MEDICINE - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.MedicinePocketMenu:
	ld hl, MedicinePocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wMedicinePocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wMedicinePocketScrollPosition]
	call PackScrollingMenu
	ld [wMedicinePocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wMedicinePocketCursor], a
	lb bc, $1, $5 ; Items, Balls
	call Pack_InterpretJoypad
	ret c
	jmp .ItemMedsBallsBerries_LoadSubmenu

.InitBallsPocket:
	ld a, BALL - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.BallsPocketMenu:
	ld hl, BallsPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBallsPocketScrollPosition]
	call PackScrollingMenu
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	lb bc, $3, $7 ; Medicine, TM/HM
	call Pack_InterpretJoypad
	ret c
	jmp .ItemMedsBallsBerries_LoadSubmenu

.InitTMHMPocket:
	ld a, TM_HM - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.TMHMPocketMenu:
	farcall TMHMPocket
	lb bc, $5, $9 ; Balls, Berries
	call Pack_InterpretJoypad
	ret c
	jmp nz, PackSortMenu
	ld hl, MenuDataHeader_Use
	ld de, .Jumptable1
	jmp PackBuildMenu

.Jumptable1:
	dw .UseItem
	dw DoNothing

.UseItem:
	farcall AskTeachTMHM
	ret c
	farcall ChooseMonToLearnTMHM
	jr c, .declined
	ld hl, wOptions1
	ld a, [hl]
	push af
	res NO_TEXT_SCROLL, [hl]
	farcall TeachTMHM
	pop af
	ld [wOptions1], a
.declined
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.InitBerriesPocket:
	ld a, BERRIES - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.BerriesPocketMenu:
	ld hl, BerriesPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wBerriesPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBerriesPocketScrollPosition]
	call PackScrollingMenu
	ld [wBerriesPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBerriesPocketCursor], a
	lb bc, $7, $b ; TM/HM, Key Items
	call Pack_InterpretJoypad
	ret c
	jr .ItemMedsBallsBerries_LoadSubmenu

.InitKeyItemsPocket:
	ld a, KEY_ITEM - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.KeyItemsPocketMenu:
	farcall KeyItemsPocket
	lb bc, $9, $1 ; Berries, Items
	call Pack_InterpretJoypad
	ret c
	jr KeyItems_LoadSubmenu

.ItemMedsBallsBerries_LoadSubmenu:
	jr nz, PackSortMenu
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	and a
	jr z, .cant_use

	ld hl, MenuDataHeader_UseGiveToss
	ld de, Jumptable_UseGiveTossQuit
	jr PackBuildMenu

.cant_use
	ld hl, MenuDataHeader_GiveToss
	ld de, Jumptable_GiveTossQuit
	; fallthrough

PackBuildMenu:
	push de
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	pop hl
	ret c
PackMenuJump:
	ld a, [wMenuCursorY]
	dec a
	jmp JumpTable

PackSortMenu:
	ld hl, Text_SortItemsHow
	call Pack_PrintTextNoScroll
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [wMenuData_ScrollingMenuSpacing]
	push af
	ld a, [wCurPocket]
	cp TM_HM - 1
	ld hl, MenuDataHeader_SortTMs
	ld de, Jumptable_SortTMs
	jr z, .got_sort_menu
	ld hl, MenuDataHeader_SortItems
	ld de, Jumptable_SortItems
.got_sort_menu
	push de
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	jr nc, .no_quit
	ld a, 3
	ld [wMenuCursorY], a
.no_quit
	pop de
	pop af
	ld [wMenuData_ScrollingMenuSpacing], a
	pop bc
	ld hl, wMenuData_ItemsPointerAddr
	ld a, c
	ld [hli], a
	ld [hl], b
	ld h, d
	ld l, e
	jr PackMenuJump

KeyItems_LoadSubmenu:
	farcall CheckSelectableKeyItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .selectable

	ld hl, MenuDataHeader_Use
	ld de, Jumptable_KeyItem_UseQuit
	jr PackBuildMenu

.selectable
	ld hl, MenuDataHeader_UseSel
	ld de, Jumptable_KeyItem_UseRegisterQuit
	jr PackBuildMenu

UseKeyItem:
	farcall CheckKeyItemMenu
	ld a, [wItemAttributeParamBuffer]
	call StackJumpTable

.Jumptable
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Current
	dw .Party
	dw .Field

.Oak:
	ld hl, Text_ThisIsntTheTime
	jmp Pack_PrintTextNoScroll

.Current:
	predef_jump DoKeyItemEffect

.Party:
	ld a, [wPartyCount]
	and a
	jr z, .NoPokemon
	predef DoKeyItemEffect
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.NoPokemon:
	ld hl, TextJump_YouDontHaveAPkmn
	jmp Pack_PrintTextNoScroll

.Field:
	predef DoKeyItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	ld a, $e ; QuitRunScript
	ld [wJumptableIndex], a
	ret

PackScrollingMenu:
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ret

MenuDataHeader_SortTMs:
	db $40 ; flags
	db 05, 08 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 3 ; items
	db "By Number@"
	db "By Name@"
	db "Quit@"

MenuDataHeader_SortItems:
	db $40 ; flags
	db 05, 10 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 3 ; items
	db "By Type@"
	db "By Name@"
	db "Quit@"

Jumptable_SortItems:
	dw SortItemsName
	dw SortItemsType
	dw DoNothing

Jumptable_SortTMs:
	dw SortTMsNumber
	dw SortTMsName
	dw DoNothing

SortTMsNumber:
	ld hl, wTMHMPocketCursor
	res 7, [hl]
	ret

SortTMsName:
	ld hl, wTMHMPocketCursor
	set 7, [hl]
	ret

SortItemsType:
SortItemsName:
	farjp SortItemsInBag

MenuDataHeader_UseGiveToss:
	db $40 ; flags
	db 03, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 4 ; items
	db "Use@"
	db "Give@"
	db "Toss@"
	db "Quit@"

Jumptable_UseGiveTossQuit:
	dw UseItem
	dw GiveItem
	dw TossMenu
	dw DoNothing

MenuDataHeader_Use:
	db %01000000 ; flags
	db 07, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 2 ; items
	db "Use@"
	db "Quit@"

MenuDataHeader_Quit:
	db %01000000 ; flags
	db 09, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 1 ; items
	db "Quit@"

Jumptable_UseQuit:
	dw UseItem
	dw DoNothing

Jumptable_KeyItem_UseQuit:
	dw UseKeyItem
	dw DoNothing

MenuDataHeader_UseSel:
	db %01000000 ; flags
	db 05, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 3 ; items
	db "Use@"
	db "Sel@"
	db "Quit@"

Jumptable_KeyItem_UseRegisterQuit:
	dw UseKeyItem
	dw RegisterKeyItem
	dw DoNothing

MenuDataHeader_GiveToss:
	db $40 ; flags
	db 05, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 3 ; items
	db "Give@"
	db "Toss@"
	db "Quit@"

Jumptable_GiveTossQuit:
	dw GiveItem
	dw TossMenu
	dw DoNothing

UseItem:
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	call StackJumpTable

.Jumptable
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Oak
	dw DoItemEffect
	dw .Party
	dw .Field

.Oak:
	ld hl, Text_ThisIsntTheTime
	jmp Pack_PrintTextNoScroll

.Party:
	ld a, [wPartyCount]
	and a
	jr z, .NoPokemon
	call DoItemEffect
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.NoPokemon:
	ld hl, TextJump_YouDontHaveAPkmn
	jmp Pack_PrintTextNoScroll

.Field:
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	ld a, $e ; QuitRunScript
	ld [wJumptableIndex], a
	ret

TossMenu:
	ld hl, Text_ThrowAwayHowMany
	call Pack_PrintTextNoScroll
	farcall SelectQuantityToToss
	push af
	call ExitMenu
	pop af
	ret c
	call Pack_GetItemName
	ld hl, Text_ConfirmThrowAway
	call MenuTextbox
	call YesNoBox
	push af
	call ExitMenu
	pop af
	ret c
	ld hl, wNumItems
	ld a, [wCurItemQuantity]
	call TossItem
	call Pack_GetItemName
	ld hl, Text_ThrewAway
	jmp Pack_PrintTextNoScroll

RegisterKeyItem:
	farcall CheckSelectableKeyItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr z, .cant_register

	; Check if the item is registered
	ld hl, wRegisteredItems
	ld a, [wCurKeyItem]
	ld e, a
	ld d, 4

.already_registered_loop
	ld a, [hl]
	cp e
	jr z, .found_registered_slot
	inc hl
	dec d
	jr nz, .already_registered_loop

	ld hl, wRegisteredItems
	ld d, 4
.loop
	ld a, [hl]
	and a
	jr z, .found_empty_slot
	inc hl
	dec d
	jr nz, .loop
	ld hl, Text_NoEmptySlot
	jmp PrintText

.found_empty_slot
	ld a, [wCurKeyItem]
	ld [hl], a
	call Pack_GetKeyItemName
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, Text_RegisteredItem
	jr .print

.found_registered_slot
	ld [hl], 0
	ld a, [wCurKeyItem]
	call Pack_GetKeyItemName
	ld hl, Text_UnregisteredItem
	jr .print

.cant_register
	ld hl, Text_CantRegister
.print
	jmp Pack_PrintTextNoScroll

GiveItem:
	ld a, [wPartyCount]
	and a
	jr z, .NoPokemon
	ld a, [wOptions1]
	push af
	res NO_TEXT_SCROLL, a
	ld [wOptions1], a
	ld a, $8
	ld [wPartyMenuActionText], a
	call ClearBGPalettes
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
.loop
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .finish
	ld a, MON_FORM
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr z, .give
	ld hl, .Egg
	call PrintText
	jr .loop

.give
	ld a, [wJumptableIndex]
	push af
	ld a, [wPackJumptableIndex]
	push af
	call GetCurNickname
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call TryGiveItemToPartymon
	pop af
	ld [wPackJumptableIndex], a
	pop af
	ld [wJumptableIndex], a
.finish
	pop af
	ld [wOptions1], a
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.NoPokemon:
	ld hl, TextJump_YouDontHaveAPkmn
	jmp Pack_PrintTextNoScroll
.Egg:
	; An EGG can't hold an item.
	text_far Text_AnEGGCantHoldAnItem
	text_end

BattlePack:
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
	ld a, [wLastBattlePocket]
	call InitPackBuffers
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .end
	call .RunJumptable
	jr .loop

.end
	ld a, [wCurPocket]
	ld [wLastBattlePocket], a
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ret

.RunJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .InitGFX            ;  0
	dw .InitItemsPocket    ;  1
	dw .ItemsPocketMenu    ;  2
	dw .InitMedicinePocket ;  3
	dw .MedicinePocketMenu ;  4
	dw .InitBallsPocket    ;  5
	dw .BallsPocketMenu    ;  6
	dw .InitTMHMPocket     ;  7
	dw .TMHMPocketMenu     ;  8
	dw .InitBerriesPocket  ;  9
	dw .BerriesPocketMenu  ; 10
	dw .InitKeyItemsPocket ; 11
	dw .KeyItemsPocketMenu ; 12
	dw Pack_QuitNoScript   ; 13
	dw Pack_QuitRunScript  ; 14

.InitGFX:
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	ld a, [wPackJumptableIndex]
	ld [wJumptableIndex], a
	jmp Pack_InitColors

.InitItemsPocket:
	ld a, ITEM - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.ItemsPocketMenu:
	ld hl, ItemsPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wBattleItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBattleItemsPocketScrollPosition]
	call PackScrollingMenu
	ld [wBattleItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBattleItemsPocketCursor], a
	lb bc, $b, $3 ; Key Items, Medicine
	call Pack_InterpretJoypad
	ret c
	jmp ItemSubmenu

.InitMedicinePocket:
	ld a, MEDICINE - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.MedicinePocketMenu:
	ld hl, MedicinePocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wBattleMedicinePocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBattleMedicinePocketScrollPosition]
	call PackScrollingMenu
	ld [wBattleMedicinePocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBattleMedicinePocketCursor], a
	lb bc, $1, $5 ; Items, Balls
	call Pack_InterpretJoypad
	ret c
	jmp ItemSubmenu

.InitBallsPocket:
	ld a, BALL - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.BallsPocketMenu:
	ld hl, BallsPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wBattleBallsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBattleBallsPocketScrollPosition]
	call PackScrollingMenu
	ld [wBattleBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBattleBallsPocketCursor], a
	lb bc, $3, $7 ; Medicine, TM/HM
	call Pack_InterpretJoypad
	ret c
	jmp ItemSubmenu

.InitTMHMPocket:
	ld a, TM_HM - 1
	ld [wCurPocket], a
	call ClearPocketList
	xor a
	ldh [hBGMapMode], a
	call WaitBGMap_DrawPackGFX
	ld hl, Text_PackEmptyString
	call Pack_PrintTextNoScroll
	jmp Pack_JumptableNext

.TMHMPocketMenu:
	farcall TMHMPocket
	lb bc, $5, $9 ; Balls, Berries
	call Pack_InterpretJoypad
	ret c
	jmp nz, PackSortMenu
	jmp KeyItemSubmenu.unusable

.InitBerriesPocket:
	ld a, BERRIES - 1
	ld [wCurPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jmp Pack_JumptableNext

.BerriesPocketMenu:
	ld hl, BerriesPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wBattleBerriesPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBattleBerriesPocketScrollPosition]
	call PackScrollingMenu
	ld [wBattleBerriesPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBattleBerriesPocketCursor], a
	lb bc, $7, $b ; TM/HM, Key Items
	call Pack_InterpretJoypad
	ret c
	jr ItemSubmenu

.InitKeyItemsPocket:
	ld a, KEY_ITEM - 1
	ld [wCurPocket], a
	call ClearPocketList
	xor a
	ldh [hBGMapMode], a
	call WaitBGMap_DrawPackGFX
	ld hl, Text_PackEmptyString
	call Pack_PrintTextNoScroll
	jmp Pack_JumptableNext

.KeyItemsPocketMenu:
	farcall KeyItemsPocket
	lb bc, $9, $1 ; Berries, Items
	call Pack_InterpretJoypad
	ret c
	farcall CheckKeyItemContext
	ld a, [wItemAttributeParamBuffer]
	jr KeyItemSubmenu

ItemSubmenu:
	jmp nz, PackSortMenu
	farcall CheckItemContext
	ld a, [wItemAttributeParamBuffer]
	and a
	ld hl, MenuDataHeader_Use
	ld de, .UsableJumptable
	jr nz, .proceed
	ld hl, MenuDataHeader_Quit
	ld de, .UnusableJumptable
.proceed
	jmp PackBuildMenu

.UsableJumptable:
	dw .Use
.UnusableJumptable:
	dw DoNothing

.Use:
	farcall CheckItemContext
	ld a, [wItemAttributeParamBuffer]
	call StackJumpTable

.ItemFunctionJumptable:
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Unused
	dw .BattleField
	dw .BattleOnly

.Oak:
	ld hl, Text_ThisIsntTheTime
	jmp Pack_PrintTextNoScroll

.Unused:
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .ReturnToBattle
	ret

.BattleField:
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .quit_run_script
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.ReturnToBattle:
	call ClearBGPalettes
	jr .quit_run_script

.BattleOnly:
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	cp $2
	jr z, .didnt_use_item
.quit_run_script
	ld a, $e ; QuitRunScript
	ld [wJumptableIndex], a
	ret

.didnt_use_item
	xor a
	ld [wItemEffectSucceeded], a
	ret

KeyItemSubmenu:
	farcall CheckKeyItemContext
	ld a, [wItemAttributeParamBuffer]
	and a
	ld hl, MenuDataHeader_Use
	ld de, .UsableJumptable
	jr nz, .proceed
.unusable:
	ld hl, MenuDataHeader_Quit
	ld de, .UnusableJumptable
.proceed
	jmp PackBuildMenu

.UsableJumptable:
	dw .Use
.UnusableJumptable:
	dw DoNothing

.Use:
	farcall CheckKeyItemContext
	ld a, [wItemAttributeParamBuffer]
	call StackJumpTable

.KeyItemFunctionJumptable:
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Current
	dw .BattleField
	dw .BattleOnly

.Oak:
	ld hl, Text_ThisIsntTheTime
	jmp Pack_PrintTextNoScroll

.Current:
	predef DoKeyItemEffect
	jr .didnt_use_item

.BattleField:
	predef DoKeyItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .quit_run_script
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jmp Pack_InitColors

.BattleOnly:
	predef DoKeyItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	cp $2
	jr z, .didnt_use_item
.quit_run_script
	ld a, $e ; QuitRunScript
	ld [wJumptableIndex], a
	ret

.didnt_use_item
	xor a
	ld [wItemEffectSucceeded], a
	ret

InitPackBuffers:
	push af
	xor a
	ld [wJumptableIndex], a
	pop af
	and $7
	ld [wCurPocket], a
	inc a
	add a
	dec a
	ld [wPackJumptableIndex], a
	xor a
	ld [wPackUsedItem], a
	xor a
	ld [wSwitchItem], a
	ret

DepositSellInitPackBuffers:
	xor a
	ldh [hBGMapMode], a
	ld [wJumptableIndex], a ; PACKSTATE_INITGFX
	ld [wPackJumptableIndex], a ; PACKSTATE_INITGFX
	ld [wCurPocket], a ; ITEM_POCKET
	ld [wPackUsedItem], a
	ld [wSwitchItem], a
	call Pack_InitGFX
	jmp Pack_InitColors

DepositSellPack:
.loop
	call .RunJumptable
	call DepositSellTutorial_InterpretJoypad
	jr c, .loop
	ret

.RunJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .ItemsPocket
	dw .MedicinePocket
	dw .BallsPocket
	dw .TMHMPocket
	dw .BerriesPocket
	dw .KeyItemsPocket

.ItemsPocket:
	ld a, ITEM - 1
	call InitPocket
	ld hl, PC_Mart_ItemsPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	ret

.MedicinePocket:
	ld a, MEDICINE - 1
	call InitPocket
	ld hl, PC_Mart_MedicinePocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wMedicinePocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wMedicinePocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wMedicinePocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wMedicinePocketCursor], a
	ret

.BallsPocket:
	ld a, BALL - 1
	call InitPocket
	ld hl, PC_Mart_BallsPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	ret

.TMHMPocket:
	ld a, TM_HM - 1
	call InitPocket
	call WaitBGMap_DrawPackGFX
	farcall TMHMPocket
	ld a, [wCurItem]
	ret

.BerriesPocket:
	ld a, BERRIES - 1
	call InitPocket
	ld hl, PC_Mart_BerriesPocketMenuDataHeader
	call CopyMenuHeader
	ld a, [wBerriesPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBerriesPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBerriesPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBerriesPocketCursor], a
	ret

.KeyItemsPocket:
	ld a, KEY_ITEM - 1
	call InitPocket
	call WaitBGMap_DrawPackGFX
	farcall KeyItemsPocket
	ld a, [wCurItem]
	ret

InitPocket:
	ld [wCurPocket], a
	call ClearPocketList
	jmp WaitBGMap_DrawPackGFX

DepositSellTutorial_InterpretJoypad:
	ld hl, wMenuJoypad
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and D_LEFT
	jr nz, .d_left
	ld a, [hl]
	and D_RIGHT
	jr nz, .d_right
	scf
	ret

.a_button
	ld a, TRUE
	ld [wPackUsedItem], a
	and a
	ret

.b_button
	xor a ; FALSE
	ld [wPackUsedItem], a
	and a
	ret

.d_left
	ld a, [wJumptableIndex]
	dec a
	cp -1
	jr nz, .left_ok
	ld a, 5
.left_ok
	ld [wJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.d_right
	ld a, [wJumptableIndex]
	inc a
	cp 6
	jr nz, .right_ok
	xor a
.right_ok
	ld [wJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

TutorialPack:
	call DepositSellInitPackBuffers
	ld a, [wInputType]
	or a
	jr z, .loop
	ld hl, .autoinput_right_right_a
	ld a, BANK(.autoinput_right_right_a)
	call StartAutoInput
.loop
	call .RunJumptable
	call DepositSellTutorial_InterpretJoypad
	jr c, .loop
	xor a ; FALSE
	ld [wPackUsedItem], a
	ret

.autoinput_right_right_a
	db NO_INPUT, $40
	db D_RIGHT,  $00
	db NO_INPUT, $40
	db D_RIGHT,  $00
	db NO_INPUT, $40
.autoselect
	db A_BUTTON, $00
	db NO_INPUT, $ff ; end

.RunJumptable:
	call StandardStackJumpTable

.Jumptable
	dw .Items
	dw .Medicine
	dw .Balls

.Items:
	ld a, ITEM - 1
	ld hl, .ItemsMenuDataHeader
	jr .DisplayPocket

.ItemsMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .ItemsMenuData2
	db 1 ; default option

.ItemsMenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wDudeNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

.Medicine:
	ld a, MEDICINE - 1
	ld hl, .MedicineMenuDataHeader
	jr .DisplayPocket

.MedicineMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MedicineMenuData2
	db 1 ; default option

.MedicineMenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wDudeNumMedicine
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

.Balls:
	ld a, BALL - 1
	ld hl, .BallsMenuDataHeader
	jr .DisplayPocket

.BallsMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .BallsMenuData2
	db 1 ; default option

.BallsMenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wDudeNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

.DisplayPocket:
	push hl
	call InitPocket
	pop hl
	call CopyMenuHeader
	jmp ScrollingMenu

Pack_JumptableNext:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Pack_QuitNoScript:
	ld hl, wJumptableIndex
	set 7, [hl]
	xor a ; FALSE
	ld [wPackUsedItem], a
	ret

Pack_QuitRunScript:
	ld hl, wJumptableIndex
	set 7, [hl]
	ld a, TRUE
	ld [wPackUsedItem], a
	ret

Pack_PrintTextNoScroll:
	ld a, [wOptions1]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions1], a
	call PrintText
	pop af
	ld [wOptions1], a
	ret

WaitBGMap_DrawPackGFX:
	call ApplyTilemapInVBlank
DrawPackGFX:
	; place top row
	ld a, [wCurPocket]
	and $7
	push af
	ld c, a
	add a
	add c
	cp 10
	jr c, .got_pocket
	inc a
	cp 14
	jr c, .got_pocket
	inc a
.got_pocket
	ld b, a
	inc b
	ld a, 2
	ld c, 20
	hlcoord 0, 0
.loop
	dec b
	jr nz, .normal_insert
	ld [hl], $1 ; no-optimize *hl++|*hl-- = N
	inc hl
	jr .insert_ok
.normal_insert
	ld [hli], a
	inc a
.insert_ok
	dec c
	jr nz, .loop

	; place pack gfx
	ld bc, .FemaleGFX
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .got_pointers
	ld a, [wPlayerGender]
	rrca
	jr c, .got_pointers
	ld bc, .MaleGFX
.got_pointers
	pop af
	ld l, a
	ld h, 0
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, vTiles2 tile $28
	lb bc, BANK("Pack Graphics"), 25
	jmp DecompressRequest2bpp

.MaleGFX:
	dw PackM0GFX ; far-ok
	dw PackM1GFX ; far-ok
	dw PackM2GFX ; far-ok
	dw PackM3GFX ; far-ok
	dw PackM4GFX ; far-ok
	dw PackM5GFX ; far-ok

.FemaleGFX:
	dw PackF0GFX ; far-ok
	dw PackF1GFX ; far-ok
	dw PackF2GFX ; far-ok
	dw PackF3GFX ; far-ok
	dw PackF4GFX ; far-ok
	dw PackF5GFX ; far-ok

Pack_InterpretJoypad:
	ld hl, wMenuJoypad
	ld a, [wSwitchItem]
	and a
	jr nz, .switching_item
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_button
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_button
	ld a, [hl]
	and D_LEFT
	jr nz, .d_left
	ld a, [hl]
	and D_RIGHT
	jr nz, .d_right
	ld a, [hl]
	and SELECT
	jr nz, .select
	ld a, [hl]
	and START
	jr nz, .start
	scf
	ret

.a_button
	xor a
	ret

.b_button
	ld a, $d ; QuitNoScript
	ld [wJumptableIndex], a
	scf
	ret

.d_left
	ld a, b
	ld [wJumptableIndex], a
	ld [wPackJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.d_right
	ld a, c
	ld [wJumptableIndex], a
	ld [wPackJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.select
	farcall SwitchItemsInBag
	ld hl, Text_MoveItemWhere
	call Pack_PrintTextNoScroll
	scf
	ret

.start
	or 1
	ret

.switching_item
	ld a, [hl]
	and A_BUTTON | SELECT
	jr nz, .place_insert
	ld a, [hl]
	and B_BUTTON
	jr nz, .end_switch
	scf
	ret

.place_insert
	farcall SwitchItemsInBag
	ld de, SFX_SWITCH_POKEMON
	call WaitPlaySFX
	ld de, SFX_SWITCH_POKEMON
	call WaitPlaySFX
.end_switch
	xor a
	ld [wSwitchItem], a
	scf
	ret

Pack_InitGFX:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	ld hl, PackInterfaceGFX
	ld de, vTiles2 tile $01
	lb bc, BANK(PackInterfaceGFX), 39
	call DecompressRequest2bpp
; This is where the items themselves will be listed.
	hlcoord 5, 1
	lb bc, 11, 15
	call ClearBox
; Place the left column
	hlcoord 0, 1
	ld de, .PackLeftColumnTilemapString
	ld bc, SCREEN_WIDTH - 5
.loop
	ld a, [de]
	and a
	jr nz, .continue
	add hl, bc
	jr .next
.continue
	cp $ff
	jr z, .ok
	ld [hli], a
.next
	inc de
	jr .loop
.ok
; Place the textbox for displaying the item description
	hlcoord 0, SCREEN_HEIGHT - 4 - 2
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	call EnableLCD
	jmp DrawPackGFX

.PackLeftColumnTilemapString:
	db $18, $19, $19, $19, $1a, 0 ; Background (blue if male, pink if female)
	db $28, $29, $2a, $2b, $2c, 0 ; Pack image
	db $2d, $2e, $2f, $30, $31, 0
	db $32, $33, $34, $35, $36, 0
	db $37, $38, $39, $3a, $3b, 0
	db $3c, $3d, $3e, $3f, $40, 0
	db $1b, $27, $27, $27, $1d, 0 ; Item icon
	db $16, $1e, $1f, $20, $17, 0
	db $16, $21, $22, $23, $17, 0
	db $16, $24, $25, $26, $17, 0
	db $15, $1c, $1c, $1c, $15, -1

Pack_GetItemName:
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	jmp CopyName1

Pack_GetKeyItemName:
	ld a, [wCurKeyItem]
	ld [wNamedObjectIndex], a
	call GetKeyItemName
	jmp CopyName1

ClearPocketList:
	hlcoord 5, 2
	lb bc, 10, SCREEN_WIDTH - 5
	jmp ClearBox

Pack_InitColors:
	call ApplyTilemapInVBlank
	ld a, CGB_PACKPALS
	call GetCGBLayout
	jmp SetPalettes

ItemsPocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_ItemsPocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumItems
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

MedicinePocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumMedicine
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_MedicinePocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumMedicine
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

BallsPocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_BallsPocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumBalls
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

BerriesPocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumBerries
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_BerriesPocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumBerries
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

KeyItemsPocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ed ; flags, special workaround for registered item symbols
	db 5, 8 ; rows, columns
	db 1 ; horizontal spacing
;	dbw 0, wNumKeyItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_KeyItemsPocketMenuDataHeader:
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 1 ; horizontal spacing
;	dbw 0, wNumKeyItems
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

Text_SortItemsHow:
	text "How do you want"
	line "to sort items?"
	done

Text_NoEmptySlot:
	text "There are no free"
	line "register slots."

	para "Unregister another"
	line "item first."
	prompt

Text_ThrowAwayHowMany:
	; Throw away how many?
	text_far _AskThrowAwayText
	text_end

Text_ConfirmThrowAway:
	; Throw away @ @ (S)?
	text_far _AskQuantityThrowAwayText
	text_end

Text_ThrewAway:
	; Threw away @ (S).
	text_far _ThrewAwayText
	text_end

Text_ThisIsntTheTime:
	; OAK:  ! This isn't the time to use that!
	text_far _OakThisIsntTheTimeText
	text_end

TextJump_YouDontHaveAPkmn:
	; You don't have a #MON!
	text_far Text_YouDontHaveAPkmn
	text_end

Text_RegisteredItem:
	; Registered the @ .
	text_far _RegisteredItemText
	text_end

Text_UnregisteredItem:
	text_far UnregisteredItemText
	text_end

Text_CantRegister:
	; You can't register that item.
	text_far _CantRegisterText
	text_end

Text_MoveItemWhere:
	; Where should this be moved to?
	text_far _AskItemMoveText
	text_end

Text_PackEmptyString:
	;
	text_far ClearText
	text_end

PackInterfaceGFX:
INCBIN "gfx/pack/pack_top_left.2bpp.lz"

Special_ChooseItem::
	call DisableSpriteUpdates
	call LoadStandardMenuHeader
	call DepositSellInitPackBuffers
	call .PickItem
	jmp ReturnToMapWithSpeechTextbox

.PickItem:
	xor a ; ld a, FALSE
	ldh [hScriptVar], a
.loop
	call DepositSellPack

	ld a, [wPackUsedItem]
	and a
	ret z

	call CheckUniqueItemPocket
	jr z, .next

	ld a, TRUE
	ldh [hScriptVar], a
	ret

.next
	ld hl, .ItemCantBeSelectedText
	call PrintText
	jr .loop

.ItemCantBeSelectedText:
	text_far ItemCantBeSelectedText
	text_end
