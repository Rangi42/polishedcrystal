Pack: ; 10000
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
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
	ld a, [wCurrPocket]
	ld [wLastPocket], a
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ret
; 10026

.RunJumptable: ; 10026
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

; 10030

.Jumptable: ; 10030 (4:4030)

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

.InitGFX: ; 10046 (4:4046)
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	ld a, [wcf64]
	ld [wJumptableIndex], a
	jp Pack_InitColors

.InitItemsPocket: ; 10056 (4:4056)
	ld a, ITEM - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.ItemsPocketMenu: ; 10067 (4:4067)
	ld hl, ItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	lb bc, $b, $3 ; Key Items, Medicine
	call Pack_InterpretJoypad
	ret c
	jp .ItemBallsKey_LoadSubmenu

.InitMedicinePocket:
	ld a, MEDICINE - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.MedicinePocketMenu:
	ld hl, MedicinePocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wMedicinePocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wMedicinePocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wMedicinePocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wMedicinePocketCursor], a
	lb bc, $1, $5 ; Items, Balls
	call Pack_InterpretJoypad
	ret c
	jp .ItemBallsKey_LoadSubmenu

.InitBallsPocket: ; 10186 (4:4186)
	ld a, BALL - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.BallsPocketMenu: ; 10198 (4:4198)
	ld hl, BallsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	lb bc, $3, $7 ; Medicine, TM/HM
	call Pack_InterpretJoypad
	ret c
	jp .ItemBallsKey_LoadSubmenu

.InitTMHMPocket: ; 100d3 (4:40d3)
	ld a, TM_HM - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.TMHMPocketMenu: ; 100e8 (4:40e8)
	farcall TMHMPocket
	lb bc, $5, $9 ; Balls, Berries
	call Pack_InterpretJoypad
	ret c
	ld hl, .MenuDataHeader1
	ld de, .Jumptable1
	push de
	call LoadMenuDataHeader
	call VerticalMenu
	call ExitMenu
	pop hl
	ret c
	ld a, [wMenuCursorY]
	dec a
	call Pack_GetJumptablePointer
	jp hl

; 10124 (4:4124)
.MenuDataHeader1: ; 0x10124
	db $40 ; flags
	db 07, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2_1
	db 1 ; default option
; 0x1012c

.MenuData2_1: ; 0x1012c
	db $c0 ; flags
	db 2 ; items
	db "Use@"
	db "Quit@"
; 0x10137

.Jumptable1: ; 10137

	dw .UseItem
	dw QuitItemSubmenu

; 1013b

.UseItem: ; 10159
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
	ld [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jp Pack_InitColors

.InitBerriesPocket:
	ld a, BERRIES - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.BerriesPocketMenu:
	ld hl, BerriesPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wBerriesPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBerriesPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBerriesPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBerriesPocketCursor], a
	lb bc, $7, $b ; TM/HM, Key Items
	call Pack_InterpretJoypad
	ret c
	jr .ItemBallsKey_LoadSubmenu

.InitKeyItemsPocket: ; 10094 (4:4094)
	ld a, KEY_ITEM - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.KeyItemsPocketMenu: ; 100a6 (4:40a6)
	ld hl, KeyItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	lb bc, $9, $1 ; Berries, Items
	call Pack_InterpretJoypad
	ret c
	; fallthrough

.ItemBallsKey_LoadSubmenu: ; 101c5 (4:41c5)
	jr nz, PackSortMenu
	farcall _CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .tossable
	farcall CheckSelectableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .selectable
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .usable
	jr .unusable

.selectable
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .selectable_usable
	jr .selectable_unusable

.tossable
	farcall CheckSelectableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .tossable_selectable
	jr .tossable_unselectable

.usable
	ld hl, MenuDataHeader_UsableKeyItem
	ld de, Jumptable_UseGiveTossRegisterQuit
	jr PackBuildMenu

.selectable_usable
	ld hl, MenuDataHeader_UsableItem
	ld de, Jumptable_UseGiveTossQuit
	jr PackBuildMenu

.tossable_selectable
	ld hl, MenuDataHeader_UnusableItem
	ld de, Jumptable_UseQuit
	jr PackBuildMenu

.tossable_unselectable
	ld hl, MenuDataHeader_UnusableKeyItem
	ld de, Jumptable_UseRegisterQuit
	jr PackBuildMenu

.unusable
	ld hl, MenuDataHeader_HoldableKeyItem
	ld de, Jumptable_GiveTossRegisterQuit
	jr PackBuildMenu

.selectable_unusable
	ld hl, MenuDataHeader_HoldableItem
	ld de, Jumptable_GiveTossQuit

PackBuildMenu:
	push de
	call LoadMenuDataHeader
	call VerticalMenu
	call ExitMenu
	pop hl
	ret c
PackMenuJump:
	ld a, [wMenuCursorY]
	dec a
	call Pack_GetJumptablePointer
	jp hl

PackSortMenu:
	ld hl, Text_SortItemsHow
	call Pack_PrintTextNoScroll
	ld hl, wMenuData2_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [wMenuData2_ScrollingMenuSpacing]
	push af
	ld hl, MenuDataHeader_SortItems
	ld de, Jumptable_SortItems
	push de
	call LoadMenuDataHeader
	call VerticalMenu
	call ExitMenu
	jr nc, .no_quit
	ld a, 3
	ld [wMenuCursorY], a
.no_quit
	pop de
	pop af
	ld [wMenuData2_ScrollingMenuSpacing], a
	pop bc
	ld hl, wMenuData2_ItemsPointerAddr
	ld a, c
	ld [hli], a
	ld [hl], b
	ld h, d
	ld l, e
	jr PackMenuJump

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
	dw QuitItemSubmenu

SortItemsType:
SortItemsName:
	farjp SortItemsInBag

MenuDataHeader_UsableKeyItem: ; 0x10249
	db $40 ; flags
	db 01, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10251

.MenuData2: ; 0x10251
	db $c0 ; flags
	db 5 ; items
	db "Use@"
	db "Give@"
	db "Toss@"
	db "Sel@"
	db "Quit@"
; 0x1026a

Jumptable_UseGiveTossRegisterQuit: ; 1026a

	dw UseItem
	dw GiveItem
	dw TossMenu
	dw RegisterItem
	dw QuitItemSubmenu
; 10274

MenuDataHeader_UsableItem: ; 0x10274
	db $40 ; flags
	db 03, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x1027c

.MenuData2: ; 0x1027c
	db $c0 ; flags
	db 4 ; items
	db "Use@"
	db "Give@"
	db "Toss@"
	db "Quit@"
; 0x10291

Jumptable_UseGiveTossQuit: ; 10291

	dw UseItem
	dw GiveItem
	dw TossMenu
	dw QuitItemSubmenu
; 10299

MenuDataHeader_UnusableItem: ; 0x10299
	db %01000000 ; flags
	db 07, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x102a1

.MenuData2: ; 0x102a1
	db $c0 ; flags
	db 2 ; items
	db "Use@"
	db "Quit@"
; 0x102ac

Jumptable_UseQuit: ; 102ac

	dw UseItem
	dw QuitItemSubmenu
; 102b0

MenuDataHeader_UnusableKeyItem: ; 0x102b0
	db %01000000 ; flags
	db 05, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x102b8

.MenuData2: ; 0x102b8
	db $c0 ; flags
	db 3 ; items
	db "Use@"
	db "Sel@"
	db "Quit@"
; 0x102c7

Jumptable_UseRegisterQuit: ; 102c7

	dw UseItem
	dw RegisterItem
	dw QuitItemSubmenu
; 102cd

MenuDataHeader_HoldableKeyItem: ; 0x102cd
	db $40 ; flags
	db 03, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x102d5

.MenuData2: ; 0x102d5
	db $c0 ; flags
	db 4 ; items
	db "Give@"
	db "Toss@"
	db "Sel@"
	db "Quit@"
; 0x102ea

Jumptable_GiveTossRegisterQuit: ; 102ea

	dw GiveItem
	dw TossMenu
	dw RegisterItem
	dw QuitItemSubmenu
; 102f2

MenuDataHeader_HoldableItem: ; 0x102f2
	db $40 ; flags
	db 05, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x102fa

.MenuData2: ; 0x102fa
	db $c0 ; flags
	db 3 ; items
	db "Give@"
	db "Toss@"
	db "Quit@"
; 0x1030b

Jumptable_GiveTossQuit: ; 1030b

	dw GiveItem
	dw TossMenu
	dw QuitItemSubmenu

; 10311

UseItem: ; 10311
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld hl, .dw
	rst JumpTable
	ret
; 1031f

.dw ; 1031f (4:431f)

	dw .Oak
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Current
	dw .Party
	dw .Field
; 1035c

.Oak: ; 1032d (4:432d)
	ld hl, Text_ThisIsntTheTime
	jp Pack_PrintTextNoScroll

.Current: ; 10334 (4:4334)
	jp DoItemEffect

.Party: ; 10338 (4:4338)
	ld a, [wPartyCount]
	and a
	jr z, .NoPokemon
	call DoItemEffect
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jp Pack_InitColors

.NoPokemon:
	ld hl, TextJump_YouDontHaveAPkmn
	jp Pack_PrintTextNoScroll

.Field: ; 10355 (4:4355)
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	ld a, $e ; QuitRunScript
	ld [wJumptableIndex], a
	ret
; 10364 (4:4364)

TossMenu: ; 10364
	ld hl, Text_ThrowAwayHowMany
	call Pack_PrintTextNoScroll
	farcall SelectQuantityToToss
	push af
	call ExitMenu
	pop af
	ret c
	call Pack_GetItemName
	ld hl, Text_ConfirmThrowAway
	call MenuTextBox
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
	jp Pack_PrintTextNoScroll
; 1039d

RegisterItem: ; 103c2
	farcall CheckSelectableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .cant_register

	; Check if the item is registered
	ld hl, wRegisteredItems
	ld a, [wCurItem]
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
	jr .print

.found_empty_slot
	ld a, [wCurItem]
	ld [hl], a
	call Pack_GetItemName
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, Text_RegisteredItem
	jr .print

.found_registered_slot
	ld [hl], 0
	ld a, [wCurItem]
	call Pack_GetItemName
	ld hl, Text_UnregisteredItem
	jr .print

.cant_register
	ld hl, Text_CantRegister
.print
	jp Pack_PrintTextNoScroll

GiveItem: ; 103fd
	ld a, [wPartyCount]
	and a
	jp z, .NoPokemon
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
	ld a, [wCurPartySpecies]
	cp EGG
	jr nz, .give
	ld hl, .Egg
	call PrintText
	jr .loop

.give
	ld a, [wJumptableIndex]
	push af
	ld a, [wcf64]
	push af
	call GetCurNick
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes
	call TryGiveItemToPartymon
	pop af
	ld [wcf64], a
	pop af
	ld [wJumptableIndex], a
.finish
	pop af
	ld [wOptions1], a
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jp Pack_InitColors

.NoPokemon: ; 10486 (4:4486)
	ld hl, TextJump_YouDontHaveAPkmn
	jp Pack_PrintTextNoScroll
; 1048d (4:448d)
.Egg: ; 0x1048d
	; An EGG can't hold an item.
	text_jump Text_AnEGGCantHoldAnItem
	db "@"
; 0x10492

QuitItemSubmenu: ; 10492
	ret
; 10493

BattlePack: ; 10493
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
	call InitPackBuffers
.loop
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .end
	call .RunJumptable
	call DelayFrame
	jr .loop

.end
	ld a, [wCurrPocket]
	ld [wLastPocket], a
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ret
; 104b9

.RunJumptable: ; 104b9
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

; 104c3

.Jumptable: ; 104c3 (4:44c3)

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

.InitGFX: ; 104d9 (4:44d9)
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	ld a, [wcf64]
	ld [wJumptableIndex], a
	jp Pack_InitColors

.InitItemsPocket: ; 104e9 (4:44e9)
	ld a, ITEM - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.ItemsPocketMenu: ; 104fa (4:44fa)
	ld hl, ItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wItemsPocketCursor], a
	lb bc, $b, $3 ; Key Items, Medicine
	call Pack_InterpretJoypad
	ret c
	jp ItemSubmenu

.InitMedicinePocket:
	ld a, MEDICINE - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.MedicinePocketMenu:
	ld hl, MedicinePocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wMedicinePocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wMedicinePocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wMedicinePocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wMedicinePocketCursor], a
	lb bc, $1, $5 ; Items, Balls
	call Pack_InterpretJoypad
	ret c
	jp ItemSubmenu

.InitBallsPocket: ; 10594 (4:4594)
	ld a, BALL - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.BallsPocketMenu: ; 105a6 (4:45a6)
	ld hl, BallsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	lb bc, $3, $7 ; Medicine, TM/HM
	call Pack_InterpretJoypad
	ret c
	jp ItemSubmenu

.InitTMHMPocket: ; 10566 (4:4566)
	ld a, TM_HM - 1
	ld [wCurrPocket], a
	call ClearPocketList
	xor a
	ld [hBGMapMode], a
	call WaitBGMap_DrawPackGFX
	ld hl, Text_PackEmptyString
	call Pack_PrintTextNoScroll
	jp Pack_JumptableNext

.TMHMPocketMenu: ; 10581 (4:4581)
	farcall TMHMPocket
	lb bc, $5, $9 ; Balls, Berries
	call Pack_InterpretJoypad
	ret c
	xor a
	jp TMHMSubmenu

.InitBerriesPocket:
	ld a, BERRIES - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.BerriesPocketMenu:
	ld hl, BerriesPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wBerriesPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wBerriesPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBerriesPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBerriesPocketCursor], a
	lb bc, $7, $b ; TM/HM, Key Items
	call Pack_InterpretJoypad
	ret c
	jr ItemSubmenu

.InitKeyItemsPocket: ; 10527 (4:4527)
	ld a, KEY_ITEM - 1
	ld [wCurrPocket], a
	call ClearPocketList
	call WaitBGMap_DrawPackGFX
	jp Pack_JumptableNext

.KeyItemsPocketMenu: ; 10539 (4:4539)
	ld hl, KeyItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	lb bc, $9, $1 ; Berries, Items
	call Pack_InterpretJoypad
	ret c
	; fallthrough

ItemSubmenu: ; 105d3 (4:45d3)
	jp nz, PackSortMenu
	farcall CheckItemContext
	ld a, [wItemAttributeParamBuffer]
TMHMSubmenu: ; 105dc (4:45dc)
	and a
	ld hl, .UsableMenuDataHeader
	ld de, .UsableJumptable
	jr nz, .proceed
	ld hl, .UnusableMenuDataHeader
	ld de, .UnusableJumptable
.proceed
	jp PackBuildMenu

; 10601 (4:4601)
.UsableMenuDataHeader: ; 0x10601
	db $40 ; flags
	db 07, 13 ; start coords
	db 11, 19 ; end coords
	dw .UsableMenuData2
	db 1 ; default option
; 0x10609

.UsableMenuData2: ; 0x10609
	db $c0 ; flags
	db 2 ; items
	db "Use@"
	db "Quit@"
; 0x10614

.UsableJumptable: ; 10614

	dw .Use
	dw .Quit
; 10618

.UnusableMenuDataHeader: ; 0x10618
	db $40 ; flags
	db 09, 13 ; start coords
	db 11, 19 ; end coords
	dw .UnusableMenuData2
	db 1 ; default option
; 0x10620

.UnusableMenuData2: ; 0x10620
	db $c0 ; flags
	db 1 ; items
	db "Quit@"
; 0x10627

.UnusableJumptable: ; 10627

	dw .Quit
; 10629

.Use: ; 10629
	farcall CheckItemContext
	ld a, [wItemAttributeParamBuffer]
	ld hl, .ItemFunctionJumptable
	rst JumpTable
	ret

.ItemFunctionJumptable: ; 10637 (4:4637)

	dw .Oak
	dw .Oak
	dw .Oak
	dw .Oak
	dw .Unused
	dw .BattleField
	dw .BattleOnly

.Oak: ; 10645 (4:4645)
	ld hl, Text_ThisIsntTheTime
	jp Pack_PrintTextNoScroll

.Unused: ; 1064c (4:464c)
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .ReturnToBattle
	ret

.BattleField: ; 10656 (4:4656)
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr nz, .quit_run_script
	xor a
	ld [hBGMapMode], a
	call Pack_InitGFX
	call WaitBGMap_DrawPackGFX
	jp Pack_InitColors

.ReturnToBattle: ; 1066c (4:466c)
	call ClearBGPalettes
	jr .quit_run_script

.BattleOnly: ; 10671 (4:4671)
	call DoItemEffect
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .Oak
	cp $2
	jr z, .didnt_use_item
.quit_run_script ; 1067e (4:467e)
	ld a, $e ; QuitRunScript
	ld [wJumptableIndex], a
	ret

.didnt_use_item ; 10684 (4:4684)
	xor a
	ld [wItemEffectSucceeded], a
.Quit: ; 10689
	ret
; 1068a

InitPackBuffers: ; 1068a
	xor a
	ld [wJumptableIndex], a
	ld a, [wLastPocket]
	and $7
	ld [wCurrPocket], a
	inc a
	add a
	dec a
	ld [wcf64], a
	xor a
	ld [wcf66], a
	xor a
	ld [wSwitchItem], a
	ret
; 106a5

DepositSellInitPackBuffers: ; 106a5
	xor a
	ld [hBGMapMode], a
	ld [wJumptableIndex], a
	ld [wcf64], a
	ld [wCurrPocket], a
	ld [wcf66], a
	ld [wSwitchItem], a
	call Pack_InitGFX
	jp Pack_InitColors
; 106be

DepositSellPack: ; 106be
.loop
	call .RunJumptable
	call DepositSellTutorial_InterpretJoypad
	jr c, .loop
	ret
; 106c7

.RunJumptable: ; 106c7
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pack_GetJumptablePointer
	jp hl

; 106d1

.Jumptable: ; 106d1 (4:46d1)

	dw .ItemsPocket
	dw .MedicinePocket
	dw .BallsPocket
	dw .TMHMPocket
	dw .BerriesPocket
	dw .KeyItemsPocket

.ItemsPocket: ; 106d9 (4:46d9)
	ld a, ITEM - 1
	call InitPocket
	ld hl, PC_Mart_ItemsPocketMenuDataHeader
	call CopyMenuDataHeader
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
	call CopyMenuDataHeader
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

.BallsPocket: ; 1073b (4:473b)
	ld a, BALL - 1
	call InitPocket
	ld hl, PC_Mart_BallsPocketMenuDataHeader
	call CopyMenuDataHeader
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

.TMHMPocket: ; 10726 (4:4726)
	ld a, TM_HM - 1
	call InitPocket
	call WaitBGMap_DrawPackGFX
	farcall TMHMPocket
	ld a, [wCurItem]
	ld [wCurItem], a
	ret

.BerriesPocket:
	ld a, BERRIES - 1
	call InitPocket
	ld hl, PC_Mart_BerriesPocketMenuDataHeader
	call CopyMenuDataHeader
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

.KeyItemsPocket: ; 106ff (4:46ff)
	ld a, KEY_ITEM - 1
	call InitPocket
	ld hl, PC_Mart_KeyItemsPocketMenuDataHeader
	call CopyMenuDataHeader
	ld a, [wKeyItemsPocketCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wKeyItemsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wKeyItemsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	ret

InitPocket: ; 10762 (4:4762)
	ld [wCurrPocket], a
	call ClearPocketList
	jp WaitBGMap_DrawPackGFX

DepositSellTutorial_InterpretJoypad: ; 1076f
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
	ld [wcf66], a
	and a
	ret

.b_button
	xor a
	ld [wcf66], a
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
; 107bb

TutorialPack: ; 107bb
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
	xor a
	ld [wcf66], a
	ret

.autoinput_right_right_a
	db NO_INPUT, $40
	db D_RIGHT,  $00
	db NO_INPUT, $40
	db D_RIGHT,  $00
	db NO_INPUT, $40
	db A_BUTTON, $00
	db NO_INPUT, $ff ; end
; 107d7

.RunJumptable: ; 107d7
	ld a, [wJumptableIndex]
	ld hl, .dw
	call Pack_GetJumptablePointer
	jp hl

; 107e1

.dw ; 107e1 (4:47e1)

	dw .Items
	dw .Medicine
	dw .Balls

.Items: ; 107e9 (4:47e9)
	ld a, ITEM - 1
	ld hl, .ItemsMenuDataHeader
	jr .DisplayPocket

; 107ef (4:47ef)
.ItemsMenuDataHeader: ; 0x107ef
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .ItemsMenuData2
	db 1 ; default option
; 0x107f7

.ItemsMenuData2: ; 0x107f7
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wDudeNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 10807

.Medicine: ; 10807 (4:4807)
	ld a, MEDICINE - 1
	ld hl, .MedicineMenuDataHeader
	jr .DisplayPocket

; 1080e (4:480e)
.MedicineMenuDataHeader: ; 0x1080e
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MedicineMenuData2
	db 1 ; default option
; 0x10816

.MedicineMenuData2: ; 0x10816
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wDudeNumMedicine
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 10826

.Balls: ; 1083b (4:483b)
	ld a, BALL - 1
	ld hl, .BallsMenuDataHeader
	jr .DisplayPocket

; 10842 (4:4842)
.BallsMenuDataHeader: ; 0x10842
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .BallsMenuData2
	db 1 ; default option
; 0x1084a

.BallsMenuData2: ; 0x1084a
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wDudeNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 1085a

.DisplayPocket: ; 1085a (4:485a)
	push hl
	call InitPocket
	pop hl
	call CopyMenuDataHeader
	jp ScrollingMenu

Pack_JumptableNext: ; 10866 (4:4866)
	ld hl, wJumptableIndex
	inc [hl]
	ret

Pack_GetJumptablePointer: ; 1086b
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret
; 10874

Pack_QuitNoScript: ; 10874 (4:4874)
	ld hl, wJumptableIndex
	set 7, [hl]
	xor a
	ld [wcf66], a
	ret

Pack_QuitRunScript: ; 1087e (4:487e)
	ld hl, wJumptableIndex
	set 7, [hl]
	ld a, TRUE
	ld [wcf66], a
	ret

Pack_PrintTextNoScroll: ; 10889 (4:4889)
	ld a, [wOptions1]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions1], a
	call PrintText
	pop af
	ld [wOptions1], a
	ret

WaitBGMap_DrawPackGFX: ; 1089a (4:489a)
	call ApplyTilemapInVBlank
DrawPackGFX: ; 1089d
	; place top row
	ld a, [wCurrPocket]
	and $7
	push af
	ld c, a
	add a, a
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
	ld [hl], $1
	inc hl
	jr .insert_ok
.normal_insert
	ld [hli], a
	inc a
.insert_ok
	dec c
	jr nz, .loop

	; place pack gfx
	pop af
	ld d, a
	ld bc, 25 tiles
	ld hl, PackGFX
	ld e, BANK(PackGFX)
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .female
	ld a, [wPlayerGender]
	rrca
	jr c, .male
.female
	ld hl, PackFGFX
	ld e, BANK(PackFGFX)
.male
	ld a, d
	rst AddNTimes
	ld b, e
	ld c, 25
	ld d, h
	ld e, l
	ld hl, VTiles2 tile $27
	jp Request2bpp

Pack_InterpretJoypad: ; 108d4 (4:48d4)
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
	ld [wcf64], a
	push de
	ld de, SFX_SWITCH_POCKETS
	call PlaySFX
	pop de
	scf
	ret

.d_right
	ld a, c
	ld [wJumptableIndex], a
	ld [wcf64], a
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

Pack_InitGFX: ; 10955
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	ld hl, PackMenuGFX ; PackLeftColumnGFX is after it
	ld de, VTiles2 tile $01
	ld bc, (20 + 18) tiles
	ld a, BANK(PackMenuGFX)
	call FarCopyBytes
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
	call TextBox
	call EnableLCD
	jp DrawPackGFX
; 109a5

.PackLeftColumnTilemapString:
	db $15, $15, $15, $15, $15, 0 ; Background (blue if male, pink if female)
	db $27, $28, $29, $2a, $2b, 0 ; Pack image
	db $2c, $2d, $2e, $2f, $30, 0
	db $31, $32, $33, $34, $35, 0
	db $36, $37, $38, $39, $3a, 0
	db $3b, $3c, $3d, $3e, $3f, 0
	db $16, $17, $17, $17, $18, 0 ; Item icon
	db $19, $1e, $1f, $20, $1a, 0
	db $19, $21, $22, $23, $1a, 0
	db $19, $24, $25, $26, $1a, 0
	db $1b, $1c, $1c, $1c, $1d, -1

Pack_GetItemName: ; 10a1d
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	jp CopyName1
; 10a2a

ClearPocketList: ; 10a36 (4:4a36)
	hlcoord 5, 2
	lb bc, 10, SCREEN_WIDTH - 5
	jp ClearBox

Pack_InitColors: ; 10a40
	call ApplyTilemapInVBlank
	ld b, CGB_PACKPALS
	call GetCGBLayout
	jp SetPalettes
; 10a4f

ItemsPocketMenuDataHeader: ; 0x10a4f
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10a57

.MenuData2: ; 0x10a57
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 10a67

PC_Mart_ItemsPocketMenuDataHeader: ; 0x10a67
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10a6f

.MenuData2: ; 0x10a6f
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumItems
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 10a7f

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

BallsPocketMenuDataHeader: ; 0x10aaf
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10ab7

.MenuData2: ; 0x10ab7
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumBalls
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 10ac7

PC_Mart_BallsPocketMenuDataHeader: ; 0x10ac7
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10acf

.MenuData2: ; 0x10acf
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 2 ; horizontal spacing
	dbw 0, wNumBalls
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 10adf

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

KeyItemsPocketMenuDataHeader: ; 0x10a7f
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10a87

.MenuData2: ; 0x10a87
	db $ee ; flags
	db 5, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wNumKeyItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 10a97

PC_Mart_KeyItemsPocketMenuDataHeader: ; 0x10a97
	db $40 ; flags
	db 01, 07 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x10a9f

.MenuData2: ; 0x10a9f
	db $2e ; flags
	db 5, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wNumKeyItems
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemIconAndDescription
; 10aaf

Text_SortItemsHow:
	text "How do you want"
	line "to sort items?@@"

Text_NoEmptySlot:
	text "There are no free"
	line "register slots."

	para "Unregister another"
	line "item first.@@"

Text_ThrowAwayHowMany: ; 0x10ae4
	; Throw away how many?
	text_jump UnknownText_0x1c0ba5
	db "@"
; 0x10ae9

Text_ConfirmThrowAway: ; 0x10ae9
	; Throw away @ @ (S)?
	text_jump UnknownText_0x1c0bbb
	db "@"
; 0x10aee

Text_ThrewAway: ; 0x10aee
	; Threw away @ (S).
	text_jump UnknownText_0x1c0bd8
	db "@"
; 0x10af3

Text_ThisIsntTheTime: ; 0x10af3
	; OAK:  ! This isn't the time to use that!
	text_jump UnknownText_0x1c0bee
	db "@"
; 0x10af8

TextJump_YouDontHaveAPkmn: ; 0x10af8
	; You don't have a #MON!
	text_jump Text_YouDontHaveAPkmn
	db "@"
; 0x10afd

Text_RegisteredItem: ; 0x10afd
	; Registered the @ .
	text_jump UnknownText_0x1c0c2e
	db "@"
; 0x10b02

Text_UnregisteredItem:
	text "Unregistered the"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	prompt
	db "@"

Text_CantRegister: ; 0x10b02
	; You can't register that item.
	text_jump UnknownText_0x1c0c45
	db "@"
; 0x10b07

Text_MoveItemWhere: ; 0x10b07
	; Where should this be moved to?
	text_jump UnknownText_0x1c0c63
	db "@"
; 0x10b0c

Text_PackEmptyString: ; 0x10b0c
	;
	text_jump UnknownText_0x1c0c83
	db "@"
; 0x10b11

PackMenuGFX:
INCBIN "gfx/pack/pack_top_row.2bpp"
PackLeftColumnGFX:
INCBIN "gfx/pack/pack_left_column.2bpp"

Special_ChooseItem::
	call DisableSpriteUpdates
	call LoadStandardMenuDataHeader
	call DepositSellInitPackBuffers
	call .PickItem
	farjp ReturnToMapWithSpeechTextbox

.PickItem:
	xor a ; ld a, FALSE
	ld [wScriptVar], a
.loop
	call DepositSellPack

	ld a, [wcf66]
	and a
	ret z

	ld a, [wCurrPocket]
	cp KEY_ITEM - 1
	jr z, .next
	cp TM_HM - 1
	jr z, .next

	call CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .next

	ld a, TRUE
	ld [wScriptVar], a
	ret

.next
	ld hl, .ItemCantBeSelectedText
	call PrintText
	jr .loop

.ItemCantBeSelectedText:
	text_jump ItemCantBeSelectedText
	db "@"
