WonderTrade::
	ld hl, .Text_WonderTradeQuestion
	call PrintText
	call YesNoBox
	jr c, .canceled

	ld hl, .Text_WonderTradePrompt
	call PrintText

	ld b, 6
	callba SelectTradeOrDaycareMon
	jr c, .canceled

	ld hl, PartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, StringBuffer1
	call CopyTradeName
	ld hl, .Text_WonderTradeConfirm
	call PrintText
	call YesNoBox
	jr c, .canceled

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
.canceled
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
	ld hl, .done
	ret
.done
	text_jump WonderTradeDoneFanfare
	db "@"


DoWonderTrade:
	ld a, [CurPartySpecies]
	ld [wPlayerTrademonSpecies], a

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
	ld a, 2
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
	ld h, a
	call Random
	ld l, a
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


GetWonderTradeOTName:
; hl = .WonderTradeOTNameTable + a * PLAYER_NAME_LENGTH
	ld hl, .WonderTradeOTNameTable
	ld b, 0
	ld c, PLAYER_NAME_LENGTH
	call AddNTimes
	ret

; TODO: Associate each OT name with a correct gender (via wOTTrademonCaughtData?)
.WonderTradeOTNameTable:
	db "Rangi@@@" ; 00
	db "Mateo@@@" ; 01
	db "Crystal@" ; 02
	db "Drayano@" ; 03
	db "Satoshi@" ; 04
	db "Satoru@@" ; 05
	db "Nemo@@@@" ; 06
	db "Nemo@@@@" ; 07
	db "Nemo@@@@" ; 08
	db "Nemo@@@@" ; 09
	db "Nemo@@@@" ; 0A
	db "Nemo@@@@" ; 0B
	db "Nemo@@@@" ; 0C
	db "Nemo@@@@" ; 0D
	db "Nemo@@@@" ; 0E
	db "Nemo@@@@" ; 0F
	db "Nemo@@@@" ; 10
	db "Nemo@@@@" ; 11
	db "Nemo@@@@" ; 12
	db "Nemo@@@@" ; 13
	db "Nemo@@@@" ; 14
	db "Nemo@@@@" ; 15
	db "Nemo@@@@" ; 16
	db "Nemo@@@@" ; 17
	db "Nemo@@@@" ; 18
	db "Nemo@@@@" ; 19
	db "Nemo@@@@" ; 1A
	db "Nemo@@@@" ; 1B
	db "Nemo@@@@" ; 1C
	db "Nemo@@@@" ; 1D
	db "Nemo@@@@" ; 1E
	db "Nemo@@@@" ; 1F
	db "Nemo@@@@" ; 20
	db "Nemo@@@@" ; 21
	db "Nemo@@@@" ; 22
	db "Nemo@@@@" ; 23
	db "Nemo@@@@" ; 24
	db "Nemo@@@@" ; 25
	db "Nemo@@@@" ; 26
	db "Nemo@@@@" ; 27
	db "Nemo@@@@" ; 28
	db "Nemo@@@@" ; 29
	db "Nemo@@@@" ; 2A
	db "Nemo@@@@" ; 2B
	db "Nemo@@@@" ; 2C
	db "Nemo@@@@" ; 2D
	db "Nemo@@@@" ; 2E
	db "Nemo@@@@" ; 2F
	db "Nemo@@@@" ; 30
	db "Nemo@@@@" ; 31
	db "Nemo@@@@" ; 32
	db "Nemo@@@@" ; 33
	db "Nemo@@@@" ; 34
	db "Nemo@@@@" ; 35
	db "Nemo@@@@" ; 36
	db "Nemo@@@@" ; 37
	db "Nemo@@@@" ; 38
	db "Nemo@@@@" ; 39
	db "Nemo@@@@" ; 3A
	db "Nemo@@@@" ; 3B
	db "Nemo@@@@" ; 3C
	db "Nemo@@@@" ; 3D
	db "Nemo@@@@" ; 3E
	db "Nemo@@@@" ; 3F
	db "Nemo@@@@" ; 40
	db "Nemo@@@@" ; 41
	db "Nemo@@@@" ; 42
	db "Nemo@@@@" ; 43
	db "Nemo@@@@" ; 44
	db "Nemo@@@@" ; 45
	db "Nemo@@@@" ; 46
	db "Nemo@@@@" ; 47
	db "Nemo@@@@" ; 48
	db "Nemo@@@@" ; 49
	db "Nemo@@@@" ; 4A
	db "Nemo@@@@" ; 4B
	db "Nemo@@@@" ; 4C
	db "Nemo@@@@" ; 4D
	db "Nemo@@@@" ; 4E
	db "Nemo@@@@" ; 4F
	db "Nemo@@@@" ; 50
	db "Nemo@@@@" ; 51
	db "Nemo@@@@" ; 52
	db "Nemo@@@@" ; 53
	db "Nemo@@@@" ; 54
	db "Nemo@@@@" ; 55
	db "Nemo@@@@" ; 56
	db "Nemo@@@@" ; 57
	db "Nemo@@@@" ; 58
	db "Nemo@@@@" ; 59
	db "Nemo@@@@" ; 5A
	db "Nemo@@@@" ; 5B
	db "Nemo@@@@" ; 5C
	db "Nemo@@@@" ; 5D
	db "Nemo@@@@" ; 5E
	db "Nemo@@@@" ; 5F
	db "Nemo@@@@" ; 60
	db "Nemo@@@@" ; 61
	db "Nemo@@@@" ; 62
	db "Nemo@@@@" ; 63
	db "Nemo@@@@" ; 64
	db "Nemo@@@@" ; 65
	db "Nemo@@@@" ; 66
	db "Nemo@@@@" ; 67
	db "Nemo@@@@" ; 68
	db "Nemo@@@@" ; 69
	db "Nemo@@@@" ; 6A
	db "Nemo@@@@" ; 6B
	db "Nemo@@@@" ; 6C
	db "Nemo@@@@" ; 6D
	db "Nemo@@@@" ; 6E
	db "Nemo@@@@" ; 6F
	db "Nemo@@@@" ; 70
	db "Nemo@@@@" ; 71
	db "Nemo@@@@" ; 72
	db "Nemo@@@@" ; 73
	db "Nemo@@@@" ; 74
	db "Nemo@@@@" ; 75
	db "Nemo@@@@" ; 76
	db "Nemo@@@@" ; 77
	db "Nemo@@@@" ; 78
	db "Nemo@@@@" ; 79
	db "Nemo@@@@" ; 7A
	db "Nemo@@@@" ; 7B
	db "Nemo@@@@" ; 7C
	db "Nemo@@@@" ; 7D
	db "Nemo@@@@" ; 7E
	db "Nemo@@@@" ; 7F
	db "Nemo@@@@" ; 80
	db "Nemo@@@@" ; 81
	db "Nemo@@@@" ; 82
	db "Nemo@@@@" ; 83
	db "Nemo@@@@" ; 84
	db "Nemo@@@@" ; 85
	db "Nemo@@@@" ; 86
	db "Nemo@@@@" ; 87
	db "Nemo@@@@" ; 88
	db "Nemo@@@@" ; 89
	db "Nemo@@@@" ; 8A
	db "Nemo@@@@" ; 8B
	db "Nemo@@@@" ; 8C
	db "Nemo@@@@" ; 8D
	db "Nemo@@@@" ; 8E
	db "Nemo@@@@" ; 8F
	db "Nemo@@@@" ; 90
	db "Nemo@@@@" ; 91
	db "Nemo@@@@" ; 92
	db "Nemo@@@@" ; 93
	db "Nemo@@@@" ; 94
	db "Nemo@@@@" ; 95
	db "Nemo@@@@" ; 96
	db "Nemo@@@@" ; 97
	db "Nemo@@@@" ; 98
	db "Nemo@@@@" ; 99
	db "Nemo@@@@" ; 9A
	db "Nemo@@@@" ; 9B
	db "Nemo@@@@" ; 9C
	db "Nemo@@@@" ; 9D
	db "Nemo@@@@" ; 9E
	db "Nemo@@@@" ; 9F
	db "Nemo@@@@" ; A0
	db "Nemo@@@@" ; A1
	db "Nemo@@@@" ; A2
	db "Nemo@@@@" ; A3
	db "Nemo@@@@" ; A4
	db "Nemo@@@@" ; A5
	db "Nemo@@@@" ; A6
	db "Nemo@@@@" ; A7
	db "Nemo@@@@" ; A8
	db "Nemo@@@@" ; A9
	db "Nemo@@@@" ; AA
	db "Nemo@@@@" ; AB
	db "Nemo@@@@" ; AC
	db "Nemo@@@@" ; AD
	db "Nemo@@@@" ; AE
	db "Nemo@@@@" ; AF
	db "Nemo@@@@" ; B0
	db "Nemo@@@@" ; B1
	db "Nemo@@@@" ; B2
	db "Nemo@@@@" ; B3
	db "Nemo@@@@" ; B4
	db "Nemo@@@@" ; B5
	db "Nemo@@@@" ; B6
	db "Nemo@@@@" ; B7
	db "Nemo@@@@" ; B8
	db "Nemo@@@@" ; B9
	db "Nemo@@@@" ; BA
	db "Nemo@@@@" ; BB
	db "Nemo@@@@" ; BC
	db "Nemo@@@@" ; BD
	db "Nemo@@@@" ; BE
	db "Nemo@@@@" ; BF
	db "Nemo@@@@" ; C0
	db "Nemo@@@@" ; C1
	db "Nemo@@@@" ; C2
	db "Nemo@@@@" ; C3
	db "Nemo@@@@" ; C4
	db "Nemo@@@@" ; C5
	db "Nemo@@@@" ; C6
	db "Nemo@@@@" ; C7
	db "Nemo@@@@" ; C8
	db "Nemo@@@@" ; C9
	db "Nemo@@@@" ; CA
	db "Nemo@@@@" ; CB
	db "Nemo@@@@" ; CC
	db "Nemo@@@@" ; CD
	db "Nemo@@@@" ; CE
	db "Nemo@@@@" ; CF
	db "Nemo@@@@" ; D0
	db "Nemo@@@@" ; D1
	db "Nemo@@@@" ; D2
	db "Nemo@@@@" ; D3
	db "Nemo@@@@" ; D4
	db "Nemo@@@@" ; D5
	db "Nemo@@@@" ; D6
	db "Nemo@@@@" ; D7
	db "Nemo@@@@" ; D8
	db "Nemo@@@@" ; D9
	db "Nemo@@@@" ; DA
	db "Nemo@@@@" ; DB
	db "Nemo@@@@" ; DC
	db "Nemo@@@@" ; DD
	db "Nemo@@@@" ; DE
	db "Nemo@@@@" ; DF
	db "Nemo@@@@" ; E0
	db "Nemo@@@@" ; E1
	db "Nemo@@@@" ; E2
	db "Nemo@@@@" ; E3
	db "Nemo@@@@" ; E4
	db "Nemo@@@@" ; E5
	db "Nemo@@@@" ; E6
	db "Nemo@@@@" ; E7
	db "Nemo@@@@" ; E8
	db "Nemo@@@@" ; E9
	db "Nemo@@@@" ; EA
	db "Nemo@@@@" ; EB
	db "Nemo@@@@" ; EC
	db "Nemo@@@@" ; ED
	db "Nemo@@@@" ; EE
	db "Nemo@@@@" ; EF
	db "Nemo@@@@" ; F0
	db "Nemo@@@@" ; F1
	db "Nemo@@@@" ; F2
	db "Nemo@@@@" ; F3
	db "Nemo@@@@" ; F4
	db "Nemo@@@@" ; F5
	db "Nemo@@@@" ; F6
	db "Nemo@@@@" ; F7
	db "Nemo@@@@" ; F8
	db "Nemo@@@@" ; F9
	db "Nemo@@@@" ; FA
	db "Nemo@@@@" ; FB
	db "Nemo@@@@" ; FC
	db "Nemo@@@@" ; FD
	db "Nemo@@@@" ; FE
	db "Nemo@@@@" ; FF


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
; Don't receive Pokémon below a valid level.
; Legendaries and other banned Pokémon have a "valid" level of 255.
	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld d, a

	ld a, [wOTTrademonSpecies]
	ld hl, .MinimumPokemonLevels
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	dec a

	cp d
	jr nc, .level_too_low
	xor a
.level_too_low
	ret

.MinimumPokemonLevels
	db 255 ; ?????
	db   1 ; Bulbasaur
	db  16 ; Ivysaur
	db  32 ; Venusaur
	db   1 ; Charmander
	db  16 ; Charmeleon
	db  36 ; Charizard
	db   1 ; Squirtle
	db  16 ; Wartortle
	db  36 ; Blastoise
	db   1 ; Caterpie
	db   7 ; Metapod
	db  10 ; Butterfree
	db   1 ; Weedle
	db   7 ; Kakuna
	db  10 ; Beedrill
	db   1 ; Pidgey
	db  18 ; Pidgeotto
	db  36 ; Pidgeot
	db   1 ; Rattata
	db  20 ; Raticate
	db   1 ; Spearow
	db  20 ; Fearow
	db   1 ; Ekans
	db  22 ; Arbok
	db   1 ; Pikachu
	db  20 ; Raichu
	db   1 ; Sandshrew
	db  22 ; Sandslash
	db   1 ; Nidoran♀
	db  16 ; Nidorina
	db  36 ; Nidoqueen
	db   1 ; Nidoran♂
	db  16 ; Nidorino
	db  36 ; Nidoking
	db   5 ; Clefairy
	db  20 ; Clefable
	db   1 ; Vulpix
	db  20 ; Ninetales
	db   5 ; Jigglypuff
	db  20 ; Wigglytuff
	db   1 ; Zubat
	db  22 ; Golbat
	db   1 ; Oddish
	db  21 ; Gloom
	db  32 ; Vileplume
	db   1 ; Paras
	db  24 ; Parasect
	db   1 ; Venonat
	db  31 ; Venomoth
	db   1 ; Diglett
	db  26 ; Dugtrio
	db   1 ; Meowth
	db  28 ; Persian
	db   1 ; Psyduck
	db  33 ; Golduck
	db   1 ; Mankey
	db  28 ; Primeape
	db   1 ; Growlithe
	db  20 ; Arcanine
	db   1 ; Poliwag
	db  25 ; Poliwhirl
	db  36 ; Poliwrath
	db   1 ; Abra
	db  16 ; Kadabra
	db  36 ; Alakazam
	db   1 ; Machop
	db  28 ; Machoke
	db  46 ; Machamp
	db   1 ; Bellsprout
	db  21 ; Weepinbell
	db  32 ; Victreebel
	db   1 ; Tentacool
	db  30 ; Tentacruel
	db   1 ; Geodude
	db  25 ; Graveler
	db  45 ; Golem
	db   1 ; Ponyta
	db  40 ; Rapidash
	db   1 ; Slowpoke
	db  37 ; Slowbro
	db   1 ; Magnemite
	db  30 ; Magneton
	db   1 ; Farfetch'd
	db   1 ; Doduo
	db  31 ; Dodrio
	db   1 ; Seel
	db  34 ; Dewgong
	db   1 ; Grimer
	db  38 ; Muk
	db   1 ; Shellder
	db  34 ; Cloyster
	db   1 ; Gastly
	db  25 ; Haunter
	db  45 ; Gengar
	db   1 ; Onix
	db   1 ; Drowzee
	db  26 ; Hypno
	db   1 ; Krabby
	db  28 ; Kingler
	db   1 ; Voltorb
	db  30 ; Electrode
	db   1 ; Exeggcute
	db  30 ; Exeggutor
	db   1 ; Cubone
	db  28 ; Marowak
	db  20 ; Hitmonlee
	db  20 ; Hitmonchan
	db   1 ; Lickitung
	db   1 ; Koffing
	db  35 ; Weezing
	db   1 ; Rhyhorn
	db  42 ; Rhydon
	db   1 ; Chansey
	db   1 ; Tangela
	db   1 ; Kangaskhan
	db   1 ; Horsea
	db  32 ; Seadra
	db   1 ; Goldeen
	db  33 ; Seaking
	db   1 ; Staryu
	db  33 ; Starmie
	db   1 ; Mr.Mime
	db   1 ; Scyther
	db  20 ; Jynx
	db  20 ; Electabuzz
	db  20 ; Magmar
	db   1 ; Pinsir
	db   1 ; Tauros
	db   1 ; Magikarp
	db  20 ; Gyarados
	db   1 ; Lapras
	db   1 ; Ditto
	db   1 ; Eevee
	db  20 ; Vaporeon
	db  20 ; Jolteon
	db  20 ; Flareon
	db   1 ; Porygon
	db   1 ; Omanyte
	db  40 ; Omastar
	db   1 ; Kabuto
	db  40 ; Kabutops
	db   1 ; Aerodactyl
	db   1 ; Snorlax
	db 255 ; Articuno
	db 255 ; Zapdos
	db 255 ; Moltres
	db   1 ; Dratini
	db  30 ; Dragonair
	db  55 ; Dragonite
	db 255 ; Mewtwo
	db 255 ; Mew
	db   1 ; Chikorita
	db  16 ; Bayleef
	db  32 ; Meganium
	db   1 ; Cyndaquil
	db  14 ; Quilava
	db  36 ; Typhlosion
	db   1 ; Totodile
	db  18 ; Croconaw
	db  30 ; Feraligatr
	db   1 ; Sentret
	db  15 ; Furret
	db   1 ; Hoothoot
	db  20 ; Noctowl
	db   1 ; Ledyba
	db  18 ; Ledian
	db   1 ; Spinarak
	db  22 ; Ariados
	db  32 ; Crobat
	db   1 ; Chinchou
	db  27 ; Lanturn
	db   1 ; Pichu
	db   1 ; Cleffa
	db   1 ; Igglybuff
	db   1 ; Togepi
	db  20 ; Togetic
	db   1 ; Natu
	db  25 ; Xatu
	db   1 ; Mareep
	db  15 ; Flaaffy
	db  30 ; Ampharos
	db  32 ; Bellossom
	db   1 ; Marill
	db  18 ; Azumarill
	db   1 ; Sudowoodo
	db  36 ; Politoed
	db   1 ; Hoppip
	db  18 ; Skiploom
	db  27 ; Jumpluff
	db   1 ; Aipom
	db   1 ; Sunkern
	db  20 ; Sunflora
	db   1 ; Yanma
	db   1 ; Wooper
	db  20 ; Quagsire
	db  20 ; Espeon
	db  20 ; Umbreon
	db   1 ; Murkrow
	db  37 ; Slowking
	db   1 ; Misdreavus
	db   1 ; Unown
	db   1 ; Wobbuffet
	db   1 ; Girafarig
	db   1 ; Pineco
	db  31 ; Forretress
	db   1 ; Dunsparce
	db   1 ; Gligar
	db  20 ; Steelix
	db   1 ; Snubbull
	db  23 ; Granbull
	db   1 ; Qwilfish
	db  20 ; Scizor
	db   1 ; Shuckle
	db   1 ; Heracross
	db   1 ; Sneasel
	db   1 ; Teddiursa
	db  30 ; Ursaring
	db   1 ; Slugma
	db  38 ; Magcargo
	db   1 ; Swinub
	db  33 ; Piloswine
	db   1 ; Corsola
	db   1 ; Remoraid
	db  25 ; Octillery
	db   1 ; Delibird
	db   1 ; Mantine
	db   1 ; Skarmory
	db   1 ; Houndour
	db  24 ; Houndoom
	db  55 ; Kingdra
	db   1 ; Phanpy
	db  25 ; Donphan
	db  20 ; Porygon2
	db   1 ; Stantler
	db   1 ; Smeargle
	db   1 ; Tyrogue
	db  20 ; Hitmontop
	db   1 ; Smoochum
	db   1 ; Elekid
	db   1 ; Magby
	db   1 ; Miltank
	db  20 ; Blissey
	db 255 ; Raikou
	db 255 ; Entei
	db 255 ; Suicune
	db   1 ; Larvitar
	db  30 ; Pupitar
	db  55 ; Tyranitar
	db 255 ; Lugia
	db 255 ; Ho-Oh
	db 255 ; Celebi
	db 255 ; ?????
	db 255 ; Egg
	db 255 ; ?????
	db 255 ; ?????
