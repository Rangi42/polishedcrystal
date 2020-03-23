LinkCommunications:
	call ClearBGPalettes
	ld c, 80
	call DelayFrames
	call ClearScreen
	call ClearSprites
	call UpdateSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld c, 80
	call DelayFrames
	call ClearScreen
	call UpdateSprites
	call LoadStandardFont
	call LoadFontsBattleExtra
	call LoadTradeScreenGFX
	call ApplyAttrAndTilemapInVBlank
	hlcoord 3, 8
	lb bc, 2, 12
	call LinkTextbox
	hlcoord 4, 10
	ld de, String_PleaseWait
	rst PlaceString
	call SetTradeRoomBGPals
	call ApplyAttrAndTilemapInVBlank
	ld hl, wcf5d
	xor a
	ld [hli], a
	ld [hl], $50
	; fallthrough

Gen2ToGen2LinkComms:
	call ClearLinkData
	call Link_PrepPartyData_Gen2
	call FixDataForLinkTransfer
	call Function29dba
	ldh a, [hScriptVar]
	and a
	jp z, LinkTimeout
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .Player1
	ld c, 3
	call DelayFrames
	xor a
	ldh [hSerialSend], a
	ld a, $1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a
	call DelayFrame
	xor a
	ldh [hSerialSend], a
	ld a, $1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a

.Player1:
	ld de, MUSIC_NONE
	call PlayMusic
	ld c, 3
	call DelayFrames
	xor a
	ldh [rIF], a
	ld a, %01000
	ldh [rIE], a
	ld hl, wLinkBuffer
	ld de, wLinkBufferEnd
	ld bc, 17
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a
	ld hl, wLinkData
	ld de, wLinkOTExchangeStart
	ld bc, wLinkOTExchangeEnd - wLinkOTExchangeStart
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a
	ld hl, wLinkMisc
	ld de, wPlayerTrademonSpecies
	ld bc, wPlayerTrademonSpecies - wLinkMisc
	call Serial_ExchangeBytes
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr nz, .not_trading
	ld hl, wc9f4
	ld de, wcb84
	ld bc, $186
	call Function283f2

.not_trading
	xor a
	ldh [rIF], a
	ld a, %11001
	ldh [rIE], a
	ld de, MUSIC_NONE
	call PlayMusic
	call Link_CopyRandomNumbers
	ld hl, wOTPlayerName
	call Link_FindFirstNonControlCharacter_SkipZero
	ld de, wLinkData
	ld bc, $1b9
	call Link_CopyOTData
	ld de, wPlayerTrademonSpecies
	ld hl, wLinkPlayerPartyMon1Species
	ld c, $2
.loop1
	ld a, [de]
	inc de
	and a
	jr z, .loop1
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop1
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop1
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .next1
	push hl
	push bc
	ld b, $0
	dec a
	ld c, a
	add hl, bc
	ld [hl], SERIAL_NO_DATA_BYTE
	pop bc
	pop hl
	jr .loop1

.next1
	ld hl, wc90f
	dec c
	jr nz, .loop1
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jp nz, .skip_mail
	ld hl, wcb84
.loop2
	ld a, [hli]
	cp $20
	jr nz, .loop2
.loop3
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop3
	cp $20
	jr z, .loop3
	dec hl
	ld de, wcb84
	ld bc, $190
	rst CopyBytes
	ld hl, wcb84
	ld bc, $c6
.loop4
	ld a, [hl]
	cp $21
	jr nz, .okay1
	ld [hl], SERIAL_NO_DATA_BYTE
.okay1
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop4
	ld de, wcc9e
.loop5
	ld a, [de]
	inc de
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .start_copying_mail
	ld hl, wcc4a
	dec a
	ld b, $0
	ld c, a
	add hl, bc
	ld [hl], SERIAL_NO_DATA_BYTE
	jr .loop5

.start_copying_mail
	ld hl, wcb84
	ld de, wc9f4
	ld b, PARTY_LENGTH
.copy_mail_loop
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	rst CopyBytes
	ld a, (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) % $100
	add e
	ld e, a
	ld a, (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) / $100
	adc d
	ld d, a
	pop bc
	dec b
	jr nz, .copy_mail_loop
	ld de, wc9f4
	ld b, PARTY_LENGTH
.copy_author_loop
	push bc
	ld a, (MAIL_MSG_LENGTH + 1) % $100
	add e
	ld e, a
	ld a, (MAIL_MSG_LENGTH + 1) / $100
	adc d
	ld d, a
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	rst CopyBytes
	pop bc
	dec b
	jr nz, .copy_author_loop
	ld b, PARTY_LENGTH
	ld de, wc9f4
.fix_mail_loop
	push bc
	ld hl, MAIL_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop bc
	dec b
	jr nz, .fix_mail_loop
	ld de, wcb0e
	xor a
	ld [de], a

.skip_mail
	ld hl, wLinkData
	ld de, wOTPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld de, wOTPartyCount
	ld bc, 8
	rst CopyBytes
	ld de, wOTPlayerID
	ld bc, 2
	rst CopyBytes
	ld de, wOTPartyMons
	ld bc, wOTPartyDataEnd - wOTPartyMons
	rst CopyBytes
	ld de, MUSIC_NONE
	call PlayMusic
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr nz, .ready_to_trade
	ld a, CAL
	ld [wOtherTrainerClass], a
	call ClearScreen
	call Link_WaitBGMap
	ld hl, wOptions2
	ld a, [hl]
	push af
	and $ff - (BATTLE_SWITCH | BATTLE_PREDICT)
	ld [hl], a
	ld hl, wOTPlayerName
	ld de, wOTClassName
	ld bc, NAME_LENGTH
	rst CopyBytes
	call ReturnToMapFromSubmenu
	ldh a, [rIE]
	push af
	ldh a, [rIF]
	push af
	xor a
	ldh [rIF], a
	ldh a, [rIE]
	set 1, a
	ldh [rIE], a
	pop af
	ldh [rIF], a
	predef StartBattle
	ldh a, [rIF]
	ld h, a
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	ld a, h
	ldh [rIF], a
	pop af
	ld [wOptions2], a
	farcall LoadPokemonData
	jp Function28b22

.ready_to_trade
	ld de, MUSIC_ROUTE_30
	call PlayMusic
	jp InitTradeMenuDisplay

LinkTimeout:
	ld de, .TooMuchTimeHasElapsed
	ld b, 10
.loop
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .loop
	xor a
	ld [hld], a
	ld [hl], a
	ldh [hVBlank], a
	push de
	hlcoord 0, 12
	lb bc, 4, 18
	push de
	call LinkTextbox
	pop de
	pop hl
	bccoord 1, 14
	call PlaceWholeStringInBoxAtOnce
	ld c, 15
	call FadeToWhite
	call ClearScreen
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	jp ApplyAttrAndTilemapInVBlank

.TooMuchTimeHasElapsed:
	; Too much time has elapsed. Please try again.
	text_jump UnknownText_0x1c4183
	db "@"

Function283f2:
	ld a, $1
	ldh [hSerialIgnoringInitialData], a
.loop
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	push bc
	ld b, a
	inc hl
	ld a, 48
.delay_cycles
	dec a
	jr nz, .delay_cycles
	ldh a, [hSerialIgnoringInitialData]
	and a
	ld a, b
	pop bc
	jr z, .load
	dec hl
	xor a
	ldh [hSerialIgnoringInitialData], a
	jr .loop

.load
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

String_PleaseWait:
	db "Please wait!@"

ClearLinkData:
	ld hl, wLinkData
	ld bc, wLinkDataEnd - wLinkData
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

FixDataForLinkTransfer:
	ld hl, wLinkBuffer
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, wLinkBattleRNs - wLinkBuffer
.loop1
	ld [hli], a
	dec b
	jr nz, .loop1
	ld b, wLinkBattleEarlyEnd - wLinkBattleRNs
.loop2
	call Random
	cp SERIAL_PREAMBLE_BYTE
	jr nc, .loop2
	ld [hli], a
	dec b
	jr nz, .loop2
	ld hl, wLinkMisc
	ld a, SERIAL_PREAMBLE_BYTE
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld b, $c8
	xor a
.loop3
	ld [hli], a
	dec b
	jr nz, .loop3
	ld hl, wLinkPlayerPartyMon1ID - 1
	ld de, wLinkPlayerFixedPartyMon1ID
	lb bc, 0, 0
.loop4
	inc c
	ld a, c
	cp SERIAL_PREAMBLE_BYTE
	jr z, .next1
	ld a, b
	dec a
	jr nz, .next2
	push bc
	ld b, $27
	ld a, c
	cp b
	pop bc
	jr z, .done
.next2
	inc hl
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .loop4
	ld a, c
	ld [de], a
	inc de
	ld [hl], SERIAL_PATCH_LIST_PART_TERMINATOR
	jr .loop4

.next1
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	inc de
	lb bc, 1, 0
	jr .loop4

.done
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	ret

Link_PrepPartyData_Gen2:
	ld de, wLinkData
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, 6
.loop1
	ld [de], a
	inc de
	dec b
	jr nz, .loop1
	; de = $c806
	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes
	; de = $c811
	ld hl, wPartyCount
	ld bc, 1 + PARTY_LENGTH + 1
	rst CopyBytes
	; de = $c819
	ld hl, wPlayerID
	ld bc, 2
	rst CopyBytes
	; de = $c81b
	ld hl, wPartyMon1Species
	ld bc, PARTY_LENGTH * PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	; de = $c93b
	ld hl, wPartyMonOT
	ld bc, PARTY_LENGTH * NAME_LENGTH
	rst CopyBytes
	; de = $c97d
	ld hl, wPartyMonNicknames
	ld bc, PARTY_LENGTH * PKMN_NAME_LENGTH
	rst CopyBytes
	; de = $c9bf

; Okay, we did all that.  Now, are we in the trade center?
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	ret nz

; Fill 5 bytes at wc9f4 with $20
	ld de, wc9f4
	ld a, $20
	ld c, 5
.wc9f4_loop
	ld [de], a
	inc de
	dec c
	jr nz, .wc9f4_loop

; Copy all the mail messages to wc9f9
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld hl, sPartyMail
	ld b, PARTY_LENGTH
.loop2
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	rst CopyBytes
	ld bc, sPartyMon1MailEnd - sPartyMon1MailAuthor
	add hl, bc
	pop bc
	dec b
	jr nz, .loop2
; Copy the mail metadata to wcabf
	ld hl, sPartyMail
	ld b, PARTY_LENGTH
.loop3
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	add hl, bc
	ld bc, sPartyMon1MailEnd - sPartyMon1MailAuthor
	rst CopyBytes
	pop bc
	dec b
	jr nz, .loop3

	ld b, PARTY_LENGTH
	ld de, sPartyMail
	ld hl, wc9f9
.loop4
	push bc
	push hl
	ld de, MAIL_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld bc, sPartyMon1MailAuthor - sPartyMon1Mail
	add hl, bc
	pop bc
	dec b
	jr nz, .loop4
	call CloseSRAM
	ld hl, wc9f9
	ld bc, PARTY_LENGTH * (sPartyMon1MailAuthor - sPartyMon1Mail)
.loop5
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .skip2
	ld [hl], sPartyMon1MailAuthor - sPartyMon1Mail

.skip2
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop5
	ld hl, wcabf
	ld de, wcb13
	lb bc, PARTY_LENGTH * (sPartyMon1MailEnd - sPartyMon1MailAuthor), $0
.loop6
	inc c
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .skip3
	ld [hl], SERIAL_PATCH_LIST_PART_TERMINATOR
	ld a, c
	ld [de], a
	inc de

.skip3
	inc hl
	dec b
	jr nz, .loop6
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	ret

Link_CopyOTData:
.loop
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

Link_CopyRandomNumbers:
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret z
	ld hl, wLinkBufferEnd
	call Link_FindFirstNonControlCharacter_AllowZero
	ld de, wLinkBattleRNs
	ld c, 10
.loop
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

Link_FindFirstNonControlCharacter_SkipZero:
.loop
	ld a, [hli]
	and a
	jr z, .loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	dec hl
	ret

Link_FindFirstNonControlCharacter_AllowZero:
.loop
	ld a, [hli]
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	dec hl
	ret

Link_WaitBGMap:
	call ApplyTilemapInVBlank
	jp ApplyAttrAndTilemapInVBlank

InitTradeMenuDisplay:
	call ClearScreen
	call LoadTradeScreenGFX
	call InitTradeSpeciesList
	xor a
	ld hl, wOtherPlayerLinkMode
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, 1
	ld [wMenuCursorY], a
	inc a
	ld [wPlayerLinkAction], a
	jp LinkTrade_PlayerPartyMenu

InitTradeSpeciesList:
	ld hl, .TradeScreenTilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst CopyBytes
	call InitLinkTradePalMap
	call PlaceTradePartnerNamesAndParty
	hlcoord 10, 17
	ld de, .Cancel
	jp _PlaceString

.TradeScreenTilemap:
INCBIN "gfx/link_trade/16d465.tilemap"

.Cancel:
	db "Cancel@"

PlaceTradePartnerNamesAndParty:
	hlcoord 4, 0
	ld de, wPlayerName
	rst PlaceString
	ld a, $14
	ld [bc], a
	hlcoord 4, 8
	ld de, wOTPlayerName
	rst PlaceString
	ld a, $14
	ld [bc], a
	hlcoord 7, 1
	ld a, [wPartyCount]
	ld de, wPartyMons
	call .PlaceSpeciesNames
	hlcoord 7, 9
	ld a, [wOTPartyCount]
	ld de, wOTPartyMons
.PlaceSpeciesNames:
	push bc
	ld b, a
	ld c, 0
.loop
	push hl
	push bc
	ld hl, MON_IS_EGG
	add hl, de
	ld a, c
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_species
	ld hl, MON_SPECIES
	add hl, de
	pop bc
	push bc
	ld a, c
	call GetPartyLocation
	ld a, [hl]
.got_species
	pop bc
	pop hl
	ld [wd265], a
	push bc
	push hl
	push de
	push hl
	ld a, c
	ldh [hProduct], a
	call GetPokemonName
	pop hl
	rst PlaceString
	pop de
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	inc c
	dec b
	jr nz, .loop
	pop bc
	ret

LinkTrade_OTPartyMenu:
	ld a, OTPARTYMON
	ld [wMonType], a
	ld a, A_BUTTON | D_UP | D_DOWN
	ld [wMenuJoypadFilter], a
	ld a, [wOTPartyCount]
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 9
	ld [w2DMenuCursorInitY], a
	ld a, 6
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorX], a
	ln a, 1, 0
	ld [w2DMenuCursorOffsets], a
	ld a, $20
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a

LinkTradeOTPartymonMenuLoop:
	call LinkTradeMenu
	ld a, d
	and a
	jp z, LinkTradePartiesMenuMasterLoop
	bit A_BUTTON_F, a
	jr z, .not_a_button
	ld hl, wOTPartyCount
	ld de, wOTPartyMonOT
	ld a, ENEMY_OT_NAME
	ld [wNamedObjectTypeBuffer], a
	ld hl, wOTPartyMon1Species
	call LinkMonStatsScreen
	call InitLinkTradePalMap
	call ApplyAttrAndTilemapInVBlank
	jp LinkTradePartiesMenuMasterLoop

.not_a_button
	bit D_UP_F, a
	jr z, .not_d_up
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jp nz, LinkTradePartiesMenuMasterLoop
	xor a
	ld [wMonType], a
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
	ld a, [wPartyCount]
	ld [wMenuCursorY], a
	jr LinkTrade_PlayerPartyMenu

.not_d_up
	bit D_DOWN_F, a
	jp z, LinkTradePartiesMenuMasterLoop
	jp Function28ac9

LinkMonStatsScreen:
	ld a, [wMenuCursorY]
	dec a
	ld [wCurPartyMon], a
	call LowVolume
	predef StatsScreenInit
	ld a, [wCurPartyMon]
	inc a
	ld [wMenuCursorY], a
	call ClearScreen
	call ClearBGPalettes
	call MaxVolume
	call LoadTradeScreenGFX
	call Link_WaitBGMap
	call InitTradeSpeciesList
	call SetTradeRoomBGPals
	jp ApplyAttrAndTilemapInVBlank

LinkTrade_PlayerPartyMenu:
	call InitLinkTradePalMap
	xor a
	ld [wMonType], a
	ld a, A_BUTTON | D_UP | D_DOWN
	ld [wMenuJoypadFilter], a
	ld a, [wPartyCount]
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 1
	ld [w2DMenuCursorInitY], a
	ld a, 6
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorX], a
	ln a, 1, 0
	ld [w2DMenuCursorOffsets], a
	ld a, $20
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	call ApplyAttrAndTilemapInVBlank

LinkTradePartymonMenuLoop:
	call LinkTradeMenu
	ld a, d
	and a
	jr nz, .check_joypad
	jp LinkTradePartiesMenuMasterLoop

.check_joypad
	bit A_BUTTON_F, a
	jr z, .not_a_button
	jp Function28926

.not_a_button
	bit D_DOWN_F, a
	jr z, .not_d_down
	ld a, [wMenuCursorY]
	dec a
	jp nz, LinkTradePartiesMenuMasterLoop
	ld a, OTPARTYMON
	ld [wMonType], a
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
	ld a, 1
	ld [wMenuCursorY], a
	jp LinkTrade_OTPartyMenu

.not_d_down
	bit D_UP_F, a
	jr z, LinkTradePartiesMenuMasterLoop
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wPartyCount]
	cp b
	jr nz, LinkTradePartiesMenuMasterLoop
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
	jp Function28ade

LinkTradePartiesMenuMasterLoop:
	ld a, [wMonType]
	and a
	jp z, LinkTradePartymonMenuLoop ; PARTYMON
	jp LinkTradeOTPartymonMenuLoop  ; OTPARTYMON

LinkTradeMenu:
	ld hl, w2DMenuFlags2
	res 7, [hl]
	ldh a, [hBGMapMode]
	push af
	call .loop
	pop af
	ldh [hBGMapMode], a
.GetJoypad:
	push bc
	push af
	ldh a, [hJoyLast]
	and D_PAD
	ld b, a
	ldh a, [hJoyPressed]
	and BUTTONS
	or b
	ld b, a
	pop af
	ld a, b
	pop bc
	ld d, a
	ret

.loop
	call .UpdateCursor
	call .UpdateBGMapAndOAM
	call .loop2
	ret nc
	farcall _2DMenuInterpretJoypad
	ret c
	ld a, [w2DMenuFlags1]
	bit 7, a
	ret nz
	call .GetJoypad
	ld b, a
	ld a, [wMenuJoypadFilter]
	and b
	jr z, .loop
	ret

.UpdateBGMapAndOAM:
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a
	call ApplyTilemapInVBlank
	pop af
	ldh [hOAMUpdate], a
	xor a
	ldh [hBGMapMode], a
	ret

.loop2
	call RTC
	call .TryAnims
	ret c
	ld a, [w2DMenuFlags1]
	bit 7, a
	jr z, .loop2
	and a
	ret

.UpdateCursor:
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	cp $1f
	jr nz, .not_currently_selected
	ld a, [wCursorOffCharacter]
	ld [hl], a
	push hl
	push bc
	ld bc, PKMN_NAME_LENGTH
	add hl, bc
	ld [hl], a
	pop bc
	pop hl

.not_currently_selected
	ld a, [w2DMenuCursorInitY]
	ld b, a
	ld a, [w2DMenuCursorInitX]
	ld c, a
	call Coord2Tile
	ld a, [w2DMenuCursorOffsets]
	swap a
	and $f
	ld c, a
	ld a, [wMenuCursorY]
	ld b, a
	xor a
	dec b
	jr z, .skip
.loop3
	add c
	dec b
	jr nz, .loop3

.skip
	ld c, SCREEN_WIDTH
	rst AddNTimes
	ld a, [w2DMenuCursorOffsets]
	and $f
	ld c, a
	ld a, [wMenuCursorX]
	ld b, a
	xor a
	dec b
	jr z, .skip2
.loop4
	add c
	dec b
	jr nz, .loop4

.skip2
	ld c, a
	add hl, bc
	ld a, [hl]
	cp $1f
	jr z, .cursor_already_there
	ld [wCursorOffCharacter], a
	ld [hl], $1f
	push hl
	push bc
	ld bc, PKMN_NAME_LENGTH
	add hl, bc
	ld [hl], $1f
	pop bc
	pop hl
.cursor_already_there
	ld a, l
	ld [wCursorCurrentTile], a
	ld a, h
	ld [wCursorCurrentTile + 1], a
	ret

.TryAnims:
	ld a, [w2DMenuFlags1]
	bit 6, a
	jr z, .skip_anims
	farcall PlaySpriteAnimationsAndDelayFrame
.skip_anims
	call JoyTextDelay
	call .GetJoypad
	and a
	ret z
	scf
	ret

Function28926:
	call LoadTileMapToTempTileMap
	ld a, [wMenuCursorY]
	push af
	hlcoord 0, 15
	lb bc, 1, 18
	call LinkTextbox
	hlcoord 2, 16
	ld de, .String_Stats_Trade
	rst PlaceString
	call Link_WaitBGMap

.joy_loop
	ld a, " "
	ldcoord_a 11, 16
	ld a, A_BUTTON | B_BUTTON | D_RIGHT
	ld [wMenuJoypadFilter], a
	ld a, 1
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 16
	ld [w2DMenuCursorInitY], a
	ld a, 1
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	ln a, 2, 0
	ld [w2DMenuCursorOffsets], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	call DoMenuJoypadLoop
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit B_BUTTON_F, a
	jr z, .show_stats
.b_button
	pop af
	ld [wMenuCursorY], a
	call Call_LoadTempTileMapToTileMap
	jp LinkTrade_PlayerPartyMenu

.d_right
	ld a, " "
	ldcoord_a 1, 16
	ld a, A_BUTTON | B_BUTTON | D_LEFT
	ld [wMenuJoypadFilter], a
	ld a, 1
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 16
	ld [w2DMenuCursorInitY], a
	ld a, 11
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	ln a, 2, 0
	ld [w2DMenuCursorOffsets], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	call DoMenuJoypadLoop
	bit D_LEFT_F, a
	jp nz, .joy_loop
	bit B_BUTTON_F, a
	jr nz, .b_button
	jr .try_trade

.show_stats
	pop af
	ld [wMenuCursorY], a
	ld hl, wPartyCount
	ld de, wPartyMonOT
	ld a, PARTY_OT_NAME
	ld [wNamedObjectTypeBuffer], a
	call LinkMonStatsScreen
	call Call_LoadTempTileMapToTileMap
	hlcoord 6, 1
	lb bc, 6, 1
	ld a, " "
	call LinkEngine_FillBox
	hlcoord 17, 1
	lb bc, 6, 1
	ld a, " "
	call LinkEngine_FillBox
	jp LinkTrade_PlayerPartyMenu

.try_trade
	call PlaceHollowCursor
	pop af
	ld [wMenuCursorY], a
	dec a
	ld [wd002], a
	ld [wPlayerLinkAction], a
	call Function16d6ce
	ld a, [wOtherPlayerLinkMode]
	cp $f
	jp z, InitTradeMenuDisplay
	ld [wd003], a
	ld a, [wOtherPlayerLinkMode]
	hlcoord 6, 9
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	ld [hl], "▷"
	ld c, 100
	call DelayFrames
	call ValidateOTTrademon
	jr c, .abnormal
	call Functionfb5dd
	jp nc, LinkTrade
	xor a
	ld [wcf57], a
	ld [wOtherPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	call Link_WaitBGMap
	ld hl, .Text_CantTradeLastMon
	bccoord 1, 14
	call PlaceWholeStringInBoxAtOnce
	jr .cancel_trade

.abnormal
	xor a
	ld [wcf57], a
	ld [wOtherPlayerLinkAction], a
	ld a, [wd003]
	ld hl, wOTPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_ot_species
	ld a, [wd003]
	ld hl, wOTPartySpecies
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
.got_ot_species
	ld [wd265], a
	call GetPokemonName
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	call Link_WaitBGMap
	ld hl, .Text_Abnormal
	bccoord 1, 14
	call PlaceWholeStringInBoxAtOnce

.cancel_trade
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	rst PlaceString
	ld a, $1
	ld [wPlayerLinkAction], a
	call Function16d6ce
	ld c, 100
	call DelayFrames
	jp InitTradeMenuDisplay

.Text_CantTradeLastMon:
	; If you trade that #MON, you won't be able to battle.
	text_jump UnknownText_0x1c41b1
	db "@"

.String_Stats_Trade:
	db "Stats     Trade@"

.Text_Abnormal:
	; Your friend's @  appears to be abnormal!
	text_jump UnknownText_0x1c41e6
	db "@"

ValidateOTTrademon:
	ld a, [wd003]
	ld hl, wOTPartyMon1Species
	call GetPartyLocation
	push hl
	ld a, [wd003]
	inc a
	ld c, a
	ld b, 0
	ld hl, wOTPartyCount
	add hl, bc
	ld a, [hl]
	pop hl
	cp [hl]
	jr nz, .abnormal

	ld b, h
	ld c, l
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	cp MAX_LEVEL + 1
	jr nc, .abnormal
	and a
	ret

.abnormal
	scf
	ret

Functionfb5dd:
	ld a, [wd002]
	ld d, a
	ld a, [wPartyCount]
	ld b, a
	ld c, $0
.loop
	ld a, c
	cp d
	jr z, .next
	ld a, c
	ld hl, wPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	jr nz, .done

.next
	inc c
	dec b
	jr nz, .loop
	ld a, [wd003]
	ld hl, wOTPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	jr nz, .done
	scf
	ret

.done
	and a
	ret

Function28ac9:
	ld a, [wMenuCursorY]
	cp 1
	jp nz, LinkTradePartiesMenuMasterLoop
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
Function28ade:
.loop1
	ld a, "▶"
	ldcoord_a 9, 17
.loop2
	call JoyTextDelay
	ldh a, [hJoyLast]
	and a
	jr z, .loop2
	bit A_BUTTON_F, a
	jr nz, .a_button
	push af
	ld a, " "
	ldcoord_a 9, 17
	pop af
	bit D_UP_F, a
	jr z, .d_up
	ld a, [wOTPartyCount]
	ld [wMenuCursorY], a
	jp LinkTrade_OTPartyMenu

.d_up
	ld a, $1
	ld [wMenuCursorY], a
	jp LinkTrade_PlayerPartyMenu

.a_button
	ld a, "▷"
	ldcoord_a 9, 17
	ld a, $f
	ld [wPlayerLinkAction], a
	call Function16d6ce
	ld a, [wOtherPlayerLinkMode]
	cp $f
	jr nz, .loop1
Function28b22:
	ld c, 15
	call FadeToWhite
	call ClearScreen
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call ApplyAttrAndTilemapInVBlank
	xor a
	ldh [rSB], a
	ldh [hSerialSend], a
	ld a, $1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a
	ret

LinkEngine_FillBox:
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

LinkTrade:
	xor a
	ld [wcf57], a
	ld [wOtherPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	call Link_WaitBGMap
	ld a, [wd002]
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_party_species
	ld a, [wd002]
	ld hl, wPartySpecies
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
.got_party_species
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wd004
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes
	ld a, [wd003]
	ld hl, wOTPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_ot_species
	ld a, [wd003]
	ld hl, wOTPartySpecies
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
.got_ot_species
	ld [wd265], a
	call GetPokemonName
	ld hl, .TradeThisForThat
	bccoord 1, 14
	call PlaceWholeStringInBoxAtOnce
	call LoadStandardMenuDataHeader
	hlcoord 10, 7
	lb bc, 3, 7
	call LinkTextbox
	ld de, .TradeCancel
	hlcoord 12, 8
	rst PlaceString
	ld a, 8
	ld [w2DMenuCursorInitY], a
	ld a, 11
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 2
	ld [w2DMenuNumRows], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ld a, 1
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	call Link_WaitBGMap
	call DoMenuJoypadLoop
	push af
	call ExitMenu
	call ApplyAttrAndTilemapInVBlank
	pop af
	bit 1, a
	jr nz, .asm_28c33
	ld a, [wMenuCursorY]
	dec a
	jr z, .asm_28c54

.asm_28c33
	ld a, $1
	ld [wPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	rst PlaceString
	call Function16d6ce
	jr .asm_28ea3

.asm_28c54
	ld a, $2
	ld [wPlayerLinkAction], a
	call Function16d6ce
	ld a, [wOtherPlayerLinkMode]
	dec a
	jr nz, .asm_28c7b
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	rst PlaceString
.asm_28ea3
	ld c, 100
	call DelayFrames
	jp InitTradeMenuDisplay

.asm_28c7b
	ld hl, sPartyMail
	ld a, [wd002]
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld d, h
	ld e, l
	ld bc, MAIL_STRUCT_LENGTH
	add hl, bc
	ld a, [wd002]
	ld c, a
.asm_28c96
	inc c
	ld a, c
	cp $6
	jr z, .asm_28ca6
	push bc
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	pop bc
	jr .asm_28c96

.asm_28ca6
	ld hl, sPartyMail
	ld a, [wPartyCount]
	dec a
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	push hl
	ld hl, wc9f4
	ld a, [wd003]
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	pop de
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	call CloseSRAM
	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld a, [wd002]
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_tradeparty_species
	ld a, [wd002]
	ld hl, wPartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
.got_tradeparty_species
	ld [wPlayerTrademonSpecies], a
	push af
	ld a, [wd002]
	ld hl, wPartyMonOT
	call SkipNames
	ld de, wPlayerTrademonOTName
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld hl, wPartyMon1ID
	ld a, [wd002]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonID], a
	ld a, [hl]
	ld [wPlayerTrademonID + 1], a
	ld hl, wPartyMon1DVs
	ld a, [wd002]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonDVs], a
	ld a, [hli]
	ld [wPlayerTrademonDVs + 1], a
	ld a, [hl]
	ld [wPlayerTrademonDVs + 2], a
	ld hl, wPartyMon1Species
	ld a, [wd002]
	call GetPartyLocation
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld [wPlayerTrademonCaughtData], a
	ld hl, wOTPlayerName
	ld de, wOTTrademonSenderName
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld a, [wd003]
	ld hl, wOTPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_tradeot_species
	ld a, [wd003]
	ld hl, wOTPartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
.got_tradeot_species
	ld [wOTTrademonSpecies], a
	ld a, [wd003]
	ld hl, wOTPartyMonOT
	call SkipNames
	ld de, wOTTrademonOTName
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld hl, wOTPartyMon1ID
	ld a, [wd003]
	call GetPartyLocation
	ld a, [hli]
	ld [wOTTrademonID], a
	ld a, [hl]
	ld [wOTTrademonID + 1], a
	ld hl, wOTPartyMon1DVs
	ld a, [wd003]
	call GetPartyLocation
	ld a, [hli]
	ld [wOTTrademonDVs], a
	ld a, [hli]
	ld [wOTTrademonDVs + 1], a
	ld a, [hl]
	ld [wOTTrademonDVs + 2], a
	ld hl, wOTPartyMon1Species
	ld a, [wd003]
	call GetPartyLocation
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld [wOTTrademonCaughtData], a
	ld a, [wd002]
	ld [wCurPartyMon], a
	ld hl, wPartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd002], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromPartyOrBox
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld a, $1
	ld [wForceEvolution], a
	ld a, [wd003]
	push af
	ld hl, wOTPartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd003], a
	ld c, 100
	call DelayFrames
	call ClearTileMap
	call LoadFontsBattleExtra
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player_2
	predef TradeAnimation
	jr .done_animation
.player_2
	farcall TradeAnimationPlayer2
.done_animation
	pop af
	ld c, a
	ld [wCurPartyMon], a
	ld hl, wOTPartySpecies
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld hl, wOTPartyMon1Species
	ld a, c
	call GetPartyLocation
	ld de, wTempMonSpecies
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	farcall AddTempmonToParty
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall EvolvePokemon
	call ClearScreen
	call LoadTradeScreenGFX
	call SetTradeRoomBGPals
	call Link_WaitBGMap
	ld b, $1
	pop af
	ld c, a
	cp MEW
	jr z, .loop
	ld a, [wCurPartySpecies]
	cp MEW
	jr z, .loop
	ld b, $2
	ld a, c
	cp CELEBI
	jr z, .loop
	ld a, [wCurPartySpecies]
	cp CELEBI
	jr z, .loop
	ld b, $0

.loop
	ld a, b
	ld [wPlayerLinkAction], a
	push bc
	call Serial_PlaceWaitingTextAndSyncAndExchangeNybble
	pop bc
	ld a, b
	and a
	jr z, .save
	ld a, [wOtherPlayerLinkAction]
	cp b
	jr nz, .loop

.save
	farcall SaveAfterLinkTrade
	ld c, 40
	call DelayFrames
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	hlcoord 1, 14
	ld de, .TradeCompleted
	rst PlaceString
	call Link_WaitBGMap
	ld c, 50
	call DelayFrames
	jp Gen2ToGen2LinkComms

.TradeCancel:
	db   "Trade"
	next "Cancel@"

.TradeThisForThat:
	; Trade @ for @ ?
	text_jump UnknownText_0x1c4212
	db "@"

.TradeCompleted:
	db   "Trade completed!@"

String_TooBadTheTradeWasCanceled:
	db   "Too bad! The trade"
	next "was canceled!@"

LinkTextbox::
	push bc
	push hl

	push hl
	ld a, $30
	ld [hli], a
	inc a ; $31
	call .fill_row
	inc a ; $32
	ld [hl], a
	pop hl

	ld de, SCREEN_WIDTH
	add hl, de
.loop
	push hl
	ld a, $33
	ld [hli], a
	ld a, " "
	call .fill_row
	ld [hl], $34
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .loop

	ld a, $35
	ld [hli], a
	inc a ; $36
	call .fill_row
	inc a ; $37
	ld [hl], a

	pop hl
	pop bc
	ld de, wAttrMap - wTileMap
	add hl, de
	inc b
	inc b
	inc c
	inc c
	ld a, $7
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop bc
	dec b
	jr nz, .row
	ret

.fill_row:
	ld d, c
.row_loop
	ld [hli], a
	dec d
	jr nz, .row_loop
	ret

Function16d6ce:
	call LoadStandardMenuDataHeader
	hlcoord 5, 10
	lb bc, 1, 9
	call LinkTextbox
	hlcoord 6, 11
	ld de, .Waiting
	rst PlaceString
	call ApplyTilemapInVBlank
	call ApplyAttrAndTilemapInVBlank
	ld c, 50
	call DelayFrames
	call Serial_SyncAndExchangeNybble
	call ExitMenu
	jp ApplyAttrAndTilemapInVBlank

.Waiting:
	db "Waiting…!@"

LoadTradeScreenGFX:
	ld hl, TradeScreenGFX
	ld de, vTiles2
	lb bc, BANK(TradeScreenGFX), 70
	jp DecompressRequest2bpp

TradeScreenGFX:
INCBIN "gfx/link_trade/border.2bpp.lz"

SetTradeRoomBGPals:
	farcall LoadLinkTradePalette
	farcall ApplyPals
	jp SetPalettes

INCLUDE "engine/movie/trade_animation.asm"

WaitForOtherPlayerToExit:
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	xor a
	ldh [rSB], a
	ldh [hSerialReceive], a
	ld a, $1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a
	ld c, 3
	call DelayFrames
	xor a
	ldh [rSB], a
	ldh [hSerialReceive], a
	xor a ; redundant?
	ldh [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ldh [rSC], a
	ld c, 3
	call DelayFrames
	xor a
	ldh [rSB], a
	ldh [hSerialReceive], a
	ldh [rSC], a
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ldh a, [rIF]
	push af
	xor a
	ldh [rIF], a
	ld a, %01011
	ldh [rIE], a
	pop af
	ldh [rIF], a
	ld hl, wLinkTimeoutFrames
	xor a
	ld [hli], a
	ld [hl], a
	ldh [hVBlank], a
	ld [wLinkMode], a
	ret

Special_SetBitsForLinkTradeRequest:
	ld a, LINK_TRADECENTER - 1
	ld [wPlayerLinkAction], a
	ld [wd265], a
	ret

Special_SetBitsForBattleRequest:
	ld a, LINK_COLOSSEUM - 1
	ld [wPlayerLinkAction], a
	ld [wd265], a
	ret

Special_WaitForLinkedFriend:
	ld a, [wPlayerLinkAction]
	and a
	jr z, .no_link_action
	ld a, $2
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	xor a ; redundant?
	ldh [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ldh [rSC], a
	call DelayFrame
	call DelayFrame
	call DelayFrame

.no_link_action
	ld a, $2
	ld [wLinkTimeoutFrames + 1], a
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [wLinkTimeoutFrames], a
.loop
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .connected
	cp USING_EXTERNAL_CLOCK
	jr z, .connected
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ld a, $2
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	xor a ; redundant?
	ldh [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ldh [rSC], a
	ld a, [wLinkTimeoutFrames]
	dec a
	ld [wLinkTimeoutFrames], a
	jr nz, .not_done
	ld a, [wLinkTimeoutFrames + 1]
	dec a
	ld [wLinkTimeoutFrames + 1], a
	jr z, .done

.not_done
	ld a, $1
	ldh [rSB], a
	ld a, $1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a
	call DelayFrame
	jr .loop

.connected
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	ld c, $32
	call DelayFrames
	ld a, $1
	ldh [hScriptVar], a
	ret

.done
	xor a
	ldh [hScriptVar], a
	ret

Special_CheckLinkTimeout:
	ld a, $1
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, $3
	ld [hli], a
	xor a
	ld [hl], a
	call ApplyTilemapInVBlank
	ld a, $2
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
	call Link_CheckCommunicationError
	xor a
	ldh [hVBlank], a
	ldh a, [hScriptVar]
	and a
	ret nz
	jp Link_ResetSerialRegistersAfterLinkClosure

Function29dba:
	ld a, $5
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, $3
	ld [hli], a
	xor a
	ld [hl], a
	call ApplyTilemapInVBlank
	ld a, $2
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
	call Link_CheckCommunicationError
	ldh a, [hScriptVar]
	and a
	jr z, .vblank
	ld bc, -1
.wait
	dec bc
	ld a, b
	or c
	jr nz, .wait
	ld a, [wOtherPlayerLinkMode]
	cp $5
	jr nz, .script_var
	ld a, $6
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, $1
	ld [hli], a
	ld [hl], $32
	call Link_CheckCommunicationError
	ld a, [wOtherPlayerLinkMode]
	cp $6
	jr z, .vblank

.script_var
	xor a
	ldh [hScriptVar], a
	ret

.vblank
	xor a
	ldh [hVBlank], a
	ret

Link_CheckCommunicationError:
	xor a
	ldh [hSerialReceivedNewData], a
	ld hl, wLinkTimeoutFrames + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	push hl
	call .CheckConnected
	pop hl
	jr nz, .load_true
	call .AcknowledgeSerial
	call .ConvertDW
	call .CheckConnected
	jr nz, .load_true
	call .AcknowledgeSerial
	xor a
	jr .load_scriptvar

.load_true
	ld a, $1

.load_scriptvar
	ldh [hScriptVar], a
	ld hl, wLinkTimeoutFrames
	xor a
	ld [hli], a
	ld [hl], a
	ret

.CheckConnected:
	call Serial_SyncAndExchangeNybble
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	inc a
	ret nz
	ld a, [hl]
	inc a
	ret

.AcknowledgeSerial:
	ld b, $a
.loop
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .loop
	ret

.ConvertDW:
	dec h
	srl h
	rr l
	srl h
	rr l
	inc h
	ld a, h
	ld [wLinkTimeoutFrames], a
	ld a, l
	ld [wLinkTimeoutFrames + 1], a
	ret

Special_TryQuickSave:
	ld a, [wd265]
	push af
	farcall Link_SaveGame
	ld a, $1
	jr nc, .return_result
	xor a
.return_result
	ldh [hScriptVar], a
	pop af
	ld [wd265], a
	ret

Special_CheckBothSelectedSameRoom:
	ld a, [wd265]
	call Link_EnsureSync
	push af
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	pop af
	ld b, a
	ld a, [wd265]
	cp b
	jr nz, .fail
	ld a, [wd265]
	inc a
	ld [wLinkMode], a
	xor a
	ldh [hVBlank], a
	ld a, $1
	ldh [hScriptVar], a
	ret

.fail
	xor a
	ldh [hScriptVar], a
	ret

Special_TradeCenter:
	ld a, LINK_TRADECENTER
	jr _Special_LinkCommunications

Special_Colosseum:
	ld a, LINK_COLOSSEUM
_Special_LinkCommunications:
	ld [wLinkMode], a
	call DisableSpriteUpdates
	call LinkCommunications
	call EnableSpriteUpdates
	xor a
	ldh [hVBlank], a
	ret

Special_CloseLink:
	xor a
	ld [wLinkMode], a
	ld c, $3
	call DelayFrames
	jp Link_ResetSerialRegistersAfterLinkClosure

Special_FailedLinkToPast:
	ld c, 40
	call DelayFrames
	ld a, $e
	jp Link_EnsureSync

Link_ResetSerialRegistersAfterLinkClosure:
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ld a, $2
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	ldh [rSC], a
	ret

Link_EnsureSync:
	add $d0
	ld [wPlayerLinkAction], a
	ld [wcf57], a
	ld a, $2
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
.receive_loop
	call Serial_ExchangeLinkMenuSelection
	ld a, [wOtherPlayerLinkMode]
	ld b, a
	and $f0
	cp $d0
	jr z, .done
	ld a, [wOtherPlayerLinkAction]
	ld b, a
	and $f0
	cp $d0
	jr nz, .receive_loop

.done
	xor a
	ldh [hVBlank], a
	ld a, b
	and $f
	ret

Special_CableClubCheckWhichChris:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	ld a, $1
	jr z, .yes
	dec a

.yes
	ldh [hScriptVar], a
	ret

DetermineLinkBattleResult:
	call UpdateEnemyMonInParty
	ld hl, wPartyMon1HP
	call .CountMonsRemaining
	push bc
	ld hl, wOTPartyMon1HP
	call .CountMonsRemaining
	ld a, c
	pop bc
	cp c
	jr z, .even_number_of_mons_remaining
	jr c, .defeat
	jr .victory

.even_number_of_mons_remaining
	call .BothSides_CheckNumberMonsAtFullHealth
	jr z, .drawn
	ld a, e
	cp $1
	jr z, .victory
	cp $2
	jr z, .defeat
	ld hl, wPartyMon1HP
	call .CalcPercentHPRemaining
	push de
	ld hl, wOTPartyMon1HP
	call .CalcPercentHPRemaining
	pop hl
	ld a, d
	cp h
	jr c, .victory
	jr z, .compare_lo
	jr .defeat

.compare_lo
	ld a, e
	cp l
	jr z, .drawn
	jr nc, .defeat

.victory
	ld a, [wBattleResult]
	and $f0
	ld [wBattleResult], a
	ret

.defeat
	ld a, [wBattleResult]
	and $f0
	add $1
	ld [wBattleResult], a
	ret

.drawn
	ld a, [wBattleResult]
	and $f0
	add $2
	ld [wBattleResult], a
	ret

.CountMonsRemaining:
	lb bc, 3, 0
	ld de, PARTYMON_STRUCT_LENGTH - 1
.loop
	ld a, [hli]
	or [hl]
	jr nz, .not_fainted
	inc c

.not_fainted
	add hl, de
	dec b
	jr nz, .loop
	ret

.CalcPercentHPRemaining:
	ld de, 0
	ld c, $3
.loop2
	ld a, [hli]
	or [hl]
	jr z, .next
	dec hl
	xor a
	ldh [hDividend + 0], a
	ld a, [hli]
	ldh [hDividend + 1], a
	ld a, [hli]
	ldh [hDividend + 2], a
	xor a
	ldh [hDividend + 3], a
	ld a, [hli]
	ld b, a
	ld a, [hld]
	srl b
	rra
	srl b
	rra
	ldh [hDivisor], a
	ld b, $4
	call Divide
	ldh a, [hQuotient + 2]
	add e
	ld e, a
	ldh a, [hQuotient + 1]
	adc d
	ld d, a
	dec hl

.next
	push de
	ld de, $2f
	add hl, de
	pop de
	dec c
	jr nz, .loop2
	ret

.BothSides_CheckNumberMonsAtFullHealth:
	ld hl, wPartyMon1HP
	call .CheckFaintedOrFullHealth
	jr nz, .finish ; we have a pokemon that's neither fainted nor at full health
	ld hl, wOTPartyMon1HP
	call .CheckFaintedOrFullHealth
	ld e, $1
	ret

.finish
	ld hl, wOTPartyMon1HP
	call .CheckFaintedOrFullHealth
	ld e, $0
	ret nz ; we both have pokemon that are neither fainted nor at full health
	ld e, $2
	ld a, $1
	and a
	ret

.CheckFaintedOrFullHealth:
	ld d, 3
.loop3
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	or b
	jr z, .fainted_or_full_health
	ld a, [hli]
	cp b
	ret nz
	ld a, [hld]
	cp c
	ret nz

.fainted_or_full_health
	push de
	ld de, PARTYMON_STRUCT_LENGTH - 2
	add hl, de
	pop de
	dec d
	jr nz, .loop3
	ret

InitLinkTradePalMap:
	hlcoord 0, 0, wAttrMap
	lb bc, 16, 2
	ld a, $4
	call .fill_box
	ld a, $3
	ldcoord_a 0, 1, wAttrMap
	ldcoord_a 0, 14, wAttrMap
	hlcoord 2, 0, wAttrMap
	lb bc, 8, 18
	ld a, $5
	call .fill_box
	hlcoord 2, 8, wAttrMap
	lb bc, 8, 18
	ld a, $6
	call .fill_box
	hlcoord 0, 16, wAttrMap
	lb bc, 2, SCREEN_WIDTH
	ld a, $4
	call .fill_box
	ld a, $3
	lb bc, 6, 1
	hlcoord 6, 1, wAttrMap
	call .fill_box
	ld a, $3
	lb bc, 6, 1
	hlcoord 17, 1, wAttrMap
	call .fill_box
	ld a, $3
	lb bc, 6, 1
	hlcoord 6, 9, wAttrMap
	call .fill_box
	ld a, $3
	lb bc, 6, 1
	hlcoord 17, 9, wAttrMap
	call .fill_box
	ld a, $2
	hlcoord 2, 16, wAttrMap
	ld [hli], a
	ld a, $7
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], $2
	hlcoord 2, 17, wAttrMap
	ld a, $3
	ld bc, 6
	jp _ByteFill

.fill_box:
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret
