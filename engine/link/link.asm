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
	ld hl, wLinkByteTimeout
	xor a
	ld [hli], a
	ld [hl], $50
	; fallthrough

Gen2ToGen2LinkComms:
	call ClearLinkData
	call Link_PrepPartyData_Gen2
	call FixDataForLinkTransfer
	call CheckLinkTimeout_Gen2
	ldh a, [hScriptVar]
	and a
	jp z, LinkTimeout
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .player_1

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

.player_1:
	ld de, MUSIC_NONE
	call PlayMusic
	ld c, 3
	call DelayFrames
	xor a
	ldh [rIF], a
	ld a, 1 << SERIAL
	ldh [rIE], a

	ld hl, wLinkBattleRNPreamble
	ld de, wEnemyMon
	ld bc, SERIAL_RN_PREAMBLE_LENGTH + SERIAL_RNS_LENGTH
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

	ld hl, wLinkData
	ld de, wOTPartyData
	ld bc, wOTPartyDataEnd - wOTPartyData
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
	ld hl, wLinkPlayerMail
	ld de, wLinkOTMail
	ld bc, wLinkPlayerMailEnd - wLinkPlayerMail
	call ExchangeBytes

.not_trading
	xor a
	ldh [rIF], a
	ld a, 1 << SERIAL | 1 << VBLANK
	ldh [rIE], a
	ld de, MUSIC_NONE
	call PlayMusic

	call Link_CopyRandomNumbers
	ld hl, wOTPartyData
	call Link_FindFirstNonControlCharacter_SkipZero
	ld de, wLinkData
	ld bc, NAME_LENGTH + 1 + PARTY_LENGTH + 1 + 2 + (PARTYMON_STRUCT_LENGTH + NAME_LENGTH * 2) * PARTY_LENGTH
	call Link_CopyOTData

	ld de, wPlayerTrademon
	ld hl, wLinkPatchList1
	ld c, 2
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
	ld b, 0
	dec a
	ld c, a
	add hl, bc
	ld [hl], SERIAL_NO_DATA_BYTE
	pop bc
	pop hl
	jr .loop1

.next1
	ld hl, wLinkPatchList2
	dec c
	jr nz, .loop1

	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jp nz, .skip_mail
	ld hl, wLinkOTMail
.loop2
	ld a, [hli]
	cp SERIAL_MAIL_PREAMBLE_BYTE
	jr nz, .loop2
.loop3
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop3
	cp SERIAL_MAIL_PREAMBLE_BYTE
	jr z, .loop3
	dec hl
	ld de, wLinkOTMail
	ld bc, wLinkDataEnd - wLinkOTMail
	rst CopyBytes
	ld hl, wLinkOTMail
	ld bc, (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
.loop4
	ld a, [hl]
	cp SERIAL_MAIL_REPLACEMENT_BYTE
	jr nz, .okay1
	ld [hl], SERIAL_NO_DATA_BYTE
.okay1
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop4
	ld de, wOTPlayerMailPatchSet
.loop5
	ld a, [de]
	inc de
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .start_copying_mail
	ld hl, wLinkOTMailMetadata
	dec a
	ld b, 0
	ld c, a
	add hl, bc
	ld [hl], SERIAL_NO_DATA_BYTE
	jr .loop5

.start_copying_mail
	ld hl, wLinkOTMail
	ld de, wLinkReceivedMail
	ld b, PARTY_LENGTH
.copy_mail_loop
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	rst CopyBytes
	ld a, LOW(MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1))
	add e
	ld e, a
	ld a, HIGH(MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1))
	adc d
	ld d, a
	pop bc
	dec b
	jr nz, .copy_mail_loop
	ld de, wLinkReceivedMail
	ld b, PARTY_LENGTH
.copy_author_loop
	push bc
	ld a, LOW(MAIL_MSG_LENGTH + 1)
	add e
	ld e, a
	ld a, HIGH(MAIL_MSG_LENGTH + 1)
	adc d
	ld d, a
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	rst CopyBytes
	pop bc
	dec b
	jr nz, .copy_author_loop
	ld b, PARTY_LENGTH
	ld de, wLinkReceivedMail
.fix_mail_loop
	push bc
	ld hl, MAIL_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop bc
	dec b
	jr nz, .fix_mail_loop
	ld de, wLinkReceivedMailEnd
	xor a
	ld [de], a

.skip_mail
	ld hl, wLinkPlayerName
	ld de, wOTPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes

	ld de, wOTPartyCount
	ld bc, 1 + PARTY_LENGTH + 1
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
	set LCD_STAT, a
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
	jp ExitLinkCommunications

.ready_to_trade
	ld de, MUSIC_ROUTE_30
	call PlayMusic
	jp InitTradeMenuDisplay

LinkTimeout:
	ld de, .LinkTimeoutText
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

.LinkTimeoutText:
	; Too much time has elapsed. Please try again.
	text_jump _LinkTimeoutText
	text_end

ExchangeBytes:
; This is similar to Serial_ExchangeBytes,
; but without a SERIAL_PREAMBLE_BYTE check.
	ld a, TRUE
	ldh [hSerialIgnoringInitialData], a
.loop
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	push bc
	ld b, a
	inc hl
	ld a, 48
.wait
	dec a
	jr nz, .wait
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
	ld hl, wLinkBattleRNPreamble
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, wLinkBattleRNs - wLinkBattleRNPreamble
.preamble_loop
	ld [hli], a
	dec b
	jr nz, .preamble_loop

	ld b, SERIAL_RNS_LENGTH
.rn_loop
	call Random
	cp SERIAL_PREAMBLE_BYTE
	jr nc, .rn_loop
	ld [hli], a
	dec b
	jr nz, .rn_loop

	ld hl, wPlayerPatchLists
	ld a, SERIAL_PREAMBLE_BYTE
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld b, 200
	xor a
.loop1
	ld [hli], a
	dec b
	jr nz, .loop1

	ld hl, wLinkPlayerPartyMon1ID - 1
	ld de, wLinkPlayerFixedPartyMon1ID
	lb bc, 0, 0
.loop2
	inc c
	ld a, c
	cp SERIAL_PATCH_LIST_LENGTH + 1
	jr z, .next1
	ld a, b
	dec a
	jr nz, .next2
	push bc
	ld b, 2 + PARTYMON_STRUCT_LENGTH * PARTY_LENGTH - SERIAL_PATCH_LIST_LENGTH + 1
	ld a, c
	cp b
	pop bc
	jr z, .done
.next2
	inc hl
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .loop2
	ld a, c
	ld [de], a
	inc de
	ld [hl], SERIAL_PATCH_LIST_PART_TERMINATOR
	jr .loop2

.next1
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	inc de
	lb bc, 1, 0
	jr .loop2

.done
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	ret

Link_PrepPartyData_Gen2:
	ld de, wLinkData
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, SERIAL_PREAMBLE_LENGTH
.loop1
	ld [de], a
	inc de
	dec b
	jr nz, .loop1

	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes

	ld hl, wPartyCount
	ld bc, 1 + PARTY_LENGTH + 1
	rst CopyBytes

	ld hl, wPlayerID
	ld bc, 2
	rst CopyBytes

	ld hl, wPartyMon1Species
	ld bc, PARTY_LENGTH * PARTYMON_STRUCT_LENGTH
	rst CopyBytes

	ld hl, wPartyMonOT
	ld bc, PARTY_LENGTH * NAME_LENGTH
	rst CopyBytes

	ld hl, wPartyMonNicknames
	ld bc, PARTY_LENGTH * MON_NAME_LENGTH
	rst CopyBytes

; Okay, we did all that.  Now, are we in the trade center?
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	ret nz

; Fill 5 bytes at wLinkPlayerMailPreamble with $20
	ld de, wLinkPlayerMailPreamble
	ld a, $20
	ld c, 5
.loop
	ld [de], a
	inc de
	dec c
	jr nz, .loop

; Copy all the mail messages to wLinkPlayerMailMessages
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld hl, sPartyMail
	ld b, PARTY_LENGTH
.loop2
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	rst CopyBytes
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	add hl, bc
	pop bc
	dec b
	jr nz, .loop2

; Copy the mail metadata to wLinkPlayerMailMetadata
	ld hl, sPartyMail
	ld b, PARTY_LENGTH
.loop3
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	add hl, bc
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	rst CopyBytes
	pop bc
	dec b
	jr nz, .loop3

	ld b, PARTY_LENGTH
	ld de, sPartyMail
	ld hl, wLinkPlayerMailMessages
.loop4
	push bc
	push hl
	ld de, MAIL_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld bc, MAIL_MSG_LENGTH + 1
	add hl, bc
	pop bc
	dec b
	jr nz, .loop4
	call CloseSRAM

	ld hl, wLinkPlayerMailMessages
	ld bc, (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
.loop5
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .skip2
	ld [hl], SERIAL_MAIL_REPLACEMENT_BYTE
.skip2
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop5

	ld hl, wLinkPlayerMailMetadata
	ld de, wLinkPlayerMailPatchSet
	lb bc, (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) * PARTY_LENGTH, 0
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
	ld hl, wEnemyMonSpecies
	call Link_FindFirstNonControlCharacter_AllowZero
	ld de, wLinkBattleRNs
	ld c, SERIAL_RNS_LENGTH
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
	rst PlaceString
	ret

.TradeScreenTilemap:
INCBIN "gfx/trade/border.tilemap"

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
	jp LinkTradeOTPartymonMenuCheckCancel

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
	jp z, LinkTradePartiesMenuMasterLoop
	bit A_BUTTON_F, a
	jp nz, LinkTrade_TradeStatsMenu
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
	jp LinkTradePartymonMenuCheckCancel

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
	ld bc, MON_NAME_LENGTH
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
	ld bc, MON_NAME_LENGTH
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

LinkTrade_TradeStatsMenu:
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
	call LinkMonStatsScreen
	call Call_LoadTempTileMapToTileMap
	hlcoord 6, 1
	lb bc, 6, 1
	call ClearBox
	hlcoord 17, 1
	lb bc, 6, 1
	call ClearBox
	jp LinkTrade_PlayerPartyMenu

.try_trade
	call PlaceHollowCursor
	pop af
	ld [wMenuCursorY], a
	dec a
	ld [wCurTradePartyMon], a
	ld [wPlayerLinkAction], a
	call PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	cp $f
	jp z, InitTradeMenuDisplay
	ld [wCurOTTradePartyMon], a
	ld a, [wOtherPlayerLinkMode]
	hlcoord 6, 9
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	ld [hl], "▷"
	ld c, 100
	call DelayFrames
	call ValidateOTTrademon
	jr c, .abnormal
	call CheckAnyOtherAliveMonsForTrade
	jp nc, LinkTrade
	xor a
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
	ld [wOtherPlayerLinkAction], a
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_ot_species
	ld a, [wCurOTTradePartyMon]
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
	call PrintWaitingTextAndSyncAndExchangeNybble
	ld c, 100
	call DelayFrames
	jp InitTradeMenuDisplay

.Text_CantTradeLastMon:
	; If you trade that #MON, you won't be able to battle.
	text_jump _LinkTradeCantBattleText
	text_end

.String_Stats_Trade:
	db "Stats     Trade@"

.Text_Abnormal:
	; Your friend's @  appears to be abnormal!
	text_jump _LinkAbnormalMonText
	text_end

ValidateOTTrademon:
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMon1Species
	call GetPartyLocation
	push hl
	ld a, [wCurOTTradePartyMon]
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

CheckAnyOtherAliveMonsForTrade:
	ld a, [wCurTradePartyMon]
	ld d, a
	ld a, [wPartyCount]
	ld b, a
	ld c, 0
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
	ld a, [wCurOTTradePartyMon]
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

LinkTradeOTPartymonMenuCheckCancel:
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
LinkTradePartymonMenuCheckCancel:
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
	ld a, 1
	ld [wMenuCursorY], a
	jp LinkTrade_PlayerPartyMenu

.a_button
	ld a, "▷"
	ldcoord_a 9, 17
	ld a, $f
	ld [wPlayerLinkAction], a
	call PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	cp $f
	jr nz, .loop1
ExitLinkCommunications:
	ld c, 15
	call FadeToWhite
	call ClearScreen
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call ApplyAttrAndTilemapInVBlank
	xor a
	ldh [rSB], a
	ldh [hSerialSend], a
	ld a, 1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a
	ret

LinkTrade:
	xor a
	ld [wOtherPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	call Link_WaitBGMap
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_party_species
	ld a, [wCurTradePartyMon]
	ld hl, wPartySpecies
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
.got_party_species
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wBufferTrademonNick
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_ot_species
	ld a, [wCurOTTradePartyMon]
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
	call LoadStandardMenuHeader
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
	jr nz, .canceled
	ld a, [wMenuCursorY]
	dec a
	jr z, .try_trade

.canceled
	ld a, $1
	ld [wPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	rst PlaceString
	call PrintWaitingTextAndSyncAndExchangeNybble
	jr .finish_cancel

.try_trade
	ld a, $2
	ld [wPlayerLinkAction], a
	call PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	dec a
	jr nz, .do_trade
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	rst PlaceString
.finish_cancel
	ld c, 100
	call DelayFrames
	jp InitTradeMenuDisplay

.do_trade
	ld hl, sPartyMail
	ld a, [wCurTradePartyMon]
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld d, h
	ld e, l
	ld bc, MAIL_STRUCT_LENGTH
	add hl, bc
	ld a, [wCurTradePartyMon]
	ld c, a
.copy_mail
	inc c
	ld a, c
	cp $6
	jr z, .copy_player_data
	push bc
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	pop bc
	jr .copy_mail

.copy_player_data
	ld hl, sPartyMail
	ld a, [wPartyCount]
	dec a
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	push hl
	ld hl, wLinkPlayerMail
	ld a, [wCurOTTradePartyMon]
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	pop de
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	call CloseSRAM

; Buffer player data
; nickname
	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	ld bc, NAME_LENGTH
	rst CopyBytes
; species
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_tradeparty_species
	ld a, [wCurTradePartyMon]
	ld hl, wPartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
.got_tradeparty_species
	ld [wPlayerTrademonSpecies], a
	push af
; OT name
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMonOT
	call SkipNames
	ld de, wPlayerTrademonOTName
	ld bc, NAME_LENGTH
	rst CopyBytes
; ID
	ld hl, wPartyMon1ID
	ld a, [wCurTradePartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonID], a
	ld a, [hl]
	ld [wPlayerTrademonID + 1], a
; DVs
	ld hl, wPartyMon1DVs
	ld a, [wCurTradePartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonDVs], a
	ld a, [hli]
	ld [wPlayerTrademonDVs + 1], a
	ld a, [hl]
	ld [wPlayerTrademonDVs + 2], a
; caught data
	ld hl, wPartyMon1Species
	ld a, [wCurTradePartyMon]
	call GetPartyLocation
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld [wPlayerTrademonCaughtData], a

; Buffer other player data
; nickname
	ld hl, wOTPlayerName
	ld de, wOTTrademonSenderName
	ld bc, NAME_LENGTH
	rst CopyBytes
; species
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMon1IsEgg
	call GetPartyLocation
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_tradeot_species
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
.got_tradeot_species
	ld [wOTTrademonSpecies], a
; OT name
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMonOT
	call SkipNames
	ld de, wOTTrademonOTName
	ld bc, NAME_LENGTH
	rst CopyBytes
; ID
	ld hl, wOTPartyMon1ID
	ld a, [wCurOTTradePartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wOTTrademonID], a
	ld a, [hl]
	ld [wOTTrademonID + 1], a
; DVs
	ld hl, wOTPartyMon1DVs
	ld a, [wCurOTTradePartyMon]
	call GetPartyLocation
	ld a, [hli]
	ld [wOTTrademonDVs], a
	ld a, [hli]
	ld [wOTTrademonDVs + 1], a
	ld a, [hl]
	ld [wOTTrademonDVs + 2], a
; caught data
	ld hl, wOTPartyMon1Species
	ld a, [wCurOTTradePartyMon]
	call GetPartyLocation
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld [wOTTrademonCaughtData], a

	ld a, [wCurTradePartyMon]
	ld [wCurPartyMon], a
	ld hl, wPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wCurTradePartyMon], a

	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromPartyOrBox
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld a, TRUE
	ld [wForceEvolution], a
	ld a, [wCurOTTradePartyMon]
	push af
	ld hl, wOTPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wCurOTTradePartyMon], a

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
	call TradeAnimationPlayer2
.done_animation
	pop af
	ld c, a
	ld [wCurPartyMon], a
	ld hl, wOTPartySpecies
	ld d, 0
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

; Check if either of the Pokémon sent was a Mew or Celebi, and send a different
; byte depending on that. Presumably this would've been some prevention against
; illicit trade machines, but it doesn't seem like a very effective one.
; Removing this code breaks link compatibility with the vanilla gen2 games, but
; has otherwise no consequence.
	ld b, 1
	pop af
	ld c, a
	cp MEW
	jr z, .send_checkbyte
	ld a, [wCurPartySpecies]
	cp MEW
	jr z, .send_checkbyte
	ld b, 2
	ld a, c
	cp CELEBI
	jr z, .send_checkbyte
	ld a, [wCurPartySpecies]
	cp CELEBI
	jr z, .send_checkbyte

; Send the byte in a loop until the desired byte has been received.
	ld b, 0
.send_checkbyte
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
	jr nz, .send_checkbyte

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
	text_jump _LinkAskTradeForText
	text_end

.TradeCompleted:
	db "Trade completed!@"

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

PrintWaitingTextAndSyncAndExchangeNybble:
	call LoadStandardMenuHeader
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
INCBIN "gfx/trade/border.2bpp.lz"

SetTradeRoomBGPals:
	farcall LoadLinkTradePalette
	farcall ApplyPals
	jp SetPalettes

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
	ld a, 1 << SERIAL | 1 << LCD_STAT | 1 << VBLANK
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

CheckLinkTimeout_Gen2:
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
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	ld l, [hl]
	ld h, a
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
	; a = carry ? FALSE (0) : TRUE
	sbc a
	inc a
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
	ld [wLinkPlayerSyncBuffer], a
	ld [wLinkPlayerSyncBuffer + 1], a
	ld a, $2
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
.receive_loop
	call Serial_ExchangeSyncBytes
	ld a, [wLinkReceivedSyncBuffer]
	ld b, a
	and $f0
	cp $d0
	jr z, .done
	ld a, [wLinkReceivedSyncBuffer + 1]
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
	jr nz, .defeat
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
	inc a
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
	rst ByteFill
	ret

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
