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
	call LoadTradeScreenBorderGFX
	call ApplyAttrAndTilemapInVBlank
	hlcoord 3, 8
	lb bc, 2, 12
	call LinkTextboxAtHL
	hlcoord 4, 10
	ld de, String_PleaseWait
	rst PlaceString
	call SetTradeRoomBGPals
	call ApplyAttrAndTilemapInVBlank
	ld hl, wLinkByteTimeout
	xor a
	assert LOW(SERIAL_LINK_BYTE_TIMEOUT) == 0
	ld [hli], a
	ld [hl], HIGH(SERIAL_LINK_BYTE_TIMEOUT)
	; fallthrough

Gen2ToGen2LinkComms:
	call ClearLinkData
	call Link_PrepPartyData_Gen2
	call FixDataForLinkTransfer
	call PrepareForLinkTransfers

	ld hl, wLinkBattleRNPreamble
	ld de, wOTLinkBattleRNData
	ld bc, SERIAL_RN_PREAMBLE_LENGTH + SERIAL_RNS_LENGTH
	vc_hook ExchangeBytes1
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

	ld hl, wLinkSendParty
	ld de, wLinkReceivedPartyData
	ld bc, wLinkSendPartyEnd - wLinkSendParty
	vc_hook ExchangeBytes2
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

; Preserve Polished Crystal's existing patch-list transfer span.
	ld hl, wPlayerPatchLists
	ld de, wLinkReceivedPatchLists
	ld bc, wLinkReceivedPatchLists - wPlayerPatchLists
	vc_hook ExchangeBytes3
	call Serial_ExchangeBytes

	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr nz, .not_trading
	ld hl, wLinkSendMail
	ld de, wLinkReceivedMail
	ld bc, wLinkSendMailEnd - wLinkSendMail
	vc_hook ExchangeBytes4
	call ExchangeBytes

.not_trading
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a
	ld e, MUSIC_NONE
	call PlayMusic

	call Link_CopyRandomNumbers

; Strip control bytes before applying the received party patch lists.
	ld hl, wLinkReceivedPartyData
	call Link_FindFirstNonControlCharacter_SkipZero
	ld de, wLinkPlayerPartyData
	ld bc, wLinkPlayerPartyDataEnd - wLinkPlayerPartyData
	call Link_CopyOTData

	ld de, wLinkReceivedPatchLists
	ld hl, wLinkPlayerPatchedData
	ld c, 2 ; number of patch areas
.party_patch_loop
	ld a, [de]
	inc de
	and a
	jr z, .party_patch_loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .party_patch_loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .party_patch_loop
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .next_patch_list
	push hl
	push bc
	ld b, 0
	dec a
	ld c, a
	add hl, bc
	ld [hl], SERIAL_NO_DATA_BYTE
	pop bc
	pop hl
	jr .party_patch_loop

.next_patch_list
	ld hl, wLinkPlayerPatchedData + SERIAL_PATCH_DATA_SIZE
	dec c
	jr nz, .party_patch_loop

	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jmp nz, .skip_mail
; Align and patch the raw received mail before rearranging it.
	ld hl, wLinkReceivedMail
.find_mail_preamble
	ld a, [hli]
	cp SERIAL_MAIL_PREAMBLE_BYTE
	jr nz, .find_mail_preamble
.skip_mail_preamble
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .skip_mail_preamble
	cp SERIAL_MAIL_PREAMBLE_BYTE
	jr z, .skip_mail_preamble
	dec hl
	ld de, wLinkReceivedMailMessages
	ld bc, wLinkDataEnd - wLinkReceivedMail
	rst CopyBytes
; Replace the escaped no-data byte across all received message bodies.
	ld hl, wLinkReceivedMailMessages
	ld bc, (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
.mail_body_patch_loop
	ld a, [hl]
	cp SERIAL_MAIL_REPLACEMENT_BYTE
	jr nz, .mail_body_patched
	ld [hl], SERIAL_NO_DATA_BYTE
.mail_body_patched
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .mail_body_patch_loop
; Restore the no-data bytes recorded in the mail metadata patch set.
	ld de, wLinkReceivedMailPatchSet
.mail_metadata_patch_loop
	ld a, [de]
	inc de
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .start_copying_mail
	ld hl, wLinkReceivedMailMetadata
	dec a
	ld b, 0
	ld c, a
	add hl, bc
	ld [hl], SERIAL_NO_DATA_BYTE
	jr .mail_metadata_patch_loop

.start_copying_mail
; Rearrange the separate message/metadata arrays into individual mail structs.
	ld hl, wLinkReceivedMailMessages
	ld de, wLinkOTMail
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
	ld de, wLinkOTMail
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
; Polished has no mail-language conversion; preserve the original pointer walk.
	ld b, PARTY_LENGTH
	ld de, wLinkOTMail
.advance_mail_loop
	push bc
	ld hl, MAIL_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop bc
	dec b
	jr nz, .advance_mail_loop
	ld de, wLinkOTMailEnd
	xor a
	ld [de], a

.skip_mail
	ld hl, wLinkPlayerName
	ld de, wOTPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes

	ld a, [hli]
	ld [wOTPartyCount], a

	ld de, wOTPlayerID
	ld bc, wLinkPlayerPartyMons - wLinkPlayerID
	rst CopyBytes

	ld de, wOTPartyMons
	ld bc, wOTPartyDataEnd - wOTPartyMons
	rst CopyBytes

	ld e, MUSIC_NONE
	call PlayMusic
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr nz, .ready_to_trade

	ld a, [wLinkOtherPlayerGender]
	assert PLAYER_MALE + 1 == CAL
	assert PLAYER_FEMALE + 1 == CARRIE
	assert PLAYER_ENBY + 1 == JACKY
	assert PLAYER_BETA + 1 == EUNA
	inc a
	ld [wOtherTrainerClass], a
	xor a ; TRAINERPAL_NONE
	ld [wTrainerPal], a

	call ClearScreen
	call Link_WaitBGMap
	ld hl, wOptions2
	ld a, [hl]
	push af
	and ~(BATTLE_SWITCH | BATTLE_PREDICT)
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
	pop af
	ldh [rIF], a

	farcall StartBattle

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
	jmp ExitLinkCommunications

.ready_to_trade
	ld e, MUSIC_ROUTE_30
	call PlayMusic
	jmp InitTradeMenuDisplay

LinkTimeout:
	ld de, .LinkTimeoutText
	ld b, 10
.acknowledge_loop
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge_loop
	xor a
	ld [hld], a
	ld [hl], a
	ldh [hVBlank], a
	push de
	hlcoord 0, 12
	lb bc, 4, 18
	push de
	call LinkTextboxAtHL
	pop de
	pop hl
	bccoord 1, 14
	call PlaceWholeStringInBoxAtOnce
	ld c, 15
	call FadeToWhite
	call ClearScreen
	ld a, CGB_PLAIN
	call GetCGBLayout
	jmp ApplyAttrAndTilemapInVBlank

.LinkTimeoutText:
	; Too much time has elapsed. Please try again.
	text_farend _LinkTimeoutText
ExchangeBytes:
; Send BC bytes from HL and receive BC bytes at DE.
; This is similar to Serial_ExchangeBytes,
; but without a SERIAL_PREAMBLE_BYTE check.
	ld a, TRUE
	ldh [hSerialIgnoringInitialData], a
.exchange_loop
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
	jr z, .store_byte
	dec hl
	xor a
	ldh [hSerialIgnoringInitialData], a
	jr .exchange_loop

.store_byte
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .exchange_loop
	ret

String_PleaseWait:
	text "Please wait!"
	done

ClearLinkData:
	ld hl, wLinkData
	ld bc, wLinkDataEnd - wLinkData
.clear_loop
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .clear_loop
	ret

FixDataForLinkTransfer:
	ld hl, wLinkBattleRNPreamble
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, wLinkBattleRNs - wLinkBattleRNPreamble
.preamble_loop
	ld [hli], a
	dec b
	jr nz, .preamble_loop

; Initialize random seed, making sure special bytes are omitted.
	ld b, SERIAL_RNS_LENGTH
.rn_loop
	call Random
	cp SERIAL_PREAMBLE_BYTE
	jr nc, .rn_loop
	ld [hli], a
	dec b
	jr nz, .rn_loop

; Clear the patch list after its preamble.
	ld hl, wPlayerPatchLists
	ld a, SERIAL_PREAMBLE_BYTE
rept SERIAL_PATCH_PREAMBLE_LENGTH
	ld [hli], a
endr
	ld b, SERIAL_PATCH_LIST_LENGTH
	xor a
.clear_loop
	ld [hli], a
	dec b
	jr nz, .clear_loop

; Patch the outgoing player ID and party structs. The matching decoded
; origin is wLinkPlayerPatchedData, which has no serial preamble.
; HL starts one byte before the first patched byte; offsets are 1-based.
	ld hl, wLinkSendPartyPlayerID - 1
	ld de, wPlayerPatchLists + SERIAL_RNS_LENGTH
	lb bc, 0, 0
.patch_loop
; Check whether the first patch area has reached its end.
	inc c
	ld a, c
	cp SERIAL_PATCH_DATA_SIZE + 1
	jr z, .data1_done
	ld a, b
	dec a
	jr nz, .process
; Check whether the second patch area has reached its end.
	push bc
	ld b, wLinkSendPartyPatchedDataEnd - wLinkSendPartyPlayerID - SERIAL_PATCH_DATA_SIZE + 1
	ld a, c
	cp b
	pop bc
	jr z, .data2_done
.process
; Replace the no-data byte and record its 1-based offset in the patch list.
	inc hl
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .patch_loop
	ld a, c
	ld [de], a
	inc de
	ld [hl], SERIAL_PATCH_REPLACEMENT_BYTE
	jr .patch_loop

.data1_done
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	inc de
	lb bc, 1, 0
	jr .patch_loop

.data2_done
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	ret

Link_PrepPartyData_Gen2:
	ld de, wLinkSendParty
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, SERIAL_PREAMBLE_LENGTH
.preamble_loop
	ld [de], a
	inc de
	dec b
	jr nz, .preamble_loop

	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes

	ld a, [wPartyCount]
	ld [de], a
	inc de

	ld hl, wPlayerID
	ld bc, wLinkSendPartyPlayerPartyMon1 - wLinkSendPartyPlayerID
	rst CopyBytes

	ld hl, wPartyMon1Species
	ld bc, PARTY_LENGTH * PARTYMON_STRUCT_LENGTH
	rst CopyBytes

	ld hl, wPartyMonOTs
	ld bc, PARTY_LENGTH * NAME_LENGTH
	rst CopyBytes

	ld hl, wPartyMonNicknames
	ld bc, PARTY_LENGTH * MON_NAME_LENGTH
	rst CopyBytes

; Okay, we did all that.  Now, are we in the trade center?
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	ret nz

; Fill the outgoing mail preamble.
	ld de, wLinkSendMailPreamble
	ld a, SERIAL_MAIL_PREAMBLE_BYTE
	ld c, SERIAL_MAIL_PREAMBLE_LENGTH
.mail_preamble_loop
	ld [de], a
	inc de
	dec c
	jr nz, .mail_preamble_loop

; Copy all the mail messages to wLinkSendMailMessages
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld hl, sPartyMail
	ld b, PARTY_LENGTH
.message_loop
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	rst CopyBytes
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	add hl, bc
	pop bc
	dec b
	jr nz, .message_loop

; Copy the mail metadata to wLinkSendMailMetadata
	ld hl, sPartyMail
	ld b, PARTY_LENGTH
.metadata_loop
	push bc
	ld bc, MAIL_MSG_LENGTH + 1
	add hl, bc
	ld bc, MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)
	rst CopyBytes
	pop bc
	dec b
	jr nz, .metadata_loop

; Polished does not translate mail languages; retain the pointer walk.
	ld b, PARTY_LENGTH
	ld de, sPartyMail
	ld hl, wLinkSendMailMessages
.advance_mail_loop
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
	jr nz, .advance_mail_loop
	call CloseSRAM

; SERIAL_NO_DATA_BYTE cannot be sent as part of message text.
	ld hl, wLinkSendMailMessages
	ld bc, (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
.message_patch_loop
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .message_patch_skip
	ld [hl], SERIAL_MAIL_REPLACEMENT_BYTE
.message_patch_skip
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .message_patch_loop

; Calculate the patch offsets for the mail metadata.
	ld hl, wLinkSendMailMetadata
	ld de, wLinkSendMailPatchSet
	lb bc, (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) * PARTY_LENGTH, 0
.metadata_patch_loop
	inc c
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .metadata_patch_skip
	ld [hl], SERIAL_PATCH_REPLACEMENT_BYTE
	ld a, c
	ld [de], a
	inc de
.metadata_patch_skip
	inc hl
	dec b
	jr nz, .metadata_patch_loop

	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	ret

Link_CopyOTData:
; Copy BC decoded bytes from HL to DE, discarding SERIAL_NO_DATA_BYTE.
.copy_data_loop
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .copy_data_loop
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .copy_data_loop
	ret

Link_CopyRandomNumbers:
; The external-clock player adopts the peer's shared battle RNG stream.
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret z
	ld hl, wOTLinkBattleRNData
	call Link_FindFirstNonControlCharacter_AllowZero
	ld de, wLinkBattleRNs
	ld c, SERIAL_RNS_LENGTH
.copy_rn_loop
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .copy_rn_loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .copy_rn_loop
	ld [de], a
	inc de
	dec c
	jr nz, .copy_rn_loop
	ret

Link_FindFirstNonControlCharacter_SkipZero:
; Advance HL to the first byte other than zero, preamble, or no-data.
.skip_control_bytes
	ld a, [hli]
	and a
	jr z, .skip_control_bytes
	cp SERIAL_PREAMBLE_BYTE
	jr z, .skip_control_bytes
	cp SERIAL_NO_DATA_BYTE
	jr z, .skip_control_bytes
	dec hl
	ret

Link_FindFirstNonControlCharacter_AllowZero:
; Advance HL past preamble/no-data bytes; zero is valid random data.
.skip_control_bytes
	ld a, [hli]
	cp SERIAL_PREAMBLE_BYTE
	jr z, .skip_control_bytes
	cp SERIAL_NO_DATA_BYTE
	jr z, .skip_control_bytes
	dec hl
	ret

Link_WaitBGMap:
	call ApplyTilemapInVBlank
	jmp ApplyAttrAndTilemapInVBlank

InitTradeMenuDisplay:
	call ClearScreen
	call LoadTradeScreenBorderGFX
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
	jmp LinkTrade_PlayerPartyMenu

InitTradeSpeciesList:
	ld hl, .TradeScreenTilemap
	decoord 0, 0
	call Decompress
	call InitLinkTradePalMap
	call PlaceTradePartnerNamesAndParty
	hlcoord 10, 17
	ld de, .CancelString
	rst PlaceString
	ret

.TradeScreenTilemap:
INCBIN "gfx/trade/border.tilemap.lzp"

.CancelString:
	text "Cancel"
	done

PlaceTradePartnerNamesAndParty:
	hlcoord 4, 0
	ld de, wPlayerName
	rst PlaceString
	ld a, $13
	ld [bc], a
	hlcoord 4, 8
	ld de, wOTPlayerName
	rst PlaceString
	ld a, $13
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
.species_loop
	push hl
	push bc
	ld hl, MON_IS_EGG
	add hl, de
	ld a, c
	call GetPartyLocation
	assert MON_IS_EGG == MON_FORM
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_species
	ld a, [hl]
	ld [wNamedObjectIndex+1], a
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
	ld [wNamedObjectIndex], a
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
	jr nz, .species_loop
	pop bc
	ret

LinkTrade_OTPartyMenu:
	ld a, OTPARTYMON
	ld [wMonType], a
	ld a, PAD_A | PAD_UP | PAD_DOWN
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
	ld a, _2DMENU_WRAP_UP_DOWN
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a

LinkTradeOTPartymonMenuLoop:
	call LinkTradeMenu
	ld a, d
	and a
	jmp z, LinkTradePartiesMenuMasterLoop
	bit B_PAD_A, a
	jr z, .not_a_button
	call LinkMonSummaryScreen
	call InitLinkTradePalMap
	call ApplyAttrAndTilemapInVBlank
	jmp LinkTradePartiesMenuMasterLoop

.not_a_button
	bit B_PAD_UP, a
	jr z, .not_d_up
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jmp nz, LinkTradePartiesMenuMasterLoop
	xor a
	ld [wMonType], a
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], ' '
	pop bc
	pop hl
	ld a, [wPartyCount]
	ld [wMenuCursorY], a
	jr LinkTrade_PlayerPartyMenu

.not_d_up
	bit B_PAD_DOWN, a
	jmp z, LinkTradePartiesMenuMasterLoop
	jmp LinkTradeOTPartymonMenuCheckCancel

LinkMonSummaryScreen:
	ld a, [wMenuCursorY]
	dec a
	ld [wCurPartyMon], a
	ld a, [wMonType]
	push af
	farcall OpenPartySummary
	pop af
	ld [wMonType], a
	ld a, [wCurPartyMon]
	inc a
	ld [wMenuCursorY], a
	call LoadTradeScreenBorderGFX
	call Link_WaitBGMap
	call InitTradeSpeciesList
	call SetTradeRoomBGPals
	jmp ApplyAttrAndTilemapInVBlank

LinkTrade_PlayerPartyMenu:
	call InitLinkTradePalMap
	xor a
	ld [wMonType], a
	ld a, PAD_A | PAD_UP | PAD_DOWN
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
	ld a, _2DMENU_WRAP_UP_DOWN
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	call ApplyAttrAndTilemapInVBlank

LinkTradePartymonMenuLoop:
	call LinkTradeMenu
	ld a, d
	and a
	jr z, LinkTradePartiesMenuMasterLoop
	bit B_PAD_A, a
	jmp nz, LinkTrade_TradeSummaryMenu
	bit B_PAD_DOWN, a
	jr z, .not_d_down
	ld a, [wMenuCursorY]
	dec a
	jr nz, LinkTradePartiesMenuMasterLoop
	ld a, OTPARTYMON
	ld [wMonType], a
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], ' '
	pop bc
	pop hl
	ld a, 1
	ld [wMenuCursorY], a
	jmp LinkTrade_OTPartyMenu

.not_d_down
	bit B_PAD_UP, a
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
	ld [hl], ' '
	pop bc
	pop hl
	jmp LinkTradePartymonMenuCheckCancel

LinkTradePartiesMenuMasterLoop:
	ld a, [wMonType]
	and a
	jr z, LinkTradePartymonMenuLoop ; PARTYMON
	jmp LinkTradeOTPartymonMenuLoop  ; OTPARTYMON

LinkTradeMenu:
	ld hl, w2DMenuFlags2
	res _2DMENU_EXITING_F, [hl]
	ldh a, [hBGMapMode]
	push af
	call .menu_loop
	pop af
	ldh [hBGMapMode], a
.GetJoypad:
	push bc
	push af
	ldh a, [hJoyLast]
	and PAD_CTRL_PAD
	ld b, a
	ldh a, [hJoyPressed]
	and PAD_BUTTONS
	or b
	ld b, a
	pop af
	ld a, b
	pop bc
	ld d, a
	ret

.menu_loop
	call .UpdateCursor
	call .UpdateBGMapAndOAM
	call .joypad_loop
	ret nc
	farcall _2DMenuInterpretJoypad
	ret c
	ld a, [w2DMenuFlags1]
	bit _2DMENU_DISABLE_JOYPAD_FILTER_F, a
	ret nz
	call .GetJoypad
	ld b, a
	ld a, [wMenuJoypadFilter]
	and b
	jr z, .menu_loop
	ret

.UpdateBGMapAndOAM:
	ldh a, [hOAMUpdate]
	push af
	ld a, TRUE
	ldh [hOAMUpdate], a
	call ApplyTilemapInVBlank
	pop af
	ldh [hOAMUpdate], a
	xor a
	assert NO_BG_MAP_TRANSFER == 0
	ldh [hBGMapMode], a
	ret

.joypad_loop
	call RTC
	call .TryAnims
	ret c
	ld a, [w2DMenuFlags1]
	bit _2DMENU_DISABLE_JOYPAD_FILTER_F, a
	jr z, .joypad_loop
	and a
	ret

.UpdateCursor:
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	cp $16
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
	jr z, .got_cursor_row
.cursor_row_loop
	add c
	dec b
	jr nz, .cursor_row_loop

.got_cursor_row
	ld c, SCREEN_WIDTH
	rst AddNTimes
	ld a, [w2DMenuCursorOffsets]
	and $f
	ld c, a
	ld a, [wMenuCursorX]
	ld b, a
	xor a
	dec b
	jr z, .got_cursor_column
.cursor_column_loop
	add c
	dec b
	jr nz, .cursor_column_loop

.got_cursor_column
	ld c, a
	add hl, bc
	ld a, [hl]
	cp $16
	jr z, .cursor_already_there
	ld [wCursorOffCharacter], a
	ld [hl], $16
	push hl
	push bc
	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld [hl], $16
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
	bit _2DMENU_ENABLE_SPRITE_ANIMS_F, a
	jr z, .skip_anims
	farcall PlaySpriteAnimationsAndDelayFrame
.skip_anims
	call JoyTextDelay
	call .GetJoypad
	and a
	ret z
	scf
	ret

LinkTrade_TradeSummaryMenu:
	call LoadTileMapToTempTileMap
	ld a, [wMenuCursorY]
	push af
	hlcoord 0, 15
	lb bc, 1, 18
	call LinkTextboxAtHL
	hlcoord 2, 16
	ld de, .String_Summary_Trade
	rst PlaceString
	call Link_WaitBGMap

.joy_loop
	ld a, ' '
	ldcoord_a 11, 16
	ld a, PAD_A | PAD_B | PAD_RIGHT
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
	bit B_PAD_RIGHT, a
	jr nz, .d_right
	bit B_PAD_B, a
	jr z, .show_summary
.b_button
	pop af
	ld [wMenuCursorY], a
	call SafeLoadTempTileMapToTileMap
	jmp LinkTrade_PlayerPartyMenu

.d_right
	ld a, ' '
	ldcoord_a 1, 16
	ld a, PAD_A | PAD_B | PAD_LEFT
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
	bit B_PAD_LEFT, a
	jr nz, .joy_loop
	bit B_PAD_B, a
	jr nz, .b_button
	jr .try_trade

.show_summary
	pop af
	ld [wMenuCursorY], a
	call LinkMonSummaryScreen
	call SafeLoadTempTileMapToTileMap
	hlcoord 6, 1
	lb bc, PARTY_LENGTH, 1
	call ClearBox
	hlcoord 17, 1
	lb bc, PARTY_LENGTH, 1
	call ClearBox
	jmp LinkTrade_PlayerPartyMenu

.try_trade
	call PlaceHollowCursor
	pop af
	ld [wMenuCursorY], a
	dec a
	ld [wCurTradePartyMon], a
	ld [wPlayerLinkAction], a
	call PlaceWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	cp LINK_ACTION_CANCEL
	jmp z, InitTradeMenuDisplay
	ld [wCurOTTradePartyMon], a
	ld a, [wOtherPlayerLinkMode]
	hlcoord 6, 9
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	ld [hl], '▷'
	ld c, 100
	call DelayFrames
	call ValidateOTTrademon
	jr c, .abnormal
	call CheckAnyOtherAliveMonsForTrade
	jmp nc, LinkTrade
	xor a
	ld [wOtherPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextboxAtHL
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
	assert MON_IS_EGG == MON_FORM
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_ot_species
	ld a, [hl]
	ld [wNamedObjectIndex+1], a
	ld bc, MON_SPECIES - MON_FORM
	add hl, bc
	ld a, [hl]
.got_ot_species
	ld [wNamedObjectIndex], a
	call GetPokemonName
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextboxAtHL
	call Link_WaitBGMap
	ld hl, .Text_Abnormal
	bccoord 1, 14
	call PlaceWholeStringInBoxAtOnce

.cancel_trade
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	rst PlaceString
	ld a, $1
	ld [wPlayerLinkAction], a
	call PlaceWaitingTextAndSyncAndExchangeNybble
	ld c, 100
	call DelayFrames
	jmp InitTradeMenuDisplay

.Text_CantTradeLastMon:
	; If you trade that #MON, you won't be able to battle.
	text_farend _LinkTradeCantBattleText
.String_Summary_Trade:
	text "Summary   Trade"
	done

.Text_Abnormal:
	; Your friend's @  appears to be abnormal!
	text_farend _LinkAbnormalMonText
ValidateOTTrademon:
; Returns carry if level isn't within 1-100.
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMon1Level
	call GetPartyLocation
	ld a, [hl]

	; Only allow level 1-100.
	dec a
	cp MAX_LEVEL
	ccf
	ret

CheckAnyOtherAliveMonsForTrade:
	ld a, [wCurTradePartyMon]
	ld d, a
	ld a, [wPartyCount]
	ld b, a
	ld c, 0
.party_loop
	ld a, c
	cp d
	jr z, .next_mon
	ld a, c
	ld hl, wPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	jr nz, .can_battle

.next_mon
	inc c
	dec b
	jr nz, .party_loop
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	jr nz, .can_battle
	scf
	ret

.can_battle
	and a
	ret

LinkTradeOTPartymonMenuCheckCancel:
	ld a, [wMenuCursorY]
	dec a
	jmp nz, LinkTradePartiesMenuMasterLoop
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], ' '
	pop bc
	pop hl
LinkTradePartymonMenuCheckCancel:
.cancel_menu_loop
	ld a, '▶'
	ldcoord_a 9, 17
.joypad_loop
	call JoyTextDelay
	ldh a, [hJoyLast]
	and a
	jr z, .joypad_loop
	bit B_PAD_A, a
	jr nz, .a_button
	push af
	ld a, ' '
	ldcoord_a 9, 17
	pop af
	bit B_PAD_UP, a
	jr z, .d_up
	ld a, [wOTPartyCount]
	ld [wMenuCursorY], a
	jmp LinkTrade_OTPartyMenu

.d_up
	ld a, 1
	ld [wMenuCursorY], a
	jmp LinkTrade_PlayerPartyMenu

.a_button
	ld a, '▷'
	ldcoord_a 9, 17
	ld a, LINK_ACTION_CANCEL
	ld [wPlayerLinkAction], a
	call PlaceWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	cp LINK_ACTION_CANCEL
	jr nz, .cancel_menu_loop
ExitLinkCommunications:
	ld c, 15
	call FadeToWhite
	call ClearScreen
	ld a, CGB_PLAIN
	call GetCGBLayout
	call ApplyAttrAndTilemapInVBlank
	xor a
	ldh [rSB], a
	ldh [hSerialSend], a
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
	vc_hook ExitLinkCommunications_ret
	ret

LinkTrade:
	xor a
	ld [wOtherPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextboxAtHL
	call Link_WaitBGMap
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	assert MON_IS_EGG == MON_FORM
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_party_species
	ld a, [hl]
	ld [wNamedObjectIndex+1], a
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
.got_party_species
	ld [wNamedObjectIndex], a
	ld bc, MON_FORM - MON_SPECIES
	add hl, bc
	ld a, [hl]
	and SPECIESFORM_MASK
	ld [wNamedObjectIndex+1], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wBufferTrademonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMon1IsEgg
	call GetPartyLocation
	assert MON_IS_EGG == MON_FORM
	bit MON_IS_EGG_F, [hl]
	ld a, EGG
	jr nz, .got_ot_species
	ld a, [hl]
	ld [wNamedObjectIndex+1], a
	ld bc, MON_SPECIES - MON_FORM
	add hl, bc
	ld a, [hl]
.got_ot_species
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, .TradeThisForThat
	bccoord 1, 14
	call PlaceWholeStringInBoxAtOnce
	call LoadStandardMenuHeader
	hlcoord 10, 7
	lb bc, 3, 7
	call LinkTextboxAtHL
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
	ln a, 2, 0
	ld [w2DMenuCursorOffsets], a
	ld a, PAD_A | PAD_B
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
	bit B_PAD_B, a
	jr nz, .canceled
	ld a, [wMenuCursorY]
	dec a
	jr z, .try_trade

.canceled
	ld a, $1
	ld [wPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	rst PlaceString
	call PlaceWaitingTextAndSyncAndExchangeNybble
	jr .finish_cancel

.try_trade
	ld a, $2
	ld [wPlayerLinkAction], a
	call PlaceWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	dec a
	jr nz, .do_trade
; The other player canceled the trade.

	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	rst PlaceString
.finish_cancel
	ld c, 100
	call DelayFrames
	jmp InitTradeMenuDisplay

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
	cp PARTY_LENGTH
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
	ld hl, wLinkOTMail
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
	assert MON_IS_EGG == MON_FORM
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	ld a, [hl]
	ld [wPlayerTrademonForm], a
	bit MON_IS_EGG_F, a
	ld a, EGG
	jr nz, .got_tradeparty_species
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
.got_tradeparty_species
	ld [wPlayerTrademonSpecies], a
	push af
; OT name
	ld a, [wCurTradePartyMon]
	ld hl, wPartyMonOTs
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
; Caught ball
	ld hl, wPartyMon1CaughtBall
	ld a, [wCurTradePartyMon]
	call GetPartyLocation
	ld a, [hl]
	and CAUGHT_BALL_MASK
	ld [wPlayerTrademonCaughtBall], a

; Buffer other player data
; nickname
	ld hl, wOTPlayerName
	ld de, wOTTrademonSenderName
	ld bc, NAME_LENGTH
	rst CopyBytes
; species
	ld a, [wCurOTTradePartyMon]
	assert MON_IS_EGG == MON_FORM
	ld hl, wOTPartyMon1IsEgg
	call GetPartyLocation
	ld a, [hl]
	ld [wOTTrademonForm], a
	bit MON_IS_EGG_F, a
	ld a, EGG
	jr nz, .got_tradeot_species
	ld bc, MON_SPECIES - MON_FORM
	add hl, bc
	ld a, [hl]
.got_tradeot_species
	ld [wOTTrademonSpecies], a
; OT name
	ld a, [wCurOTTradePartyMon]
	ld hl, wOTPartyMonOTs
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
; Caught ball
	ld hl, wOTPartyMon1CaughtBall
	ld a, [wCurOTTradePartyMon]
	call GetPartyLocation
	ld a, [hl]
	and CAUGHT_BALL_MASK
	ld [wOTTrademonCaughtBall], a

	ld a, [wCurTradePartyMon]
	ld [wCurPartyMon], a
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld [wCurTradePartyMon], a

	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromParty
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld a, [wCurOTTradePartyMon]
	push af
	ld hl, wOTPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld [wCurOTTradePartyMon], a
	ld a, EVOLVE_TRADE
	ld [wForceEvolution], a

	ld c, 100
	call DelayFrames
	call ClearTileMap
	call LoadFontsBattleExtra
	ld a, CGB_PLAIN
	call GetCGBLayout
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player_2
	call TradeAnimation
	jr .done_animation
.player_2
	call TradeAnimationPlayer2
.done_animation
	pop af
	ld c, a
	ld [wCurPartyMon], a
	ld hl, wOTPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld hl, wOTPartyMon1Species
	ld b, $81 ; copy from OT party to temp (bits 7 and 0)
	inc c
	farcall CopyBetweenPartyAndTemp
	farcall AddTempMonToParty
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall EvolvePokemon
	call ClearScreen
	call LoadTradeScreenBorderGFX
	call SetTradeRoomBGPals
	call Link_WaitBGMap

; Retain the legacy Gen 2 Mew/Celebi check-byte handshake between Polished
; peers. Polished's game/version negotiation excludes vanilla Gen 2 games.
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
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, .TradeCompleted
	rst PlaceString
	call Link_WaitBGMap
	vc_hook Trade_save_game_end
	ld c, 50
	call DelayFrames
	jmp Gen2ToGen2LinkComms

.TradeCancel:
	text "Trade"
	next "Cancel"
	done

.TradeThisForThat:
	; Trade @ for @ ?
	text_farend _LinkAskTradeForText
.TradeCompleted:
	text "Trade completed!"
	done

String_TooBadTheTradeWasCanceled:
	text "Too bad! The trade"
	next "was canceled!"
	done

LinkTextboxAtHL::
; Draw the B-by-C interior at HL using Polished's border tiles ($20-$27).
	push bc
	push hl

	push hl
	ld a, $20
	ld [hli], a
	inc a ; $21
	call .PlaceRow
	inc a ; $22
	ld [hl], a
	pop hl

	ld de, SCREEN_WIDTH
	add hl, de
.border_loop
	push hl
	ld a, $23
	ld [hli], a
	ld a, ' '
	call .PlaceRow
	ld [hl], $24
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .border_loop

	ld a, $25
	ld [hli], a
	inc a ; $26
	call .PlaceRow
	inc a ; $27
	ld [hl], a

	pop hl
	pop bc
	ld de, wAttrmap - wTilemap
	add hl, de
	inc b
	inc b
	inc c
	inc c
	ld a, PAL_BG_TEXT
.palette_row
	push bc
	push hl
.palette_column
	ld [hli], a
	dec c
	jr nz, .palette_column
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop bc
	dec b
	jr nz, .palette_row
	ret

.PlaceRow:
	ld d, c
.tile_row_loop
	ld [hli], a
	dec d
	jr nz, .tile_row_loop
	ret

PlaceWaitingTextAndSyncAndExchangeNybble:
	call LoadStandardMenuHeader
	hlcoord 5, 10
	lb bc, 1, 9
	call LinkTextboxAtHL
	hlcoord 6, 11
	ld de, .Waiting
	rst PlaceString
	call ApplyTilemapInVBlank
	call ApplyAttrAndTilemapInVBlank
	ld c, 50
	call DelayFrames
	call WaitLinkTransfer
	call ExitMenu
	jmp ApplyAttrAndTilemapInVBlank

.Waiting:
	text "Waiting…!"
	done

LoadTradeScreenBorderGFX:
	ld hl, LinkCommsBorderGFX
	ld de, vTiles2
	lb bc, BANK(LinkCommsBorderGFX), 40
	jmp DecompressRequest2bpp

SetTradeRoomBGPals:
	farcall LoadLinkTradePalette
	farcall ApplyPals
	jmp SetDefaultBGPAndOBP

WaitForOtherPlayerToExit:
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	xor a
	ldh [rSB], a
	ldh [hSerialReceive], a
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
	ld c, 3
	call DelayFrames
	xor a
	ldh [rSB], a
	ldh [hSerialReceive], a
	xor a ; redundant?
	ldh [rSC], a
	ld a, SC_START | SC_EXTERNAL
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
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a
	pop af
	ldh [rIF], a
	ld hl, wLinkTimeoutFrames
	xor a
	ld [hli], a
	ld [hl], a
	ldh [hVBlank], a
	ld [wLinkMode], a
	vc_hook Wireless_term_exit
	ret

Special_SetBitsForLinkTradeRequest:
	ld a, CABLECLUBROOM_TRADECENTER
	ld [wPlayerLinkAction], a
	ld [wChosenCableClubRoom], a
	ret

Special_SetBitsForBattleRequest:
	ld a, CABLECLUBROOM_COLOSSEUM
	ld [wPlayerLinkAction], a
	ld [wChosenCableClubRoom], a
	ret

Special_WaitForLinkedFriend:
	ld a, [wPlayerLinkAction]
	and a
	jr z, .no_link_action
	ld a, USING_INTERNAL_CLOCK
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	xor a ; redundant?
	ldh [rSC], a
	ld a, SC_START | SC_EXTERNAL
; The VC hook sets hSerialConnectionStatus to USING_INTERNAL_CLOCK so the
; player can pass the receptionist. Its patch assumes the original address.
	vc_hook Link_fake_connection_status
	vc_assert hSerialConnectionStatus == $ffcb, \
		"hSerialConnectionStatus is no longer located at 00:ffcb."
	vc_assert USING_INTERNAL_CLOCK == $02, "USING_INTERNAL_CLOCK is no longer equal to $02."
	ldh [rSC], a
	call DelayFrame
	call DelayFrame
	call DelayFrame

.no_link_action
	ld a, $2
	ld [wLinkTimeoutFrames + 1], a
	ld a, $ff ; low byte of the receptionist's retry counter
	ld [wLinkTimeoutFrames], a
.connection_loop
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .connected
	cp USING_EXTERNAL_CLOCK
	jr z, .connected
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ld a, USING_INTERNAL_CLOCK
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	xor a ; redundant?
	ldh [rSC], a
	ld a, SC_START | SC_EXTERNAL
	ldh [rSC], a
	ld hl, wLinkTimeoutFrames
	dec [hl]
	jr nz, .try_internal_clock
	inc hl
	dec [hl]
	jr z, .timeout

.try_internal_clock
	ld a, USING_EXTERNAL_CLOCK
	ldh [rSB], a
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
	call DelayFrame
	jr .connection_loop

.connected
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	ld c, 50
	call DelayFrames
	ld a, TRUE
	ldh [hScriptVar], a
	ret

.timeout
	xor a
	ldh [hScriptVar], a
	ret

Special_CheckLinkTimeout:
; Initial connection check performed by the link receptionist.
	ld a, $1
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, $3
	ld [hli], a
	xor a
	ld [hl], a
	call ApplyTilemapInVBlank
	ld a, VBLANK_SOUND_ONLY
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
	call Link_CheckCommunicationError
	xor a
	ldh [hVBlank], a
	ldh a, [hScriptVar]
	and a
	ret nz
	jmp Link_ResetSerialRegistersAfterLinkClosure

CheckLinkTimeout_Gen2:
; If hScriptVar is zero on exit, the connection has timed out.
	ld a, LINK_ACTION_READY
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, $3
	ld [hli], a
	xor a
	ld [hl], a
	call ApplyTilemapInVBlank
	ld a, VBLANK_SOUND_ONLY
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
	call Link_CheckCommunicationError
	ldh a, [hScriptVar]
	and a
	jr z, .exit
; Wait about $70000 cycles to give the other Game Boy time to be ready.
	ld bc, -1
.peer_ready_delay
	dec bc
	ld a, b
	or c
	jr nz, .peer_ready_delay
; Disconnect if the other player has not reached the first ready handshake.
	ld a, [wOtherPlayerLinkMode]
	cp LINK_ACTION_READY
	jr nz, .timeout
; A second ready handshake increases reliability.
	ld a, LINK_ACTION_READY_CONFIRM
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	vc_patch Wireless_net_delay_7
if DEF(VIRTUAL_CONSOLE)
	ld a, $3
else
	ld a, 1
endc
	vc_patch_end
	ld [hli], a
	ld [hl], 50
	call Link_CheckCommunicationError
	ld a, [wOtherPlayerLinkMode]
	cp LINK_ACTION_READY_CONFIRM
	jr z, .exit

.timeout
	xor a
	ldh [hScriptVar], a
	ret

.exit
	xor a
	ldh [hVBlank], a
	ret

Link_CheckCommunicationError:
	xor a
	ldh [hSerialReceivedNewData], a
	vc_hook Wireless_prompt
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
	jr .done

.load_true
	ld a, TRUE

.done
	ldh [hScriptVar], a
	ld hl, wLinkTimeoutFrames
	xor a
	ld [hli], a
	ld [hl], a
	ret

.CheckConnected:
	call WaitLinkTransfer
	ld hl, wLinkTimeoutFrames
	vc_hook Wireless_net_recheck
	ld a, [hli]
	inc a
	ret nz
	ld a, [hl]
	inc a
	ret

.AcknowledgeSerial:
	vc_patch Wireless_net_delay_5
if DEF(VIRTUAL_CONSOLE)
	ld b, 26
else
	ld b, 10
endc
	vc_patch_end
.acknowledge_loop
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge_loop
	ret

.ConvertDW:
; [wLinkTimeoutFrames] = ((HL - $100) / 4) + $100
;                      = (HL / 4) + $c0
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
	ld a, [wChosenCableClubRoom]
	push af
	farcall Link_SaveGame
	vc_hook Wireless_TQS_block_input_1
	ld a, TRUE
	jr nc, .return_result
	vc_hook Wireless_TQS_block_input_2
	xor a ; FALSE
.return_result
	ldh [hScriptVar], a
	pop af
	ld [wChosenCableClubRoom], a
	ret

PrepareForLinkTransfers:
	call CheckLinkTimeout_Gen2
	ldh a, [hScriptVar]
	and a
	jmp z, LinkTimeout
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .player_1

	ld c, 3
	call DelayFrames
	xor a
	ldh [hSerialSend], a
	inc a
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
	call DelayFrame
	xor a
	ldh [hSerialSend], a
	inc a
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a

.player_1:
	ld e, MUSIC_NONE
	call PlayMusic
	vc_patch Wireless_net_delay_6
if DEF(VIRTUAL_CONSOLE)
	ld c, 26
else
	ld c, 3
endc
	vc_patch_end
	call DelayFrames
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL
	ldh [rIE], a
	ret

PerformLinkChecks:
	xor a
	ld bc, wLinkReceivedPolishedMiscBufferEnd - wLinkReceivedPolishedMiscBuffer
	ld hl, wLinkReceivedPolishedMiscBuffer
	rst ByteFill

	; This acts as the old Special_CheckBothSelectedSameRoom.
	; We send a dummy byte here that will cause old versions
	; of Polished Crystal's CheckBothSelectedSameRoom function
	; to fail.
	ld a, LINK_ROOM_DUMMY - 1
	call Link_ExchangeNybble
	cp LINK_ROOM_DUMMY - 1
	jmp nz, .OldVersionDetected

	; Prepare for multiple byte transfers
	ldh a, [rIF]
	push af
	ldh a, [rIE]
	push af
	call PrepareForLinkTransfers

	; Perform game ID byte transfer.
	; hl needs to be set to wLinkPolishedMiscBuffer
	; so we load the values in reverse.
	ld hl, wLinkPolishedMiscGameID
	ld a, LINK_GAME_ID
	ld [hld], a
	ld a, SERIAL_POLISHED_PREAMBLE_BYTE
	ld [hld], a
	ld [hl], SERIAL_PREAMBLE_BYTE
	ld de, wLinkReceivedPolishedMiscBuffer
	; bc is the number of bytes we should transfer.
	; It needs to account for the maximum number of
	; preamble bytes that can be sent plus the number
	; of data bytes.
	ld bc, SERIAL_POLISHED_MAX_PREAMBLE_LENGTH + wLinkPolishedMiscGameIDEnd - wLinkPolishedMiscGameID
	call Serial_ExchangeBytes

	; Save other game ID and check link compatibility
	call .SkipPreambleBytes
	ld [wLinkOtherPlayerGameID], a
	; Is other game ID == our game ID?
	cp LINK_GAME_ID
	jr z, .game_id_ok
	; Is other game ID != the other compatible game ID?
	cp OTHER_GAME_ID
	jmp nz, .WrongGameID
	; The other game ID can be traded with but not battled
	ld a, [wChosenCableClubRoom]
	cp CABLECLUBROOM_COLOSSEUM
	jmp z, .WrongGameID
.game_id_ok

	; Perform version and room byte transfers
	ld hl, wLinkPolishedMiscRoom
	ld a, [wChosenCableClubRoom]
	ld [hld], a
	ld a, LOW(LINK_MIN_TRADE_VERSION)
	ld [hld], a
	ld a, HIGH(LINK_MIN_TRADE_VERSION)
	ld [hld], a
	ld a, LOW(LINK_VERSION)
	ld [hld], a
	ld a, HIGH(LINK_VERSION)
	ld [hld], a
	ld a, SERIAL_POLISHED_PREAMBLE_BYTE
	ld [hld], a
	ld [hl], SERIAL_PREAMBLE_BYTE
	ld de, wLinkReceivedPolishedMiscBuffer
	ld bc, SERIAL_POLISHED_MAX_PREAMBLE_LENGTH + wLinkPolishedMiscVersionEnd - wLinkPolishedMiscVersion
	call Serial_ExchangeBytes

	; Save version and room bytes
	call .SkipPreambleBytes
	ld [wLinkOtherPlayerVersion], a
	ld a, [de]
	ld [wLinkOtherPlayerVersion + 1], a
	inc de
	ld a, [de]
	ld [wLinkOtherPlayerMinTradeVersion], a
	inc de
	ld a, [de]
	ld [wLinkOtherPlayerMinTradeVersion + 1], a
	inc de
	ld a, [de]
	ld b, a
	; Check correct room
	ld a, [wChosenCableClubRoom]
	cp b
	jr nz, .WrongRoom
	inc a
	ld [wLinkMode], a
	; Check version
	call CheckCorrectLinkVersion
	cp LINK_VERSION_COMPATIBLE
	jr c, .WrongVersion
	jr nz, .WrongMinVersion

	; Perform options byte transfers
	ld hl, wLinkPolishedMiscOptions2
	ld a, [wInitialOptions2]
	ld [hld], a
	ld a, [wInitialOptions]
	ld [hld], a
	ld a, SERIAL_POLISHED_PREAMBLE_BYTE
	ld [hld], a
	ld [hl], SERIAL_PREAMBLE_BYTE
	ld de, wLinkReceivedPolishedMiscBuffer
	ld bc, SERIAL_POLISHED_MAX_PREAMBLE_LENGTH + wLinkPolishedMiscOptionsEnd - wLinkPolishedMiscOptions
	call Serial_ExchangeBytes
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ld c, 66
	call z, DelayFrames

	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr z, .skip_options
	; Perform options check
	call .SkipPreambleBytes
	ld b, a
	ld a, [wInitialOptions]
	xor b
	and LINK_OPTMASK
	jr nz, .WrongOptions
	ld a, [de]
	ld b, a
	ld a, [wInitialOptions2]
	xor b
	and EV_OPTMASK
	jr nz, .WrongOptions
.skip_options

	; Process link opponent gender
	ld a, [wPlayerGender]
	call Link_ExchangeNybble
	ld [wLinkOtherPlayerGender], a
	xor a
	ldh [hVBlank], a
	; fallthrough
.Success
	inc a ; LINK_ERR_SUCCESS
	jr .return_result_restore_interrupts

.OldVersionDetected
	xor a ; LINK_ERR_OLD_PC_DETECT
	; fallthrough
.return_result:
	ldh [hScriptVar], a
	ret

.WrongGameID
	ld a, LINK_ERR_MISMATCH_GAME_ID
	jr .return_result_restore_interrupts

.WrongVersion
	ld a, LINK_ERR_MISMATCH_VERSION
	jr .return_result_restore_interrupts

.WrongMinVersion
	cp LINK_VERSION_SELF_TOO_OLD
	ld a, LINK_ERR_VERSION_TOO_LOW
	jr z, .return_result_restore_interrupts
	inc a ; LINK_ERR_OTHER_VERSION_TOO_LOW
	jr .return_result_restore_interrupts

.WrongOptions
	ld a, LINK_ERR_MISMATCH_GAME_OPTIONS
	jr .return_result_restore_interrupts

.WrongRoom
	ld a, LINK_ERR_INCOMPATIBLE_ROOMS
	; fallthrough
.return_result_restore_interrupts
	ldh [hScriptVar], a
	pop af
	ldh [rIE], a
	pop af
	ldh [rIF], a
	ld e, MUSIC_POKEMON_CENTER
	jmp PlayMusic

.SkipPreambleBytes
; This sub function skips over the no longer
; needed preamble bytes.
	ld de, wLinkReceivedPolishedMiscBuffer
.skip_preamble_loop
	ld a, [de]
	inc de
	cp SERIAL_POLISHED_PREAMBLE_BYTE
	jr nz, .skip_preamble_loop
	ld a, [de]
	inc de
	ret

CheckCorrectLinkVersion:
; Return a LINK_VERSION_* result in A; trades check minimum versions, while
; battles require equal versions. Version words are transferred high byte first.
	ld hl, wLinkOtherPlayerVersion
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr z, .trade_center

	; Is other game version == LINK_VERSION?
	ld a, [hli]
	cp HIGH(LINK_VERSION)
	jr nz, .version_not_equal
	ld a, [hl]
	cp LOW(LINK_VERSION)
	jr z, .success
	jr .version_not_equal

.trade_center
	; Is other game version >= LINK_MIN_TRADE_VERSION?
	ld a, [hli]
	cp HIGH(LINK_MIN_TRADE_VERSION)
	jr z, .check_other_version_low
	jr c, .other_game_below_min_version
.check_other_version_low
	ld a, [hl]
	cp LOW(LINK_MIN_TRADE_VERSION)
	jr z, .check_other_min_version
	jr c, .other_game_below_min_version

.check_other_min_version
	; Is LINK_VERSION >= other game min trade version?
	ld hl, wLinkOtherPlayerMinTradeVersion
	ld a, [hli]
	cp HIGH(LINK_VERSION)
	jr z, .check_other_min_version_low
	jr nc, .below_trade_min_version
.check_other_min_version_low
	ld a, [hl]
	cp LOW(LINK_VERSION)
	jr z, .success
	jr nc, .below_trade_min_version
	;fallthrough
.success
	xor a
	inc a ; LINK_VERSION_COMPATIBLE
	ret
.version_not_equal
	xor a ; LINK_VERSION_INCOMPATIBLE
	ret
.other_game_below_min_version
	ld a, LINK_VERSION_PEER_TOO_OLD
	ret
.below_trade_min_version
	ld a, LINK_VERSION_SELF_TOO_OLD
	ret

Link_ExchangeNybble:
	call Link_EnsureSync
	push af
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	pop af
	ret

Special_TradeCenter:
	vc_hook Wireless_TradeCenter
	ld a, LINK_TRADECENTER
	jr _Special_LinkCommunications

Special_Colosseum:
	vc_hook Wireless_Colosseum
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
	vc_hook Wireless_room_check
	; fallthrough

Link_ResetSerialRegistersAfterLinkClosure:
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ld a, USING_INTERNAL_CLOCK
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	ldh [rSC], a
	ret

Special_FailedLinkToPast:
	ld c, 40
	call DelayFrames
	ld a, LINK_ACTION_FAILED
	; fallthrough

Link_EnsureSync:
; Exchange a four-bit action with the sync high nybble, returning it in A.
	add SERIAL_SYNC_PREAMBLE_BYTE
	ld [wLinkPlayerSyncBuffer], a
	ld [wLinkPlayerSyncBuffer + 1], a
	ld a, VBLANK_SOUND_ONLY
	ldh [hVBlank], a
	call DelayFrame
	call DelayFrame
.receive_loop
	call Serial_ExchangeSyncBytes
	ld a, [wLinkReceivedSyncBuffer]
	ld b, a
	and SERIAL_MODE_MASK
	cp SERIAL_SYNC_PREAMBLE_BYTE
	jr z, .done
	ld a, [wLinkReceivedSyncBuffer + 1]
	ld b, a
	and SERIAL_MODE_MASK
	cp SERIAL_SYNC_PREAMBLE_BYTE
	jr nz, .receive_loop

.done
	xor a
	ldh [hVBlank], a
	ld a, b
	and SERIAL_ACTION_MASK
	ret

Special_CableClubCheckWhichChris:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	ld a, TRUE
	jr z, .yes
	dec a ; FALSE

.yes
	ldh [hScriptVar], a
	ret

InitLinkTradePalMap:
; Palette slots 2-7 use LinkTradePalette; the layout differs from pokecrystal.
	hlcoord 0, 0, wAttrmap
	lb bc, 16, 2
	ld a, $4
	call .fill_box
	ld a, $3
	ldcoord_a 0, 1, wAttrmap
	ldcoord_a 0, 14, wAttrmap
	hlcoord 2, 0, wAttrmap
	lb bc, 8, 18
	ld a, $5
	call .fill_box
	hlcoord 2, 8, wAttrmap
	lb bc, 8, 18
	ld a, $6
	call .fill_box
	hlcoord 0, 16, wAttrmap
	lb bc, 2, SCREEN_WIDTH
	ld a, $4
	call .fill_box
	ld a, $3
	lb bc, PARTY_LENGTH, 1
	hlcoord 6, 1, wAttrmap
	call .fill_box
	ld a, $3
	lb bc, PARTY_LENGTH, 1
	hlcoord 17, 1, wAttrmap
	call .fill_box
	ld a, $3
	lb bc, PARTY_LENGTH, 1
	hlcoord 6, 9, wAttrmap
	call .fill_box
	ld a, $3
	lb bc, PARTY_LENGTH, 1
	hlcoord 17, 9, wAttrmap
	call .fill_box
	ld a, $2
	hlcoord 2, 16, wAttrmap
	ld [hli], a
	ld a, PAL_BG_TEXT
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], $2
	hlcoord 2, 17, wAttrmap
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

; hl = send data
; de = receive data
; bc = length of data
Serial_ExchangeBytes::
; Send BC bytes from HL, receive BC bytes at DE, and wait for the peer preamble.
	ld a, TRUE
	ldh [hSerialIgnoringInitialData], a
.exchange_loop
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
	jr z, .store_byte
	dec hl
	cp SERIAL_PREAMBLE_BYTE
	jr nz, .exchange_loop
	xor a
	ldh [hSerialIgnoringInitialData], a
	jr .exchange_loop

.store_byte
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .exchange_loop
	ret

Serial_ExchangeByte::
; Exchange hSerialSend for a received byte in A, retrying no-data bytes.
.timeout_loop
	xor a
	ldh [hSerialReceivedNewData], a
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .not_player_2
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
.not_player_2

.receive_loop
	ldh a, [hSerialReceivedNewData]
	and a
	jr nz, .await_new_data
	ldh a, [hSerialConnectionStatus]
	dec a
	jr nz, .not_player_1_or_timed_out
	call CheckLinkTimeoutFramesNonzero
	jr z, .not_player_1_or_timed_out
	call .ShortDelay
	push hl
	ld hl, wLinkTimeoutFrames + 1
	inc [hl]
	jr nz, .no_rollover_up
	dec hl
	inc [hl]

.no_rollover_up
	pop hl
	call CheckLinkTimeoutFramesNonzero
	jr nz, .receive_loop
	jr SerialDisconnected

.not_player_1_or_timed_out
	ldh a, [rIE]
	and IE_SERIAL | IE_TIMER | IE_VBLANK
	cp IE_SERIAL
	jr nz, .receive_loop
	ld a, [wLinkByteTimeout]
	dec a ; no-optimize inefficient WRAM increment/decrement
	ld [wLinkByteTimeout], a
	jr nz, .receive_loop
	ld a, [wLinkByteTimeout + 1]
	dec a ; no-optimize inefficient WRAM increment/decrement
	ld [wLinkByteTimeout + 1], a
	jr nz, .receive_loop
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .await_new_data

	ld a, 255
.long_delay_loop
	dec a
	jr nz, .long_delay_loop

.await_new_data
	xor a
	ldh [hSerialReceivedNewData], a
	ldh a, [rIE]
	and IE_SERIAL | IE_TIMER | IE_VBLANK
	sub IE_SERIAL
	jr nz, .non_serial_interrupts_enabled

	; A is zero after subtracting IE_SERIAL.
	assert LOW(SERIAL_LINK_BYTE_TIMEOUT) == 0
	ld [wLinkByteTimeout], a
	ld a, HIGH(SERIAL_LINK_BYTE_TIMEOUT)
	ld [wLinkByteTimeout + 1], a

.non_serial_interrupts_enabled
	ldh a, [hSerialReceive]
	cp SERIAL_NO_DATA_BYTE
	ret nz
	call CheckLinkTimeoutFramesNonzero
	jr z, .timed_out
	push hl
	ld hl, wLinkTimeoutFrames + 1
	ld a, [hl]
	dec a
	ld [hld], a
	inc a
	jr nz, .no_rollover
	dec [hl]

.no_rollover
	pop hl
	call CheckLinkTimeoutFramesNonzero
	jr z, SerialDisconnected

.timed_out
	ldh a, [rIE]
	and IE_SERIAL | IE_TIMER | IE_VBLANK
	cp IE_SERIAL
	ld a, SERIAL_NO_DATA_BYTE
	ret z
	ld a, [hl]
	ldh [hSerialSend], a
	call DelayFrame
	jmp .timeout_loop

.ShortDelay
	ld a, 15
.short_delay_loop
	dec a
	jr nz, .short_delay_loop
	ret

CheckLinkTimeoutFramesNonzero::
	push hl
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	or [hl]
	pop hl
	ret

SerialDisconnected::
; Mark disconnection by setting wLinkTimeoutFrames to $ffff; A is zero here.
	dec a
	ld [wLinkTimeoutFrames], a
	ld [wLinkTimeoutFrames + 1], a
	ret

; This is used to check that both players entered the same Cable Club room.
Serial_ExchangeSyncBytes::
	ld hl, wLinkPlayerSyncBuffer
	ld de, wLinkReceivedSyncBuffer
	ld c, $2
	ld a, TRUE
	ldh [hSerialIgnoringInitialData], a
.exchange
	call DelayFrame
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	ld b, a
	inc hl
	ldh a, [hSerialIgnoringInitialData]
	and a
	; Preserve the zero flag from the initial-data check.
	ld a, FALSE ; no-optimize a = 0
	ldh [hSerialIgnoringInitialData], a
	jr nz, .exchange
	ld a, b
	ld [de], a
	inc de
	dec c
	jr nz, .exchange
	ret

Serial_PlaceWaitingTextAndSyncAndExchangeNybble::
	call LoadTileMapToTempTileMap
	call PlaceWaitingText
	call WaitLinkTransfer
	jmp SafeLoadTempTileMapToTileMap

PlaceWaitingText::
	hlcoord 4, 10
	lb bc, 1, 10

	ld a, [wBattleMode]
	and a
	jr z, .not_in_battle

	call Textbox
	jr .place_text

.not_in_battle
	call LinkTextboxAtHL

.place_text
	hlcoord 5, 11
	ld de, .Waiting
	rst PlaceString
	ld c, 50
	jmp DelayFrames

.Waiting:
	db "Waiting…!@"

WaitLinkTransfer::
; Wait for a peer action, then receive and acknowledge it before returning.
	vc_hook Wireless_WaitLinkTransfer
	ld a, $ff
	ld [wOtherPlayerLinkAction], a
.wait_for_action
	call LinkTransfer
	call DelayFrame
	call CheckLinkTimeoutFramesNonzero
	jr z, .check_action
	push hl
	ld hl, wLinkTimeoutFrames + 1
	dec [hl]
	jr nz, .resume_polling
	dec hl
	dec [hl]
	jr nz, .resume_polling
	; The frame counter expired, so the peer may be disconnected.
	pop hl
	xor a
	jmp SerialDisconnected

.resume_polling
	pop hl

.check_action
	ld a, [wOtherPlayerLinkAction]
	inc a
	jr z, .wait_for_action

	vc_patch Wireless_net_delay_1
if DEF(VIRTUAL_CONSOLE)
	ld b, 26
else
	ld b, 10
endc
	vc_patch_end
.receive
	call DelayFrame
	call LinkTransfer
	dec b
	jr nz, .receive

	vc_patch Wireless_net_delay_2
if DEF(VIRTUAL_CONSOLE)
	ld b, 26
else
	ld b, 10
endc
	vc_patch_end
.acknowledge
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge

	ld a, [wOtherPlayerLinkAction]
	ld [wOtherPlayerLinkMode], a
	vc_hook Wireless_WaitLinkTransfer_ret
	ret

CheckPartyForMail:
	ld a, [wPartyCount]
	ld c, a
	ld hl, wPartyMon1Item
	ld de, wPartyMon2Item - wPartyMon1Item
.party_loop
	ld a, [hl]
	call ItemIsMail_a
	jr c, .has_mail
	add hl, de
	dec c
	jr nz, .party_loop
	ldh [hScriptVar], a
	ret

.has_mail
	ld a, TRUE
	ldh [hScriptVar], a
	ret
