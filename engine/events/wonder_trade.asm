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
	call GetPartyParamLocationAndValue
	bit MON_IS_EGG_F, a
	jr z, .not_egg
	ld a, EGG
	ld [wCurPartySpecies], a
.not_egg
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	cp LOW(PICHU)
	jr nz, .not_spiky_eared_pichu
	assert MON_FORM == MON_EXTSPECIES
	ld bc, MON_FORM - MON_SPECIES
	add hl, bc
	ld a, [hl]
	and SPECIESFORM_MASK
	cp HIGH(PICHU) << MON_EXTSPECIES_F | PICHU_SPIKY_EARED_FORM
	ld hl, .Text_WonderTradeCantTradeSpikyEaredPichu
	jmp z, PrintText
.not_spiky_eared_pichu
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

	jmp ReturnToMapWithSpeechTextbox

.Text_WonderTradeQuestion:
	text_far WonderTradeQuestionText
	text_end

.Text_WonderTradePrompt:
	text_far WonderTradePromptText
	text_end

.Text_WonderTradeCantTradeSpikyEaredPichu
	text_far WonderTradeCantTradeSpikyEaredPichuText
	text_end

;.Text_WonderTradeCantTradeEgg:
;	text_far WonderTradeCantTradeEggText
;	text_end

.Text_WonderTradeConfirm:
	text_far WonderTradeConfirmText
	text_end

.Text_WonderTradeSetup:
	text_far WonderTradeSetupText
	text_end

.Text_WonderTradeReady:
	text_far WonderTradeReadyText
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
	jmp .compute_trademon_stats

.random_trademon
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld d, a

	ld bc, NUM_SPECIES
	call RandomRange16
	ld hl, ValidPokemonLevels
	add hl, bc
	add hl, bc

	ld a, [hli]
	dec a
	cp d
	jr nc, .random_trademon

	ld a, [hl]
	cp d
	jr c, .random_trademon

	inc bc
	ld a, c
	ld [wOTTrademonSpecies], a
	ld a, b
	swap a
	add a
	ld b, a
	ld [wOTTrademonForm], a

	ld a, [wPlayerTrademonSpecies]
	cp c
	jr nz, .got_species
	ld a, [wPlayerTrademonForm]
	and EXTSPECIES_MASK
	cp b
	jr z, .random_trademon

.got_species
	ld a, [wPlayerTrademonSpecies]
	ld c, a
	ld a, [wPlayerTrademonForm]
	ld b, a
	ld de, wPlayerTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld a, [wOTTrademonSpecies]
	ld c, a
	ld a, [wOTTrademonForm]
	ld b, a
	ld de, wOTTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonOTs
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

	xor a
	ld [wPlayerTrademonCaughtData], a
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
	predef RemoveMonFromParty

	call GetWonderTradeOTForm
	ld a, d
	ld [wCurForm], a
	ld [wOTTrademonForm], a
	predef TryAddMonToParty

	ld a, [wOTTrademonSpecies]
	ld c, a
	ld a, [wOTTrademonForm]
	ld b, a
	ld de, wOTTrademonNickname
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	call Random
	ld [wWonderTradeScratch], a
	call Random
	ld [wWonderTradeScratch + 1], a
	ld hl, wWonderTradeScratch
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

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call CopyTradeOT

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
	ld [wWonderTradeScratch], a
	call Random
	ld [wWonderTradeScratch + 1], a
	call Random
	ld [wWonderTradeScratch + 2], a
	ld hl, wWonderTradeScratch
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
	ld [wWonderTradeScratch], a
	; Random gender (50-50)
	call Random
	and GENDER_MASK
	ld b, a
	; Egg for Egg
	ld a, [wPlayerTrademonSpecies]
	inc a ; cp EGG
	jr nz, .not_egg
	dec a ; ld a, EGG
	ld [wOTTrademonSpecies], a
	push bc
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, .EggString
	call CopyTradeName
	pop bc
	ld a, b
	or IS_EGG_MASK
	ld b, a
.not_egg
	; Form
	ld a, [wCurForm]
	add b
	ld [wWonderTradeScratch + 1], a
	ld hl, wWonderTradeScratch
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
	farcall ComputeNPCTrademonStatsAndEggSteps
	farcall GivePokerusToWonderTradeMon
	pop af
	ld [wCurPartyMon], a
	jmp PopAFBCDEHL

.EggString:
	rawchar "Egg@@@@@@@@"

GetGSBallPichu:
	ld a, 2
	ldh [hScriptVar], a

	assert !HIGH(PICHU)

	ld a, LOW(PICHU)
	ld [wOTTrademonSpecies], a
	ld a, FEMALE | PICHU_SPIKY_EARED_FORM ; spiky-eared variant
	ld [wOTTrademonForm], a

	ld a, [wPlayerTrademonSpecies]
	ld c, a
	ld a, [wPlayerTrademonForm]
	ld b, a
	ld de, wPlayerTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld c, a
	ld a, [wOTTrademonForm]
	ld [wCurForm], a
	ld b, a
	ld de, wOTTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonOTs
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

	xor a
	ld [wPlayerTrademonCaughtData], a
	ld [wOTTrademonCaughtData], a

	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, 30
	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromParty
	predef TryAddMonToParty

	ld c, ULTRA_BALL
	farcall SetGiftPartyMonCaughtData

	ld a, [wOTTrademonSpecies]
	ld c, a
	ld a, [wOTTrademonForm]
	ld b, a
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

	ld hl, wPartyMonOTs
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

GetWonderTradeOTForm:
; pick randomly from [1, N] for [wOTTrademonSpecies], or default to 1
; returns result in d
	ld a, [wOTTrademonSpecies]
	ld c, a
	ld a, [wOTTrademonForm]
	and EXTSPECIES_MASK
	ld b, a
	lb de, PLAIN_FORM, 1 ; d = form to return, e = running count of eligible variants found
	or d
	ld d, a
	ld hl, CosmeticSpeciesAndFormTable - 1
.loop
	inc hl
	ld a, [hli] ; species
	and a
	ret z
	cp c
	jr nz, .loop
	ld a, [hl] ; extspecies + form
	and EXTSPECIES_MASK
	cp b
	jr nz, .loop
	push hl
	push bc
	ld b, [hl]
	call CheckInvalidVariants
	pop bc
	pop hl
	jr c, .loop
	inc e
	ld a, e
	call RandomRange
	and a
	jr nz, .loop ; 1/n chance for switch
	ld a, [hl]
	and SPECIESFORM_MASK
	ld d, a
	jr .loop

CheckInvalidVariants:
	ld hl, InvalidVariants
	jmp GetSpeciesAndFormIndexFromHL

INCLUDE "data/pokemon/invalid_variants.asm"

GetWonderTradeHeldItem:
; Returns a level-scaled item reward
	ld a, [wOTTrademonSpecies]
	inc a ; cp EGG
	ret z
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

INCLUDE "data/pokemon/valid_levels.asm"
