StartMenu:: ; 125cd

	call ClearWindowData

	ld de, SFX_MENU
	call PlaySFX

	farcall ReanchorBGMap_NoOAMUpdate

	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	ld hl, .MenuDataHeader
	jr z, .GotMenuData
	ld hl, .ContestMenuDataHeader
.GotMenuData:

	call LoadMenuDataHeader
	call .SetUpMenuItems
	ld a, [wBattleMenuCursorBuffer]
	ld [wMenuCursorBuffer], a
	call DrawVariableLengthMenuBox
	call .DrawBugContestStatusBox
	call SafeUpdateSprites
	call BGMapAnchorTopLeft
	farcall LoadFonts_NoOAMUpdate
	call .DrawBugContestStatus
	call UpdateTimePals
	jr .Select

.Reopen:
	call UpdateSprites
	call UpdateTimePals
	call .SetUpMenuItems
	ld a, [wBattleMenuCursorBuffer]
	ld [wMenuCursorBuffer], a

.Select:
	call .GetInput
	jr c, .Exit
	ld a, [wMenuCursorBuffer]
	ld [wBattleMenuCursorBuffer], a
	call PlayClickSFX
	call PlaceHollowCursor
	call .OpenMenu

; Menu items have different return functions.
; For example, saving exits the menu.
	ld hl, .MenuReturns
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.MenuReturns:
	dw .Reopen
	dw .Exit
	dw .ExitMenuCallFuncCloseText
	dw .ExitMenuRunScriptCloseText
	dw .ExitMenuRunScript
	dw .ReturnEnd
	dw .ReturnRedraw

.Exit:
	ld a, [hOAMUpdate]
	push af
	ld a, 1
	ld [hOAMUpdate], a
	call LoadFontsExtra
	pop af
	ld [hOAMUpdate], a
.ReturnEnd:
	call ExitMenu
.ReturnEnd2:
	call CloseText
	jp UpdateTimePals

.GetInput:
; Return carry on exit, and no-carry on selection.
	xor a
	ld [hBGMapMode], a
	call SetUpMenu
	ld a, $ff
	ld [wMenuSelection], a
.loop
	call ReadMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b
	cp A_BUTTON
	jr z, .a
	jr .loop
.a
	call PlayClickSFX
	and a
	ret
.b
	scf
	ret
; 12691

.ExitMenuRunScript: ; 12691
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ld [hMenuReturn], a
	ret
; 12699

.ExitMenuRunScriptCloseText: ; 12699
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ld [hMenuReturn], a
	jr .ReturnEnd2
; 126a2

.ExitMenuCallFuncCloseText: ; 126a2
	call ExitMenu
	ld hl, wQueuedScriptBank
	call FarPointerCall
	jr .ReturnEnd2
; 126b1

.ReturnRedraw: ; 126b1
	call ClearBGPalettes
	call ExitMenu
	call ReloadTilesetAndPalettes
	call DrawVariableLengthMenuBox
	call .DrawBugContestStatus
	call UpdateSprites
	call FinishExitMenu
	jp .Reopen
; 126b7

.MenuDataHeader:
	db $40 ; tile backup
	db 0, 10 ; start coords
	db 17, 19 ; end coords
	dw .MenuData
	db 1 ; default selection

.ContestMenuDataHeader:
	db $40 ; tile backup
	db 2, 10 ; start coords
	db 17, 19 ; end coords
	dw .MenuData
	db 1 ; default selection

.MenuData:
	db %10101000 ; x padding, wrap around, start can close
	dn 0, 0 ; rows, columns
	dw wMenuItemsList
	dw .MenuString
	dw .Items

.Items:
	dw StartMenu_Pokedex,  .PokedexString,  .NullDesc
	dw StartMenu_Pokemon,  .PartyString,    .NullDesc
	dw StartMenu_Pack,     .PackString,     .NullDesc
	dw StartMenu_Status,   .StatusString,   .NullDesc
	dw StartMenu_Save,     .SaveString,     .NullDesc
	dw StartMenu_Option,   .OptionString,   .NullDesc
	dw StartMenu_Exit,     .ExitString,     .NullDesc
	dw StartMenu_Pokegear, .PokegearString, .NullDesc
	dw StartMenu_Quit,     .QuitString,     .NullDesc

.PokedexString: 	db "#dex@"
.PartyString:   	db "#mon@"
.PackString:    	db "Bag@"
.StatusString:  	db "<PLAYER>@"
.SaveString:    	db "Save@"
.OptionString:  	db "Options@"
.ExitString:    	db "Exit@"
.PokegearString:	db "<PO><KE>gear@"
.QuitString:    	db "Quit@"

; Menu accounts are removed; this is vestigial
.NullDesc:      	db "@"

.OpenMenu: ; 127e5
	ld a, [wMenuSelection]
	call .GetMenuAccountTextPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; 127ef

.MenuString: ; 127ef
	push de
	ld a, [wMenuSelection]
	call .GetMenuAccountTextPointer
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	jp PlaceString
; 12800

.GetMenuAccountTextPointer: ; 12819
	ld e, a
	ld d, 0
	ld hl, wMenuData2PointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
rept 6
	add hl, de
endr
	ret
; 12829


.SetUpMenuItems: ; 12829
	xor a
	ld [wWhichIndexSet], a
	call .FillMenuList

	ld hl, wStatusFlags
	bit 0, [hl]
	jr z, .no_pokedex
	xor a ; pokedex
	call .AppendMenuList
.no_pokedex

	ld a, [wPartyCount]
	and a
	jr z, .no_pokemon
	ld a, 1 ; pokemon
	call .AppendMenuList
.no_pokemon

	ld a, [wLinkMode]
	and a
	jr nz, .no_pack
	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	jr nz, .no_pack
	ld a, 2 ; pack
	call .AppendMenuList
.no_pack

	ld hl, wPokegearFlags
	bit 7, [hl]
	jr z, .no_pokegear
	ld a, 7 ; pokegear
	call .AppendMenuList
.no_pokegear

	ld a, 3 ; status
	call .AppendMenuList

	ld a, [wLinkMode]
	and a
	jr nz, .no_save
	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	ld a, 8 ; quit
	jr nz, .write
	ld a, 4 ; save
.write
	call .AppendMenuList
.no_save

	ld a, 5 ; option
	call .AppendMenuList
	ld a, 6 ; exit
	call .AppendMenuList
	ld a, c
	ld [wMenuItemsList], a
	ret
; 1288d


.FillMenuList: ; 1288d
	xor a
	ld hl, wMenuItemsList
	ld [hli], a
	ld a, -1
	ld bc, wMenuItemsListEnd - (wMenuItemsList + 1)
	call ByteFill
	ld de, wMenuItemsList + 1
	ld c, 0
	ret
; 128a0

.AppendMenuList: ; 128a0
	ld [de], a
	inc de
	inc c
	ret
; 128a4

.DrawBugContestStatusBox: ; 128d1
	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	ret z
	farjp StartMenu_DrawBugContestStatusBox
; 128de

.DrawBugContestStatus: ; 128de
	ld hl, wStatusFlags2
	bit 2, [hl] ; ENGINE_BUG_CONTEST_TIMER
	jr nz, .contest
	ret
.contest
	farjp StartMenu_PrintBugContestStatus
; 128ed


StartMenu_Exit: ; 128ed
; Exit the menu.

	ld a, 1
	ret
; 128f0


StartMenu_Quit: ; 128f0
; Retire from the bug catching contest.

	ld hl, .EndTheContestText
	call StartMenuYesNo
	jr c, .DontEndContest
	ld a, BANK(BugCatchingContestReturnToGateScript)
	ld hl, BugCatchingContestReturnToGateScript
	call FarQueueScript
	ld a, 4
	ret

.DontEndContest:
	xor a
	ret

.EndTheContestText:
	text_jump UnknownText_0x1c1a6c
	db "@"
; 1290b


StartMenu_Save: ; 1290b
; Save the game.

	call BufferScreen
	farcall SaveMenu
	jr nc, .asm_12919
	xor a
	ret
.asm_12919
	ld a, 1
	ret
; 1291c


StartMenu_Option: ; 1291c
; Game options.

	call FadeToMenu
	farcall OptionsMenu
	ld a, 6
	ret
; 12928


StartMenu_Status: ; 12928
; Player status.

	call FadeToMenu
	farcall TrainerCard
	call CloseSubmenu
	xor a
	ret
; 12937


StartMenu_Pokedex: ; 12937

	ld a, [wPartyCount]
	and a
	jr z, .asm_12949

	call FadeToMenu
	farcall Pokedex
	call CloseSubmenu

.asm_12949
	xor a
	ret
; 1294c


StartMenu_Pokegear: ; 1294c

	call FadeToMenu
	farcall InitPokegearPalettes
	farcall PokeGear
	call CloseSubmenu
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	xor a
	ret
; 1295b


StartMenu_Pack: ; 1295b

	call FadeToMenu
	farcall Pack
	ld a, [wcf66]
	and a
	jr nz, .used_item
	call CloseSubmenu
	xor a
	ret

.used_item
	call ExitAllMenus
	ld a, 4
	ret
; 12976


StartMenu_Pokemon: ; 12976

	ld a, [wPartyCount]
	and a
	jr z, .return

	call FadeToMenu

.choosemenu
	xor a
	ld [wPartyMenuActionText], a ; Choose a POKéMON.
	call ClearBGPalettes

.menu
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX

.menunoreload
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call ApplyTilemapInVBlank
	call SetPalettes ; load regular palettes?
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .return ; if cancelled or pressed B

	call PokemonActionSubmenu
	push af
	call SFXDelay2
	pop af
	cp 3
	jr z, .menu
	cp 0
	jr z, .choosemenu
	cp 1
	jr z, .menunoreload
	cp 2
	jr z, .quit

.return
	call CloseSubmenu
	xor a
	ret

.quit
	ld a, b
	push af
	call ExitAllMenus
	pop af
	ret
; 129d5

HasNoItems: ; 129d5
	ld a, [wNumItems]
	and a
	ret nz
	ld a, [wNumMedicine]
	and a
	ret nz
	ld a, [wNumBalls]
	and a
	ret nz
	ld a, [wNumBerries]
	and a
	ret nz
	ld a, [wNumKeyItems]
	and a
	ret nz
	scf
	ret

TossItemFromPC: ; 129f4
	push de
	call PartyMonItemName
	farcall _CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .key_item
	ld hl, .TossHowMany
	call MenuTextBox
	farcall SelectQuantityToToss
	push af
	call CloseWindow
	call ExitMenu
	pop af
	jr c, .quit
	ld hl, .ConfirmToss
	call MenuTextBox
	call YesNoBox
	push af
	call ExitMenu
	pop af
	jr c, .quit
	pop hl
	ld a, [wCurItemQuantity]
	call TossItem
	call PartyMonItemName
	ld hl, .TossedThisMany
	call MenuTextBox
	call ExitMenu
	and a
	ret

.key_item
	call .CantToss
.quit
	pop hl
	scf
	ret

.TossHowMany:
	; Toss out how many @ (S)?
	text_jump UnknownText_0x1c1a90
	db "@"

.ConfirmToss:
	; Throw away @ @ (S)?
	text_jump UnknownText_0x1c1aad
	db "@"

.TossedThisMany:
	; Discarded @ (S).
	text_jump UnknownText_0x1c1aca
	db "@"

.CantToss:
	ld hl, .TooImportantToToss
	jp MenuTextBoxBackup

.TooImportantToToss:
	; That's too impor- tant to toss out!
	text_jump UnknownText_0x1c1adf
	db "@"
; 0x12a60

CantUseItem: ; 12a60
	ld hl, CantUseItemText
	jp MenuTextBoxWaitButton
; 12a67

CantUseItemText: ; 12a67
	text_jump UnknownText_0x1c1b03
	db "@"
; 12a6c


PartyMonItemName: ; 12a6c
	ld a, [wCurItem]
	ld [wd265], a
	call GetItemName
	jp CopyName1
; 12a79


CancelPokemonAction: ; 12a79
	farcall InitPartyMenuWithCancel
	farcall UnfreezeMonIcons
	ld a, 1
	ret
; 12a88


PokemonActionSubmenu: ; 12a88
	hlcoord 1, 15
	lb bc, 2, 18
	call ClearBox
	farcall MonSubmenu
	call GetCurNick
	ld a, [wMenuSelection]
	ld hl, .Actions
	ld de, 3
	call IsInArray
	jr nc, .nothing

	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.nothing
	xor a
	ret

.Actions:
	dbw MONMENU_CUT,        MonMenu_Cut ; Cut
	dbw MONMENU_FLY,        MonMenu_Fly ; Fly
	dbw MONMENU_SURF,       MonMenu_Surf ; Surf
	dbw MONMENU_STRENGTH,   MonMenu_Strength ; Strength
	dbw MONMENU_FLASH,      MonMenu_Flash ; Flash
	dbw MONMENU_WHIRLPOOL,  MonMenu_Whirlpool ; Whirlpool
	dbw MONMENU_DIG,        MonMenu_Dig ; Dig
	dbw MONMENU_TELEPORT,   MonMenu_Teleport ; Teleport
	dbw MONMENU_SOFTBOILED, MonMenu_Softboiled_MilkDrink ; Softboiled
	dbw MONMENU_MILKDRINK,  MonMenu_Softboiled_MilkDrink ; MilkDrink
	dbw MONMENU_HEADBUTT,   MonMenu_Headbutt ; Headbutt
	dbw MONMENU_WATERFALL,  MonMenu_Waterfall ; Waterfall
	dbw MONMENU_ROCKSMASH,  MonMenu_RockSmash ; RockSmash
	dbw MONMENU_STATS,      OpenPartyStats
	dbw MONMENU_SWITCH,     SwitchPartyMons
	dbw MONMENU_ITEM,       GiveTakePartyMonItem
	dbw MONMENU_CANCEL,     CancelPokemonAction
	dbw MONMENU_MOVE,       ManagePokemonMoves ; move
	dbw MONMENU_MAIL,       MonMailAction ; mail
; 12aec


SwitchPartyMons: ; 12aec

; Don't try if there's nothing to switch!
	ld a, [wPartyCount]
	cp 2
	jr c, .DontSwitch

	ld a, [wCurPartyMon]
	inc a
	ld [wSwitchMon], a

	farcall HoldSwitchmonIcon
	farcall InitPartyMenuNoCancel

	ld a, 4
	ld [wPartyMenuActionText], a
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText

	hlcoord 0, 1
	ld bc, 20 * 2
	ld a, [wSwitchMon]
	dec a
	rst AddNTimes
	ld [hl], "▷"
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame

	farcall PartyMenuSelect
	bit 1, b
	jr c, .DontSwitch

	farcall _SwitchPartyMons

	xor a
	ld [wPartyMenuActionText], a

	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX

	ld a, 1
	ret

.DontSwitch:
	xor a
	ld [wPartyMenuActionText], a
	jp CancelPokemonAction
; 12b60


GiveTakePartyMonItem: ; 12b60

; Eggs can't hold items!
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .cancel

	call GetPartyItemLocation
	ld a, [hl]
	and a
	ld de, .noItemString
	jr z, .not_holding_anything
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld de, wStringBuffer1
.not_holding_anything
	hlcoord 1, 16
	call PlaceString
	ld hl, GiveTakeItemMenuData
	call LoadMenuDataHeader
	call VerticalMenu
	call ExitMenu
	jr c, .cancel

	call GetCurNick
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .take

	call LoadStandardMenuDataHeader
	call ClearPalettes
	call .GiveItem
	call ClearPalettes
	call LoadFontsBattleExtra
	call ExitMenu
	xor a
	ret

.take
	call TakePartyItem
	ld a, 3
	ret

.cancel
	ld a, 3
	ret
; 12ba9

.noItemString
	db "No held item@"

.GiveItem:

	farcall DepositSellInitPackBuffers

.loop
	farcall DepositSellPack

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

	jp TryGiveItemToPartymon

.next
	ld hl, CantBeHeldText
	call MenuTextBoxBackup
	jr .loop
; 12bd9


TryGiveItemToPartymon: ; 12bd9

	call SpeechTextBox
	call PartyMonItemName
	call GetPartyItemLocation
	ld a, [hl]
	and a
	jr z, .give_item_to_mon

	ld d, a
	call ItemIsMail
	jr c, .please_remove_mail
	ld a, [hl]
	jr .already_holding_item

.give_item_to_mon
	call GiveItemToPokemon
	ld hl, MadeHoldText
	call MenuTextBoxBackup
	jp GivePartyItem

.please_remove_mail
	ld hl, PleaseRemoveMailText
	jp MenuTextBoxBackup

.already_holding_item
	ld [wd265], a
	call GetItemName
	ld hl, SwitchAlreadyHoldingText
	call StartMenuYesNo
	ret c

	call GiveItemToPokemon
	ld a, [wd265]
	push af
	ld a, [wCurItem]
	ld [wd265], a
	pop af
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	jr nc, .bag_full

	ld hl, TookAndMadeHoldText
	call MenuTextBoxBackup
	ld a, [wd265]
	ld [wCurItem], a
	jp GivePartyItem

.bag_full
	ld a, [wd265]
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	ld hl, ItemStorageIsFullText
	jp MenuTextBoxBackup
; 12c4c


GivePartyItem: ; 12c4c

	call GetPartyItemLocation
	ld a, [wCurItem]
	ld [hl], a
	ld d, a
	call ItemIsMail
	ret nc
	jp ComposeMailMessage
; 12c60


TakePartyItem: ; 12c60

	call SpeechTextBox
	call GetPartyItemLocation
	ld a, [hl]
	and a
	jr z, .asm_12c8c

	ld [wCurItem], a
	call ReceiveItemFromPokemon
	jr nc, .asm_12c94

	call ItemIsMail
	call GetPartyItemLocation
	ld a, [hl]
	ld [wd265], a
	ld [hl], NO_ITEM
	call GetItemName
	ld hl, TookFromText
	jp MenuTextBoxBackup

.asm_12c8c
	ld hl, IsntHoldingAnythingText
	jp MenuTextBoxBackup

.asm_12c94
	ld hl, ItemStorageIsFullText
	jp MenuTextBoxBackup
; 12c9b


GiveTakeItemMenuData: ; 12c9b
	db %01010000
	db 12, 13 ; start coords
	db 17, 19 ; end coords
	dw .Items
	db 1 ; default option

.Items:
	db %10000000 ; x padding
	db 2 ; # items
	db "Give@"
	db "Take@"
; 12caf


TookAndMadeHoldText: ; 12caf
	text_jump UnknownText_0x1c1b2c
	db "@"
; 12cb4

MadeHoldText: ; 12cb4
	text_jump UnknownText_0x1c1b57
	db "@"
; 12cb9

PleaseRemoveMailText: ; 12cb9
	text_jump UnknownText_0x1c1b6f
	db "@"
; 12cbe

IsntHoldingAnythingText: ; 12cbe
	text_jump UnknownText_0x1c1b8e
	db "@"
; 12cc3

ItemStorageIsFullText: ; 12cc3
	text_jump UnknownText_0x1c1baa
	db "@"
; 12cc8

TookFromText: ; 12cc8
	text_jump UnknownText_0x1c1bc4
	db "@"
; 12ccd

SwitchAlreadyHoldingText: ; 12ccd
	text_jump UnknownText_0x1c1bdc
	db "@"
; 12cd2

CantBeHeldText: ; 12cd2
	text_jump UnknownText_0x1c1c09
	db "@"
; 12cd7


GetPartyItemLocation: ; 12cd7
	push af
	ld a, MON_ITEM
	call GetPartyParamLocation
	pop af
	ret
; 12cdf


ReceiveItemFromPokemon: ; 12cdf
	ld a, $1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	jp ReceiveItem
; 12cea


GiveItemToPokemon: ; 12cea (4:6cea)
	ld a, $1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	jp TossItem

StartMenuYesNo: ; 12cf5
	call MenuTextBox
	call YesNoBox
	jp ExitMenu
; 12cfe


ComposeMailMessage: ; 12cfe (4:6cfe)
	ld de, wTempMailMessage
	farcall _ComposeMailMessage
	ld hl, wPlayerName
	ld de, wTempMailAuthor
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld hl, wPlayerID
	ld bc, 2
	rst CopyBytes
	ld a, [wCurPartySpecies]
	ld [de], a
	inc de
	ld a, [wCurItem]
	ld [de], a
	ld a, [wCurPartyMon]
	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, wTempMail
	ld bc, MAIL_STRUCT_LENGTH
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	rst CopyBytes
	jp CloseSRAM

MonMailAction: ; 12d45
; If in the trade center, selecting the mail only allows you to read the mail.
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr z, .read

; Show the READ/TAKE/QUIT menu.
	ld hl, .MenuDataHeader
	call LoadMenuDataHeader
	call VerticalMenu
	call ExitMenu

; Interpret the menu.
	jp c, .done
	ld a, [wMenuCursorY]
	cp $1
	jr z, .read
	cp $2
	jr z, .take
	jp .done

.read
	farcall ReadPartyMonMail
	xor a
	ret

.take
	ld hl, .sendmailtopctext
	call StartMenuYesNo
	jr c, .RemoveMailToBag
	ld a, [wCurPartyMon]
	ld b, a
	farcall SendMailToPC
	jr c, .MailboxFull
	ld hl, .sentmailtopctext
	call MenuTextBoxBackup
	jr .done

.MailboxFull:
	ld hl, .mailboxfulltext
	call MenuTextBoxBackup
	jr .done

.RemoveMailToBag:
	ld hl, .mailwilllosemessagetext
	call StartMenuYesNo
	jr c, .done
	call GetPartyItemLocation
	ld a, [hl]
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	jr nc, .BagIsFull
	call GetPartyItemLocation
	ld [hl], $0
	call GetCurNick
	ld hl, .tookmailfrommontext
	call MenuTextBoxBackup
	jr .done

.BagIsFull:
	ld hl, .bagfulltext
	call MenuTextBoxBackup
	; fallthrough

.done
	ld a, $3
	ret
; 12dc9


.MenuDataHeader:
	db $40 ; flags
	db 10, 12 ; start coords
	db 17, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x12dd1

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Read@"
	db "Take@"
	db "Quit@"
; 0x12de2


.mailwilllosemessagetext
; The MAIL will lose its message. OK?
	text_jump UnknownText_0x1c1c22
	db "@"
; 0x12de7

.tookmailfrommontext
; MAIL detached from <POKEMON>.
	text_jump UnknownText_0x1c1c47
	db "@"
; 0x12dec

.bagfulltext
; There's no space for removing MAIL.
	text_jump UnknownText_0x1c1c62
	db "@"
; 0x12df1

.sendmailtopctext
; Send the removed MAIL to your PC?
	text_jump UnknownText_0x1c1c86
	db "@"
; 0x12df6

.mailboxfulltext
; Your PC's MAILBOX is full.
	text_jump UnknownText_0x1c1ca9
	db "@"
; 0x12dfb

.sentmailtopctext
; The MAIL was sent to your PC.
	text_jump UnknownText_0x1c1cc4
	db "@"
; 0x12e00


OpenPartyStats: ; 12e00
	call LoadStandardMenuDataHeader
	call ClearSprites
; PartyMon
	xor a
	ld [wMonType], a
	call LowVolume
	predef StatsScreenInit
	call MaxVolume
	call ExitMenu
	xor a
	ret
; 12e1b


MonMenu_Cut: ; 12e1b
	farcall CutFunction
_MonMenu_StandardCheck:
	ld a, [wFieldMoveSucceeded]
	cp $1
	jr nz, _MonMenu_StandardFail
_MonMenu_StandardSuccess:
	ld b, $4
	ld a, $2
	ret

_MonMenu_StandardFail:
	ld a, $3
	ret
; 12e30

MonMenu_Fly: ; 12e30
	farcall FlyFunction
	ld a, [wFieldMoveSucceeded]
	cp $0
	jr z, .Error
	cp $2
	jr z, _MonMenu_StandardFail
	jr _MonMenu_StandardSuccess

.Error:
	xor a
	ret

MonMenu_Flash: ; 12e55
	farcall OWFlash
	jr _MonMenu_StandardCheck
; 12e6a

MonMenu_Strength: ; 12e6a
	farcall StrengthFunction
	jr _MonMenu_StandardCheck
; 12e7f

MonMenu_Whirlpool: ; 12e7f
	farcall WhirlpoolFunction
	jr _MonMenu_StandardCheck
; 12e94

MonMenu_Waterfall: ; 12e94
	farcall WaterfallFunction
	jr _MonMenu_StandardCheck
; 12ea9

MonMenu_Teleport: ; 12ea9
	farcall TeleportFunction
_MonMenu_AlternateCheck:
	ld a, [wFieldMoveSucceeded]
	and a
	jr z, _MonMenu_StandardFail
	jr _MonMenu_StandardSuccess
; 12ebd

MonMenu_Surf: ; 12ebd
	farcall SurfFunction
	jr _MonMenu_AlternateCheck
; 12ed1

MonMenu_Dig: ; 12ed1
	farcall DigFunction
	jr _MonMenu_StandardCheck
; 12ee6

MonMenu_Headbutt: ; 12f26
	farcall HeadbuttFunction
	jr _MonMenu_StandardCheck
; 12f3b

MonMenu_RockSmash: ; 12f3b
	farcall RockSmashFunction
	jr _MonMenu_StandardCheck
; 12f50

MonMenu_Softboiled_MilkDrink: ; 12ee6
	call .CheckMonHasEnoughHP
	jr nc, .NotEnoughHP
	farcall Softboiled_MilkDrinkFunction
	jr .finish

.NotEnoughHP:
	ld hl, .Text_NotEnoughHP
	call PrintText

.finish
	xor a
	ld [wPartyMenuActionText], a
	ld a, $3
	ret
; 12f00

.Text_NotEnoughHP:
	; Not enough HP!
	text_jump UnknownText_0x1c1ce3
	db "@"
; 0x12f05

.CheckMonHasEnoughHP:
; Need to have at least (MaxHP / 5) HP left.
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld [hDividend + 0], a
	ld a, [hl]
	ld [hDividend + 1], a
	ld a, 5
	ld [hDivisor], a
	ld b, 2
	call Divide
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hQuotient + 2]
	sub [hl]
	dec hl
	ld a, [hQuotient + 1]
	sbc [hl]
	ret
; 12f26

	const_def
	const MOVESCREEN_NORMAL
	const MOVESCREEN_DELETER
	const MOVESCREEN_NEWMOVE
	const MOVESCREEN_REMINDER

ChooseMoveToDelete:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call LoadFontsBattleExtra
	ld a, MOVESCREEN_DELETER
	ld [wMoveScreenMode], a
	call MoveScreenLoop
	pop bc
	push af
	ld a, b
	ld [wOptions1], a
	call ClearBGPalettes
	pop af
	ret

ChooseMoveToForget:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call LoadTileMapToTempTileMap
	call LoadFontsBattleExtra
	ld a, MOVESCREEN_NEWMOVE
	ld [wMoveScreenMode], a
	call MoveScreenLoop
	pop bc
	push af
	ld a, b
	ld [wOptions1], a
	call ClearBGPalettes
	ld a, [wBattleMode]
	and a
	jr z, .tm_tutor

	; Level up in battle
	call ClearTileMap
	call ClearSprites
	call ClearPalettes
	call DelayFrame
	call UpdateSprites
	farcall FinishBattleAnim
	farcall _LoadBattleFontsHPBar
	farcall GetMonBackpic
	call LoadTempTileMapToTileMap
	jr .done

.tm_tutor
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call SpeechTextBox
.done
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	pop af
	ret

ChooseMoveToRelearn:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call LoadFontsBattleExtra
	ld a, MOVESCREEN_REMINDER
	ld [wMoveScreenMode], a
	call MoveScreenLoop
	pop bc
	push af
	ld a, b
	ld [wOptions1], a
	jr c, .no_moves
	call ClearBGPalettes
	ld a, [wCurPartyMon]
	push af
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	pop af
	ld [wCurPartyMon], a
	pop af
	push af
	call nz, SpeechTextBox
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
.no_moves
	pop af
	ret

ManagePokemonMoves: ; 12fba
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	xor a
	ld [wMoveScreenMode], a
	call MoveScreenLoop
	pop af
	ld [wOptions1], a
	call ClearBGPalettes

.egg
	xor a
	ret
; 12fd5

MoveScreenLoop:
; Returns:
; a = >0: f = nc|nz; selected move (index in wMoveScreenSelectedMove)
; a =  0: f = nc|z;  user pressed B
;         f = c;     no options existed, move screen was aborted early
	xor a
	ld [wMoveScreenSelectedMove], a
	ld [wMoveScreenCursor], a
	ld [wMoveScreenOffset], a
	ld [wMoveScreenNumMoves], a

	; Zero the first 4 moves to avoid oddities if we have less than 4 total
	ld hl, wMoveScreenMoves
	ld b, NUM_MOVES
	xor a
.zero_movescreenmoves
	ld [hli], a
	dec b
	jr nz, .zero_movescreenmoves
	ld a, [wMoveScreenMode]
	cp MOVESCREEN_REMINDER
	jr z, .movecopy_reminder

	; Copy over moves from the party struct
	ld bc, NUM_MOVES
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld de, wMoveScreenMoves
.movecopy_loop
	ld a, [hli]
	and a
	jr z, .movecopy_done
	ld [de], a
	inc de
	inc b
	dec c
	jr nz, .movecopy_loop

.movecopy_done
	; If we're learning a new move, append the move to the move list buffer
	ld a, [wMoveScreenMode]
	cp MOVESCREEN_NEWMOVE
	jr nz, .newmove_done
	ld a, [wPutativeTMHMMove]
	ld [de], a
	inc b
	jr .newmove_done

.movecopy_reminder
	call GetForgottenMoves
	ld b, c
.newmove_done
	ld a, b
	ld [wMoveScreenNumMoves], a
	sub 1
	ret c ; no moves

	; Initialize the interface
	call SetUpMoveScreenBG
	call MoveScreen_ListMoves
	jr .loop
.outer_loop
	call MoveScreen_ListMovesFast
.pressed_start
	ld c, 5
	call DelayFrames
.loop
	farcall PlaySpriteAnimationsAndDelayFrame
	call JoyTextDelay

	; allow d-pad to be held, but not a/b/start/select
	ld a, [hJoyPressed]
	and BUTTONS
	ld b, a
	ld a, [hJoyDown]
	and D_PAD
	or b
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
	jp c, .pressed_left
	rrca
	jp c, .pressed_up
	rrca
	jp c, .pressed_down
	jr .loop
.pressed_a
	ld a, [wMoveScreenMode]
	and a ; cp MOVESCREEN_NORMAL
	jr z, .swap_move
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ld a, [wMoveScreenCursor]
	ld c, a
	ld a, [wMoveScreenOffset]
	add c
	ld c, a
	ld b, 0
	ld hl, wMoveScreenMoves
	add hl, bc
	ld a, [hl]
	ld [wMoveScreenSelectedMove], a
	ld a, [wMoveScreenMode]
	cp MOVESCREEN_NEWMOVE
	ld a, c
	jr nz, .ok
	push bc
	call IsHMMove
	pop bc
	ld a, c
	jr nc, .ok
	cp 4 ; selected new move
	jr z, .ok
	ld hl, Text_CantForgetHM
	call PrintTextNoBox
	jr .outer_loop
.ok
	inc a
	and a
	ret
.pressed_b
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ld a, [wMoveSwapBuffer]
	and a
	ret z
	xor a
	ld [wMoveSwapBuffer], a
	jp .outer_loop
.pressed_select
	ld a, [wMoveScreenMode]
	and a
	jp nz, .loop
.swap_move
	; check if we are in swap mode
	ld a, [wMoveSwapBuffer]
	and a
	jp nz, .perform_swap
	ld a, [wMoveScreenCursor]
	inc a
	ld [wMoveSwapBuffer], a
	jp .outer_loop
.pressed_right
	ld a, [wMoveScreenMode]
	and a
	jr z, .species_right
	ld a, [wMoveScreenCursor]
	cp 3
	jp z, .far_down
	ld a, [wMoveScreenNumMoves]
	dec a
	cp 4
	jp c, .update_screen_cursor
	ld a, 3
	jp .update_screen_cursor
.species_right
	ld a, [wPartyCount]
	ld d, a
	ld a, [wCurPartyMon]
	dec d
	cp d
	jp z, .loop
.loop_right
	inc a
	ld d, a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1IsEgg
	rst AddNTimes
	ld a, [hl]
	and IS_EGG_MASK
	ld a, d
	jr nz, .loop_right_invalid
	ld hl, wPartyMon1Species
	rst AddNTimes
	ld a, [hl]
	call IsAPokemon
	ld a, d
	jr c, .loop_right_invalid
	ld [wCurPartyMon], a
	jp MoveScreenLoop
.loop_right_invalid
	ld a, [wPartyCount]
	dec a
	cp d
	ld a, d
	jp z, .loop
	jr .loop_right
.pressed_left
	ld a, [wMoveScreenMode]
	and a
	jp z, .species_left
	ld a, [wMoveScreenCursor]
	and a
	jr z, .far_up
	xor a
	jr .update_screen_cursor
.species_left
	ld a, [wCurPartyMon]
	and a
	jp z, .loop
.loop_left
	dec a
	ld d, a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1IsEgg
	rst AddNTimes
	ld a, [hl]
	and IS_EGG_MASK
	ld a, d
	jr nz, .loop_left_invalid
	ld hl, wPartyMon1Species
	rst AddNTimes
	ld a, [hl]
	call IsAPokemon
	ld a, d
	jr c, .loop_left_invalid
	ld [wCurPartyMon], a
	jp MoveScreenLoop
.loop_left_invalid
	and a
	jp z, .loop
	jr .loop_left
.pressed_up
	ld a, [wMoveScreenCursor]
	and a
	jr z, .scroll_up
	dec a
	jr .update_screen_cursor
.pressed_down
	ld a, [wMoveScreenNumMoves]
	ld b, a
	ld a, [wMoveScreenCursor]
	cp 3
	jr z, .scroll_down
	inc a
	cp b
	jp nc, .outer_loop ; less than 4 moves
.update_screen_cursor
	ld [wMoveScreenCursor], a
	jp .outer_loop
.far_up
	ld a, [wMoveScreenOffset]
	sub 4
	jr nc, .update_screen_offset
	xor a
	jr .update_screen_offset
.scroll_up
	ld a, [wMoveScreenOffset]
	and a
	jp z, .outer_loop
	dec a
	jr .update_screen_offset
.far_down
	ld a, [wMoveScreenNumMoves]
	sub 4
	ld b, a
	ld a, [wMoveScreenOffset]
	add 4
	cp b
	jr c, .update_screen_offset
	ld a, b
	jr .update_screen_offset
.scroll_down
	ld a, [wMoveScreenNumMoves]
	ld b, a
	ld a, [wMoveScreenOffset]
	add 4
	sub b
	jp nc, .outer_loop
	ld a, [wMoveScreenOffset]
	inc a
.update_screen_offset
	ld [wMoveScreenOffset], a
	call MoveScreen_ListMoves
	jp .loop

.perform_swap
	ld a, [wBattleMode]
	and a
	jr z, .regular_swap_move

	; If we're transformed, the Moves screen shows our original moveset.
	; So swapping in the moves screen swap our original moves, while
	; swapping in the battle interface swaps our temporary moves.
	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .regular_swap_move
	ld a, [wMoveScreenCursor]
	inc a
	ld [wMenuCursorY], a
	farcall SwapBattleMoves
	jr .finish_swap

.regular_swap_move
	ld a, MON_MOVES
	call GetPartyParamLocation
	call .swap_location
	ld a, MON_PP
	call GetPartyParamLocation
	call .swap_location

.finish_swap
	ld hl, wMoveScreenMoves
	call .swap_location
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	call WaitSFX
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	call WaitSFX
	xor a
	ld [wMoveSwapBuffer], a
	call MoveScreen_ListMoves
	jp .loop

.swap_location
	ld a, [wMoveScreenCursor]
	ld b, 0
	ld c, a
	push hl
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wMoveSwapBuffer]
	dec a
	ld c, a
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

GetForgottenMoves::
; retrieve a list of a mon's forgotten moves, excluding ones beyond level
; and moves the mon already knows
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	dec a
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

	ld de, wMoveScreenMoves
	ld c, a
	ld a, [wCurPartyLevel]
	ld b, a
	ld b, 100 ; Gen VII behaviour
	inc b ; so that we can use jr nc
.loop
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc hl
	and a
	ret z
	cp b
	ret nc
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc hl

	; exclude moves the user already knows
	push hl
	push bc
	ld b, a
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld c, NUM_MOVES
	ld a, b
	call .move_exists
	jr z, .already_knows_move
	pop bc
	push bc
	jr .move_ok
	ld b, 0
	ld hl, wMoveScreenMoves
	call .move_exists
	jr z, .already_knows_move
.move_ok
	pop bc
	pop hl
	ld [de], a
	inc de
	inc c
	jr .loop
.already_knows_move
	pop bc
	pop hl
	jr .loop

.move_exists
	ld b, a
.move_exists_loop
	ld a, [hli]
	cp b
	ret z
	dec c
	jr nz, .move_exists_loop
	inc c ; ret nz
	ld a, b
	ret

String_MoveSwap: ; 1316b
	db "Switch with?@"
; 13172

SetUpMoveScreenBG: ; 13172
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	xor a
	ld [hBGMapMode], a
	ld b, CGB_PARTY_MENU
	call GetCGBLayout
	farcall LoadStatsGFX
	farcall ClearSpriteAnims2
	ld a, [wCurPartyMon]
	ld e, a
	ld d, $0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wd265], a
	farcall LoadMoveMenuMonIcon
	hlcoord 0, 1
	lb bc, 9, 18
	call TextBox
	hlcoord 0, 11
	lb bc, 5, 18
	call TextBox
	hlcoord 2, 0
	lb bc, 2, 3
	call ClearBox
	xor a
	ld [wMonType], a
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNick
	hlcoord 5, 1
	call PlaceString
	push bc
	farcall CopyPkmnToTempMon
	pop hl
	call PrintLevel
	ld hl, wPlayerHPPal
	call SetHPPal
	call SetPalettes
	hlcoord 16, 0
	lb bc, 1, 3
	jp ClearBox
; 131ef

MoveScreen_ListMoves:
	ld c, 2
	call DelayFrames
	hlcoord 1, 2
	lb bc, 14, 18
	call ClearBox
	xor a
	ld [hBGMapMode], a
	ld hl, wMoveScreenMoves
	ld b, a
	ld a, [wMoveScreenOffset]
	ld c, a
	add hl, bc
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	rst CopyBytes
	ld a, SCREEN_WIDTH * 2 ; move list spacing
	ld [wBuffer1], a
	hlcoord 2, 3
	predef ListMoves

	; Get PP -- either current PP, or default PP for the move
	ld hl, wListMoves_MoveIndicesBuffer
	ld de, wTempMonMoves
	ld bc, NUM_MOVES
	rst CopyBytes

	; Get default PP for moves
	ld c, NUM_MOVES
	ld hl, wTempMonMoves
	ld de, wTempMonPP
.defaultpp_loop
	ld a, [hli]
	push hl
	push bc
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	dec a
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld [de], a
	inc de
	pop bc
	pop hl
	dec c
	jr nz, .defaultpp_loop

	; Get current PP for current moves
	ld a, [wMoveScreenMode]
	cp MOVESCREEN_REMINDER
	jr z, .got_pp
	ld a, MON_PP
	call GetPartyParamLocation
	ld c, NUM_MOVES
	ld de, wTempMonPP
	ld a, [wMoveScreenOffset]
.currentpp_loop
	and a
	jr z, .currentpp_ok
	dec a
	jr .currentpp_next
.currentpp_ok
	push af
	ld a, [hl]
	ld [de], a
	inc de
	pop af
.currentpp_next
	inc hl
	dec c
	jr nz, .currentpp_loop

.got_pp
	; Now we have things set up correctly
	hlcoord 10, 4
	predef ListMovePP
	hlcoord 1, 12, wAttrMap
	ld bc, 6
	xor a
	call ByteFill

	farcall ApplyAttrMap

MoveScreen_ListMovesFast:
	hlcoord 0, 11
	lb bc, 5, 18
	call TextBox
	ld hl, wTempMonMoves
	ld a, [wMoveScreenCursor]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurMove], a

	hlcoord 1, 1 ; 2 below topmost position
	ld bc, SCREEN_WIDTH * 2
	ld a, [wMoveSwapBuffer]
	ld d, a
	ld a, [wMoveScreenCursor]
	inc a
	ld e, a
	xor a
.cursor_loop
	inc a
	add hl, bc
	ld [hl], " "
	cp d
	jr nz, .not_selected_swap
	ld [hl], "▷"
.not_selected_swap
	cp e
	jr nz, .not_selected
	ld [hl], "▶"
.not_selected
	cp NUM_MOVES
	jr nz, .cursor_loop
	ld a, [wMoveScreenOffset]
	and a
	jr z, .skip_up
	hlcoord 18, 2
	ld a, "▲"
	ld [hl], a
.skip_up
	ld a, [wMoveScreenOffset]
	ld b, a
	ld a, [wMoveScreenNumMoves]
	sub b
	sub 5
	jr c, .skip_down
	hlcoord 18, 10
	ld a, "▼"
	ld [hl], a
.skip_down
	jp PlaceMoveData

PlaceMoveData:
	ld a, [wMoveSwapBuffer]
	and a
	jr z, .not_swapping
	hlcoord 1, 14
	ld de, String_MoveSwap
	call PlaceString
	ld a, $1
	ld [hBGMapMode], a
	ret

.not_swapping
	xor a
	ld [hBGMapMode], a

	hlcoord 10, 12
	ld de, String_PowAcc
	call PlaceString

	ld a, [wCurMove]
	dec a
	ld hl, Moves + MOVE_CATEGORY
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld b, a
	push bc
	ld hl, CategoryIconGFX
	ld bc, 2 tiles
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, VTiles2 tile $59
	lb bc, BANK(CategoryIconGFX), 2
	call Request2bpp
	hlcoord 1, 12
	ld [hl], $59
	inc hl
	ld [hl], $5a

	ld a, [wCurMove]
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	ld c, a
	ld de, wUnknBGPals palette 0 + 2
	push af
	farcall LoadCategoryAndTypePals
	call SetPalettes

	pop af
	ld hl, TypeIconGFX
	ld bc, 4 * LEN_1BPP_TILE
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, VTiles2 tile $5b
	lb bc, BANK(TypeIconGFX), 4
	call Request1bpp
	hlcoord 3, 12
	ld [hl], $5b
	inc hl
	ld [hl], $5c
	inc hl
	ld [hl], $5d
	inc hl
	ld [hl], $5e

	ld a, [wCurMove]
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	hlcoord 10, 12
	cp 2
	jr c, .no_power
	ld [wd265], a
	ld de, wd265
	lb bc, 1, 3
	call PrintNum
	jr .place_accuracy
.no_power
	ld de, String_na
	call PlaceString

.place_accuracy
	ld a, [wCurMove]
	dec a
	ld hl, Moves + MOVE_ACC
	ld bc, MOVE_LENGTH
	rst AddNTimes
	; convert internal accuracy representation to a number
	; between 0-100
	ld a, BANK(Moves)
	call GetFarByte
	ld [hMultiplicand], a
	ld a, 100
	ld [hMultiplier], a
	call Multiply
	ld a, [hProduct]
	; don't increase a for 0% moves
	and a
	jr z, .no_inc
	inc a
.no_inc
	hlcoord 15, 12
	cp 2
	jr c, .no_acc
	ld [wd265], a
	ld de, wd265
	lb bc, 1, 3
	call PrintNum
	jr .description
.no_acc
	ld de, String_na
	call PlaceString

.description
	hlcoord 1, 14
	predef PrintMoveDesc
	ld a, $1
	ld [hBGMapMode], a
	ret
; 132ba

String_na: ; 132cf
	db "---@"

String_PowAcc:
	db "   <BOLDP>/   %@"

Text_CantForgetHM:
; HM moves can't be forgotten now.
	text_jump UnknownText_0x1c5772
	db "@"
