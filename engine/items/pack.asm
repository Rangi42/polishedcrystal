; Pack.Jumptable and BattlePack.Jumptable indexes
	const_def
	const PACKSTATE_INITGFX
	const PACKSTATE_INITPOCKET
	const PACKSTATE_POCKETMENU
	const PACKSTATE_SORTMENU
	const PACKSTATE_USEITEM
	const PACKSTATE_QUITNOSCRIPT
	const PACKSTATE_QUITRUNSCRIPT

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
	dw PackJumptable_InitGFX
	dw PackJumptable_InitPocket
	dw .PocketMenu
	dw PackJumptable_SortMenu
	dw .HandleItemSubmenu
	dw PackJumptable_QuitNoScript
	dw PackJumptable_QuitRunScript

.PocketMenu:
	ld hl, wItemsPocketCursor
	jmp Pack_RegularPocketMenu

.HandleTMHMSubmenu:
	ld hl, MenuDataHeader_Use
	ld de, .Jumptable1
	jr PackBuildMenu

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

.HandleKeyItemSubmenu:
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

.HandleItemSubmenu:
	; Restore previous pack state as default, unless changed by item use.
	call Pack_SetPocketMenuJump

	; TM/HM and Key Items have separate use handlers.
	call Pack_IsTMHMPocket
	jr z, .HandleTMHMSubmenu
	cp KEY_ITEM - 1
	jr z, .HandleKeyItemSubmenu

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

Pack_IsTMHMPocket:
; Returns z if we're in the TM/HM pocket. Pack.PocketMenu relies on a's value.
	ld a, [wCurPocket]
	cp TM_HM - 1
	ret

PackJumptable_SortMenu:
	; Restore previous jumptable state for when we finish sorting.
	call Pack_SetPocketMenuJump

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
	ld a, PACKSTATE_QUITRUNSCRIPT
	ld [wJumptableIndex], a
	ret

PackScrollingMenu:
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ret

MenuDataHeader_SortTMs:
	db MENU_BACKUP_TILES
	menu_coords 8, 5, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 3 ; items
	db "By Number@"
	db "By Name@"
	db "Quit@"

MenuDataHeader_SortItems:
	db MENU_BACKUP_TILES
	menu_coords 10, 5, 19, 11
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
	ld a, [wScrollingMenuCursorPosition]
	push af
	farcall SortItemsInBag
	pop af
	ld [wScrollingMenuCursorPosition], a
	ret

MenuDataHeader_UseGiveToss:
	db MENU_BACKUP_TILES
	menu_coords 13, 3, 19, 11
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
	db MENU_BACKUP_TILES
	menu_coords 13, 7, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c0 ; flags
	db 2 ; items
	db "Use@"
	db "Quit@"

MenuDataHeader_Quit:
	db MENU_BACKUP_TILES
	menu_coords 13, 9, 19, 11
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
	db MENU_BACKUP_TILES
	menu_coords 13, 5, 19, 11
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
	db MENU_BACKUP_TILES
	menu_coords 13, 5, 19, 11
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
	ld a, PACKSTATE_QUITRUNSCRIPT
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
	farcall PlacePartyMenuText
	call ApplyTilemapInVBlank
	call SetDefaultBGPAndOBP
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .finish
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	bit MON_IS_EGG_F, a
	jr z, .give
	ld hl, .Egg
	call PrintText
	jr .loop

.give
	ld a, [wJumptableIndex]
	push af
	call GetCurNickname
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call TryGiveItemToPartymon
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
	dw PackJumptable_InitGFX
	dw PackJumptable_InitPocket
	dw .PocketMenu
	dw PackJumptable_SortMenu
	dw ItemSubmenu
	dw PackJumptable_QuitNoScript
	dw PackJumptable_QuitRunScript

.PocketMenu:
	ld hl, wBattleItemsPocketCursor
	jr Pack_RegularPocketMenu

PackJumptable_InitGFX:
	xor a
	ldh [hBGMapMode], a
	call Pack_InitGFX
	call Pack_InitColors
	; fallthrough
PackJumptable_InitPocket:
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	; fallthrough
Pack_SetPocketMenuJump:
	ld a, PACKSTATE_POCKETMENU
	ld [wJumptableIndex], a
	ret

Pack_RegularPocketMenu:
	ld bc, ItemsPocketMenuDataHeader
	call Pack_PocketMenu
	jmp Pack_InterpretJoypad

Pack_TutorialPocketMenu:
	ld bc, Tutorial_ItemsPocketMenuDataHeader
	jr Pack_TempPocketMenu

Pack_DepositSellPocketMenu:
	; Menu input is handled elsewhere.
	ld bc, PC_Mart_ItemsPocketMenuDataHeader
	; fallthrough
Pack_TempPocketMenu:
	ld hl, wTempPocketCursor
	; fallthrough
Pack_PocketMenu:
	; Handle TM/HM pocket separately.
	call Pack_IsTMHMPocket
	jr c, .got_pack_offset
	jr nz, .not_tmhm

	farjp TMHMPocket

.not_tmhm
	; Shift berries and key up by 1 since TM/HM is in the middle.
	dec a
.got_pack_offset
	; Grab relative menu data.
	push hl
	ld h, b
	ld l, c
	ld bc, MedicinePocketMenuDataHeader - ItemsPocketMenuDataHeader
	push af
	rst AddNTimes
	call CopyMenuHeader
	pop af
	pop hl
	ld bc, 1
	rst AddNTimes
	ld a, [hl]
	ld [wMenuCursorBuffer], a
	push hl
	ld bc, wItemsPocketScrollPosition - wItemsPocketCursor
	add hl, bc
	ld a, [hl]
	push hl
	call PackScrollingMenu
	pop hl
	ld [hl], a
	pop hl
	ld a, [wMenuCursorY]
	ld [hl], a
	ret

ItemSubmenu:
	call Pack_SetPocketMenuJump
	call Pack_IsTMHMPocket
	jmp z, KeyItemSubmenu.unusable
	cp KEY_ITEM - 1
	jr z, KeyItemSubmenu
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
	ld a, PACKSTATE_QUITRUNSCRIPT
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
	ld a, PACKSTATE_QUITRUNSCRIPT
	ld [wJumptableIndex], a
	ret

.didnt_use_item
	xor a
	ld [wItemEffectSucceeded], a
	ret

InitPackBuffers:
; Parameters: a = starting pocket
	; Ensure that the starting pocket is valid.
	cp NUM_POCKETS
	jr c, .valid_pocket

	; Otherwise, reset to the first pocket tab.
	xor a
.valid_pocket
	ld [wCurPocket], a
	xor a ; PACKSTATE_INITGFX
	ld [wJumptableIndex], a

	ld [wPackUsedItem], a
	ld [wSwitchItem], a
	ret

DepositSellInitPackBuffers:
	xor a
	ldh [hBGMapMode], a
	ld [wCurPocket], a ; ITEM_POCKET
	ld [wPackUsedItem], a
	ld [wSwitchItem], a
	ld bc, NUM_POCKETS
	ld hl, wTempPocketCursor
	rst ByteFill
	call Pack_InitGFX
	jmp Pack_InitColors

ContinueDepositSellPack:
	call ClearPocketList
DepositSellPack:
	call WaitBGMap_DrawPackGFX
	call Pack_DepositSellPocketMenu
	call DepositSellTutorial_InterpretJoypad
	ret nc
	jr ContinueDepositSellPack

DepositSellTutorial_InterpretJoypad:
	ld hl, wMenuJoypad
	ld a, [hl]
	rrca
	jr c, .pressed_a
	rrca
	jr c, .pressed_b
	rrca ; skip select
	rrca ; skip start
	rrca
	jr c, .pressed_right
	rrca
	jr c, .pressed_left
	scf
	ret

.pressed_a
	ld a, TRUE
.set_packuseditem_ret_nc
	ld [wPackUsedItem], a
	and a
	ret

.pressed_b
	xor a ; FALSE
	jr .set_packuseditem_ret_nc

.pressed_right
	ld b, 1
	jr .get_pocket_for_switch

.pressed_left
	ld b, -1
.get_pocket_for_switch
	ld a, [wCurPocket]
.switch_pocket
	; Very slow (can do over 200 iterations), but smallest byte-wise.
	add b
	cp NUM_POCKETS
	jr nc, .switch_pocket
	ld [wCurPocket], a
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
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	call Pack_TutorialPocketMenu
	call DepositSellTutorial_InterpretJoypad
	jr c, .loop
	xor a ; FALSE
	ld [wPackUsedItem], a
	ret

.autoinput_right_right_a
	db NO_INPUT,  $40
	db PAD_RIGHT, $00
	db NO_INPUT,  $40
	db PAD_RIGHT, $00
	db NO_INPUT,  $40
.autoselect
	db PAD_A,     $00
	db NO_INPUT,  $ff ; end

PackJumptable_QuitNoScript:
	xor a ; FALSE
	jr Pack_DoQuit

PackJumptable_QuitRunScript:
	ld a, TRUE
	; fallthrough
Pack_DoQuit:
	ld [wPackUsedItem], a
	ld hl, wJumptableIndex
	set 7, [hl]
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
	sbc -1 ; jr c, .got_pocket / inc a
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
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ld bc, FemalePackGFX
	jr z, .got_pointers
	ld a, [wPlayerGender]
	ld bc, MalePackGFX
	and a ; PLAYER_MALE
	jr z, .got_pointers
	ld bc, FemalePackGFX
	dec a ; PLAYER_FEMALE
	jr z, .got_pointers
	; PLAYER_ENBY
	ld bc, EnbyPackGFX
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

MalePackGFX:
	farbank "Pack Graphics"
	fardw PackM0GFX
	fardw PackM1GFX
	fardw PackM2GFX
	fardw PackM3GFX
	fardw PackM4GFX
	fardw PackM5GFX

FemalePackGFX:
	farbank "Pack Graphics"
	fardw PackF0GFX
	fardw PackF1GFX
	fardw PackF2GFX
	fardw PackF3GFX
	fardw PackF4GFX
	fardw PackF5GFX

EnbyPackGFX:
	farbank "Pack Graphics"
	fardw PackX0GFX
	fardw PackX1GFX
	fardw PackX2GFX
	fardw PackX3GFX
	fardw PackX4GFX
	fardw PackX5GFX

Pack_InterpretJoypad:
	ld hl, wMenuJoypad
	ld a, [wSwitchItem]
	and a
	jr nz, .switching_item
	ld a, [wMenuJoypad]
	rrca
	jr c, .pressed_a
	rrca
	jr c, .pressed_b
	rrca
	jr c, .pressed_select
	rrca
	jr c, .pressed_start
	rrca
	jr c, .pressed_right
	rrca
	jr c, .pressed_left

	; Up/Down is handled by the menu code.
	ret

.pressed_a
	ld a, PACKSTATE_USEITEM
.set_jumptable
	ld [wJumptableIndex], a
	ret

.pressed_b
	ld a, PACKSTATE_QUITNOSCRIPT
	jr .set_jumptable

.pressed_select
	call Pack_IsTMHMPocket
	ret z
	farcall SwitchItemsInBag
	ld hl, Text_MoveItemWhere
	jmp Pack_PrintTextNoScroll

.pressed_start
	ld a, PACKSTATE_SORTMENU
	jr .set_jumptable

.pressed_right
	ld b, 1
	jr .get_pocket_for_switch

.pressed_left
	ld b, -1
.get_pocket_for_switch
	ld a, [wCurPocket]
.switch_pocket
	; Very slow (can do over 200 iterations), but smallest byte-wise.
	add b
	cp NUM_POCKETS
	jr nc, .switch_pocket
	ld [wCurPocket], a
	ld a, PACKSTATE_INITPOCKET
	ld [wJumptableIndex], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	ret

.switching_item
	ld a, [hl]
	and PAD_A | PAD_SELECT
	jr nz, .place_insert
	ld a, [hl]
	and PAD_B
	jr nz, .end_switch
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
	jmp SetDefaultBGPAndOBP

; Note that the game assumes strict order of menu data headers!
ItemsPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

MedicinePocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumMedicine
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

BallsPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

BerriesPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ee ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBerries
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

KeyItemsPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $ed ; flags, special workaround for registered item symbols
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_KEY ; item format
	dbw 0, wKeyItems
	dba PlaceMenuKeyItemName
	dba DoNothing
	dba UpdateKeyItemIconAndDescription

PC_Mart_ItemsPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_MedicinePocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumMedicine
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_BallsPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_BerriesPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBerries
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

PC_Mart_KeyItemsPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_KEY ; item format
	dbw 0, wKeyItems
	dba PlaceMenuKeyItemName
	dba DoNothing
	dba UpdateKeyItemIconAndDescription

Tutorial_ItemsPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wDudeNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

Tutorial_MedicinePocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wDudeNumMedicine
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription

Tutorial_BallsPocketMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 1, 19, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $2e ; flags
	db 5, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wDudeNumBalls
	dba PlaceMenuItemName
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
