WonderTrade::
	ld hl, DailyFlags2
	bit 3, [hl] ; ENGINE_DAILY_WONDER_TRADE
	jp nz, .already_traded

	ld hl, .Text_WonderTradeQuestion
	call PrintText
	call YesNoBox
	ret c

	ld hl, .Text_WonderTradePrompt
	call PrintText

	ld b, 6
	callba SelectTradeOrDaycareMon
	ret c

	ld hl, PartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, StringBuffer1
	call CopyTradeName
	ld hl, .Text_WonderTradeConfirm
	call PrintText
	call YesNoBox
	ret c

	ld hl, .Text_WonderTradeSetup
	call PrintText

	call DoWonderTrade

	ld hl, .Text_WonderTradeReady
	call PrintText

	call DisableSpriteUpdates
	predef TradeAnimation
	call ReturnToMapWithSpeechTextbox

	ld hl, DailyFlags2
	set 3, [hl] ; ENGINE_DAILY_WONDER_TRADE

	ld hl, .Text_WonderTradeComplete
	call PrintText

	call RestartMapMusic

	ld hl, PartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld a, [de]
	ld b, a
	ld a, GS_BALL
	cp b
	ret nz

	ld de, EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	ld b, SET_FLAG
	call EventFlagAction
	ld de, EVENT_CAN_GIVE_GS_BALL_TO_KURT
	ld b, SET_FLAG
	call EventFlagAction
	ld hl, .Text_WonderTradeForGSBallPichuText
	call PrintText
	ret

.already_traded
	ld hl, .Text_WonderTradeAlreadyDone
	call PrintText
	ret

.Text_WonderTradeQuestion:
	text_jump WonderTradeQuestionText
	db "@"

.Text_WonderTradePrompt:
	text_jump WonderTradePromptText
	db "@"

.Text_WonderTradeConfirm:
	text_jump WonderTradeConfirmText
	db "@"

.Text_WonderTradeSetup:
	text_jump WonderTradeSetupText
	db "@"

.Text_WonderTradeReady:
	text_jump WonderTradeReadyText
	db "@"

.Text_WonderTradeComplete:
	text_jump WonderTradeCompleteText
	start_asm
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld hl, .trade_done
	ret

.trade_done
	text_jump WonderTradeDoneFanfare
	db "@"

.Text_WonderTradeAlreadyDone:
	text_jump WonderTradeAlreadyDoneText
	db "@"

.Text_WonderTradeForGSBallPichuText:
	text_jump WonderTradeForGSBallPichuText
	db "@"

DoWonderTrade:
	ld a, [CurPartySpecies]
	ld [wPlayerTrademonSpecies], a

	; If you've beaten the Elite Four...
	ld de, EVENT_BEAT_ELITE_FOUR
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr z, .random_trademon
	; ...and haven't gotten the GS Ball Pichu yet...
	ld de, EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr nz, .random_trademon

	; ...then receive a shiny Pichu holding a GS Ball
	call GetGSBallPichu
	jp .compute_trademon_stats

.random_trademon
	ld a, NUM_POKEMON
	call RandomRange
	inc a
	ld [wOTTrademonSpecies], a
	call CheckValidLevel
	and a
	jr nz, .random_trademon

	ld a, [wPlayerTrademonSpecies]
	ld de, wPlayerTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld hl, PartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonOTName
	call CopyTradeName

	ld hl, PlayerName
	ld de, wPlayerTrademonSenderName
	call CopyTradeName

	ld hl, PartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonID
	call Trade_CopyTwoBytes

	ld hl, PartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, PartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld b, h
	ld c, l
	callba GetCaughtGender
	ld a, c
	ld [wPlayerTrademonCaughtData], a

	; BUG: Caught data doesn't seem to be saved.
	; Look at source code for SetGiftPartyMonCaughtData.
	xor a
	ld [wOTTrademonCaughtData], a

	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld [CurPartyLevel], a
	ld a, [wOTTrademonSpecies]
	ld [CurPartySpecies], a
	xor a
	ld [MonType], a
	ld [wPokemonWithdrawDepositParameter], a
	callab RemoveMonFromPartyOrBox
	predef TryAddMonToParty

	ld b, RESET_FLAG
	callba SetGiftPartyMonCaughtData

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonNickname
	call GetTradeMonName
	call CopyTradeName

	ld hl, PartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	; a = random byte
	; OT ID = (a ^ %10101010) << 8 | a
	call Random
	ld [Buffer1], a
	ld b, %10101010
	xor b
	ld [Buffer1 + 1], a
	ld hl, Buffer1
	ld de, wOTTrademonID
	call Trade_CopyTwoBytes

	ld hl, PartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Trade_CopyTwoBytes

	ld a, [wOTTrademonID]
	call GetWonderTradeOTName
	push hl
	ld de, wOTTrademonOTName
	call CopyTradeName
	pop hl
	ld de, wOTTrademonSenderName
	call CopyTradeName

	ld hl, PartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call CopyTradeName

	; Random DVs
	call Random
	ld [Buffer1], a
	call Random
	ld [Buffer1 + 1], a
	ld hl, Buffer1
	ld de, wOTTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, PartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, PartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	call GetWonderTradeHeldItem
	ld [de], a

.compute_trademon_stats
	push af
	push bc
	push de
	push hl
	ld a, [CurPartyMon]
	push af
	ld a, [PartyCount]
	dec a
	ld [CurPartyMon], a
	callba ComputeNPCTrademonStats
	pop af
	ld [CurPartyMon], a
	pop hl
	pop de
	pop bc
	pop af
	ret


GetGSBallPichu:
	ld a, PICHU
	ld [wOTTrademonSpecies], a

	ld a, [wPlayerTrademonSpecies]
	ld de, wPlayerTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld hl, PartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonOTName
	call CopyTradeName

	ld hl, PlayerName
	ld de, wPlayerTrademonSenderName
	call CopyTradeName

	ld hl, PartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonID
	call Trade_CopyTwoBytes

	ld hl, PartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, PartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld b, h
	ld c, l
	callba GetCaughtGender
	ld a, c
	ld [wPlayerTrademonCaughtData], a

	; BUG: Caught data doesn't seem to be saved.
	; Look at source code for SetGiftPartyMonCaughtData.
	xor a
	ld [wOTTrademonCaughtData], a

	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, 30
	ld [CurPartyLevel], a
	ld a, [wOTTrademonSpecies]
	ld [CurPartySpecies], a
	xor a
	ld [MonType], a
	ld [wPokemonWithdrawDepositParameter], a
	callab RemoveMonFromPartyOrBox
	predef TryAddMonToParty

	ld b, RESET_FLAG
	callba SetGiftPartyMonCaughtData

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonNickname
	call GetTradeMonName
	call CopyTradeName

	ld hl, PartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	ld hl, PlayerID
	ld de, wOTTrademonID
	call Trade_CopyTwoBytes

	ld hl, PartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Trade_CopyTwoBytes

	ld hl, PlayerName
	push hl
	ld de, wOTTrademonOTName
	call CopyTradeName
	pop hl
	ld de, wOTTrademonSenderName
	call CopyTradeName

	ld hl, PartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call CopyTradeName

	ld a, ATKDEFDV_SHINY
	ld [wOTTrademonDVs], a
	ld a, SPDSPCDV_SHINY
	ld [wOTTrademonDVs + 1], a

	ld hl, PartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, PartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld a, GS_BALL
	ld [de], a

	ret

GetWonderTradeOTName:
; hl = .WonderTradeOTNameTable + a * PLAYER_NAME_LENGTH
	ld hl, .WonderTradeOTNameTable
	ld b, 0
	ld c, PLAYER_NAME_LENGTH
	call AddNTimes
	ret

; TODO: Associate each OT name with a correct gender (via wOTTrademonCaughtData?)
.WonderTradeOTNameTable:
	db "Nemo@@@@" ; $00
	db "Rangi@@@" ; $01
	db "Satoshi@" ; $02
	db "Tajiri@@" ; $03
	db "Satoru@@" ; $04
	db "Iwata@@@" ; $05
	db "Junichi@" ; $06
	db "Masuda@@" ; $07
	db "Imakuni@" ; $08
	db "Bryan@@@" ; $09
	db "Crystal@" ; $0A
	db "Mateo@@@" ; $0B
	db "Drayano@" ; $0C
	db "Pum@@@@@" ; $0D
	db "James@@@" ; $0E
	db "Marckus@" ; $0F
	db "Brock@@@" ; $10
	db "Misty@@@" ; $11
	db "Surge@@@" ; $12
	db "Erika@@@" ; $13
	db "Janine@@" ; $14
	db "Sabrina@" ; $15
	db "Blaine@@" ; $16
	db "Blue@@@@" ; $17
	db "Lorelei@" ; $18
	db "Bruno@@@" ; $19
	db "Agatha@@" ; $1A
	db "Lance@@@" ; $1B
	db "Falkner@" ; $1C
	db "Bugsy@@@" ; $1D
	db "Whitney@" ; $1E
	db "Morty@@@" ; $1F
	db "Chuck@@@" ; $20
	db "Jasmine@" ; $21
	db "Pryce@@@" ; $22
	db "Clair@@@" ; $23
	db "Will@@@@" ; $24
	db "Koga@@@@" ; $25
	db "Karen@@@" ; $26
	db "Red@@@@@" ; $27
	db "Green@@@" ; $28
	db "Yellow@@" ; $29
	db "Gold@@@@" ; $2A
	db "Silver@@" ; $2B
	db "Ruby@@@@" ; $2C
	db "Safire@@" ; $2D
	db "Emerald@" ; $2E
	db "Diamond@" ; $2F
	db "Pearl@@@" ; $30
	db "Black@@@" ; $31
	db "White@@@" ; $32
	db "Ash@@@@@" ; $33
	db "Gary@@@@" ; $34
	db "Richie@@" ; $35
	db "Ethan@@@" ; $36
	db "Lyra@@@@" ; $37
	db "Brendan@" ; $38
	db "May@@@@@" ; $39
	db "Wally@@@" ; $3A
	db "Lucas@@@" ; $3B
	db "Dawn@@@@" ; $3C
	db "Barry@@@" ; $3D
	db "Leaf@@@@" ; $3E
	db "Hilbert@" ; $3F
	db "Hilda@@@" ; $40
	db "Cheren@@" ; $41
	db "Bianca@@" ; $42
	db "Nate@@@@" ; $43
	db "Rosa@@@@" ; $44
	db "Hugh@@@@" ; $45
	db "Calem@@@" ; $46
	db "Serena@@" ; $47
	db "Shauna@@" ; $48
	db "Trevor@@" ; $49
	db "Tierno@@" ; $4A
	db "Hibiki@@" ; $4B
	db "Kotone@@" ; $4C
	db "Yuuki@@@" ; $4D
	db "Haruka@@" ; $4E
	db "Mitsuru@" ; $4F
	db "Kouki@@@" ; $50
	db "Hikari@@" ; $51
	db "Jun@@@@@" ; $52
	db "Touya@@@" ; $53
	db "Touko@@@" ; $54
	db "Bel@@@@@" ; $55
	db "Kyouhei@" ; $56
	db "Mei@@@@@" ; $57
	db "Oak@@@@@" ; $58
	db "Elm@@@@@" ; $59
	db "Birch@@@" ; $5A
	db "Rowan@@@" ; $5B
	db "Juniper@" ; $5C
	db "Ivy@@@@@" ; $5D
	db "Hala@@@@" ; $5E
	db "Kukui@@@" ; $5F
	db "Bill@@@@" ; $60
	db "Lanette@" ; $61
	db "Celio@@@" ; $62
	db "Bebe@@@@" ; $63
	db "Amanita@" ; $64
	db "Cassius@" ; $65
	db "Joey@@@@" ; $66
	db "AJ@@@@@@" ; $67
	db "Camila@@" ; $68
	db "Alice@@@" ; $69
	db "Leo@@@@@" ; $6A
	db "Aoooo@@@" ; $6B
	db "Jimmy@@@" ; $6C
	db "Cly@@@@@" ; $6D
	db "Revo@@@@" ; $6E
	db "Everyle@" ; $6F
	db "Zetsu@@@" ; $70
	db "Alexis@@" ; $71
	db "Hanson@@" ; $72
	db "Sawyer@@" ; $73
	db "Masuda@@" ; $74
	db "Nickel@@" ; $75
	db "Olson@@@" ; $76
	db "Wright@@" ; $77
	db "Bickett@" ; $78
	db "Saito@@@" ; $79
	db "Diaz@@@@" ; $7A
	db "Hunter@@" ; $7B
	db "Hill@@@@" ; $7C
	db "Javier@@" ; $7D
	db "Kaufman@" ; $7E
	db "O'Brien@" ; $7F
	db "Frost@@@" ; $80
	db "Morse@@@" ; $81
	db "Yufune@@" ; $82
	db "Rajan@@@" ; $83
	db "Stock@@@" ; $84
	db "Thurman@" ; $85
	db "Wagner@@" ; $86
	db "Yates@@@" ; $87
	db "Andrews@" ; $88
	db "Bahn@@@@" ; $89
	db "Mori@@@@" ; $8A
	db "Buckman@" ; $8B
	db "Cobb@@@@" ; $8C
	db "Hughes@@" ; $8D
	db "Arita@@@" ; $8E
	db "Easton@@" ; $8F
	db "Freeman@" ; $90
	db "Giese@@@" ; $91
	db "Hatcher@" ; $92
	db "Jackson@" ; $93
	db "Kahn@@@@" ; $94
	db "Leong@@@" ; $95
	db "Marino@@" ; $96
	db "Newman@@" ; $97
	db "Nguyen@@" ; $98
	db "Ogden@@@" ; $99
	db "Park@@@@" ; $9A
	db "Raine@@@" ; $9B
	db "Sells@@@" ; $9C
	db "Turner@@" ; $9D
	db "Walker@@" ; $9E
	db "Meyer@@@" ; $9F
	db "Johnson@" ; $A0
	db "Adams@@@" ; $A1
	db "Smith@@@" ; $A2
	db "Tajiri@@" ; $A3
	db "Baker@@@" ; $A4
	db "Collins@" ; $A5
	db "Smart@@@" ; $A6
	db "Dykstra@" ; $A7
	db "Eaton@@@" ; $A8
	db "Wong@@@@" ; $A9
	db "Nemo@@@@" ; $AA
	db "Nemo@@@@" ; $AB
	db "Nemo@@@@" ; $AC
	db "Nemo@@@@" ; $AD
	db "Nemo@@@@" ; $AE
	db "Nemo@@@@" ; $AF
	db "Nemo@@@@" ; $B0
	db "Nemo@@@@" ; $B1
	db "Nemo@@@@" ; $B2
	db "Nemo@@@@" ; $B3
	db "Nemo@@@@" ; $B4
	db "Nemo@@@@" ; $B5
	db "Nemo@@@@" ; $B6
	db "Nemo@@@@" ; $B7
	db "Nemo@@@@" ; $B8
	db "Nemo@@@@" ; $B9
	db "Nemo@@@@" ; $BA
	db "Nemo@@@@" ; $BB
	db "Nemo@@@@" ; $BC
	db "Nemo@@@@" ; $BD
	db "Nemo@@@@" ; $BE
	db "Nemo@@@@" ; $BF
	db "Nemo@@@@" ; $C0
	db "Nemo@@@@" ; $C1
	db "Nemo@@@@" ; $C2
	db "Nemo@@@@" ; $C3
	db "Nemo@@@@" ; $C4
	db "Nemo@@@@" ; $C5
	db "Nemo@@@@" ; $C6
	db "Nemo@@@@" ; $C7
	db "Nemo@@@@" ; $C8
	db "Nemo@@@@" ; $C9
	db "Nemo@@@@" ; $CA
	db "Nemo@@@@" ; $CB
	db "Nemo@@@@" ; $CC
	db "Nemo@@@@" ; $CD
	db "Nemo@@@@" ; $CE
	db "Nemo@@@@" ; $CF
	db "Nemo@@@@" ; $D0
	db "Nemo@@@@" ; $D1
	db "Nemo@@@@" ; $D2
	db "Nemo@@@@" ; $D3
	db "Nemo@@@@" ; $D4
	db "Nemo@@@@" ; $D5
	db "Nemo@@@@" ; $D6
	db "Nemo@@@@" ; $D7
	db "Nemo@@@@" ; $D8
	db "Nemo@@@@" ; $D9
	db "Nemo@@@@" ; $DA
	db "Nemo@@@@" ; $DB
	db "Nemo@@@@" ; $DC
	db "Nemo@@@@" ; $DD
	db "Nemo@@@@" ; $DE
	db "Nemo@@@@" ; $DF
	db "Nemo@@@@" ; $E0
	db "Nemo@@@@" ; $E1
	db "Nemo@@@@" ; $E2
	db "Nemo@@@@" ; $E3
	db "Nemo@@@@" ; $E4
	db "Nemo@@@@" ; $E5
	db "Nemo@@@@" ; $E6
	db "Nemo@@@@" ; $E7
	db "Nemo@@@@" ; $E8
	db "Nemo@@@@" ; $E9
	db "Nemo@@@@" ; $EA
	db "Nemo@@@@" ; $EB
	db "Nemo@@@@" ; $EC
	db "Nemo@@@@" ; $ED
	db "Nemo@@@@" ; $EE
	db "Nemo@@@@" ; $EF
	db "Nemo@@@@" ; $F0
	db "Nemo@@@@" ; $F1
	db "Nemo@@@@" ; $F2
	db "Nemo@@@@" ; $F3
	db "Nemo@@@@" ; $F4
	db "Nemo@@@@" ; $F5
	db "Nemo@@@@" ; $F6
	db "Nemo@@@@" ; $F7
	db "Nemo@@@@" ; $F8
	db "Nemo@@@@" ; $F9
	db "Nemo@@@@" ; $FA
	db "Nemo@@@@" ; $FB
	db "Nemo@@@@" ; $FC
	db "Nemo@@@@" ; $FD
	db "Nemo@@@@" ; $FE
	db "Nemo@@@@" ; $FF


GetWonderTradeHeldItem:
; Pick a random held item based on the bits of a random number.
; If bit 1 is set (50% chance), no held item.
; Otherwise, if bit 2 is set (25% chance), then Berry.
; And so on, with better items being more rare.
	call Random
	ld b, a
; TODO: factor out the repetition here with rept...endr and sla
	and a, %00000001
	jr z, .isbit2on
	ld a, 0
	jp .done
.isbit2on
	ld a, b
	and a, %00000010
	jr z, .isbit3on
	ld a, 1
	jp .done
.isbit3on
	ld a, b
	and a, %00000100
	jr z, .isbit4on
	ld a, 2
	jp .done
.isbit4on
	ld a, b
	and a, %00001000
	jr z, .isbit5on
	ld a, 3
	jp .done
.isbit5on
	ld a, b
	and a, %00010000
	jr z, .isbit6on
	ld a, 4
	jp .done
.isbit6on
	ld a, b
	and a, %00100000
	jr z, .isbit7on
	ld a, 5
	jp .done
.isbit7on
	ld a, b
	and a, %01000000
	jr z, .isbit8on
	ld a, 6
	jp .done
.isbit8on
	ld a, b
	and a, %10000000
	jr z, .allbitsoff
	ld a, 7
	jp .done
.allbitsoff
	ld a, 8
.done
	ld hl, .HeldItemsTable
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ret

.HeldItemsTable:
	db NO_ITEM
	db BERRY
	db GOLD_BERRY
	db MYSTERYBERRY
	db QUICK_CLAW
	db SCOPE_LENS
	db KINGS_ROCK
	db LEFTOVERS
	db LUCKY_EGG

CheckValidLevel:
; Don't receive Pokémon outside a valid level range.
; Legendaries and other banned Pokémon have a "valid" range of 255 to 255.
	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld d, a

	ld a, [wOTTrademonSpecies]
	ld hl, .ValidPokemonLevels
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc

	ld a, [hli]
	dec a
	cp d
	ret nc

	ld a, [hl]
	cp d
	ret c

	xor a
	ret

.ValidPokemonLevels
	;  min, max
	db 255, 255 ; ?????
	db   1,  15 ; Bulbasaur
	db  16,  31 ; Ivysaur
	db  32, 100 ; Venusaur
	db   1,  15 ; Charmander
	db  16,  35 ; Charmeleon
	db  36, 100 ; Charizard
	db   1,  15 ; Squirtle
	db  16,  35 ; Wartortle
	db  36, 100 ; Blastoise
	db   1,   6 ; Caterpie
	db   7,   9 ; Metapod
	db  10, 100 ; Butterfree
	db   1,   6 ; Weedle
	db   7,   9 ; Kakuna
	db  10, 100 ; Beedrill
	db   1,  17 ; Pidgey
	db  18,  35 ; Pidgeotto
	db  36, 100 ; Pidgeot
	db   1,  19 ; Rattata
	db  20, 100 ; Raticate
	db   1,  17 ; Marill
	db  18, 100 ; Azumarill
	db   1,  21 ; Ekans
	db  22, 100 ; Arbok
	db   1,  19 ; Pikachu
	db  20, 100 ; Raichu
	db   1,  21 ; Sandshrew
	db  22, 100 ; Sandslash
	db   1,  15 ; Nidoran♀
	db  16,  35 ; Nidorina
	db  36, 100 ; Nidoqueen
	db   1,  15 ; Nidoran♂
	db  16,  35 ; Nidorino
	db  36, 100 ; Nidoking
	db   5,  19 ; Clefairy
	db  20, 100 ; Clefable
	db   1,  19 ; Vulpix
	db  20, 100 ; Ninetales
	db   5,  19 ; Jigglypuff
	db  20, 100 ; Wigglytuff
	db   1,  21 ; Zubat
	db  22, 100 ; Golbat
	db   1,  20 ; Oddish
	db  21,  31 ; Gloom
	db  32, 100 ; Vileplume
	db   1,  23 ; Paras
	db  24, 100 ; Parasect
	db   1,  30 ; Venonat
	db  31, 100 ; Venomoth
	db   1,  25 ; Diglett
	db  26, 100 ; Dugtrio
	db   1,  27 ; Meowth
	db  28, 100 ; Persian
	db   1,  32 ; Psyduck
	db  33, 100 ; Golduck
	db   1,  27 ; Mankey
	db  28, 100 ; Primeape
	db   1,  19 ; Growlithe
	db  20, 100 ; Arcanine
	db   1,  24 ; Poliwag
	db  25,  35 ; Poliwhirl
	db  36, 100 ; Poliwrath
	db   1,  15 ; Abra
	db  16,  35 ; Kadabra
	db  36, 100 ; Alakazam
	db   1,  27 ; Machop
	db  28,  45 ; Machoke
	db  46, 100 ; Machamp
	db   1,  20 ; Bellsprout
	db  21,  31 ; Weepinbell
	db  32, 100 ; Victreebel
	db   1,  29 ; Tentacool
	db  30, 100 ; Tentacruel
	db   1,  24 ; Geodude
	db  25,  44 ; Graveler
	db  45, 100 ; Golem
	db   1,  39 ; Ponyta
	db  40, 100 ; Rapidash
	db   1,  36 ; Slowpoke
	db  37, 100 ; Slowbro
	db   1,  29 ; Magnemite
	db  30,  49 ; Magneton
	db   1, 100 ; Farfetch'd
	db   1,  30 ; Doduo
	db  31, 100 ; Dodrio
	db   1,  33 ; Seel
	db  34, 100 ; Dewgong
	db   1,  37 ; Grimer
	db  38, 100 ; Muk
	db   1,  33 ; Shellder
	db  34, 100 ; Cloyster
	db   1,  24 ; Gastly
	db  25,  44 ; Haunter
	db  45, 100 ; Gengar
	db   1, 100 ; Onix
	db   1,  25 ; Drowzee
	db  26, 100 ; Hypno
	db   1,  27 ; Krabby
	db  28, 100 ; Kingler
	db   1,  29 ; Voltorb
	db  30, 100 ; Electrode
	db   1,  29 ; Exeggcute
	db  30, 100 ; Exeggutor
	db   1,  27 ; Cubone
	db  28, 100 ; Marowak
	db  20, 100 ; Hitmonlee
	db  20, 100 ; Hitmonchan
	db   1,  34 ; Koffing
	db  35, 100 ; Weezing
	db   1,  41 ; Rhyhorn
	db  42,  54 ; Rhydon
	db   1, 100 ; Chansey
	db   1,  38 ; Tangela
	db   1, 100 ; Kangaskhan
	db   1,  31 ; Horsea
	db  32,  54 ; Seadra
	db   1,  19 ; Togepi
	db  20,  39 ; Togetic
	db  40, 100 ; Togekiss
	db   1,  32 ; Staryu
	db  33, 100 ; Starmie
	db   1, 100 ; Mr.Mime
	db  10, 100 ; Scyther
	db  20, 100 ; Jynx
	db  20,  36 ; Electabuzz
	db  20,  36 ; Magmar
	db  10, 100 ; Pinsir
	db   1, 100 ; Tauros
	db   1,  19 ; Magikarp
	db  20, 100 ; Gyarados
	db  20, 100 ; Lapras
	db   1, 100 ; Ditto
	db   1,  19 ; Eevee
	db  20, 100 ; Vaporeon
	db  20, 100 ; Jolteon
	db  20, 100 ; Flareon
	db   1,  20 ; Porygon
	db  15,  39 ; Omanyte
	db  40, 100 ; Omastar
	db  15,  39 ; Kabuto
	db  40, 100 ; Kabutops
	db  15, 100 ; Aerodactyl
	db  20, 100 ; Snorlax
	db 255, 255 ; Articuno
	db 255, 255 ; Zapdos
	db 255, 255 ; Moltres
	db  20,  29 ; Dratini
	db  30,  54 ; Dragonair
	db  55, 100 ; Dragonite
	db 255, 255 ; Mewtwo
	db 255, 255 ; Mew
	db   1,  15 ; Chikorita
	db  16,  31 ; Bayleef
	db  32, 100 ; Meganium
	db   1,  13 ; Cyndaquil
	db  14,  35 ; Quilava
	db  36, 100 ; Typhlosion
	db   1,  17 ; Totodile
	db  18,  29 ; Croconaw
	db  30, 100 ; Feraligatr
	db   1,  14 ; Sentret
	db  15, 100 ; Furret
	db   1,  19 ; Hoothoot
	db  20, 100 ; Noctowl
	db   1,  17 ; Ledyba
	db  18, 100 ; Ledian
	db   1,  21 ; Spinarak
	db  22, 100 ; Ariados
	db  32, 100 ; Crobat
	db   1,  26 ; Chinchou
	db  27, 100 ; Lanturn
	db   1,  19 ; Pichu
	db   1,  19 ; Munchlax
	db  50, 100 ; Magnezone
	db  39, 100 ; Tangrowth
	db   1,  24 ; Natu
	db  25, 100 ; Xatu
	db   1,  14 ; Mareep
	db  15,  29 ; Flaaffy
	db  30, 100 ; Ampharos
	db  32, 100 ; Bellossom
	db   1, 100 ; Sudowoodo
	db  36, 100 ; Politoed
	db   1,  17 ; Hoppip
	db  18,  26 ; Skiploom
	db  27, 100 ; Jumpluff
	db   1, 100 ; Aipom
	db   1,  37 ; Yanma
	db  38, 100 ; Yanmega
	db   1,  19 ; Wooper
	db  20, 100 ; Quagsire
	db  20, 100 ; Espeon
	db  20, 100 ; Umbreon
	db  20, 100 ; Leafeon
	db  20, 100 ; Glaceon
	db   1,  19 ; Murkrow
	db  20, 100 ; Honchkrow
	db  37, 100 ; Slowking
	db   1,  19 ; Misdreavus
	db  20, 100 ; Mismagius
	db   1, 100 ; Unown
	db   1, 100 ; Girafarig
	db   1,  30 ; Pineco
	db  31, 100 ; Forretress
	db   1, 100 ; Dunsparce
	db   1,  19 ; Gligar
	db  20, 100 ; Gliscor
	db  20, 100 ; Steelix
	db   1,  22 ; Snubbull
	db  23, 100 ; Granbull
	db   1, 100 ; Qwilfish
	db  20, 100 ; Scizor
	db   1, 100 ; Heracross
	db   1,  19 ; Sneasel
	db  20, 100 ; Weavile
	db   1,  29 ; Teddiursa
	db  30, 100 ; Ursaring
	db   1,  37 ; Slugma
	db  38, 100 ; Magcargo
	db   1,  32 ; Swinub
	db  33,  40 ; Piloswine
	db  41, 100 ; Mamoswine
	db   1, 100 ; Corsola
	db   1,  24 ; Remoraid
	db  25, 100 ; Octillery
	db   1, 100 ; Mantine
	db   1, 100 ; Skarmory
	db   1,  23 ; Houndour
	db  24, 100 ; Houndoom
	db  55, 100 ; Kingdra
	db   1,  24 ; Phanpy
	db  25, 100 ; Donphan
	db  20,  39 ; Porygon2
	db   1, 100 ; Stantler
	db   1, 100 ; Smeargle
	db   1,  19 ; Tyrogue
	db  20, 100 ; Hitmontop
	db   1,  19 ; Smoochum
	db   1,  19 ; Elekid
	db   1,  19 ; Magby
	db   1,  19 ; Miltank
	db  20, 100 ; Blissey
	db 255, 255 ; Raikou
	db 255, 255 ; Entei
	db 255, 255 ; Suicune
	db   1,  29 ; Larvitar
	db  30,  54 ; Pupitar
	db  55, 100 ; Tyranitar
	db 255, 255 ; Lugia
	db 255, 255 ; Ho-Oh
	db 255, 255 ; Celebi
	db  20, 100 ; Sylveon
	db  40, 100 ; Porygon-Z
	db 255, 255 ; Egg
	db 255, 255 ; ?????
