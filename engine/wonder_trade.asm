WonderTrade::
	ld hl, .Text_WonderTradeQuestion
	call PrintText
	call YesNoBox
	ret c

	ld hl, .Text_WonderTradePrompt
	call PrintText

	ld b, 6
	farcall SelectTradeOrDaycareMon
	ret c

	ld a, [CurPartySpecies]
;	cp EGG
;	jr nz, .check_gs_ball
;	ld hl, .Text_WonderTradeCantTradeEgg
;	jp PrintText

.check_gs_ball
	ld hl, PartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [CurPartyMon]
	call AddNTimes
	ld b, [hl]
	ld a, GS_BALL
	cp b
	jr nz, .continue
	ld hl, .Text_WonderTradeCantTradeGSBall
	jp PrintText

.continue
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

	eventflagset EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	eventflagset EVENT_CAN_GIVE_GS_BALL_TO_KURT
	ld de, MUSIC_SPIKY_EARED_PICHU_HGSS
	call PlayMusic
	ld hl, .Text_WonderTradeForGSBallPichuText
	jp PrintText

.Text_WonderTradeQuestion:
	text_jump WonderTradeQuestionText
	db "@"

.Text_WonderTradePrompt:
	text_jump WonderTradePromptText
	db "@"

;.Text_WonderTradeCantTradeEgg:
;	text_jump WonderTradeCantTradeEggText
;	db "@"

.Text_WonderTradeCantTradeGSBall
	text_jump WonderTradeCantTradeGSBallText
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

.Text_WonderTradeForGSBallPichuText:
	text_jump WonderTradeForGSBallPichuText
	db "@"

DoWonderTrade:
	ld a, [CurPartySpecies]
	ld [wPlayerTrademonSpecies], a

	; If you've beaten the Elite Four...
	eventflagcheck EVENT_BEAT_ELITE_FOUR
	jr z, .random_trademon
	; ...and haven't gotten the GS Ball Pichu yet...
	eventflagcheck EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	jr nz, .random_trademon
	; ...then receive a spiky-eared Pichu holding a GS Ball
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
	ld b, a
	ld a, [wOTTrademonSpecies]
	cp b
	jr z, .random_trademon

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
	call Trade_CopyThreeBytes

	ld hl, PartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, PartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld a, c
	ld [wPlayerTrademonCaughtData], a

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
	farcall RemoveMonFromPartyOrBox
	predef TryAddMonToParty

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonNickname
	call GetTradeMonName
	call CopyTradeName

	ld hl, PartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	call Random
	ld [Buffer1], a
	call Random
	ld [Buffer1 + 1], a
	ld hl, Buffer1
	ld de, wOTTrademonID
	call Trade_CopyTwoBytes

	ld hl, PartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Trade_CopyTwoBytes

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

	call GetWonderTradeOTGender
	ld b, a

	; Random Ball
	; 2/3 chance of Poké Ball, 1/3 chance of other
.random_ball
	ld a, PREMIER_BALL * 2 - 2
	call RandomRange
	cp PREMIER_BALL - 2
	jr nc, .poke_ball
	cp MASTER_BALL - 2
	jr z, .random_ball
	cp SAFARI_BALL - 2
	jr z, .random_ball
	inc a
	inc a
	jr .got_ball
.poke_ball
	ld a, POKE_BALL
.got_ball
	ld c, a

	farcall SetGiftPartyMonCaughtData

	; Random DVs
	call Random
	ld [Buffer1], a
	call Random
	ld [Buffer1 + 1], a
	call Random
	ld [Buffer1 + 2], a
	ld hl, Buffer1
	ld de, wOTTrademonDVs
	call Trade_CopyThreeBytes

	ld hl, PartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonDVs
	call Trade_CopyThreeBytes

	; Random nature
	ld a, NUM_NATURES
	call RandomRange
	ld b, a
	; Random ability
	ld a, 3
	call RandomRange
rept 5
	sla a
endr
	add b
	ld b, a
	; Random shininess (1 in 1,024)
	call Random
	and a
	jr nz, .not_shiny
	call Random
	cp $40
	jr nc, .not_shiny
	ld a, b
	or SHINY_MASK
	ld b, a
.not_shiny
	ld a, b
	ld [Buffer1], a
	; Random gender (50-50)
	call Random
	and GENDER_MASK
	ld b, a
	; Form
	ld a, [wOTTrademonSpecies]
	cp EKANS
	jr z, .ekans_arbok
	cp ARBOK
	jr z, .ekans_arbok
	cp MAGIKARP
	jr z, .magikarp
	ld a, 1
	jr .got_form_count
.ekans_arbok
	ld a, 2
	jr .got_form_count
.magikarp
	ld a, NUM_MAGIKARP
.got_form_count
	push bc
	call RandomRange
	inc a
	ld b, a
	ld a, [wOTTrademonSpecies]
	cp MAGIKARP
	jr nz, .not_first_magikarp
	ld a, [wFirstMagikarpSeen]
	and a
	jr nz, .not_first_magikarp
	ld a, b
	ld [wFirstMagikarpSeen], a
.not_first_magikarp
	ld a, b
	pop bc
	add b
	ld [Buffer1 + 1], a
	ld hl, Buffer1
	ld de, wOTTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, PartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonPersonality
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
	farcall ComputeNPCTrademonStats
	farcall GivePokerusToWonderTradeMon
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
	call Trade_CopyThreeBytes

	ld hl, PartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, PartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld b, h
	ld c, l
	farcall GetCaughtGender
	ld a, c
	ld [wPlayerTrademonCaughtData], a
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
	farcall RemoveMonFromPartyOrBox
	predef TryAddMonToParty

	ld b, MALE
	ld a, [PlayerGender]
	and a
	jr z, .male_ot_pikachu
	ld b, FEMALE
.male_ot_pikachu
	ld c, ULTRA_BALL
	farcall SetGiftPartyMonCaughtData

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

	ld a, $ff
	ld [wOTTrademonDVs], a
	ld [wOTTrademonDVs + 1], a
	ld [wOTTrademonDVs + 2], a

	ld hl, PartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonDVs
	call Trade_CopyThreeBytes

	ld a, HIDDEN_ABILITY | QUIRKY
	ld [wOTTrademonPersonality], a
	ld a, FEMALE | 2 ; spiky-eared variant
	ld [wOTTrademonPersonality + 1], a

	ld hl, PartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, PartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld a, GS_BALL
	ld [de], a

	ret

GetWonderTradeOTName:
; pick from .Table1 if [wOTTrademonID] is even, .Table2 if odd,
; using [wOTTrademonID+1] as the index
	ld hl, wOTTrademonID
	ld a, [hli]
	and 1
	ld a, [hl]
	ld hl, .Table1
	jr z, .ok
	ld hl, .Table2
.ok
	lb bc, 0, PLAYER_NAME_LENGTH
	jp AddNTimes

.Table1:
	db "Red@@@@@" ; $00
	db "Blue@@@@" ; $01
	db "Green@@@" ; $02
	db "Yellow@@" ; $03
	db "Orange@@" ; $04
	db "Gold@@@@" ; $05
	db "Silver@@" ; $06
	db "Crystal@" ; $07
	db "Ruby@@@@" ; $08
	db "Safire@@" ; $09
	db "Emerald@" ; $0a
	db "Jade@@@@" ; $0b
	db "Diamond@" ; $0c
	db "Pearl@@@" ; $0d
	db "Platina@" ; $0e
	db "Heart@@@" ; $0f
	db "Soul@@@@" ; $10
	db "Mind@@@@" ; $11
	db "Black@@@" ; $12
	db "White@@@" ; $13
	db "Gray@@@@" ; $14
	db "X@@@@@@@" ; $15
	db "Y@@@@@@@" ; $16
	db "Z@@@@@@@" ; $17
	db "Alpha@@@" ; $18
	db "Omega@@@" ; $19
	db "Delta@@@" ; $1a
	db "Lambda@@" ; $1b
	db "Theta@@@" ; $1c
	db "Zeta@@@@" ; $1d
	db "Sun@@@@@" ; $1e
	db "Moon@@@@" ; $1f
	db "Star@@@@" ; $20
	db "Ash@@@@@" ; $21
	db "Gary@@@@" ; $22
	db "Leaf@@@@" ; $23
	db "Ethan@@@" ; $24
	db "Lyra@@@@" ; $25
	db "Hiro@@@@" ; $26
	db "Kris@@@@" ; $27
	db "Brendan@" ; $28
	db "May@@@@@" ; $29
	db "Wally@@@" ; $2a
	db "Lucas@@@" ; $2b
	db "Dawn@@@@" ; $2c
	db "Barry@@@" ; $2d
	db "Hilbert@" ; $2e
	db "Hilda@@@" ; $2f
	db "Cheren@@" ; $30
	db "Bianca@@" ; $31
	db "Nate@@@@" ; $32
	db "Rosa@@@@" ; $33
	db "Hugh@@@@" ; $34
	db "Calem@@@" ; $35
	db "Serena@@" ; $36
	db "Shauna@@" ; $37
	db "Trevor@@" ; $38
	db "Tierno@@" ; $39
	db "Hau@@@@@" ; $3a
	db "Lillie@@" ; $3b
	db "Gladion@" ; $3c
	db "Wes@@@@@" ; $3d
	db "Michael@" ; $3e
	db "Todd@@@@" ; $3f
	db "Oak@@@@@" ; $40
	db "Elm@@@@@" ; $41
	db "Ivy@@@@@" ; $42
	db "Birch@@@" ; $43
	db "Rowan@@@" ; $44
	db "Juniper@" ; $45
	db "Sycamor@" ; $46
	db "Kukui@@@" ; $47
	db "Willow@@" ; $48
	db "Samuel@@" ; $49
	db "Samson@@" ; $4a
	db "Cozmo@@@" ; $4b
	db "Fennel@@" ; $4c
	db "Cedric@@" ; $4d
	db "Silktre@" ; $4e
	db "Burnet@@" ; $4f
	db "Mohn@@@@" ; $50
	db "Krane@@@" ; $51
	db "Bill@@@@" ; $52
	db "Lanette@" ; $53
	db "Brigett@" ; $54
	db "Celio@@@" ; $55
	db "Bebe@@@@" ; $56
	db "Amanita@" ; $57
	db "Cassius@" ; $58
	db "Molayne@" ; $59
	db "Brock@@@" ; $5a
	db "Misty@@@" ; $5b
	db "Surge@@@" ; $5c
	db "Erika@@@" ; $5d
	db "Janine@@" ; $5e
	db "Sabrina@" ; $5f
	db "Blaine@@" ; $60
	db "Giovani@" ; $61
	db "Lorelei@" ; $62
	db "Bruno@@@" ; $63
	db "Agatha@@" ; $64
	db "Lance@@@" ; $65
	db "Cissy@@@" ; $66
	db "Danny@@@" ; $67
	db "Rudy@@@@" ; $68
	db "Luana@@@" ; $69
	db "Prima@@@" ; $6a
	db "Falkner@" ; $6b
	db "Bugsy@@@" ; $6c
	db "Whitney@" ; $6d
	db "Morty@@@" ; $6e
	db "Chuck@@@" ; $6f
	db "Jasmine@" ; $70
	db "Pryce@@@" ; $71
	db "Clair@@@" ; $72
	db "Will@@@@" ; $73
	db "Koga@@@@" ; $74
	db "Karen@@@" ; $75
	db "Roxanne@" ; $76
	db "Brawly@@" ; $77
	db "Wattson@" ; $78
	db "Flanery@" ; $79
	db "Norman@@" ; $7a
	db "Winona@@" ; $7b
	db "Liza@@@@" ; $7c
	db "Tate@@@@" ; $7d
	db "Wallace@" ; $7e
	db "Juan@@@@" ; $7f
	db "Sidney@@" ; $80
	db "Phoebe@@" ; $81
	db "Glacia@@" ; $82
	db "Drake@@@" ; $83
	db "Steven@@" ; $84
	db "Roark@@@" ; $85
	db "Garden@@" ; $86
	db "Maylene@" ; $87
	db "Wake@@@@" ; $88
	db "Fantina@" ; $89
	db "Byron@@@" ; $8a
	db "Candice@" ; $8b
	db "Volkner@" ; $8c
	db "Aaron@@@" ; $8d
	db "Bertha@@" ; $8e
	db "Flint@@@" ; $8f
	db "Lucian@@" ; $90
	db "Cynthia@" ; $91
	db "Cilan@@@" ; $92
	db "Chili@@@" ; $93
	db "Cress@@@" ; $94
	db "Roxie@@@" ; $95
	db "Lenora@@" ; $96
	db "Burgh@@@" ; $97
	db "Elesa@@@" ; $98
	db "Clay@@@@" ; $99
	db "Skyla@@@" ; $9a
	db "Brycen@@" ; $9b
	db "Drayden@" ; $9c
	db "Iris@@@@" ; $9d
	db "Marlon@@" ; $9e
	db "Shantal@" ; $9f
	db "Marshal@" ; $a0
	db "Grimsly@" ; $a1
	db "Caitlin@" ; $a2
	db "Alder@@@" ; $a3
	db "Viola@@@" ; $a4
	db "Grant@@@" ; $a5
	db "Korrina@" ; $a6
	db "Ramos@@@" ; $a7
	db "Clemont@" ; $a8
	db "Valerie@" ; $a9
	db "Olympia@" ; $aa
	db "Wulfric@" ; $ab
	db "Malva@@@" ; $ac
	db "Siebold@" ; $ad
	db "Wiktrom@" ; $ae
	db "Drasna@@" ; $af
	db "Diantha@" ; $b0
	db "Ilima@@@" ; $b1
	db "Lana@@@@" ; $b2
	db "Kiawe@@@" ; $b3
	db "Mallow@@" ; $b4
	db "Sophcls@" ; $b5
	db "Acerola@" ; $b6
	db "Mina@@@@" ; $b7
	db "Hala@@@@" ; $b8
	db "Olivia@@" ; $b9
	db "Nanu@@@@" ; $ba
	db "Hapu@@@@" ; $bb
	db "Kahili@@" ; $bc
	db "Noland@@" ; $bd
	db "Greta@@@" ; $be
	db "Tucker@@" ; $bf
	db "Lucy@@@@" ; $c0
	db "Spenser@" ; $c1
	db "Brandon@" ; $c2
	db "Anabel@@" ; $c3
	db "Palmer@@" ; $c4
	db "Thorton@" ; $c5
	db "Dahlia@@" ; $c6
	db "Darach@@" ; $c7
	db "Argenta@" ; $c8
	db "Proton@@" ; $c9
	db "Petrel@@" ; $ca
	db "Archer@@" ; $cb
	db "Ariana@@" ; $cc
	db "Jessie@@" ; $cd
	db "James@@@" ; $ce
	db "Cassidy@" ; $cf
	db "Butch@@@" ; $d0
	db "Bonnie@@" ; $d1
	db "Clyde@@@" ; $d2
	db "Attila@@" ; $d3
	db "Hun@@@@@" ; $d4
	db "Domino@@" ; $d5
	db "Miror B@" ; $d6
	db "Matt@@@@" ; $d7
	db "Shelly@@" ; $d8
	db "Archie@@" ; $d9
	db "Tabitha@" ; $da
	db "Courtny@" ; $db
	db "Maxie@@@" ; $dc
	db "Mars@@@@" ; $dd
	db "Jupiter@" ; $de
	db "Saturn@@" ; $df
	db "Charon@@" ; $e0
	db "Cyrus@@@" ; $e1
	db "N@@@@@@@" ; $e2
	db "Colress@" ; $e3
	db "Gorm@@@@" ; $e4
	db "Bronius@" ; $e5
	db "Rood@@@@" ; $e6
	db "Zinzoln@" ; $e7
	db "Giallo@@" ; $e8
	db "Ryoku@@@" ; $e9
	db "Ghetsis@" ; $ea
	db "Anthea@@" ; $eb
	db "Concord@" ; $ec
	db "Aliana@@" ; $ed
	db "Bryony@@" ; $ee
	db "Celosia@" ; $ef
	db "Mable@@@" ; $f0
	db "Xerosic@" ; $f1
	db "Lysandr@" ; $f2
	db "Tupp@@@@" ; $f3
	db "Zipp@@@@" ; $f4
	db "Rapp@@@@" ; $f5
	db "Plumera@" ; $f6
	db "Guzma@@@" ; $f7
	db "Faba@@@@" ; $f8
	db "Wicke@@@" ; $f9
	db "Lusamin@" ; $fa
	db "Candela@" ; $fb
	db "Blanche@" ; $fc
	db "Spark@@@" ; $fd
	db "Satoshi@" ; $fe
	db "Tajiri@@" ; $ff

.Table2:
	db "Shigeru@" ; $00
	db "Hibiki@@" ; $01
	db "Kotone@@" ; $02
	db "Kamon@@@" ; $03
	db "Yuuki@@@" ; $04
	db "Haruka@@" ; $05
	db "Mitsuru@" ; $06
	db "Kouki@@@" ; $07
	db "Hikari@@" ; $08
	db "Jun@@@@@" ; $09
	db "Touya@@@" ; $0a
	db "Touko@@@" ; $0b
	db "Bel@@@@@" ; $0c
	db "Kyouhei@" ; $0d
	db "Mei@@@@@" ; $0e
	db "Helios@@" ; $0f
	db "Selene@@" ; $10
	db "Mike@@@@" ; $11
	db "Kyle@@@@" ; $12
	db "Tim@@@@@" ; $13
	db "Emy@@@@@" ; $14
	db "Chris@@@" ; $15
	db "Kim@@@@@" ; $16
	db "Jacques@" ; $17
	db "Hari@@@@" ; $18
	db "Joy@@@@@" ; $19
	db "Jenny@@@" ; $1a
	db "Delia@@@" ; $1b
	db "Daisy@@@" ; $1c
	db "Fuji@@@@" ; $1d
	db "Baoba@@@" ; $1e
	db "Copycat@" ; $1f
	db "Primo@@@" ; $20
	db "Lostele@" ; $21
	db "Teala@@@" ; $22
	db "Selphy@@" ; $23
	db "Joey@@@@" ; $24
	db "Cal@@@@@" ; $25
	db "Carrie@@" ; $26
	db "Mr.<PK><MN>@@@" ; $27
	db "Eusine@@" ; $28
	db "Cameron@" ; $29
	db "Earl@@@@" ; $2a
	db "Kurt@@@@" ; $2b
	db "Ben@@@@@" ; $2c
	db "Mary@@@@" ; $2d
	db "Reed@@@@" ; $2e
	db "Fern@@@@" ; $2f
	db "Lily@@@@" ; $30
	db "Buena@@@" ; $31
	db "Randy@@@" ; $32
	db "Maximo@@" ; $33
	db "Felicty@" ; $34
	db "Monica@@" ; $35
	db "Tuscany@" ; $36
	db "Wesley@@" ; $37
	db "Arthur@@" ; $38
	db "Frieda@@" ; $39
	db "Santos@@" ; $3a
	db "Sunny@@@" ; $3b
	db "Naoko@@@" ; $3c
	db "Sayo@@@@" ; $3d
	db "Zuki@@@@" ; $3e
	db "Kuni@@@@" ; $3f
	db "Miki@@@@" ; $40
	db "Li@@@@@@" ; $41
	db "Kiyo@@@@" ; $42
	db "Scott@@@" ; $43
	db "Briney@@" ; $44
	db "Stone@@@" ; $45
	db "Wanda@@@" ; $46
	db "Gabby@@@" ; $47
	db "Ty@@@@@@" ; $48
	db "Rydel@@@" ; $49
	db "Stern@@@" ; $4a
	db "Aarune@@" ; $4b
	db "Lisia@@@" ; $4c
	db "Zinnia@@" ; $4d
	db "Inver@@@" ; $4e
	db "Chaz@@@@" ; $4f
	db "Kiri@@@@" ; $50
	db "Johanna@" ; $51
	db "Looker@@" ; $52
	db "Cheryl@@" ; $53
	db "Riley@@@" ; $54
	db "Buck@@@@" ; $55
	db "Marley@@" ; $56
	db "Mira@@@@" ; $57
	db "Rosanne@" ; $58
	db "Julia@@@" ; $59
	db "Jordan@@" ; $5a
	db "Dexter@@" ; $5b
	db "Keira@@@" ; $5c
	db "Fuego@@@" ; $5d
	db "Helena@@" ; $5e
	db "Hawes@@@" ; $5f
	db "Charles@" ; $60
	db "Curtis@@" ; $61
	db "Yancy@@@" ; $62
	db "Ingo@@@@" ; $63
	db "Emmet@@@" ; $64
	db "Grace@@@" ; $65
	db "Alexa@@@" ; $66
	db "Dexio@@@" ; $67
	db "Sina@@@@" ; $68
	db "Gurkinn@" ; $69
	db "AZ@@@@@@" ; $6a
	db "Emma@@@@" ; $6b
	db "Phil@@@@" ; $6c
	db "Nita@@@@" ; $6d
	db "Evelyn@@" ; $6e
	db "Dana@@@@" ; $6f
	db "Morgan@@" ; $70
	db "Ryuki@@@" ; $71
	db "Gester@@" ; $72
	db "Imakuni@" ; $73
	db "Richie@@" ; $74
	db "Assunta@" ; $75
	db "Tracey@@" ; $76
	db "Duplica@" ; $77
	db "Casey@@@" ; $78
	db "Giselle@" ; $79
	db "Melanie@" ; $7a
	db "Damian@@" ; $7b
	db "Alain@@@" ; $7c
	db "Reiko@@@" ; $7d
	db "Aya@@@@@" ; $7e
	db "Rainer@@" ; $7f
	db "Sparky@@" ; $80
	db "Pyro@@@@" ; $81
	db "Mikey@@@" ; $82
	db "Orville@" ; $83
	db "A.J.@@@@" ; $84
	db "Camila@@" ; $85
	db "A@@@@@@@" ; $86
	db "Slash@@@" ; $87
	db "Alice@@@" ; $88
	db "Leo@@@@@" ; $89
	db "Aoooo@@@" ; $8a
	db "Jimmy@@@" ; $8b
	db "Cly@@@@@" ; $8c
	db "Li'l D@@@" ; $8d
	db "Arty@@@@" ; $8e
	db "Abe@@@@@" ; $8f
	db "Baba@@@@" ; $90
	db "Evan@@@@" ; $91
	db "Paul@@@@" ; $92
	db "Cyan@@@@" ; $93
	db "Revo@@@@" ; $94
	db "Everyle@" ; $95
	db "Zetsu@@@" ; $96
	db "Karuta@@" ; $97
	db "Nozomi@@" ; $98
	db "Amos@@@@" ; $99
	db "Kaito@@@" ; $9a
	db "Meiko@@@" ; $9b
	db "Miku@@@@" ; $9c
	db "Rin@@@@@" ; $9d
	db "Len@@@@@" ; $9e
	db "Luka@@@@" ; $9f
	db "Teto@@@@" ; $a0
	db "Ami@@@@@" ; $a1
	db "Minako@@" ; $a2
	db "Usagi@@@" ; $a3
	db "Rei@@@@@" ; $a4
	db "Makoto@@" ; $a5
	db "Mamoru@@" ; $a6
	db "Luna@@@@" ; $a7
	db "Artemis@" ; $a8
	db "Diana@@@" ; $a9
	db "Sakura@@" ; $aa
	db "Tomoyo@@" ; $ab
	db "Syaoran@" ; $ac
	db "Shinji@@" ; $ad
	db "Asuka@@@" ; $ae
	db "Mari@@@@" ; $af
	db "Gendo@@@" ; $b0
	db "Yui@@@@@" ; $b1
	db "Kaworu@@" ; $b2
	db "Okabe@@@" ; $b3
	db "Daru@@@@" ; $b4
	db "Kurisu@@" ; $b5
	db "Suzuha@@" ; $b6
	db "Mayuri@@" ; $b7
	db "Ruka@@@@" ; $b8
	db "Kyon@@@@" ; $b9
	db "Haruhi@@" ; $ba
	db "Yuki@@@@" ; $bb
	db "Mikuru@@" ; $bc
	db "Tsuruya@" ; $bd
	db "Ryoko@@@" ; $be
	db "Itsuki@@" ; $bf
	db "Jojo@@@@" ; $c0
	db "Jotaro@@" ; $c1
	db "Josuke@@" ; $c2
	db "Dio@@@@@" ; $c3
	db "Kei@@@@@" ; $c4
	db "Saika@@@" ; $c5
	db "Hayate@@" ; $c6
	db "Daruku@@" ; $c7
	db "Nagisa@@" ; $c8
	db "Bridget@" ; $c9
	db "Ryo@@@@@" ; $ca
	db "Clara@@@" ; $cb
	db "Hana@@@@" ; $cc
	db "Miyuki@@" ; $cd
	db "Luke@@@@" ; $ce
	db "Lun@@@@@" ; $cf
	db "Rhue@@@@" ; $d0
	db "Traziun@" ; $d1
	db "Gaius@@@" ; $d2
	db "Lyrra@@@" ; $d3
	db "Kloe@@@@" ; $d4
	db "Cetsa@@@" ; $d5
	db "Lexus@@@" ; $d6
	db "Sorya@@@" ; $d7
	db "Strata@@" ; $d8
	db "Slade@@@" ; $d9
	db "Dirk@@@@" ; $da
	db "Talan@@@" ; $db
	db "Kersh@@@" ; $dc
	db "Rangi@@@" ; $dd
	db "Remy@@@@" ; $de
	db "Sylvie@@" ; $df
	db "Matthew@" ; $e0
	db "Mateo@@@" ; $e1
	db "Babs@@@@" ; $e2
	db "Pia@@@@@" ; $e3
	db "Aizawa@@" ; $e4
	db "Suki@@@@" ; $e5
	db "Fredrik@" ; $e6
	db "Drayano@" ; $e7
	db "Hlin@@@@" ; $e8
	db "Marckus@" ; $e9
	db "Pum@@@@@" ; $ea
	db "Bryan@@@" ; $eb
	db "Don@@@@@" ; $ec
	db "Miguel@@" ; $ed
	db "Satoru@@" ; $ee
	db "Iwata@@@" ; $ef
	db "Junichi@" ; $f0
	db "Masuda@@" ; $f1
	db "Koji@@@@" ; $f2
	db "Nishino@" ; $f3
	db "Sosuke@@" ; $f4
	db "Tamada@@" ; $f5
	db "Hisashi@" ; $f6
	db "Sogabe@@" ; $f7
	db "Keita@@@" ; $f8
	db "Kagaya@@" ; $f9
	db "Yoshi@@@" ; $fa
	db "Matsuda@" ; $fb
	db "Shigeki@" ; $fc
	db "Tetsuya@" ; $fd
	db "Oota@@@@" ; $fe
	db "Turner@@" ; $ff

GetWonderTradeOTGender:
; pick from .Table1 if [wOTTrademonID] is even, .Table2 if odd,
; using [wOTTrademonID+1] as the index
	ld hl, wOTTrademonID
	ld a, [hli]
	and 1
	ld a, [hl]
	ld hl, .Table1
	jr z, .ok
	ld hl, .Table2
.ok
	ld c, a
;	ld b, CHECK_FLAG
;	predef FlagPredef
;	ld a, c
;	and a
;	ret z ; MALE
;	ld a, FEMALE
	ld b, 0
	add hl, bc
	ld a, [hl]
	ret

.Table1:
	;       Red,     Blue,    Green,   Yellow,  Orange,  Gold,    Silver,  Crystal
	genders MALE,    MALE,    FEMALE,  FEMALE,  MALE,    MALE,    MALE,    FEMALE
	;       Ruby,    Safire,  Emerald, Jade,    Diamond, Pearl,   Platina, Heart
	genders MALE,    FEMALE,  MALE,    FEMALE,  MALE,    FEMALE,  FEMALE,  MALE
	;       Soul,    Mind,    Black,   White,   Gray,    X,       Y,       Z
	genders FEMALE,  MALE,    MALE,    FEMALE,  MALE,    MALE,    FEMALE,  MALE
	;       Alpha,   Omega,   Delta,   Lambda,  Theta,   Zeta,    Sun,     Moon
	genders MALE,    FEMALE,  MALE,    FEMALE,  MALE,    MALE,    MALE,    FEMALE
	;       Star,    Ash,     Gary,    Leaf,    Ethan,   Lyra,    Hiro,    Kris
	genders FEMALE,  MALE,    MALE,    FEMALE,  MALE,    FEMALE,  MALE,    FEMALE
	;       Brendan, May,     Wally,   Lucas,   Dawn,    Barry,   Hilbert, Hilda
	genders MALE,    FEMALE,  MALE,    MALE,    FEMALE,  MALE,    MALE,    FEMALE
	;       Cheren,  Bianca,  Nate,    Rosa,    Hugh,    Calem,   Serena,  Shauna
	genders MALE,    FEMALE,  MALE,    FEMALE,  MALE,    MALE,    FEMALE,  FEMALE
	;       Trevor,  Tierno,  Hau,     Lillie,  Gladion, Wes,     Michael, Todd
	genders MALE,    MALE,    MALE,    FEMALE,  MALE,    MALE,    MALE,    MALE
	;       Oak,     Elm,     Ivy,     Birch,   Rowan,   Juniper, Sycamor, Kukui
	genders MALE,    MALE,    FEMALE,  MALE,    MALE,    FEMALE,  MALE,    MALE
	;       Willow,  Samuel,  Samson,  Cozmo,   Fennel,  Cedric,  Silktre, Burnet
	genders MALE,    MALE,    MALE,    MALE,    FEMALE,  MALE,    MALE,    FEMALE
	;       Mohn,    Krane,   Bill,    Lanette, Brigett, Celio,   Bebe,    Amanita
	genders MALE,    MALE,    MALE,    FEMALE,  FEMALE,  MALE,    FEMALE,  FEMALE
	;       Cassius, Molayne, Brock,   Misty,   Surge,   Erika,   Janine,  Sabrina
	genders MALE,    MALE,    MALE,    FEMALE,  MALE,    FEMALE,  FEMALE,  FEMALE
	;       Blaine,  Giovani, Lorelei, Bruno,   Agatha,  Lance,   Cissy,   Danny
	genders MALE,    MALE,    FEMALE,  MALE,    FEMALE,  MALE,    FEMALE,  MALE,
	;       Rudy,    Luana,   Prima,   Falkner, Bugsy,   Whitney, Morty,   Chuck
	genders MALE,    FEMALE,  FEMALE,  MALE,    MALE,    FEMALE,  MALE,    MALE,
	;       Jasmine, Pryce,   Clair,   Will,    Koga,    Karen,   Roxanne, Brawly
	genders FEMALE,  MALE,    FEMALE,  MALE,    MALE,    FEMALE,  FEMALE,  MALE,
	;       Wattson, Flanery, Norman,  Winona,  Liza,    Tate,    Wallace, Juan
	genders MALE,    FEMALE,  MALE,    FEMALE,  FEMALE,  MALE,    MALE,    MALE,
	;       Sidney,  Phoebe,  Glacia,  Drake,   Steven,  Roark,   Garden,  Maylene
	genders MALE,    FEMALE,  FEMALE,  MALE,    MALE,    MALE,    FEMALE,  FEMALE
	;       Wake,    Fantina, Byron,   Candice, Volkner, Aaron,   Bertha,  Flint
	genders MALE,    FEMALE,  MALE,    FEMALE,  MALE,    MALE,    FEMALE,  MALE
	;       Lucian,  Cynthia, Cilan,   Chili,   Cress,   Roxie,   Lenora,  Burgh
	genders MALE,    FEMALE,  MALE,    MALE,    MALE,    FEMALE,  FEMALE,  MALE
	;       Elesa,   Clay,    Skyla,   Brycen,  Drayden, Iris,    Marlon,  Shantal
	genders FEMALE,  MALE,    FEMALE,  MALE,    MALE,    FEMALE,  MALE,    FEMALE
	;       Marshal, Grimsly, Caitlin, Alder,   Viola,   Grant,   Korrina, Ramos
	genders MALE,    MALE,    FEMALE,  MALE,    FEMALE,  MALE,    FEMALE,  MALE
	;       Clemont, Valerie, Olympia, Wulfric, Malva,   Siebold, Wiktrom, Drasna
	genders MALE,    FEMALE,  FEMALE,  MALE,    FEMALE,  MALE,    MALE,    FEMALE
	;       Diantha, Ilima,   Lana,    Kiawe,   Mallow,  Sophcls, Acerola, Mina
	genders FEMALE,  MALE,    FEMALE,  MALE,    FEMALE,  MALE,    FEMALE,  FEMALE
	;       Hala,    Olivia,  Nanu,    Hapu,    Kahili,  Noland,  Greta,   Tucker
	genders MALE,    FEMALE,  MALE,    FEMALE,  FEMALE,  MALE,    FEMALE,  MALE
	;       Lucy,    Spenser, Brandon, Anabel,  Palmer,  Thorton, Dahlia,  Darach
	genders FEMALE,  MALE,    MALE,    FEMALE,  MALE,    MALE,    FEMALE,  MALE
	;       Argenta, Proton,  Petrel,  Archer,  Ariana,  Jessie,  James,   Cassidy
	genders FEMALE,  MALE,    MALE,    MALE,    FEMALE,  FEMALE,  MALE,    FEMALE
	;       Butch,   Bonnie,  Clyde,   Attila,  Hun,     Domino,  Miror B, Matt
	genders MALE,    FEMALE,  MALE,    MALE,    FEMALE,  FEMALE,  MALE,    MALE
	;       Shelly,  Archie,  Tabitha, Courtny, Maxie,   Mars,    Jupiter, Saturn
	genders FEMALE,  MALE,    MALE,    FEMALE,  MALE,    FEMALE,  FEMALE,  MALE
	;       Charon,  Cyrus,   N,       Colress, Gorm,    Bronius, Rood,    Zinzoln
	genders MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE
	;       Giallo,  Ryoku,   Ghetsis, Anthea,  Concord, Aliana,  Bryony,  Celosia
	genders MALE,    MALE,    MALE,    FEMALE,  FEMALE,  FEMALE,  FEMALE,  FEMALE
	;       Mable,   Xerosic, Lysandr, Tupp,    Zipp,    Rapp,    Plumera, Guzma
	genders FEMALE,  MALE,    MALE,    MALE,    MALE,    MALE,    FEMALE,  MALE
	;       Faba,    Wicke,   Lusamin, Candela, Blanche, Spark,   Satoshi, Tajiri
	genders MALE,    FEMALE,  FEMALE,  FEMALE,  FEMALE,  MALE,    MALE,    MALE

.Table2:
	;       Shigeru, Hibiki,  Kotone,  Kamon,   Yuuki,   Haruka,  Mitsuru, Kouki
	genders MALE,    MALE,    FEMALE,  MALE,    MALE,    FEMALE,  MALE,    MALE
	;       Hikari,  Jun,     Touya,   Touko,   Bel,     Kyouhei, Mei,     Helios
	genders FEMALE,  MALE,    MALE,    FEMALE,  FEMALE,  MALE,    FEMALE,  MALE
	;       Selene,  Mike,    Kyle,    Tim,     Emy,     Chris,   Kim,     Jacques
	genders FEMALE,  MALE,    MALE,    MALE,    FEMALE,  MALE,    FEMALE,  MALE
	;       Hari,    Joy,     Jenny,   Delia,   Daisy,   Fuji,    Baoba,   Copycat
	genders MALE,    FEMALE,  FEMALE,  FEMALE,  FEMALE,  MALE,    MALE,    FEMALE
	;       Primo,   Lostele, Teala,   Selphy,  Joey,    Cal,     Carrie,  Mr.<PK><MN>
	genders MALE,    FEMALE,  FEMALE,  FEMALE,  MALE,    MALE,    FEMALE,  MALE
	;       Eusine,  Cameron, Earl,    Kurt,    Ben,     Mary,    Reed,    Fern
	genders MALE,    MALE,    MALE,    MALE,    MALE,    FEMALE,  MALE,    MALE
	;       Lily,    Buena,   Randy,   Maximo,  Felicty, Monica,  Tuscany, Wesley
	genders FEMALE,  FEMALE,  MALE,    MALE,    FEMALE,  FEMALE,  MALE,    MALE,
	;       Arthur,  Frieda,  Santos,  Sunny,   Naoko,   Sayo,    Zuki,    Kuni
	genders MALE,    FEMALE,  MALE,    FEMALE,  FEMALE,  FEMALE,  FEMALE,  FEMALE
	;       Miki,    Li,      Kiyo,    Scott,   Briney,  Stone,   Wanda,   Gabby
	genders FEMALE,  MALE,    MALE,    MALE,    FEMALE,  MALE,    FEMALE,  FEMALE
	;       Ty,      Rydel,   Stern,   Aarune,  Lisia,   Zinnia,  Inver,   Chaz
	genders MALE,    MALE,    MALE,    MALE,    FEMALE,  FEMALE,  MALE,    MALE
	;       Kiri,    Johanna, Looker,  Cheryl,  Riley,   Buck,    Marley,  Mira
	genders FEMALE,  FEMALE,  MALE,    FEMALE,  MALE,    MALE,    FEMALE,  FEMALE
	;       Rosanne, Julia,   Jordan,  Dexter,  Keira,   Fuego,   Helena,  Hawes
	genders FEMALE,  FEMALE,  MALE,    MALE,    FEMALE,  MALE,    FEMALE,  MALE
	;       Charles, Curtis,  Yancy,   Ingo,    Emmet,   Grace,   Alexa,   Dexio
	genders MALE,    MALE,    FEMALE,  MALE,    MALE,    FEMALE,  FEMALE,  MALE
	;       Sina,    Gurkinn, AZ,      Emma,    Phil,    Nita,    Evelyn,  Dana
	genders FEMALE,  MALE,    MALE,    FEMALE,  MALE,    FEMALE,  FEMALE,  FEMALE
	;       Morgan,  Ryuki,   Gester,  Imakuni, Richie,  Assunta, Tracey,  Duplica
	genders FEMALE,  MALE,    MALE,    MALE,    MALE,    FEMALE,  MALE,    FEMALE
	;       Casey,   Giselle, Melanie, Damian,  Alain,   Reiko,   Aya,     Rainer
	genders FEMALE,  FEMALE,  FEMALE,  MALE,    MALE,    FEMALE,  FEMALE,  MALE
	;       Sparky,  Pyro,    Mikey,   Orville, A.J.,    Camila,  A,       Slash
	genders MALE,    MALE,    MALE,    MALE,    MALE,    FEMALE,  FEMALE,  FEMALE
	;       Alice,   Leo,     Aoooo,   Jimmy,   Cly,     Li'l D,  Arty,    Abe
	genders FEMALE,  MALE,    FEMALE,  MALE,    FEMALE,  MALE,    MALE,    MALE
	;       Baba,    Evan,    Paul,    Cyan,    Revo,    Everyle, Zetsu,   Karuta
	genders FEMALE,  MALE,    MALE,    FEMALE,  MALE,    MALE,    MALE,    MALE
	;       Nozomi,  Amos,    Kaito,   Meiko,   Miku,    Rin,     Len,     Luka
	genders FEMALE,  MALE,    MALE,    FEMALE,  FEMALE,  FEMALE,  MALE,    FEMALE
	;       Teto,    Ami,     Minako,  Usagi,   Rei,     Makoto,  Mamoru,  Luna
	genders FEMALE,  FEMALE,  FEMALE,  FEMALE,  FEMALE,  FEMALE,  MALE,    FEMALE
	;       Artemis, Diana,   Sakura,  Tomoyo,  Syaoran, Shinji,  Asuka,   Mari
	genders MALE,    FEMALE,  FEMALE,  FEMALE,  MALE,    MALE,    FEMALE,  FEMALE
	;       Gendo,   Yui,     Kaworu,  Okabe,   Daru,    Kurisu,  Suzuha,  Mayuri
	genders MALE,    FEMALE,  MALE,    MALE,    MALE,    FEMALE,  FEMALE,  FEMALE
	;       Ruka,    Kyon,    Haruhi,  Yuki,    Mikuru,  Tsuruya, Ryoko,   Itsuki
	genders MALE,    MALE,    FEMALE,  FEMALE,  FEMALE,  FEMALE,  FEMALE,  MALE
	;       Jojo,    Jotaro,  Josuke,  Dio,     Kei,     Saika,   Hayate,  Daruku
	genders MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE
	;       Nagisa,  Bridget, Ryo,     Clara,   Hana,    Miyuki,  Luke,    Lun
	genders MALE,    MALE,    FEMALE,  FEMALE,  FEMALE,  FEMALE,  MALE,    MALE
	;       Rhue,    Traziun, Gaius,   Lyrra,   Kloe,    Cetsa,   Lexus,   Sorya
	genders MALE,    MALE,    MALE,    FEMALE,  FEMALE,  FEMALE,  FEMALE,  FEMALE
	;       Strata,  Slade,   Dirk,    Talan,   Kersh,   Rangi,   Remy,    Sylvie
	genders MALE,    MALE,    MALE,    MALE,    MALE,    FEMALE,  MALE,    FEMALE
	;       Matthew, Mateo,   Babs,    Pia,     Aizawa,  Suki,    Fredrik, Drayano
	genders MALE,    FEMALE,  FEMALE,  FEMALE,  FEMALE,  FEMALE,  MALE,    MALE
	;       Hlin,    Marckus, Pum,     Bryan,   Don,     Miguel,  Satoru,  Iwata
	genders FEMALE,  MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE
	;       Junichi, Masuda,  Koji,    Nishino, Sosuke,  Tamada,  Hisashi, Sogabe
	genders MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE, 
	;       Keita,   Kagaya,  Yoshi,   Matsuda, Shigeki, Tetsuya, Oota,    Turner
	genders MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE,    MALE

GetWonderTradeHeldItem:
	ld hl, .HeldItems
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	jr .loop
.ok
	ld a, [hli]
	cp -1
	ld a, NO_ITEM
	ret z
	ld a, [hli]
	ret

.HeldItems:
	db 1,   LUCKY_EGG
	db 1,   LEFTOVERS
	db 2,   EVIOLITE
	db 2,   RARE_CANDY
	db 3,   ABILITY_CAP
	db 4,   FOCUS_BAND
	db 7,   KINGS_ROCK
	db 8,   QUICK_CLAW
	db 12,  WHITE_HERB
	db 24,  LEPPA_BERRY
	db 32,  SITRUS_BERRY
	db 64,  ORAN_BERRY
	db 96,  NO_ITEM
	db -1

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
	db  20, 100 ; Farfetch'd
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
	db  20, 100 ; Chansey
	db   1,  38 ; Tangela
	db  20, 100 ; Kangaskhan
	db   1,  31 ; Horsea
	db  32,  54 ; Seadra
	db   1,  19 ; Togepi
	db  20,  39 ; Togetic
	db  40, 100 ; Togekiss
	db   1,  32 ; Staryu
	db  33, 100 ; Starmie
	db  20, 100 ; Mr. Mime
	db  10, 100 ; Scyther
	db  20, 100 ; Jynx
	db  20,  46 ; Electabuzz
	db  20,  46 ; Magmar
	db  10, 100 ; Pinsir
	db  20, 100 ; Tauros
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
	db  55, 100 ; Rhyperior
	db  10, 100 ; Sudowoodo
	db  36, 100 ; Politoed
	db   1,  31 ; Sunkern
	db  32, 100 ; Sunflora
	db   1,  39 ; Yanma
	db  40, 100 ; Yanmega
	db   1,  19 ; Wooper
	db  20, 100 ; Quagsire
	db  20, 100 ; Espeon
	db  20, 100 ; Umbreon
	db  20, 100 ; Leafeon
	db  20, 100 ; Glaceon
	db   1,  39 ; Murkrow
	db  40, 100 ; Honchkrow
	db  37, 100 ; Slowking
	db   1,  39 ; Misdreavus
	db  40, 100 ; Mismagius
	db 255, 255 ; Unown
	db   1, 100 ; Wobbuffet
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
	db  10, 100 ; Heracross
	db   1,  39 ; Sneasel
	db  40, 100 ; Weavile
	db   1,  29 ; Teddiursa
	db  30, 100 ; Ursaring
	db   1,  37 ; Slugma
	db  38, 100 ; Magcargo
	db   1,  32 ; Swinub
	db  33,  44 ; Piloswine
	db  45, 100 ; Mamoswine
	db   1, 100 ; Corsola
	db   1,  24 ; Remoraid
	db  25, 100 ; Octillery
	db   1, 100 ; Mantine
	db  10, 100 ; Skarmory
	db   1,  23 ; Houndour
	db  24, 100 ; Houndoom
	db  55, 100 ; Kingdra
	db   1,  24 ; Phanpy
	db  25, 100 ; Donphan
	db  20,  39 ; Porygon2
	db   1, 100 ; Smeargle
	db   1,  19 ; Tyrogue
	db  20, 100 ; Hitmontop
	db   1,  19 ; Elekid
	db  47, 100 ; Electivire
	db   1,  19 ; Magby
	db  47, 100 ; Magmortar
	db  20, 100 ; Miltank
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
