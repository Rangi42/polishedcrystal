SelectMonFromParty:
	xor a
	ld b, a
	; fallthrough
SelectTradeOrDayCareMon:
	ld a, b
	ld [wPartyMenuActionText], a
	call DisableSpriteUpdates
	call ClearBGPalettes
	call InitPartyMenuLayout
	call ApplyTilemapInVBlank
	ld a, CGB_PARTY_MENU
	call GetCGBLayout
	call SetPalettes
	call DelayFrame
	call PartyMenuSelect
	jmp ReturnToMapWithSpeechTextbox

BT_SwapRentals:
	; Party selection is always 1-2-3, so prepare this.
	xor a
	ld hl, wBT_PartySelections
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ld a, PARTYMENUACTION_BATTLE_TOWER
	ld [wPartyMenuActionText], a
	call DisableSpriteUpdates
	call ClearBGPalettes

.loop
	call InitPartyMenuLayout
	hlcoord 1, 16
	ld de, .TradeWhichPKMN
	call PlaceString
	call ApplyTilemapInVBlank
	ld a, CGB_PARTY_MENU
	call GetCGBLayout
	call SetPalettes
	call DelayFrame
	call PartyMenuSelect
	jmp c, .return
	farcall FreezeMonIcons

	call InitPartySwap
	hlcoord 1, 16
	ld de, .TradeWhichPKMN
	call PlaceString
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	call PartyMenuSelect
	jr c, .loop

	; If we "swapped" a mon with itself, just cancel the switch choice.
	ld a, [wSwitchMon]
	ld c, a
	dec c
	ld a, [wCurPartyMon]
	cp c
	jr z, .reset_switch

	; Figure out if we actually swapped one of ours with one of the last foe's.
	ld b, 0
	cp 3
	rl b
	ld a, c
	cp 3
	rl b

	; If b is 0 or 3, we swapped within ours or opponent, which isn't a proper
	; swap.
	ld a, b
	and a
	jr z, .improper_swap
	cp 3
	jr z, .improper_swap

	; The swap is plausible. Invoke the swap.
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wSwitchMon]
	ld c, a
	push bc
	call .SwitchPartyMons

	; Perform a legality check.
	farcall BT_LegalityCheck
	dec e
	ld hl, BTText_SameSpecies
	jr z, .reset_and_print_error
	dec e
	ld hl, BTText_SameItem
	jr z, .reset_and_print_error

	call BT_ConfirmPartySelection
	jr c, .return_to_loop
	dec a
	jr nz, .return_to_loop
	pop bc
	jr .return

.reset_and_print_error
	push hl
	call InitPartyMenuLayout
	farcall FreezeMonIcons
	pop hl
	call PrintText
.return_to_loop
	pop bc
	ld a, b
	ld [wCurPartyMon], a
	inc a
	ld [wMenuCursorY], a
	ld a, c
	ld [wSwitchMon], a
	call .SwitchPartyMons
.reset_switch
	xor a
	ld [wSwitchMon], a
	jmp .loop

.improper_swap
	ld hl, .MustSwapBetweenTeams
	push hl
	call InitPartyMenuLayout
	farcall FreezeMonIcons
	pop hl
	call PrintText
	xor a
	ld [wSwitchMon], a
	jmp .loop

.return
	jmp ReturnToMapWithSpeechTextbox

.SwitchPartyMons:
	ld hl, wBT_MonParty
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wSwitchMon]
	dec a
	ld c, a
	push hl
	ld a, b
	ld b, 0
	add hl, bc
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hli], a
	ld a, b
	ld [de], a
	inc de
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	call _SwitchPartyMons
	farjp BT_SetRentalOT

.MustSwapBetweenTeams:
	text "You must trade <PK><MN>"
	line "between the teams!"
	prompt

.TradeWhichPKMN:
	db "Trade which <PK><MN>?   @"

BT_PartySelect:
	ld a, PARTYMENUACTION_BATTLE_TOWER
	ld [wPartyMenuActionText], a
	call DisableSpriteUpdates
	call ClearBGPalettes

.loop
	call InitPartyMenuLayout
	call ApplyTilemapInVBlank
	ld a, CGB_PARTY_MENU
	call GetCGBLayout
	call SetPalettes
	call DelayFrame
	call PartyMenuSelect
	jr c, .return
	farcall FreezeMonIcons

	; Check if we're entering something. In that case, remove the entry.
	ld a, [wCurPartyMon]
	call BT_CheckEnterState
	jr z, .open_menu ; not entered or banned

	call BT_RemoveCurSelection
	jr .loop

.open_menu
	call .Menu
	jr c, .loop
	; Banned mons don't get the "Enter" option
	ld a, [wCurPartyMon]
	call BT_CheckEnterState
	ld a, [wMenuCursorY]
	adc 0
	dec a ; Enter
	jr z, .Enter
	dec a ; Stats
	jmp z, .Stats
	dec a ; Moves
	jmp z, .Moves
	jr .loop ; Cancel

.return
	jmp ReturnToMapWithSpeechTextbox

.Menu:
	; 3 menu headers; eggs (implicitly banned), banned, regular
	; Check if mon is an Egg
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	ld hl, .EggMenuHeader
	jmp nz, BT_DisplayMenu

	; Check if mon is banned
	ld a, [wCurPartyMon]
	call BT_CheckEnterState
	ld hl, .MenuHeader
	jmp nc, BT_DisplayMenu
	ld hl, .BannedMenuHeader
	jmp BT_DisplayMenu

.Enter:
	call BT_AddCurSelection
	ld hl, .too_many_mons_text
	jr c, .print_error
	ld a, [wBT_PartySelectCounter]
	cp 3
	jr nz, .loop

	; Entered 3 mons. Check legality, and if OK, prompt to enter those 3.
	farcall BT_SetPlayerOT
	farcall BT_LegalityCheck
	dec e
	ld hl, BTText_SameSpecies
	jr z, .reset_and_print_error
	dec e
	ld hl, BTText_SameItem
	jr z, .reset_and_print_error

	call BT_ConfirmPartySelection
	jmp c, .loop
	dec a
	jmp nz, .loop
	jr .return

.reset_and_print_error
	push hl
	call InitPartyMenuLayout
	farcall FreezeMonIcons
	pop hl
	call PrintText
	xor a
	ld [wBT_PartySelectCounter], a
	jmp .loop

.print_error
	call PrintText
	jmp .loop

.too_many_mons_text
	text "You may only enter"
	line "with 3 #mon!"
	prompt

.Stats:
	farcall OpenPartyStats
	jmp .loop

.Moves:
	; For Eggs, "Moves" is actually the "Cancel" option
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .Cancel
	farcall ManagePokemonMoves

.Cancel:
	jmp .loop

.EggMenuHeader:
	db $00 ; flags
	db 13, 11 ; start coords
	db 17, 19 ; end coords
	dw .EggMenuData
	db 1 ; default option

.EggMenuData:
	db $c0 ; flags
	db 2 ; items
	db "Stats@"
	db "Cancel@"

.MenuHeader:
	db $00 ; flags
	db 9, 11 ; start coords
	db 17, 19 ; end coords
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $c0 ; flags
	db 4 ; items
	db "Enter@"
	db "Stats@"
	db "Moves@"
	db "Cancel@"

.BannedMenuHeader:
	db $00 ; flags
	db 11, 11 ; start coords
	db 17, 19 ; end coords
	dw .BannedMenuData
	db 1 ; default option

.BannedMenuData:
	db $c0 ; flags
	db 3 ; items
	db "Stats@"
	db "Moves@"
	db "Cancel@"

BTText_EnterBattle:
	db "Enter battle?@"

BTText_SameSpecies:
	text "The #mon must"
	line "be of different"
	cont "species!"
	prompt

BTText_SameItem:
	text "The #mon's held"
	line "items must differ!"
	prompt

BT_ConfirmPartySelection:
	call InitPartyMenuLayout
	farcall FreezeMonIcons
	hlcoord 1, 16
	ld de, BTText_EnterBattle
	call PlaceString
	ld hl, .YesNoMenuHeader
	call BT_DisplayMenu
	ld a, [wMenuCursorY]
	ret

.YesNoMenuHeader:
; the regular yes/no prompt position is unsuitable, so make our own here
	db $00 ; flags
	db 13, 14 ; start coords
	db 17, 19 ; end coords
	dw .YesNoMenuData
	db 1 ; default option

.YesNoMenuData:
	db $c0 ; flags
	db 2 ; items
	db "Yes@"
	db "No@"

BT_DisplayMenu:
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call ApplyTilemapInVBlank
	call CopyMenuData2
	ld a, [wMenuDataFlags]
	bit 7, a
	scf
	ret z
	call InitVerticalMenuCursor
	ld hl, w2DMenuFlags1
	set 6, [hl]
	call DoMenuJoypadLoop
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ldh a, [hJoyPressed]
	and a ; clear carry
	bit B_BUTTON_F, a
	ret z
	scf
	ret

BT_CheckEnterState:
; Check enter state of party mon in a. Returns:
; z|c: Banned
; z|nc: Allowed, not entered
; nz|nc: Allowed and entered, a contains entry number (1-3)
	push hl
	push de
	push bc

	; Check if the mon is banned
	push af
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .banned
	pop af
	push af
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld hl, UberMons
	call IsInByteArray
	jr c, .banned
	pop af

	; Check entry state. If we're rental-swapping, we want to display it a bit
	; differently.
	ld hl, wBT_PartySelectCounter
	ld c, [hl]
	inc c
	jr nz, .not_rental

	inc a
	cp 4
	jr c, .got_entry
	ld a, 4
	jr .got_entry

.not_rental
	ld b, a
	ld d, 0
	ld hl, wBT_PartySelections
.loop
	dec c
	ld a, c
	and a
	jr z, .return ; Not entered
	inc d
	ld a, [hli]
	cp b
	jr nz, .loop

	; Entry number is stored in d
	ld a, d
.got_entry
	and a
	jr .return

.banned
	pop af
	xor a
	scf
.return
	jmp PopBCDEHL

BT_AddCurSelection:
; Adds wCurPartyMon to BT selection. Doesn't verify that the mon already
; is entered, but will reject the selection if the player attempts to
; select a 4th+ mon by returning c.
	push hl
	ld hl, wBT_PartySelectCounter
	ld a, [hl]
	cp 3
	ccf
	jr c, .return
	inc [hl]

	add LOW(wBT_PartySelections)
	ld l, a
	adc HIGH(wBT_PartySelections)
	sub l
	ld h, a

	ld a, [wCurPartyMon]
	ld [hl], a
	and a

.return
	pop hl
	ret

BT_RemoveCurSelection:
; Removes wCurPartyMon from BT selection and shifts other entries.
; Assumes the selection entry is valid and will break otherwise.
	push hl
	push de
	push bc
	ld hl, wBT_PartySelectCounter
	ld e, [hl]
	dec [hl]
	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wBT_PartySelections
	ld d, 0
.loop
	inc d
	ld a, [hli]
	cp c
	jr nz, .loop

	; Found entry. Shift entries after this one.
	ld b, h
	ld c, l
	dec hl

.shift_loop
	ld a, d
	cp e
	jmp z, PopBCDEHL
	ld a, [bc]
	inc bc
	ld [hli], a
	inc d
	jr .shift_loop

InitPartyMenuLayout:
	call LoadPartyMenuGFX
	call InitPartyMenuWithCancel
	call InitPartyMenuGFX
	call WritePartyMenuTilemap
	jmp PrintPartyMenuText

LoadPartyMenuGFX:
	call LoadFontsBattleExtra
	farcall InitPartyMenuPalettes ; engine/color.asm
	jmp ClearSpriteAnims2

WritePartyMenuTilemap:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl] ; Disable text delay
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	rst ByteFill ; blank the tilemap
	call GetPartyMenuTilemapPointers ; This reads from a pointer table???
.loop
	ld a, [hli]
	cp $ff
	jr z, .end ; 0x5007a $8
	push hl
	ld hl, .Jumptable
	call JumpTable
	pop hl
	jr .loop ; 0x50082 $f3
.end
	pop af
	ld [wOptions1], a
	ret

.Jumptable:
	dw PlacePartyNicknames
	dw PlacePartyHPBar
	dw PlacePartyMenuHPDigits
	dw PlacePartyMonLevel
	dw PlacePartyMonStatus
	dw PlacePartyMonTMHMCompatibility
	dw PlacePartyMonEvoStoneCompatibility
	dw PlacePartyMonGender
	dw PlacePartyMonRemindable
	dw PlacePartyMonBattleTower

PlacePartyNicknames:
	hlcoord 3, 1
	ld a, [wPartyCount]
	and a
	jr z, .end
	ld c, a
	ld b, $0
.loop
	push bc
	push hl
	push hl
	ld hl, wPartyMonNicknames
	ld a, b
	call GetNickname
	pop hl
	rst PlaceString
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop

.end
	dec hl
	dec hl
	ld de, .Cancel
	rst PlaceString
	ret

.Cancel:
	db "Cancel@"

PlacePartyHPBar:
	xor a
	ld [wHPPalIndex], a
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, $0
	hlcoord 11, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .skip
	push hl
	call PlacePartymonHPBar
	pop hl
	ld d, $6
	call DrawBattleHPBar
	ld hl, wHPPals
	ld a, [wHPPalIndex]
	ld c, a
	ld b, $0
	add hl, bc
	call SetHPPal
	ld a, CGB_PARTY_MENU_HP_PALS
	call GetCGBLayout
.skip
	ld hl, wHPPalIndex
	inc [hl]
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartymonHPBar:
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1HP
	rst AddNTimes
	ld a, [hli]
	or [hl]
	jr nz, .not_fainted
	xor a
	ld e, a
	ld c, a
	ret

.not_fainted
	dec hl
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	predef_jump ComputeHPBarPixels

PlacePartyMenuHPDigits:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, $0
	hlcoord 13, 1
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1HP
	rst AddNTimes
	ld e, l
	ld d, h
	pop hl
	push de
	lb bc, 2, 3
	call PrintNum
	pop de
	ld a, "/"
	ld [hli], a
	inc de
	inc de
	lb bc, 2, 3
	call PrintNum

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonLevel:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 7, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Level
	rst AddNTimes
	ld e, l
	ld d, h
	pop hl
	ld a, [de]
	cp 100 ; This is distinct from MAX_LEVEL.
	jr nc, .ThreeDigits
	ld a, "<LV>"
	ld [hli], a
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	; jr .okay
.ThreeDigits:
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
; .okay
	call PrintNum

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonStatus:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 4, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Status
	rst AddNTimes
	ld e, l
	ld d, h
	pop hl
	call PlaceStatusString

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonTMHMCompatibility:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld hl, wPartySpecies
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld a, b
	ld hl, wPartyMon1Form
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	predef CanLearnTMHMMove
	pop hl
	call .PlaceAbleNotAble
	rst PlaceString

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.PlaceAbleNotAble:
	ld a, c
	and a
	jr nz, .able
	ld de, .string_not_able
	ret

.able
	ld de, .string_able
	ret

.string_able
	db "Able@"

.string_not_able
	db "Not able@"

PlacePartyMonEvoStoneCompatibility:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	; d = party index
	ld d, b
	; e = species
	ld a, d
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld e, [hl]
	; b = form
	ld a, d
	ld hl, wPartyMon1Form
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	and SPECIESFORM_MASK
	ld b, a
	; c = species
	ld c, e
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	call .DetermineCompatibility
	pop hl
	rst PlaceString

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.DetermineCompatibility:
	ld de, wStringBuffer1
	ld a, BANK(EvosAttacksPointers)
	ld bc, 2
	call FarCopyBytes
	ld hl, wStringBuffer1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
; Reads up to six evolution entries
	ld a, BANK(EvosAttacks)
	ld bc, wStringBuffer2 - wStringBuffer1
	call FarCopyBytes
	ld hl, wStringBuffer1
.loop2
	ld a, [hli]
	and a
	jr z, .nope
	inc hl
	inc hl
	cp EVOLVE_ITEM
	jr nz, .loop2
	dec hl
	dec hl
	ld a, [wCurItem]
	cp [hl]
	inc hl
	inc hl
	jr nz, .loop2
	ld de, .string_able
	ret

.nope
	ld de, .string_not_able
	ret

.string_able
	db "Able@"
.string_not_able
	db "Not able@"

PlacePartyMonGender:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 10, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld hl, wPartySpecies
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	pop hl
	ld a, [wCurPartyMon]
	push af
	ld a, b
	ld [wCurPartyMon], a
	push hl
	xor a
	ld [wMonType], a
	call GetGender
	ld a, " "
	jr c, .got_gender
	ld a, "<MALE>"
	jr nz, .got_gender
	inc a ; "<FEMALE>"

.got_gender
	pop hl
	ld [hli], a
	pop af
	ld [wCurPartyMon], a

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop

	ld a, CGB_PARTY_MENU
	jmp GetCGBLayout

PlacePartyMonRemindable:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr nz, .next
	push hl
	ld hl, wPartySpecies
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	farcall GetForgottenMoves
	pop hl
	call .PlaceAbleNotAble
	rst PlaceString

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.PlaceAbleNotAble:
	ld a, c
	and a
	jr nz, .able
	ld de, .string_not_able
	ret

.able
	ld de, .string_able
	ret

.string_able
	db "Able@"

.string_not_able
	db "Not able@"

PlacePartyMonBattleTower:
	ld bc, 0
	hlcoord 12, 2
.loop
	ld a, [wPartyCount]
	cp c
	ret z

	ld a, c
	call BT_CheckEnterState

	ld de, .Banned
	jr c, .next
	ld de, .Able
	jr z, .next
	dec a
	ld de, .First
	jr z, .next
	dec a
	ld de, .Second
	jr z, .next
	dec a
	ld de, .Third
	jr z, .next
	ld de, .LastFoe
.next
	push hl
	push bc
	rst PlaceString
	pop bc
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	inc c
	jr .loop

.Banned
	db "Banned@"

.Able
	db "Able@"

.First
	db "First@"

.Second
	db "Second@"

.Third
	db "Third@"

.LastFoe
	db "Last foe@"

PartyMenuCheckEgg:
	push hl
	ld a, b
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	pop hl
	ret

GetPartyMenuTilemapPointers:
	ld a, [wPartyMenuActionText]
	and $f0
	jr nz, .skip
	ld a, [wPartyMenuActionText]
	and $f
	ld e, a
	ld d, 0
	ld hl, PartyMenuQualityPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.skip
	ld hl, PartyMenuQualityPointers.Default
	ret

INCLUDE "data/party_menu_qualities.asm"

InitPartyMenuGFX:
	ld hl, wPartyCount
	ld a, [hli]
	and a
	ret z
	ld c, a
	xor a
	ldh [hObjectStructIndexBuffer], a
.loop
	push bc
	push hl
	farcall LoadPartyMenuMonIcon
	ldh a, [hObjectStructIndexBuffer]
	inc a
	ldh [hObjectStructIndexBuffer], a
	pop hl
	pop bc
	dec c
	jr nz, .loop
	farjp PlaySpriteAnimations

InitPartyMenuWithCancel:
; with cancel
	xor a
	ld [wSwitchMon], a
	ld de, PartyMenuAttributes
	call SetMenuAttributes
	ld a, [wPartyCount]
	inc a
	ld [w2DMenuNumRows], a ; list length
	dec a
	ld b, a
	ld a, [wPartyMenuCursor]
	and a
	jr z, .skip
	inc b
	cp b
	jr c, .done

.skip
	ld a, 1

.done
	ld [wMenuCursorY], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ret

InitPartySwap:
	ld a, [wCurPartyMon]
	inc a
	ld [wSwitchMon], a

	farcall HoldSwitchmonIcon

	call InitPartyMenuNoCancel
	call WritePartyMenuTilemap
	call PrintPartyMenuText

	hlcoord 0, 1
	ld bc, 20 * 2
	ld a, [wSwitchMon]
	dec a
	rst AddNTimes
	ld [hl], "▷"
	ret

InitPartyMenuNoCancel:
; no cancel
	ld de, PartyMenuAttributes
	call SetMenuAttributes
	ld a, [wPartyCount]
	ld [w2DMenuNumRows], a ; list length
	ld b, a
	ld a, [wPartyMenuCursor]
	and a
	jr z, .skip
	inc b
	cp b
	jr c, .done
.skip
	ld a, 1
.done
	ld [wMenuCursorY], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ret

PartyMenuAttributes:
; cursor y
; cursor x
; num rows
; num cols
; bit 6: animate sprites  bit 5: wrap around
; ?
; distance between items (hi: y, lo: x)
; allowed buttons (mask)
	db 1, 0
	db 0, 1
	db $60, $00
	dn 2, 0
	db 0

PartyMenuSelect:
; sets carry if exitted menu.
	call DoMenuJoypadLoop
	call PlaceHollowCursor
	ld a, [wPartyCount]
	inc a
	ld b, a
	ld a, [wMenuCursorY] ; menu selection?
	cp b
	jr z, .exitmenu ; CANCEL
	ld [wPartyMenuCursor], a
	ldh a, [hJoyLast]
	ld b, a
	bit B_BUTTON_F, b
	jr nz, .exitmenu ; B button
	ld a, [wMenuCursorY]
	dec a
	ld [wCurPartyMon], a
	ld c, a
	ld b, $0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a

	ld de, SFX_READ_TEXT_2
	call PlaySFX
	push bc
	call SFXDelay2
	pop bc
	and a
	ret

.exitmenu
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	push bc
	call SFXDelay2
	pop bc
	scf
	ret

PrintPartyMenuText:
	hlcoord 0, 14
	lb bc, 2, 18
	call Textbox
	ld a, [wPartyCount]
	and a
	jr nz, .haspokemon
	ld de, YouHaveNoPKMNString
	jr .gotstring
.haspokemon
	ld a, [wPartyMenuActionText]
	and $f ; drop high nibble
	ld hl, PartyMenuStrings
	ld e, a
	ld d, $0
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
.gotstring
	ld a, [wOptions1]
	push af
	set NO_TEXT_SCROLL, a ; disable text delay
	ld [wOptions1], a
	hlcoord 1, 16 ; Coord
	rst PlaceString
	pop af
	ld [wOptions1], a
	ret

PartyMenuStrings:
; needs to match PartyMenuQualityPointers
	dw ChooseAMonString
	dw UseOnWhichPKMNString
	dw WhichPKMNString
	dw TeachWhichPKMNString
	dw MoveToWhereString
	dw UseOnWhichPKMNString
	dw ChooseAMonString ; Probably used to be ChooseAFemalePKMNString
	dw ChooseAMonString ; Probably used to be ChooseAMalePKMNString
	dw ToWhichPKMNString
	dw TutorWhichPKMNString
	dw Choose3MonString

ChooseAMonString:
	db "Choose a #mon.@"
UseOnWhichPKMNString:
	db "Use on which <PK><MN>?@"
WhichPKMNString:
	db "Which <PK><MN>?@"
TeachWhichPKMNString:
	db "Teach which <PK><MN>?@"
TutorWhichPKMNString:
	db "Tutor which <PK><MN>?@"
Choose3MonString:
	db "Choose 3 battle <PK><MN>@"
MoveToWhereString:
	db "Move to where?@"
ToWhichPKMNString:
	db "To which <PK><MN>?@"

YouHaveNoPKMNString:
	db "You have no <PK><MN>!@"

PrintPartyMenuActionText:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	ld a, [wPartyMenuActionText]
	and $f
	add a
	add LOW(.MenuActionTexts)
	ld l, a
	adc HIGH(.MenuActionTexts)
	sub l
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOptions1]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions1], a
	call PrintText
	pop af
	ld [wOptions1], a
	ret

.MenuActionTexts:
	dw .Text_CuredOfPoison
	dw .Text_BurnWasHealed
	dw .Text_Defrosted
	dw .Text_WokeUp
	dw .Text_RidOfParalysis
	dw .Text_RecoveredSomeHP
	dw .Text_HealthReturned
	dw .Text_Revitalized
	dw .Text_GrewToLevel
	dw .Text_CameToItsSenses

.Text_RecoveredSomeHP:
	; recovered @ HP!
	text_far _RecoveredSomeHPText
	text_end

.Text_CuredOfPoison:
	; 's cured of poison.
	text_far _CuredOfPoisonText
	text_end

.Text_RidOfParalysis:
	; 's rid of paralysis.
	text_far _RidOfParalysisText
	text_end

.Text_BurnWasHealed:
	; 's burn was healed.
	text_far _BurnWasHealedText
	text_end

.Text_Defrosted:
	; was defrosted.
	text_far _WasDefrostedText
	text_end

.Text_WokeUp:
	; woke up.
	text_far _WokeUpText
	text_end

.Text_HealthReturned:
	; 's health returned.
	text_far _HealthReturnedText
	text_end

.Text_Revitalized:
	; is revitalized.
	text_far _RevitalizedText
	text_end

.Text_GrewToLevel:
	; grew to level @ !@ @
	text_far _GrewToLevelText
	text_end

.Text_CameToItsSenses:
	; came to its senses.
	text_far _CameToItsSensesText
	text_end
