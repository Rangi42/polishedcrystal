NPCTrade::
	ld a, e
	ld [wJumptableIndex], a
	call Trade_GetDialog
	ld b, CHECK_FLAG
	call TradeFlagAction
	ld a, TRADE_AFTER
	jr nz, .done

	ld a, TRADE_INTRO
	call PrintTradeText

	call YesNoBox
	ld a, TRADE_CANCEL
	jr c, .done

; Select givemon from party
	ld b, 6
	farcall SelectTradeOrDaycareMon
	ld a, TRADE_CANCEL
	jr c, .done

	ld e, TRADE_GIVEMON
	call GetTradeAttribute
	ld a, [wCurPartySpecies]
	cp [hl]
	ld a, TRADE_WRONG
	jr nz, .done

	ld b, SET_FLAG
	call TradeFlagAction

	ld hl, ConnectLinkCableText
	call PrintText

	call DoNPCTrade
	call .TradeAnimation
	call GetTradeMonNames

	ld hl, TradedForText
	call PrintText

	call RestartMapMusic

	ld a, TRADE_COMPLETE

.done
	jp PrintTradeText

.TradeAnimation:
	call DisableSpriteUpdates
	ld a, [wJumptableIndex]
	push af
	ld a, [wcf64]
	push af
	predef TradeAnimation
	pop af
	ld [wcf64], a
	pop af
	ld [wJumptableIndex], a
	jp ReturnToMapWithSpeechTextbox

TradeFlagAction:
	ld hl, wTradeFlags
	ld a, [wJumptableIndex]
	ld c, a
	predef FlagPredef
	ld a, c
	and a
	ret

Trade_GetDialog:
	ld e, TRADE_DIALOG
	call GetTradeAttribute
	ld a, [hl]
	ld [wcf64], a
	ret

DoNPCTrade:
	ld e, TRADE_GIVEMON
	call GetTradeAttribute
	ld a, [hl]
	ld [wPlayerTrademonSpecies], a

	ld e, TRADE_GETMON
	call GetTradeAttribute
	ld a, [hl]
	ld [wOTTrademonSpecies], a

	ld a, [wPlayerTrademonSpecies]
	ld de, wPlayerTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonOTName
	call CopyTradeName

	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	call CopyTradeName

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonID
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonDVs
	call Trade_CopyThreeBytes

	ld hl, wPartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld b, h
	ld c, l
	call GetCaughtGender
	ld [wPlayerTrademonCaughtData], a

	xor a
	ld [wOTTrademonCaughtData], a

	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	xor a
	ld [wMonType], a
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromPartyOrBox
	predef TryAddMonToParty

	ld e, TRADE_DIALOG
	call GetTradeAttribute
	ld a, [hl]
	cp 3
	ld b, MALE
	jr c, .male2
	ld b, FEMALE
.male2
	ld e, TRADE_BALL
	call GetTradeAttribute
	ld a, [hl]
	ld c, a
	farcall SetGiftPartyMonCaughtData

	ld e, TRADE_NICK
	call GetTradeAttribute
	ld de, wOTTrademonNickname
	call CopyTradeName

	ld hl, wPartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	ld e, TRADE_OT_NAME
	call GetTradeAttribute
	push hl
	ld de, wOTTrademonOTName
	call CopyTradeName
	pop hl
	ld de, wOTTrademonSenderName
	call CopyTradeName

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call CopyTradeName

	ld e, TRADE_DVS
	call GetTradeAttribute
	ld de, wOTTrademonDVs
	call Trade_CopyThreeBytes

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonDVs
	call Trade_CopyThreeBytes

	ld e, TRADE_PERSONALITY
	call GetTradeAttribute
	ld de, wOTTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonPersonality
	call Trade_CopyTwoBytes

	ld e, TRADE_OT_ID
	call GetTradeAttribute
	ld de, wOTTrademonID + 1
	call Trade_CopyTwoBytesReverseEndian

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Trade_CopyTwoBytes

	ld e, TRADE_ITEM
	call GetTradeAttribute
	push hl
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	pop hl
	ld a, [hl]
	ld [de], a

	push hl
	push de
	push bc
	push af
	ld a, [wCurPartyMon]
	push af
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall ComputeNPCTrademonStats
	pop af
	ld [wCurPartyMon], a
	jp PopAFBCDEHL

GetTradeAttribute:
	ld d, 0
	push de
	ld a, [wJumptableIndex]
	and $f
	swap a
	ld e, a
	ld d, 0
	ld hl, NPCTrades
	add hl, de
	add hl, de
	pop de
	add hl, de
	ret

Trade_GetAttributeOfCurrentPartymon:
	ld a, [wCurPartyMon]
	rst AddNTimes
	ret

Trade_GetAttributeOfLastPartymon:
	ld a, [wPartyCount]
	dec a
	rst AddNTimes
	ld e, l
	ld d, h
	ret

GetTradeMonName:
	push de
	ld [wd265], a
	call GetBasePokemonName
	ld hl, wStringBuffer1
	pop de
	ret

CopyTradeName:
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

Trade_CopyTwoBytes:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

Trade_CopyTwoBytesReverseEndian:
	ld a, [hli]
	ld [de], a
	dec de
	ld a, [hl]
	ld [de], a
	ret

Trade_CopyThreeBytes:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

GetTradeMonNames:
	ld e, TRADE_GETMON
	call GetTradeAttribute
	ld a, [hl]
	call GetTradeMonName

	ld de, wStringBuffer2
	call CopyTradeName

	ld e, TRADE_GIVEMON
	call GetTradeAttribute
	ld a, [hl]
	call GetTradeMonName

	ld de, wMonOrItemNameBuffer
	call CopyTradeName

	ld hl, wStringBuffer1
.loop
	ld a, [hli]
	cp "@"
	jr nz, .loop

	ld [hl], a ; "@"
	ret

GetCaughtGender:
	ld hl, MON_CAUGHTGENDER
	add hl, bc
	ld a, [hl]
	and CAUGHTGENDER_MASK
	rla
	ret

INCLUDE "data/events/npc_trades.asm"

PrintTradeText:
	push af
	call GetTradeMonNames
	pop af
	ld bc, 2 * 4
	ld hl, TradeTexts
	rst AddNTimes
	ld a, [wcf64]
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp PrintText

TradeTexts:
; intro
	dw TradeIntroText1
	dw TradeIntroText2
	dw TradeIntroText3
	dw TradeIntroText4

; cancel
	dw TradeCancelText1
	dw TradeCancelText2
	dw TradeCancelText3
	dw TradeCancelText4

; wrong mon
	dw TradeWrongText1
	dw TradeWrongText2
	dw TradeWrongText3
	dw TradeWrongText4

; completed
	dw TradeCompleteText1
	dw TradeCompleteText2
	dw TradeCompleteText3
	dw TradeCompleteText4

; after
	dw TradeAfterText1
	dw TradeAfterText2
	dw TradeAfterText3
	dw TradeAfterText4

ConnectLinkCableText:
	; OK, connect the Game Link Cable.
	text_jump UnknownText_0x1bd407
	db "@"

TradedForText:
	; traded givemon for getmon
	text_jump UnknownText_0x1bd429
	start_asm
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld hl, .done
	ret

.done
	; sound_dex_fanfare_80_109
	; interpret_data
	text_jump UnknownText_0x1bd445
	db "@"

TradeIntroText1:
	; I collect #MON. Do you have @ ? Want to trade it for my @ ?
	text_jump UnknownText_0x1bd449
	db "@"

TradeCancelText1:
	; You don't want to trade? Aww…
	text_jump UnknownText_0x1bd48c
	db "@"

TradeWrongText1:
	; Huh? That's not @ .  What a letdown…
	text_jump UnknownText_0x1bd4aa
	db "@"

TradeCompleteText1:
	; Yay! I got myself @ ! Thanks!
	text_jump UnknownText_0x1bd4d2
	db "@"

TradeAfterText1:
	; Hi, how's my old @  doing?
	text_jump UnknownText_0x1bd4f4
	db "@"

TradeIntroText2:
TradeIntroText3:
	; Hi, I'm looking for this #MON. If you have @ , would you trade it for my @ ?
	text_jump UnknownText_0x1bd512
	db "@"

TradeCancelText2:
TradeCancelText3:
	; You don't have one either? Gee, that's really disappointing…
	text_jump UnknownText_0x1bd565
	db "@"

TradeWrongText2:
TradeWrongText3:
	; You don't have @ ? That's too bad, then.
	text_jump UnknownText_0x1bd5a1
	db "@"

TradeCompleteText2:
	; Great! Thank you! I finally got @ .
	text_jump UnknownText_0x1bd5cc
	db "@"

TradeAfterText2:
	; Hi! The @ you traded me is doing great!
	text_jump UnknownText_0x1bd5f4
	db "@"

TradeIntroText4:
	; 's cute, but I don't have it. Do you have @ ? Want to trade it for my @ ?
	text_jump UnknownText_0x1bd621
	db "@"

TradeCancelText4:
	; You don't want to trade? Oh, darn…
	text_jump UnknownText_0x1bd673
	db "@"

TradeWrongText4:
	; That's not @ . Please trade with me if you get one.
	text_jump UnknownText_0x1bd696
	db "@"

TradeCompleteText4:
	; Wow! Thank you! I always wanted @ !
	text_jump UnknownText_0x1bd6cd
	db "@"

TradeAfterText4:
	; How is that @  I traded you doing? Your @ 's so cute!
	text_jump UnknownText_0x1bd6f5
	db "@"

TradeCompleteText3:
	; Uh? What happened?
	text_jump UnknownText_0x1bd731
	db "@"

TradeAfterText3:
	; Trading is so odd… I still have a lot to learn about it.
	text_jump UnknownText_0x1bd745
	db "@"
