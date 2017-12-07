LinkCommunications: ; 28000
	call ClearBGPalettes
	ld c, 80
	call DelayFrames
	call ClearScreen
	call ClearSprites
	call UpdateSprites
	xor a
	ld [hSCX], a
	ld [hSCY], a
	ld c, 80
	call DelayFrames
	call ClearScreen
	call UpdateSprites
	call LoadStandardFont
	call LoadFontsBattleExtra
	call LoadTradeScreenGFX
	call WaitBGMap2
	hlcoord 3, 8
	lb bc, 2, 12
	call LinkTextbox
	hlcoord 4, 10
	ld de, String_PleaseWait
	call PlaceString
	call SetTradeRoomBGPals
	call WaitBGMap2
	ld hl, wcf5d
	xor a
	ld [hli], a
	ld [hl], $50
	; fallthrough

Gen2ToGen2LinkComms: ; 28177
	call ClearLinkData
	call Link_PrepPartyData_Gen2
	call FixDataForLinkTransfer
	call Function29dba
	ld a, [ScriptVar]
	and a
	jp z, LinkTimeout
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .Player1
	ld c, 3
	call DelayFrames
	xor a
	ld [hSerialSend], a
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a
	call DelayFrame
	xor a
	ld [hSerialSend], a
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a

.Player1:
	ld de, MUSIC_NONE
	call PlayMusic
	ld c, 3
	call DelayFrames
	xor a
	ld [rIF], a
	ld a, $8
	ld [rIE], a
	ld hl, wLinkBuffer
	ld de, wLinkBufferEnd
	ld bc, 17
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a
	ld hl, wLinkData
	ld de, OTPlayerName
	ld bc, $1c2
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
	ld [rIF], a
	ld a, $1d
	ld [rIE], a
	ld de, MUSIC_NONE
	call PlayMusic
	call Link_CopyRandomNumbers
	ld hl, OTPlayerName
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
	ld a, SERIAL_NO_DATA_BYTE
	ld [hl], a
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
	ld bc, $190 ; 400
	call CopyBytes
	ld hl, wcb84
	ld bc, $c6 ; 198
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
	call CopyBytes
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
	call CopyBytes
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
	ld de, OTPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes
	ld de, OTPartyCount
	ld bc, 8
	call CopyBytes
	ld de, OTPlayerID
	ld bc, 2
	call CopyBytes
	ld de, OTPartyMons
	ld bc, OTPartyDataEnd - OTPartyMons
	call CopyBytes
	ld de, MUSIC_NONE
	call PlayMusic
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ld c, 66
	call z, DelayFrames
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr nz, .ready_to_trade
	ld a, CAL
	ld [OtherTrainerClass], a
	call ClearScreen
	call Link_WaitBGMap
	ld hl, Options2
	ld a, [hl]
	push af
	and $ff - (BATTLE_SWITCH | BATTLE_PREDICT)
	ld [hl], a
	ld hl, OTPlayerName
	ld de, OTClassName
	ld bc, NAME_LENGTH
	call CopyBytes
	call ReturnToMapFromSubmenu
	ld a, [wDisableTextAcceleration]
	push af
	ld a, $1
	ld [wDisableTextAcceleration], a
	ld a, [rIE]
	push af
	ld a, [rIF]
	push af
	xor a
	ld [rIF], a
	ld a, [rIE]
	set 1, a
	ld [rIE], a
	pop af
	ld [rIF], a
	predef StartBattle
	ld a, [rIF]
	ld h, a
	xor a
	ld [rIF], a
	pop af
	ld [rIE], a
	ld a, h
	ld [rIF], a
	pop af
	ld [wDisableTextAcceleration], a
	pop af
	ld [Options2], a
	farcall LoadPokemonData
	jp Function28b22

.ready_to_trade
	ld de, MUSIC_ROUTE_30
	call PlayMusic
	jp InitTradeMenuDisplay
; 283b2

LinkTimeout: ; 283b2
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
	ld [hVBlank], a
	push de
	hlcoord 0, 12
	lb bc, 4, 18
	push de
	call LinkTextbox
	pop de
	pop hl
	bccoord 1, 14
	call PlaceWholeStringInBoxAtOnce
	call RotateThreePalettesRight
	call ClearScreen
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	jp WaitBGMap2
; 283ed

.TooMuchTimeHasElapsed: ; 0x283ed
	; Too much time has elapsed. Please try again.
	text_jump UnknownText_0x1c4183
	db "@"
; 0x283f2

Function283f2: ; 283f2
	ld a, $1
	ld [hSerialIgnoringInitialData], a
.loop
	ld a, [hl]
	ld [hSerialSend], a
	call Serial_ExchangeByte
	push bc
	ld b, a
	inc hl
	ld a, 48
.delay_cycles
	dec a
	jr nz, .delay_cycles
	ld a, [hSerialIgnoringInitialData]
	and a
	ld a, b
	pop bc
	jr z, .load
	dec hl
	xor a
	ld [hSerialIgnoringInitialData], a
	jr .loop

.load
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret
; 28419

String_PleaseWait: ; 28419
	db "Please wait!@"
; 28426

ClearLinkData: ; 28426
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
; 28434

FixDataForLinkTransfer: ; 28434
	ld hl, wLinkBuffer
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, LinkBattleRNs - wLinkBuffer
.loop1
	ld [hli], a
	dec b
	jr nz, .loop1
	ld b, LinkBattleEarlyEnd - LinkBattleRNs
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
; 28499

Link_PrepPartyData_Gen2: ; 28595
	ld de, wLinkData
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, 6
.loop1
	ld [de], a
	inc de
	dec b
	jr nz, .loop1
	; de = $c806
	ld hl, PlayerName
	ld bc, NAME_LENGTH
	call CopyBytes
	; de = $c811
	ld hl, PartyCount
	ld bc, 1 + PARTY_LENGTH + 1
	call CopyBytes
	; de = $c819
	ld hl, PlayerID
	ld bc, 2
	call CopyBytes
	; de = $c81b
	ld hl, PartyMon1Species
	ld bc, PARTY_LENGTH * PARTYMON_STRUCT_LENGTH
	call CopyBytes
	; de = $c93b
	ld hl, PartyMonOT
	ld bc, PARTY_LENGTH * NAME_LENGTH
	call CopyBytes
	; de = $c97d
	ld hl, PartyMonNicknames
	ld bc, PARTY_LENGTH * PKMN_NAME_LENGTH
	call CopyBytes
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
	call CopyBytes
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
	call CopyBytes
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
; 28682

Link_CopyOTData: ; 2879e
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
; 287ab

Link_CopyRandomNumbers: ; 287ab
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret z
	ld hl, wLinkBufferEnd
	call Link_FindFirstNonControlCharacter_AllowZero
	ld de, LinkBattleRNs
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
; 287ca

Link_FindFirstNonControlCharacter_SkipZero: ; 287ca
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
; 287d8

Link_FindFirstNonControlCharacter_AllowZero: ; 287d8
.loop
	ld a, [hli]
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	dec hl
	ret
; 287e3

Link_WaitBGMap: ; 4d354
	call WaitBGMap
	jp WaitBGMap2

InitTradeMenuDisplay: ; 287e3
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
; 28803

InitTradeSpeciesList: ; 16d673
	ld hl, .TradeScreenTilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	farcall InitLinkTradePalMap
	call PlaceTradePartnerNamesAndParty
	hlcoord 10, 17
	ld de, .Cancel
	jp PlaceString
; 16d68f

.TradeScreenTilemap:
INCBIN "gfx/link_trade/16d465.tilemap"

.Cancel: ; 16d68f
	db "Cancel@"
; 16d696

PlaceTradePartnerNamesAndParty: ; fb60d
	hlcoord 4, 0
	ld de, PlayerName
	call PlaceString
	ld a, $14
	ld [bc], a
	hlcoord 4, 8
	ld de, OTPlayerName
	call PlaceString
	ld a, $14
	ld [bc], a
	hlcoord 7, 1
	ld de, PartySpecies
	call .PlaceSpeciesNames
	hlcoord 7, 9
	ld de, OTPartySpecies
.PlaceSpeciesNames: ; fb634
	ld c, $0
.loop
	ld a, [de]
	cp -1
	ret z
	ld [wd265], a
	push bc
	push hl
	push de
	push hl
	ld a, c
	ld [hProduct], a
	call GetPokemonName
	pop hl
	call PlaceString
	pop de
	inc de
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	inc c
	jr .loop
; fb656

LinkTrade_OTPartyMenu: ; 28803
	ld a, OTPARTYMON
	ld [MonType], a
	ld a, A_BUTTON | D_UP | D_DOWN
	ld [wMenuJoypadFilter], a
	ld a, [OTPartyCount]
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

LinkTradeOTPartymonMenuLoop: ; 28835
	call LinkTradeMenu
	ld a, d
	and a
	jp z, LinkTradePartiesMenuMasterLoop
	bit A_BUTTON_F, a
	jr z, .not_a_button
	ld hl, OTPartyCount
	ld de, OTPartyMonOT
	ld a, ENEMY_OT_NAME
	ld [wNamedObjectTypeBuffer], a
	ld hl, OTPartyMon1Species
	call LinkMonStatsScreen
	jp LinkTradePartiesMenuMasterLoop

.not_a_button
	bit D_UP_F, a
	jr z, .not_d_up
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [OTPartyCount]
	cp b
	jp nz, LinkTradePartiesMenuMasterLoop
	xor a
	ld [MonType], a
	call HideCursor
	push hl
	push bc
	ld bc, NAME_LENGTH
	add hl, bc
	ld [hl], " "
	pop bc
	pop hl
	ld a, [PartyCount]
	ld [wMenuCursorY], a
	jr LinkTrade_PlayerPartyMenu

.not_d_up
	bit D_DOWN_F, a
	jp z, LinkTradePartiesMenuMasterLoop
	jp Function28ac9
; 2888b

LinkMonStatsScreen: ; 4d319
	ld a, [wMenuCursorY]
	dec a
	ld [CurPartyMon], a
	call LowVolume
	predef StatsScreenInit
	ld a, [CurPartyMon]
	inc a
	ld [wMenuCursorY], a
	call ClearScreen
	call ClearBGPalettes
	call MaxVolume
	call LoadTradeScreenGFX
	call Link_WaitBGMap
	call InitTradeSpeciesList
	call SetTradeRoomBGPals
	jp WaitBGMap2

LinkTrade_PlayerPartyMenu: ; 2888b
	farcall InitLinkTradePalMap
	xor a
	ld [MonType], a
	ld a, A_BUTTON | D_UP | D_DOWN
	ld [wMenuJoypadFilter], a
	ld a, [PartyCount]
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
	call WaitBGMap2

LinkTradePartymonMenuLoop: ; 288c5
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
	ld [MonType], a
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
	ld a, [PartyCount]
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
; 2891c

LinkTradePartiesMenuMasterLoop: ; 2891c
	ld a, [MonType]
	and a
	jp z, LinkTradePartymonMenuLoop ; PARTYMON
	jp LinkTradeOTPartymonMenuLoop  ; OTPARTYMON
; 28926

LinkTradeMenu: ; 16d70c
	ld hl, w2DMenuFlags2
	res 7, [hl]
	ld a, [hBGMapMode]
	push af
	call .loop
	pop af
	ld [hBGMapMode], a
.GetJoypad: ; 16d713
	push bc
	push af
	ld a, [hJoyLast]
	and D_PAD
	ld b, a
	ld a, [hJoyPressed]
	and BUTTONS
	or b
	ld b, a
	pop af
	ld a, b
	pop bc
	ld d, a
	ret
; 16d725

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
; 16d759

.UpdateBGMapAndOAM: ; 16d759
	ld a, [hOAMUpdate]
	push af
	ld a, $1
	ld [hOAMUpdate], a
	call WaitBGMap
	pop af
	ld [hOAMUpdate], a
	xor a
	ld [hBGMapMode], a
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
; 16d77a

.UpdateCursor: ; 16d77a
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
	call AddNTimes
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
; 16d7e7

.TryAnims: ; 16d7e7
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
; 16d7fe

Function28926: ; 28926
	call LoadTileMapToTempTileMap
	ld a, [wMenuCursorY]
	push af
	hlcoord 0, 15
	lb bc, 1, 18
	call LinkTextbox
	hlcoord 2, 16
	ld de, .String_Stats_Trade
	call PlaceString
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
	call ScrollingMenuJoypad
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
	call ScrollingMenuJoypad
	bit D_LEFT_F, a
	jp nz, .joy_loop
	bit B_BUTTON_F, a
	jr nz, .b_button
	jr .try_trade

.show_stats
	pop af
	ld [wMenuCursorY], a
	ld hl, PartyCount
	ld de, PartyMonOT
	ld a, PARTY_OT_NAME
	ld [wNamedObjectTypeBuffer], a
	farcall LinkMonStatsScreen
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
	call AddNTimes
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
	ld hl, OTPartySpecies
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
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
	call PlaceString
	ld a, $1
	ld [wPlayerLinkAction], a
	call Function16d6ce
	ld c, 100
	call DelayFrames
	jp InitTradeMenuDisplay
; 28aaf

.Text_CantTradeLastMon: ; 0x28aaf
	; If you trade that #MON, you won't be able to battle.
	text_jump UnknownText_0x1c41b1
	db "@"
; 0x28ab4

.String_Stats_Trade: ; 28ab4
	db "Stats     Trade@"

.Text_Abnormal: ; 0x28ac4
	; Your friend's @  appears to be abnormal!
	text_jump UnknownText_0x1c41e6
	db "@"
; 0x28ac9

ValidateOTTrademon: ; fb57e
	ld a, [wd003]
	ld hl, OTPartyMon1Species
	call GetPartyLocation
	push hl
	ld a, [wd003]
	inc a
	ld c, a
	ld b, 0
	ld hl, OTPartyCount
	add hl, bc
	ld a, [hl]
	pop hl
	cp EGG
	jr z, .matching_or_egg
	cp [hl]
	jr nz, .abnormal

.matching_or_egg
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
; fb5dd

Functionfb5dd: ; fb5dd
	ld a, [wd002]
	ld d, a
	ld a, [PartyCount]
	ld b, a
	ld c, $0
.loop
	ld a, c
	cp d
	jr z, .next
	ld a, c
	ld hl, PartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	jr nz, .done

.next
	inc c
	dec b
	jr nz, .loop
	ld a, [wd003]
	ld hl, OTPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	jr nz, .done
	scf
	ret

.done
	and a
	ret
; fb60d

Function28ac9: ; 28ac9
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
Function28ade: ; 28ade
.loop1
	ld a, "▶"
	ldcoord_a 9, 17
.loop2
	call JoyTextDelay
	ld a, [hJoyLast]
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
	ld a, [OTPartyCount]
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
Function28b22: ; 28b22
	call RotateThreePalettesRight
	call ClearScreen
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call WaitBGMap2
	xor a
	ld [rSB], a
	ld [hSerialSend], a
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a
	ret
; 28b42

LinkEngine_FillBox: ; 28b77
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
; 28b87

LinkTrade: ; 28b87
	xor a
	ld [wcf57], a
	ld [wOtherPlayerLinkAction], a
	hlcoord 0, 12
	lb bc, 4, 18
	call LinkTextbox
	call Link_WaitBGMap
	ld a, [wd002]
	ld hl, PartySpecies
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [wd265], a
	call GetPokemonName
	ld hl, StringBuffer1
	ld de, wd004
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes
	ld a, [wd003]
	ld hl, OTPartySpecies
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
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
	call PlaceString
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
	call ScrollingMenuJoypad
	push af
	call Call_ExitMenu
	call WaitBGMap2
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
	call PlaceString
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
	call PlaceString
.asm_28ea3
	ld c, 100
	call DelayFrames
	jp InitTradeMenuDisplay
; 28eab

.asm_28c7b
	ld hl, sPartyMail
	ld a, [wd002]
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
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
	call CopyBytes
	pop bc
	jr .asm_28c96

.asm_28ca6
	ld hl, sPartyMail
	ld a, [PartyCount]
	dec a
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	push hl
	ld hl, wc9f4
	ld a, [wd003]
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	pop de
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes
	call CloseSRAM
	ld hl, PlayerName
	ld de, wPlayerTrademonSenderName
	ld bc, NAME_LENGTH
	call CopyBytes
	ld a, [wd002]
	ld hl, PartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wPlayerTrademonSpecies], a
	push af
	ld a, [wd002]
	ld hl, PartyMonOT
	call SkipNames
	ld de, wPlayerTrademonOTName
	ld bc, NAME_LENGTH
	call CopyBytes
	ld hl, PartyMon1ID
	ld a, [wd002]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonID], a
	ld a, [hl]
	ld [wPlayerTrademonID + 1], a
	ld hl, PartyMon1DVs
	ld a, [wd002]
	call GetPartyLocation
	ld a, [hli]
	ld [wPlayerTrademonDVs], a
	ld a, [hli]
	ld [wPlayerTrademonDVs + 1], a
	ld a, [hl]
	ld [wPlayerTrademonDVs + 2], a
	ld hl, PartyMon1Species
	ld a, [wd002]
	call GetPartyLocation
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld a, c
	ld [wPlayerTrademonCaughtData], a
	ld hl, OTPlayerName
	ld de, wOTTrademonSenderName
	ld bc, NAME_LENGTH
	call CopyBytes
	ld a, [wd003]
	ld hl, OTPartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wOTTrademonSpecies], a
	ld a, [wd003]
	ld hl, OTPartyMonOT
	call SkipNames
	ld de, wOTTrademonOTName
	ld bc, NAME_LENGTH
	call CopyBytes
	ld hl, OTPartyMon1ID
	ld a, [wd003]
	call GetPartyLocation
	ld a, [hli]
	ld [wOTTrademonID], a
	ld a, [hl]
	ld [wOTTrademonID + 1], a
	ld hl, OTPartyMon1DVs
	ld a, [wd003]
	call GetPartyLocation
	ld a, [hli]
	ld [wOTTrademonDVs], a
	ld a, [hli]
	ld [wOTTrademonDVs + 1], a
	ld a, [hl]
	ld [wOTTrademonDVs + 2], a
	ld hl, OTPartyMon1Species
	ld a, [wd003]
	call GetPartyLocation
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld a, c
	ld [wOTTrademonCaughtData], a
	ld a, [wd002]
	ld [CurPartyMon], a
	ld hl, PartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd002], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ld a, [PartyCount]
	dec a
	ld [CurPartyMon], a
	ld a, $1
	ld [wForceEvolution], a
	ld a, [wd003]
	push af
	ld hl, OTPartySpecies
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd003], a
	ld c, 100
	call DelayFrames
	call ClearTileMap
	call LoadFontsBattleExtra
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	ld a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player_2
	predef TradeAnimation
	jr .done_animation
.player_2
	predef TradeAnimationPlayer2
.done_animation
	pop af
	ld c, a
	ld [CurPartyMon], a
	ld hl, OTPartySpecies
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hl]
	ld [CurPartySpecies], a
	ld hl, OTPartyMon1Species
	ld a, c
	call GetPartyLocation
	ld de, TempMonSpecies
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	predef AddTempmonToParty
	ld a, [PartyCount]
	dec a
	ld [CurPartyMon], a
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
	ld a, [CurPartySpecies]
	cp MEW
	jr z, .loop
	ld b, $2
	ld a, c
	cp CELEBI
	jr z, .loop
	ld a, [CurPartySpecies]
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
	call PlaceString
	call Link_WaitBGMap
	ld c, 50
	call DelayFrames
	jp Gen2ToGen2LinkComms

.TradeCancel: ; 28eab
	db   "Trade"
	next "Cancel@"
; 28ea3

.TradeThisForThat: ; 0x28eb8
	; Trade @ for @ ?
	text_jump UnknownText_0x1c4212
	db "@"
; 0x28ebd

.TradeCompleted: ; 28ebd
	db   "Trade completed!@"

String_TooBadTheTradeWasCanceled: ; 28ece
	db   "Too bad! The trade"
	next "was canceled!@"

LinkTextbox:: ; 28eef
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
	ld de, AttrMap - TileMap
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
; 16d640

.fill_row: ; 4d3ab
	ld d, c
.row_loop
	ld [hli], a
	dec d
	jr nz, .row_loop
	ret

Function16d6ce: ; 16d6ce
	call LoadStandardMenuDataHeader
	hlcoord 5, 10
	lb bc, 1, 9
	call LinkTextbox
	hlcoord 6, 11
	ld de, .Waiting
	call PlaceString
	call WaitBGMap
	call WaitBGMap2
	ld c, 50
	call DelayFrames
	call Serial_SyncAndExchangeNybble
	call Call_ExitMenu
	jp WaitBGMap2
; 16d6e1

.Waiting: ; 16d701
	db "Waiting…!@"
; 16d70c

LoadTradeScreenGFX: ; 28ef8
	ld de, TradeScreenGFX
	ld hl, VTiles2
	lb bc, BANK(TradeScreenGFX), 70
	jp Get2bpp
; 28eff

TradeScreenGFX:
INCBIN "gfx/link_trade/border.2bpp"
; 16d421

SetTradeRoomBGPals: ; 28eff
	farcall LoadLinkTradePalette
	jp SetPalettes
; 28f09

INCLUDE "engine/trade_animation.asm"

WaitForOtherPlayerToExit: ; 29c92
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ld [hSerialConnectionStatus], a
	xor a
	ld [rSB], a
	ld [hSerialReceive], a
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a
	ld c, 3
	call DelayFrames
	xor a
	ld [rSB], a
	ld [hSerialReceive], a
	xor a ; redundant?
	ld [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ld [rSC], a
	ld c, 3
	call DelayFrames
	xor a
	ld [rSB], a
	ld [hSerialReceive], a
	ld [rSC], a
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ld [hSerialConnectionStatus], a
	ld a, [rIF]
	push af
	xor a
	ld [rIF], a
	ld a, $f
	ld [rIE], a
	pop af
	ld [rIF], a
	ld hl, wLinkTimeoutFrames
	xor a
	ld [hli], a
	ld [hl], a
	ld [hVBlank], a
	ld [wLinkMode], a
	ret
; 29ce8

Special_SetBitsForLinkTradeRequest: ; 29ce8
	ld a, LINK_TRADECENTER - 1
	ld [wPlayerLinkAction], a
	ld [wd265], a
	ret
; 29cf1

Special_SetBitsForBattleRequest: ; 29cf1
	ld a, LINK_COLOSSEUM - 1
	ld [wPlayerLinkAction], a
	ld [wd265], a
	ret
; 29cfa

Special_WaitForLinkedFriend: ; 29d11
	ld a, [wPlayerLinkAction]
	and a
	jr z, .no_link_action
	ld a, $2
	ld [rSB], a
	xor a
	ld [hSerialReceive], a
	xor a ; redundant?
	ld [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ld [rSC], a
	call DelayFrame
	call DelayFrame
	call DelayFrame

.no_link_action
	ld a, $2
	ld [wLinkTimeoutFrames + 1], a
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [wLinkTimeoutFrames], a
.loop
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .connected
	cp USING_EXTERNAL_CLOCK
	jr z, .connected
	ld a, CONNECTION_NOT_ESTABLISHED
	ld [hSerialConnectionStatus], a
	ld a, $2
	ld [rSB], a
	xor a
	ld [hSerialReceive], a
	xor a ; redundant?
	ld [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ld [rSC], a
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
	ld [rSB], a
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a
	call DelayFrame
	jr .loop

.connected
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	ld c, $32
	call DelayFrames
	ld a, $1
	ld [ScriptVar], a
	ret

.done
	xor a
	ld [ScriptVar], a
	ret
; 29d92

Special_CheckLinkTimeout: ; 29d92
	ld a, $1
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, $3
	ld [hli], a
	xor a
	ld [hl], a
	call WaitBGMap
	ld a, $2
	ld [hVBlank], a
	call DelayFrame
	call DelayFrame
	call Link_CheckCommunicationError
	xor a
	ld [hVBlank], a
	ld a, [ScriptVar]
	and a
	ret nz
	jp Link_ResetSerialRegistersAfterLinkClosure
; 29dba

Function29dba: ; 29dba
	ld a, $5
	ld [wPlayerLinkAction], a
	ld hl, wLinkTimeoutFrames
	ld a, $3
	ld [hli], a
	xor a
	ld [hl], a
	call WaitBGMap
	ld a, $2
	ld [hVBlank], a
	call DelayFrame
	call DelayFrame
	call Link_CheckCommunicationError
	ld a, [ScriptVar]
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
	ld [ScriptVar], a
	ret

.vblank
	xor a
	ld [hVBlank], a
	ret
; 29e0c

Link_CheckCommunicationError: ; 29e0c
	xor a
	ld [hSerialReceivedNewData], a
	ld a, [wLinkTimeoutFrames]
	ld h, a
	ld a, [wLinkTimeoutFrames + 1]
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
	ld [ScriptVar], a
	ld hl, wLinkTimeoutFrames
	xor a
	ld [hli], a
	ld [hl], a
	ret
; 29e3b

.CheckConnected: ; 29e3b
	call Serial_SyncAndExchangeNybble
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	inc a
	ret nz
	ld a, [hl]
	inc a
	ret
; 29e47

.AcknowledgeSerial: ; 29e47
	ld b, $a
.loop
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .loop
	ret
; 29e53

.ConvertDW: ; 29e53
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
; 29e66

Special_TryQuickSave: ; 29e66
	ld a, [wd265]
	push af
	farcall Link_SaveGame
	ld a, $1
	jr nc, .return_result
	xor a
.return_result
	ld [ScriptVar], a
	ld c, 30
	call DelayFrames
	pop af
	ld [wd265], a
	ret
; 29e82

Special_CheckBothSelectedSameRoom: ; 29e82
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
	ld [hVBlank], a
	ld a, $1
	ld [ScriptVar], a
	ret

.fail
	xor a
	ld [ScriptVar], a
	ret
; 29eaf

Special_TradeCenter: ; 29ec4
	ld a, LINK_TRADECENTER
	jr _Special_LinkCommunications
; 29ed9

Special_Colosseum: ; 29ed9
	ld a, LINK_COLOSSEUM
_Special_LinkCommunications:
	ld [wLinkMode], a
	call DisableSpriteUpdates
	call LinkCommunications
	call EnableSpriteUpdates
	xor a
	ld [hVBlank], a
	ret
; 29eee

Special_CloseLink: ; 29eee
	xor a
	ld [wLinkMode], a
	ld c, $3
	call DelayFrames
	jp Link_ResetSerialRegistersAfterLinkClosure
; 29efa

Special_FailedLinkToPast: ; 29efa
	ld c, 40
	call DelayFrames
	ld a, $e
	jp Link_EnsureSync
; 29f04

Link_ResetSerialRegistersAfterLinkClosure: ; 29f04
	ld c, 3
	call DelayFrames
	ld a, CONNECTION_NOT_ESTABLISHED
	ld [hSerialConnectionStatus], a
	ld a, $2
	ld [rSB], a
	xor a
	ld [hSerialReceive], a
	ld [rSC], a
	ret
; 29f17

Link_EnsureSync: ; 29f17
	add $d0
	ld [wPlayerLinkAction], a
	ld [wcf57], a
	ld a, $2
	ld [hVBlank], a
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
	ld [hVBlank], a
	ld a, b
	and $f
	ret
; 29f47

Special_CableClubCheckWhichChris: ; 29f47
	ld a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	ld a, $1
	jr z, .yes
	dec a

.yes
	ld [ScriptVar], a
	ret
; 29f54

DetermineLinkBattleResult: ; 2b930
	farcall UpdateEnemyMonInParty
	ld hl, PartyMon1HP
	call .CountMonsRemaining
	push bc
	ld hl, OTPartyMon1HP
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
	ld hl, PartyMon1HP
	call .CalcPercentHPRemaining
	push de
	ld hl, OTPartyMon1HP
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

.CountMonsRemaining: ; 2b995
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

.CalcPercentHPRemaining: ; 2b9a6
	ld de, 0
	ld c, $3
.loop2
	ld a, [hli]
	or [hl]
	jr z, .next
	dec hl
	xor a
	ld [hDividend + 0], a
	ld a, [hli]
	ld [hDividend + 1], a
	ld a, [hli]
	ld [hDividend + 2], a
	xor a
	ld [hDividend + 3], a
	ld a, [hli]
	ld b, a
	ld a, [hld]
	srl b
	rr a
	srl b
	rr a
	ld [hDivisor], a
	ld b, $4
	call Divide
	ld a, [hQuotient + 2]
	add e
	ld e, a
	ld a, [hQuotient + 1]
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

.BothSides_CheckNumberMonsAtFullHealth: ; 2b9e1
	ld hl, PartyMon1HP
	call .CheckFaintedOrFullHealth
	jr nz, .finish ; we have a pokemon that's neither fainted nor at full health
	ld hl, OTPartyMon1HP
	call .CheckFaintedOrFullHealth
	ld e, $1
	ret

.finish
	ld hl, OTPartyMon1HP
	call .CheckFaintedOrFullHealth
	ld e, $0
	ret nz ; we both have pokemon that are neither fainted nor at full health
	ld e, $2
	ld a, $1
	and a
	ret

.CheckFaintedOrFullHealth: ; 2ba01
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
