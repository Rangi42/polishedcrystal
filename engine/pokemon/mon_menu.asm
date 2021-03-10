HasNoItems:
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
	scf
	ret

TossItemFromPC:
	push de
	call PartyMonItemName
	ld hl, .TossHowMany
	call MenuTextbox
	farcall SelectQuantityToToss
	push af
	call CloseWindow
	call ExitMenu
	pop af
	jr c, .quit
	ld hl, .ConfirmToss
	call MenuTextbox
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
	call MenuTextbox
	call ExitMenu
	and a
	ret

.quit
	pop hl
	scf
	ret

.TossHowMany:
	; Toss out how many @ (S)?
	text_jump _ItemsTossOutHowManyText
	text_end

.ConfirmToss:
	; Throw away @ @ (S)?
	text_jump _ItemsThrowAwayText
	text_end

.TossedThisMany:
	; Discarded @ (S).
	text_jump _ItemsDiscardedText
	text_end

CantUseItem:
	ld hl, CantUseItemText
	jp MenuTextboxWaitButton

CantUseItemText:
	text_jump _ItemsOakWarningText
	text_end

PartyMonItemName:
	ld a, [wCurItem]
	ld [wd265], a
	call GetItemName
	jp CopyName1

CancelPokemonAction:
	farcall InitPartyMenuWithCancel
	farcall UnfreezeMonIcons
	ld a, 1
	ret

PokemonActionSubmenu:
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
	jp IndirectHL

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
	dbw MONMENU_FRESHSNACK, MonMenu_FreshSnack ; FreshSnack
	dbw MONMENU_HEADBUTT,   MonMenu_Headbutt ; Headbutt
	dbw MONMENU_WATERFALL,  MonMenu_Waterfall ; Waterfall
	dbw MONMENU_ROCKSMASH,  MonMenu_RockSmash ; RockSmash
	dbw MONMENU_STATS,      OpenPartyStats
	dbw MONMENU_SWITCH,     SwitchPartyMons
	dbw MONMENU_ITEM,       GiveTakePartyMonItem
	dbw MONMENU_CANCEL,     CancelPokemonAction
	dbw MONMENU_MOVE,       ManagePokemonMoves ; move
	dbw MONMENU_MAIL,       MonMailAction ; mail

SwitchPartyMons:

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

GiveTakePartyMonItem:

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
	rst PlaceString
	ld hl, GiveTakeItemMenuData
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	jr c, .cancel

	call GetCurNick
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ld a, [wMenuCursorY]
	cp 2 ; 2 = take
	jr z, .take
	cp 3 ; 3 = swap
	jr z, .swap
	; 1 = give

	call LoadStandardMenuHeader
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

.swap
	call SwapPartyItem
	ld a, 3
	ret

.cancel
	ld a, 3
	ret

.noItemString
	db "No held item@"

.GiveItem:

	call DepositSellInitPackBuffers

.loop
	call DepositSellPack

	ld a, [wPackUsedItem]
	and a
	ret z

	call CheckUniqueItemPocket
	jr nz, TryGiveItemToPartymon

	ld hl, CantBeHeldText
	call MenuTextboxBackup
	jr .loop

TryGiveItemToPartymon:

	call SpeechTextbox
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
	call MenuTextboxBackup
	jp GivePartyItem

.please_remove_mail
	ld hl, PleaseRemoveMailText
	jp MenuTextboxBackup

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
	jr c, .bag_not_full

	ld a, [wd265]
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	ld hl, ItemStorageIsFullText
	jp MenuTextboxBackup

.bag_not_full
	ld hl, TookAndMadeHoldText
	call MenuTextboxBackup
	ld a, [wd265]
	ld [wCurItem], a
	; fallthrough

GivePartyItem:
	call GetPartyItemLocation
	ld a, [wCurItem]
	ld [hl], a
	call UpdateMewtwoForm
	ld a, [wCurItem]
	ld d, a
	call ItemIsMail
	ret nc
	jp ComposeMailMessage

; swap items between two party pokemon
SwapPartyItem:
	ld a, [wPartyCount]
	cp 2
	jr c, .DontSwap
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
	jr c, .DontSwap
	; wSwitchMon contains first selected pkmn
	; wCurPartyMon contains second selected pkmn
	; getting pkmn2 item and putting into stack item addr + item id
	call GetPartyItemLocation
	ld a, [hl] ; a pkmn2 contains item 
	push hl
	push af
	; getting pkmn 1 item and putting item id into b
	ld a, [wSwitchMon]
	dec a
	ld [wCurPartyMon], a
	call GetPartyItemLocation
	ld a, [hl] ; a pkmn1 contains item 
	ld b, a
	; actual swap
	pop af 
	ld [hl], a ; pkmn1 get pkm2 item
	pop hl 
	ld a, b
	ld [hl], a ; pkmn1 get pkm2 item
	xor a
	ld [wPartyMenuActionText], a
	jp CancelPokemonAction

.DontSwap
	xor a
	ld [wPartyMenuActionText], a
	jp CancelPokemonAction

TakePartyItem:
	call SpeechTextbox
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
	call UpdateMewtwoForm
	call GetItemName
	ld hl, TookFromText
	jp MenuTextboxBackup

.asm_12c8c
	ld hl, IsntHoldingAnythingText
	jp MenuTextboxBackup

.asm_12c94
	ld hl, ItemStorageIsFullText
	jp MenuTextboxBackup

UpdateMewtwoForm:
	ld a, [wCurPartySpecies]
	cp MEWTWO
	ret nz
	ld a, [hl]
	cp ARMOR_SUIT
	ld a, MEWTWO_ARMORED_FORM
	jr z, .got_form
	dec a ; PLAIN_FORM
.got_form
	ld d, a
	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	and $ff - BASEMON_MASK
	or d
	ld [hl], a
	ret

GiveTakeItemMenuData:
	db %01010000
	db 10, 13 ; start coords
	db 17, 19 ; end coords
	dw .Items
	db 1 ; default option

.Items:
	db %10000000 ; x padding
	db 3 ; # items
	db "Give@"
	db "Take@"
	db "Swap@"

TookAndMadeHoldText:
	text_jump _PokemonSwapItemText
	text_end

MadeHoldText:
	text_jump _PokemonHoldItemText
	text_end

PleaseRemoveMailText:
	text_jump _PokemonRemoveMailText
	text_end

IsntHoldingAnythingText:
	text_jump _PokemonNotHoldingText
	text_end

ItemStorageIsFullText:
	text_jump _ItemStorageFullText
	text_end

TookFromText:
	text_jump _PokemonTookItemText
	text_end

SwitchAlreadyHoldingText:
	text_jump _PokemonAskSwapItemText
	text_end

CantBeHeldText:
	text_jump _ItemCantHeldText
	text_end

GetPartyItemLocation:
	push af
	ld a, MON_ITEM
	call GetPartyParamLocation
	pop af
	ret

ReceiveItemFromPokemon:
	ld a, $1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	jp ReceiveItem

GiveItemToPokemon:
	ld a, $1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	jp TossItem

StartMenuYesNo:
	call MenuTextbox
	call YesNoBox
	jp ExitMenu

ComposeMailMessage:
	ld de, wTempMailMessage
	call _ComposeMailMessage
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

MonMailAction:
; If in the trade center, selecting the mail only allows you to read the mail.
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr z, .read

; Show the READ/TAKE/QUIT menu.
	ld hl, .MenuDataHeader
	call LoadMenuHeader
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
	call MenuTextboxBackup
	jr .done

.MailboxFull:
	ld hl, .mailboxfulltext
	call MenuTextboxBackup
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
	call MenuTextboxBackup
	jr .done

.BagIsFull:
	ld hl, .bagfulltext
	call MenuTextboxBackup
	; fallthrough

.done
	ld a, $3
	ret

.MenuDataHeader:
	db $40 ; flags
	db 10, 12 ; start coords
	db 17, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Read@"
	db "Take@"
	db "Quit@"

.mailwilllosemessagetext
; The MAIL will lose its message. OK?
	text_jump _MailLoseMessageText
	text_end

.tookmailfrommontext
; MAIL detached from <POKEMON>.
	text_jump _MailDetachedText
	text_end

.bagfulltext
; There's no space for removing MAIL.
	text_jump _MailNoSpaceText
	text_end

.sendmailtopctext
; Send the removed MAIL to your PC?
	text_jump _MailAskSendToPCText
	text_end

.mailboxfulltext
; Your PC's MAILBOX is full.
	text_jump _MailboxFullText
	text_end

.sentmailtopctext
; The MAIL was sent to your PC.
	text_jump _MailSentToPCText
	text_end

OpenPartyStats:
	call LoadStandardMenuHeader
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

MonMenu_Cut:
	farcall CutFunction
_MonMenu_StandardCheck:
	ld a, [wFieldMoveSucceeded]
	cp $1
	jr nz, _MonMenu_StandardFail
_MonMenu_StandardSuccess:
	ld b, $4
	ld a, $2
	ret

MonMenu_Fly:
	farcall FlyFunction
	ld a, [wFieldMoveSucceeded]
	and a
	ret z
	cp $2
	jr nz, _MonMenu_StandardSuccess
_MonMenu_StandardFail:
	ld a, $3
	ret

MonMenu_Flash:
	farcall OWFlash
	jr _MonMenu_StandardCheck

MonMenu_Strength:
	farcall StrengthFunction
	jr _MonMenu_StandardCheck

MonMenu_Whirlpool:
	farcall WhirlpoolFunction
	jr _MonMenu_StandardCheck

MonMenu_Waterfall:
	farcall WaterfallFunction
	jr _MonMenu_StandardCheck

MonMenu_Teleport:
	farcall TeleportFunction
_MonMenu_AlternateCheck:
	ld a, [wFieldMoveSucceeded]
	and a
	jr z, _MonMenu_StandardFail
	jr _MonMenu_StandardSuccess

MonMenu_Surf:
	farcall SurfFunction
	jr _MonMenu_AlternateCheck

MonMenu_Dig:
	farcall DigFunction
	jr _MonMenu_StandardCheck

MonMenu_Headbutt:
	farcall HeadbuttFunction
	jr _MonMenu_StandardCheck

MonMenu_RockSmash:
	farcall RockSmashFunction
	jr _MonMenu_StandardCheck

MonMenu_FreshSnack:
	call .CheckMonHasEnoughHP
	jr nc, .NotEnoughHP
	farcall FreshSnackFunction
	jr .finish

.NotEnoughHP:
	ld hl, .Text_NotEnoughHP
	call PrintText

.finish
	xor a
	ld [wPartyMenuActionText], a
	ld a, $3
	ret

.Text_NotEnoughHP:
	; Not enough HP!
	text_jump _PokemonNotEnoughHPText
	text_end

.CheckMonHasEnoughHP:
; Need to have at least (MaxHP / 5) HP left.
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend + 0], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ldh a, [hQuotient + 2]
	sub [hl]
	dec hl
	ldh a, [hQuotient + 1]
	sbc [hl]
	ret

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
	ld a, [wCurPartyMon]
	push af
	farcall InitPartyMenuLayout
	pop af
	ld [wCurPartyMon], a
	call SpeechTextbox
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
	farcall InitPartyMenuLayout
	pop af
	ld [wCurPartyMon], a
	pop af
	push af
	call nz, SpeechTextbox
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
.no_moves
	pop af
	ret

ManagePokemonMoves:
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .egg
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
	sub 1 ; no-optimize a++|a-- (dec a can't set carry)
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

	ldh a, [hJoyPressed]
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
	ld a, [hl]
	push bc
	ld hl, HMMoves
	ld de, 1
	call IsInArray
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
	; c = species
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld c, [hl]
	; b = form
	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	and BASEMON_MASK
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
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
	push hl
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld b, [hl]
	pop hl
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

String_MoveSwap:
	db "Switch with?@"

SetUpMoveScreenBG:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	ld a, CGB_PARTY_MENU
	call GetCGBLayout
	call LoadFontsBattleExtra
	call ClearSpriteAnims2
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
	call Textbox
	hlcoord 0, 11
	lb bc, 5, 18
	call Textbox
	hlcoord 2, 0
	lb bc, 2, 3
	call ClearBox
	xor a
	ld [wMonType], a
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNick
	hlcoord 5, 1
	rst PlaceString
	push bc
	farcall CopyPkmnToTempMon
	pop hl
	call PrintLevel
	call SetPalettes
	hlcoord 16, 0
	lb bc, 1, 3
	jp ClearBox

MoveScreen_ListMoves:
	ld c, 2
	call DelayFrames
	hlcoord 1, 2
	lb bc, 14, 18
	call ClearBox
	xor a
	ldh [hBGMapMode], a
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
	ld hl, Moves + MOVE_PP
	call GetMoveProperty
	pop hl
	ld [de], a
	inc de
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
	rst ByteFill

	farcall ApplyAttrMap

MoveScreen_ListMovesFast:
	hlcoord 0, 11
	lb bc, 5, 18
	call Textbox
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
	ld [hl], "▲"
.skip_up
	ld a, [wMoveScreenOffset]
	ld b, a
	ld a, [wMoveScreenNumMoves]
	sub b
	sub 5
	jr c, .skip_down
	hlcoord 18, 10
	ld [hl], "▼"
.skip_down

PlaceMoveData:
	ld a, [wMoveSwapBuffer]
	and a
	jr z, .not_swapping
	hlcoord 1, 14
	ld de, String_MoveSwap
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret

.not_swapping
	xor a
	ldh [hBGMapMode], a

	hlcoord 10, 12
	ld de, String_PowAcc
	rst PlaceString

	call GetCurMoveFixedCategory
	ld b, a
	push bc
	ld hl, CategoryIconGFX
	ld bc, 2 tiles
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile $59
	lb bc, BANK(CategoryIconGFX), 2
	call Request2bpp
	hlcoord 1, 12
	ld [hl], $59
	inc hl
	ld [hl], $5a

	ld hl, Moves + MOVE_TYPE
	call GetCurMoveProperty
	pop bc
	ld c, a
	ld de, wBGPals1 palette 0 + 2
	push af
	farcall LoadCategoryAndTypePals
	call SetPalettes

	pop af
	ld hl, TypeIconGFX
	ld bc, 4 * LEN_1BPP_TILE
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile $5b
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

	ld hl, Moves + MOVE_POWER
	call GetCurMoveProperty
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
	rst PlaceString

.place_accuracy
	ld hl, Moves + MOVE_ACC
	call GetCurMoveProperty
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
	rst PlaceString

.description
	hlcoord 1, 14
	predef PrintMoveDesc
	ld a, $1
	ldh [hBGMapMode], a
	ret

String_na:
	db "---@"

String_PowAcc:
	db "   <BOLDP>/   %@"

Text_CantForgetHM:
; HM moves can't be forgotten now.
	text_jump _MoveCantForgetHMText
	text_end
