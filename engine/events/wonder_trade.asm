WonderTrade::
	xor a
	ldh [hScriptVar], a

	ld hl, .Text_WonderTradeQuestion
	call PrintText
	call YesNoBox
	ret c

	ld hl, .Text_WonderTradePrompt
	call PrintText

	ld b, PARTYMENUACTION_GIVE_MON
	farcall SelectTradeOrDayCareMon
	ret c

	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr z, .not_egg
	ld a, EGG
	ld [wCurPartySpecies], a
.not_egg
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wStringBuffer1
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

	jp ReturnToMapWithSpeechTextbox

.Text_WonderTradeQuestion:
	text_jump WonderTradeQuestionText
	text_end

.Text_WonderTradePrompt:
	text_jump WonderTradePromptText
	text_end

;.Text_WonderTradeCantTradeEgg:
;	text_jump WonderTradeCantTradeEggText
;	text_end

.Text_WonderTradeConfirm:
	text_jump WonderTradeConfirmText
	text_end

.Text_WonderTradeSetup:
	text_jump WonderTradeSetupText
	text_end

.Text_WonderTradeReady:
	text_jump WonderTradeReadyText
	text_end

DoWonderTrade:
	ld a, 1
	ldh [hScriptVar], a

	ld a, [wCurPartySpecies]
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

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonOTName
	call CopyTradeOT

	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	call CopyTradeOT

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

	call GetWonderTradeOTForm
	ld [wCurForm], a
	predef TryAddMonToParty

	ld a, [wOTTrademonSpecies]
	cp MAGIKARP
	jr nz, .not_first_magikarp
	ld a, [wFirstMagikarpSeen]
	and a
	jr nz, .not_first_magikarp
	ld a, [wCurForm]
	ld [wFirstMagikarpSeen], a
.not_first_magikarp

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonNickname
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	call Random
	ld [wBuffer1], a
	call Random
	ld [wBuffer1 + 1], a
	ld hl, wBuffer1
	ld de, wOTTrademonID
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Trade_CopyTwoBytes

	call GetWonderTradeOTName
	push hl
	ld de, wOTTrademonOTName
	call CopyTradeOT
	pop hl
	ld de, wOTTrademonSenderName
	call CopyTradeOT

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call CopyTradeOT

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
	ld [wBuffer1], a
	call Random
	ld [wBuffer1 + 1], a
	call Random
	ld [wBuffer1 + 2], a
	ld hl, wBuffer1
	ld de, wOTTrademonDVs
	call Trade_CopyThreeBytes

	ld hl, wPartyMon1DVs
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
	inc a
rept 5
	add a
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
	ld [wBuffer1], a
	; Random gender (50-50)
	call Random
	and GENDER_MASK
	ld b, a
	; Form
	ld a, [wCurForm]
	add b
	ld [wBuffer1 + 1], a
	ld hl, wBuffer1
	ld de, wOTTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	call GetWonderTradeHeldItem
	ld [de], a

.compute_trademon_stats
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
	farcall GivePokerusToWonderTradeMon
	pop af
	ld [wCurPartyMon], a
	jp PopAFBCDEHL

GetGSBallPichu:
	ld a, 2
	ldh [hScriptVar], a

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

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonOTName
	call CopyTradeOT

	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	call CopyTradeOT

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
	ld [wOTTrademonCaughtData], a

	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, 30
	ld [wCurPartyLevel], a
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	xor a
	ld [wMonType], a
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromPartyOrBox
	predef TryAddMonToParty

	ld b, MALE
	ld a, [wPlayerGender]
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

	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	ld hl, wPlayerID
	ld de, wOTTrademonID
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Trade_CopyTwoBytes

	ld hl, wPlayerName
	push hl
	ld de, wOTTrademonOTName
	call CopyTradeOT
	pop hl
	ld de, wOTTrademonSenderName
	call CopyTradeOT

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call CopyTradeOT

	ld a, $ff
	ld [wOTTrademonDVs], a
	ld [wOTTrademonDVs + 1], a
	ld [wOTTrademonDVs + 2], a

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonDVs
	call Trade_CopyThreeBytes

	ld a, HIDDEN_ABILITY | QUIRKY
	ld [wOTTrademonPersonality], a
	ld a, FEMALE | 2 ; spiky-eared variant
	ld [wOTTrademonPersonality + 1], a

	ld hl, wPartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonPersonality
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	xor a
	ld [de], a

	ret

GetWonderTradeOTName:
; pick from WonderTradeOTNames1 if [wOTTrademonID] is even,
; WonderTradeOTNames2 if odd, using [wOTTrademonID+1] as the index.
	ld hl, wOTTrademonID
	ld a, [hli]
	and 1
	ld a, [hl]
	ld hl, WonderTradeOTNames1
	jr z, .ok
	ld hl, WonderTradeOTNames2
.ok
	lb bc, 0, PLAYER_NAME_LENGTH
	rst AddNTimes
	ret

INCLUDE "data/events/wonder_trade/ot_names.asm"

GetWonderTradeOTGender:
; pick from .WonderTradeOTGenders1 if [wOTTrademonID] is even,
; WonderTradeOTGenders2 if odd, using [wOTTrademonID+1] as the index.
	ld hl, wOTTrademonID
	ld a, [hli]
	and 1
	ld a, [hl]
	ld hl, WonderTradeOTGenders1
	jr z, .ok
	ld hl, WonderTradeOTGenders2
.ok
	ld c, a
	ld d, BANK(WonderTradeOTGenders1) ; aka BANK(WonderTradeOTGenders2)
	ld b, CHECK_FLAG
	predef FlagPredef
	ld a, c
	and a
	ret z ; MALE
	ld a, FEMALE
	ret

INCLUDE "data/events/wonder_trade/ot_genders.asm"

GetWonderTradeOTForm:
; pick randomly from [1, N] for [wOTTrademonSpecies], or default to 1
	ld a, [wOTTrademonSpecies]
	ld hl, ValidVariantRanges
	ld de, 2
	call IsInArray
	ld a, 1
	jr nc, .ok
	inc hl
	ld a, [hl]
.ok
	call RandomRange
	inc a
	ret

INCLUDE "data/pokemon/valid_variants.asm"

GetWonderTradeHeldItem:
; Returns a level-scaled item reward
	push de
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld a, [de]
	ld b, a
	ld a, BANK(WonderTradeBaseItems)
	ld hl, WonderTradeBaseItems
	ld de, WonderTradeRareItems
	farcall GetScaledItemReward
	pop de
	ret

INCLUDE "data/events/wonder_trade/held_items.asm"

CheckValidLevel:
; Don't receive Pokémon outside a valid level range.
; Legendaries and other banned Pokémon have a "valid" range of 255 to 255.
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld d, a

	ld a, [wOTTrademonSpecies]
	ld hl, ValidPokemonLevels
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

INCLUDE "data/pokemon/valid_levels.asm"
