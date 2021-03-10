PokemonCenterPC:
	call PC_CheckPartyForPokemon
	ret c
	call PC_PlayBootSound
	ld hl, PokeCenterPCText_BootedUpPC
	call PC_DisplayText
	ld hl, PokeCenterPCText_AccessWhosePC
	call PC_DisplayTextWaitMenu
	ld hl, .TopMenu
	call LoadMenuHeader
.loop
	xor a
	ldh [hBGMapMode], a
	call .ChooseWhichPCListToUse
	ld [wWhichIndexSet], a
	call DoNthMenu
	jr c, .shutdown
	ld a, [wMenuSelection]
	ld hl, .JumpTable
	call MenuJumptable
	jr nc, .loop

.shutdown
	call PC_PlayShutdownSound
	call ExitMenu
	jp CloseWindow

.TopMenu:
	db $48 ; flags
	db 00, 00 ; start coords
	db 12, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $a0 ; flags
	db 0 ; items
	dw .WhichPC
	dw PlaceNthMenuStrings
	dw .JumpTable

.JumpTable:
	dw PlayersPC, .String_PlayersPC
	dw BillsPC, .String_BillsPC
	dw OaksPC, .String_OaksPC
	dw HallOfFamePC, .String_HallOfFame
	dw TurnOffPC, .String_TurnOff

.String_PlayersPC:  db "<PLAYER>'s PC@"
.String_BillsPC:    db "Bill's PC@"
.String_OaksPC:     db "Prof.Oak's PC@"
.String_HallOfFame: db "Hall of Fame@"
.String_TurnOff:    db "Turn Off@"

.WhichPC:
	; before pokedex
	db  3 ; items
	db  1, 0, 4 ; bill's, player's, turn off
	db -1

	; before Hall Of Fame
	db  4 ; items
	db  1, 0, 2, 4 ; bill's, player's, oak's, turn off
	db -1

	; postgame
	db  5 ; items
	db  1, 0, 2, 3, 4 ; bill's, player's, oak's, hall of fame, turn off
	db -1

.ChooseWhichPCListToUse:
	call CheckReceivedDex
	jr nz, .got_dex
	xor a
	ret

.got_dex
	ld a, [wHallOfFameCount]
	and a
	ld a, $1
	ret z
	ld a, $2
	ret

PC_CheckPartyForPokemon:
	ld a, [wPartyCount]
	and a
	ret nz
	ld de, SFX_CHOOSE_PC_OPTION
	call PlaySFX
	ld hl, .MustHavePokemonToUse
	call PC_DisplayText
	scf
	ret

.MustHavePokemonToUse:
	; Bzzzzt! You must have a #MON to use this!
	text_jump _PokecenterPCCantUseText
	text_end

BillsPC:
	call PC_PlayChoosePCSound
	ld hl, PokeCenterPCText_AccessedBillsPC
	call PC_DisplayText
	farcall _BillsPC
	and a
	ret

PlayersPC:
	call PC_PlayChoosePCSound
	ld hl, PokeCenterPCText_AccessedOwnPC
	call PC_DisplayText
	ld b, $0
	call _PlayersPC
	and a
	ret

OaksPC:
	call PC_PlayChoosePCSound
	ld hl, PokeCenterPCText_AccessedOaksPC
	call PC_DisplayText
	farcall ProfOaksPC
	and a
	ret

HallOfFamePC:
	call PC_PlayChoosePCSound
	call FadeToMenu
	farcall _HallOfFamePC
	call CloseSubmenu
	and a
	ret

TurnOffPC:
	ld hl, PokeCenterPCText_LinkClosed
	call PrintText
	scf
	ret

PC_PlayBootSound:
	ld de, SFX_BOOT_PC
	jr PC_WaitPlaySFX

PC_PlayShutdownSound:
	ld de, SFX_SHUT_DOWN_PC
	call PC_WaitPlaySFX
	jp WaitSFX

PC_PlayChoosePCSound:
	ld de, SFX_CHOOSE_PC_OPTION
	jr PC_WaitPlaySFX

PC_PlaySwapItemsSound:
	ld de, SFX_SWITCH_POKEMON
	call PC_WaitPlaySFX
	ld de, SFX_SWITCH_POKEMON

PC_WaitPlaySFX:
	push de
	call WaitSFX
	pop de
	jp PlaySFX

_PlayersHousePC:
	call PC_PlayBootSound
	ld hl, PlayersPCTurnOnText
	call PC_DisplayText
	ld b, $1
	call _PlayersPC
	and a
	jr nz, .asm_156f9
	call LoadMapPart
	call ApplyTilemap
	call UpdateSprites
	call PC_PlayShutdownSound
	ld c, $0
	ret

.asm_156f9
	call ClearBGPalettes
	ld c, $1
	ret

PlayersPCTurnOnText:
	; turned on the PC.
	text_jump _PlayersPCTurnOnText
	text_end

_PlayersPC:
	ld a, b
	ld [wWhichIndexSet], a
	ld hl, PlayersPCAskWhatDoText
	call PC_DisplayTextWaitMenu
	call .PlayersPC
	jp ExitMenu

.PlayersPC:
	xor a
	ld [wPCItemsCursor], a
	ld [wPCItemsScrollPosition], a
	ld hl, PlayersPCMenuData
	call LoadMenuHeader
.asm_15722
	call UpdateTimePals
	call DoNthMenu
	jr c, .asm_15731
	call MenuJumptable
	jr nc, .asm_15722
	jr .asm_15732

.asm_15731
	xor a

.asm_15732
	jp ExitMenu

PlayersPCMenuData:
	db %01000000
	db  0,  0 ; top left corner coords (y, x)
	db 12, 15 ; bottom right corner coords (y, x)
	dw .PlayersPCMenuData2
	db 1 ; default selected option

.PlayersPCMenuData2:
	db %10100000 ; bit7
	db 0 ; # items?
	dw .PlayersPCMenuList1
	dw PlaceNthMenuStrings
	dw .PlayersPCMenuPointers

.PlayersPCMenuPointers:
	dw PlayerWithdrawItemMenu, .WithdrawItem
	dw PlayerDepositItemMenu,  .DepositItem
	dw PlayerTossItemMenu,     .TossItem
	dw PlayerMailBoxMenu,      .MailBox
	dw PlayerDecorationMenu,   .Decoration
	dw PlayerLogOffMenu,       .LogOff
	dw PlayerLogOffMenu,       .TurnOff

.WithdrawItem: db "Withdraw Item@"
.DepositItem:  db "Deposit Item@"
.TossItem:     db "Toss Item@"
.MailBox:      db "Mail Box@"
.Decoration:   db "Decoration@"
.TurnOff:      db "Turn Off@"
.LogOff:       db "Log Off@"

WITHDRAW_ITEM EQU 0
DEPOSIT_ITEM  EQU 1
TOSS_ITEM     EQU 2
MAIL_BOX      EQU 3
DECORATION    EQU 4
TURN_OFF      EQU 5
LOG_OFF       EQU 6

.PlayersPCMenuList1:
	db 5
	db WITHDRAW_ITEM
	db DEPOSIT_ITEM
	db TOSS_ITEM
	db MAIL_BOX
	db TURN_OFF
	db -1
;.PlayersPCMenuList2:
	db 6
	db WITHDRAW_ITEM
	db DEPOSIT_ITEM
	db TOSS_ITEM
	db MAIL_BOX
	db DECORATION
	db LOG_OFF
	db -1

PC_DisplayTextWaitMenu:
	ld a, [wOptions1]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions1], a
	call MenuTextbox
	pop af
	ld [wOptions1], a
	ret

PlayersPCAskWhatDoText:
	; What do you want to do?
	text_jump _PlayersPCAskWhatDoText
	text_end

PlayerWithdrawItemMenu:
	call LoadStandardMenuHeader
	farcall ClearPCItemScreen
.loop
	call PCItemsJoypad
	jr c, .quit
	call .Submenu
	jr .loop

.quit
	call CloseSubmenu
	xor a
	ret

.Submenu:
	ld hl, .HowManyText
	call MenuTextbox
	farcall SelectQuantityToToss
	call ExitMenu
	call ExitMenu
	ret c

	ld a, [wItemQuantityChangeBuffer]
	ld [wBuffer1], a ; quantity
	ld a, [wCurItemQuantity]
	ld [wBuffer2], a
	ld hl, wNumItems
	call ReceiveItem
	jr nc, .PackFull
	ld a, [wBuffer1]
	ld [wItemQuantityChangeBuffer], a
	ld a, [wBuffer2]
	ld [wCurItemQuantity], a
	ld hl, wNumPCItems
	call TossItem
	predef PartyMonItemName
	ld hl, .WithdrewText
	call MenuTextbox
	xor a
	ldh [hBGMapMode], a
	jp ExitMenu

.PackFull:
	ld hl, .NoRoomText
	jp MenuTextboxBackup

.HowManyText:
	text_jump _PlayersPCHowManyWithdrawText
	text_end

.WithdrewText:
	text_jump _PlayersPCWithdrewItemsText
	text_end

.NoRoomText:
	text_jump _PlayersPCNoRoomWithdrawText
	text_end

PlayerTossItemMenu:
	call LoadStandardMenuHeader
	farcall ClearPCItemScreen
.loop
	call PCItemsJoypad
	jr c, .quit
	ld de, wNumPCItems
	farcall TossItemFromPC
	jr .loop

.quit
	call CloseSubmenu
	xor a
	ret

PlayerDecorationMenu:
	farcall _PlayerDecorationMenu
	ld a, c
	and a
	ret z
	scf
	ret

PlayerLogOffMenu:
	xor a
	scf
	ret

PlayerDepositItemMenu:
	call .CheckItemsInBag
	jr c, .nope
	call DisableSpriteUpdates
	call LoadStandardMenuHeader
	farcall DepositSellInitPackBuffers
.loop
	farcall DepositSellPack
	ld a, [wPackUsedItem]
	and a
	jr z, .close
	call .TryDepositItem
	farcall CheckRegisteredItem
	jr .loop

.close
	call CloseSubmenu

.nope
	xor a
	ret

.CheckItemsInBag:
	farcall HasNoItems
	ret nc
	ld hl, .NoItemsInBag
	call MenuTextboxBackup
	scf
	ret

.NoItemsInBag:
	; No items here!
	text_jump _PlayersPCNoItemsText
	text_end

.TryDepositItem:
	call CheckUniqueItemPocket
	jr z, .CantDepositItem
	ld a, [wSpriteUpdatesEnabled]
	push af
	xor a
	ld [wSpriteUpdatesEnabled], a
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld hl, .dw
	call JumpTable
	pop af
	ld [wSpriteUpdatesEnabled], a
	ret

.CantDepositItem
	ld hl, .CantDepositItemText
	call PrintText
	ld [wSpriteUpdatesEnabled], a
	ret

.dw
	dw .tossable
	dw DoNothing
	dw DoNothing
	dw DoNothing
	dw .tossable
	dw .tossable
	dw .tossable

.tossable
	ld a, [wBuffer1]
	push af
	ld a, [wBuffer2]
	push af
	call .DepositItem_
	pop af
	ld [wBuffer2], a
	pop af
	ld [wBuffer1], a
	ret

.DepositItem_:
	ld hl, .HowManyText
	call MenuTextbox
	farcall SelectQuantityToToss
	push af
	call ExitMenu
	call ExitMenu
	pop af
	jr c, .DeclinedToDeposit

	ld a, [wItemQuantityChangeBuffer]
	ld [wBuffer1], a
	ld a, [wCurItemQuantity]
	ld [wBuffer2], a
	ld hl, wNumPCItems
	call ReceiveItem
	jr nc, .NoRoomInPC
	ld a, [wBuffer1]
	ld [wItemQuantityChangeBuffer], a
	ld a, [wBuffer2]
	ld [wCurItemQuantity], a
	ld hl, wNumItems
	call TossItem
	predef PartyMonItemName
	ld hl, .DepositText
	jp PrintText

.NoRoomInPC:
	ld hl, .NoRoomText
	jp PrintText

.DeclinedToDeposit:
	and a
	ret

.CantDepositItemText:
	text_jump _PlayersPCCantDepositItemText
	text_end

.HowManyText:
	text_jump _PlayersPCHowManyDepositText
	text_end

.DepositText:
	text_jump _PlayersPCDepositItemsText
	text_end

.NoRoomText:
	text_jump _PlayersPCNoRoomDepositText
	text_end

PlayerMailBoxMenu:
	farcall _PlayerMailBoxMenu
	xor a
	ret

PCItemsJoypad:
	xor a
	ld [wSwitchItem], a
.loop
	ld a, [wSpriteUpdatesEnabled]
	push af
	xor a
	ld [wSpriteUpdatesEnabled], a
	ld hl, .PCItemsMenuData
	call CopyMenuHeader
	hlcoord 0, 0
	lb bc, 10, 18
	call Textbox
	ld a, [wPCItemsCursor]
	ld [wMenuCursorBuffer], a
	ld a, [wPCItemsScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wPCItemsScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wPCItemsCursor], a
	pop af
	ld [wSpriteUpdatesEnabled], a
	ld a, [wSwitchItem]
	and a
	jr nz, .moving_stuff_around
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_1
	cp A_BUTTON
	jr z, .a_1
	cp SELECT
	jr z, .select_1
	jr .next

.moving_stuff_around
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_2
	cp A_BUTTON
	jr z, .a_select_2
	cp SELECT
	jr z, .a_select_2
	jr .next

.b_2
	xor a
	ld [wSwitchItem], a
	jr .next

.a_select_2
	call PC_PlaySwapItemsSound
.select_1
	farcall SwitchItemsInBag
.next
	jp .loop

.a_1
	farcall ScrollingMenu_ClearLeftColumn
	call PlaceHollowCursor
	and a
	ret

.b_1
	scf
	ret

.PCItemsMenuData:
	db %01000000
	db  1,  4 ; start coords
	db 10, 18 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db %10110000
	db 4, 8 ; rows/cols?
	db 2 ; horizontal spacing?
	dbw 0, wNumPCItems
	dba PlaceMartItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

PC_DisplayText:
	call MenuTextbox
	jp ExitMenu

PokeCenterPCText_BootedUpPC:
	; turned on the PC.
	text_jump _PokecenterPCTurnOnText
	text_end

PokeCenterPCText_AccessWhosePC:
	; Access whose PC?
	text_jump _PokecenterPCWhoseText
	text_end

PokeCenterPCText_AccessedBillsPC:
	; BILL's PC accessed. #MON Storage System opened.
	text_jump _PokecenterBillsPCText
	text_end

PokeCenterPCText_AccessedOwnPC:
	; Accessed own PC. Item Storage System opened.
	text_jump _PokecenterPlayersPCText
	text_end

PokeCenterPCText_AccessedOaksPC:
	; PROF.OAK's PC accessed. #DEX Rating System opened.
	text_jump _PokecenterOaksPCText
	text_end

PokeCenterPCText_LinkClosed:
	; … Link closed…
	text_jump _PokecenterPCOaksClosedText
	text_end
