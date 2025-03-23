TryAddMonToParty:
; Check if to copy wild Pkmn or generate new Pkmn
	; Whose is it?
	ld de, wPartyCount
	ld a, [wMonType]
	and $f
	jr z, .getpartylocation ; PARTYMON
	ld de, wOTPartyCount

.getpartylocation
	; Do we have room for it?
	ld a, [de]
	cp PARTY_LENGTH
	ret nc
	; Increase the party count
	inc a
	ld [de], a
	ldh [hMoveMon], a ; HRAM backup
	; Now let's load the OT name.
	ld hl, wPartyMonOTs
	ld a, [wMonType]
	and $f
	jr z, .loadOTname
	ld hl, wOTPartyMonOTs

.loadOTname
	ldh a, [hMoveMon] ; Restore index from backup
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes
	call GetPartyPokemonName
	ld a, [wMonType]
	and $f
	ld hl, wOTPartyMonNicknames
	jr nz, .got_target_nick
	ld hl, wPartyMonNicknames
.got_target_nick
	ldh a, [hMoveMon]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	ld a, [wBattleType]
	cp BATTLETYPE_ROAMING
	jr nz, .not_roaming_form
	ld a, wRoamMon1Form - wRoamMon1
	farcall DoGetRoamMonData
	ld a, [hl]
	and SPECIESFORM_MASK
	ld [wCurForm], a
.not_roaming_form

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData

	ld hl, wPartyMon1Species
	ld a, [wMonType]
	and $f
	jr z, .initializeStats
	ld hl, wOTPartyMon1Species
.initializeStats
	ldh a, [hMoveMon]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	ld e, l
	ld d, h
	push hl

	; species
	ld a, [wCurSpecies]
	ld [de], a
	inc de

	; item
	xor a
	ld [de], a
	inc de

	; moves
	push de
	ld h, d
	ld l, e
	xor a
rept NUM_MOVES - 1
	ld [hli], a
endr
	ld [hl], a
	ld [wEvolutionOldSpecies], a
	; c = species
	ld a, [wCurSpecies]
	ld c, a
	; b = form
	ld a, [wCurForm]
	ld b, a
	predef FillMoves
	pop de
rept NUM_MOVES
	inc de
endr

	; OT ID
	ld a, [wPlayerID]
	ld [de], a
	inc de
	ld a, [wPlayerID + 1]
	ld [de], a
	inc de

	; experience
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	farcall CalcExpAtLevel
	pop de
	ldh a, [hProduct + 1]
	ld [de], a
	inc de
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de

	pop hl
	push hl

	; EVs, DVs, personality
	ld a, [wMonType]
	and $f
	jr z, .generateEVsDVsAndPersonality
	ld a, [wBattleMode]
	dec a
	jr z, .generateEVsDVsAndPersonality
	farcall GetTrainerEVsDVsAndPersonality
	pop hl
	push hl
	jmp .initializetrainermonstats

.generateEVsDVsAndPersonality
	xor a
rept 6 ; EVs
	ld [de], a
	inc de
endr
	ld a, [wBattleMode]
	dec a
	pop hl
	push hl
	jr z, .wildmon
	ld a, [wCurPartySpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	push de
	call SetSeenAndCaughtMon
	pop de
	pop hl
	push hl
	jr .random_dvs

.wildmon
	ld a, [wBattleType]
	cp BATTLETYPE_ROAMING
	jr nz, .random_dvs
	push bc
	ld a, wRoamMon1DVs - wRoamMon1
	farcall DoGetRoamMonData
	push hl
	farcall GetRoamMonHP
	ld a, [hl]
	pop hl
	and a
	pop bc
	jr z, .random_dvs
	push bc
	push de
	ld de, wDVAndPersonalityBuffer
	ld bc, 5
	rst CopyBytes
	pop de
	pop bc
	jmp .initializetrainermonstats

.random_dvs
; Random DVs
	call Random
	ld [wDVAndPersonalityBuffer], a
	call Random
	ld [wDVAndPersonalityBuffer + 1], a
	call Random
	ld [wDVAndPersonalityBuffer + 2], a

	push hl
	ld hl, wDVAndPersonalityBuffer + 2
	farcall ApplyLegendaryDVs
	pop hl

; Random nature from 0 to 24
	push hl
	ld hl, wPartyMon1Personality
	ld a, [wPartyMon1Species]
	ld c, a
	call GetAbility
	pop hl
	ld a, b
	cp SYNCHRONIZE
	jr nz, .no_synchronize
	ld a, [wPartyMon1Nature]
	and NATURE_MASK
	jr .got_nature
.no_synchronize
	ld a, NUM_NATURES
	call RandomRange
.got_nature
	ld b, a

; Random ability
; 5% hidden ability, otherwise 50% either main ability
	ld a, [wBattleMode]
	dec a
	jr nz, .ability_check

	ld a, [wBattleType]
	cp BATTLETYPE_GROTTO
	ld a, HIDDEN_ABILITY
	jr z, .got_ability

.ability_check
	call Random
	cp 1 + 5 percent
	jr c, .hidden_ability
	and $1
	jr z, .ability_2
.ability_1
	ld a, ABILITY_1
	jr .got_ability
.ability_2
	ld a, ABILITY_2
	jr .got_ability
.hidden_ability
	ld a, HIDDEN_ABILITY
.got_ability
	add b
	ld b, a

; Random shininess
; 1/4096 chance to be shiny, 3/4096 with Shiny Charm
	ld a, [wBattleMode]
	dec a
	jr nz, .shiny_check

	ld a, [wBattleType]
	cp BATTLETYPE_RED_GYARADOS
	jr z, .not_shiny
	cp BATTLETYPE_GROTTO
	jr z, .not_shiny

.shiny_check
	call Random
	and a
	jr nz, .not_shiny ; 255/256 not shiny
	ld a, [wCurKeyItem]
	push af
	ld a, SHINY_CHARM
	ld [wCurKeyItem], a
	push hl
	push bc
	push de
	call CheckKeyItem
	pop de
	pop bc
	pop hl
	jr c, .shiny_charm
	pop af
	ld [wCurKeyItem], a
	call Random
	cp SHINY_NUMERATOR
	jr nc, .not_shiny ; 240/256 still not shiny
.shiny
	ld a, SHINY_MASK
	jr .got_shininess
.shiny_charm
	pop af
	ld [wCurItem], a
	call Random
	cp CHARMED_SHINY_NUMERATOR
	jr c, .shiny ; 208/256 still not shiny
.not_shiny
	xor a
.got_shininess
	add b
	ld [wDVAndPersonalityBuffer + 3], a

	; Gender. If lead has Cute Charm, force opposite gender 2/3
	; of the time
	call GetLeadAbility
	cp CUTE_CHARM
	jr nz, .not_cute_charm
	ld a, 3
	call BattleRandomRange
	and a
	jr z, .not_cute_charm
	ld a, [wPartyMon1Gender]
	cp FEMALE
	ld a, %111
	jr z, .cute_charm_ok
	xor a
	jr .cute_charm_ok

.not_cute_charm
; Random gender
; Derived from base ratio
; Random gender selection value
	call Random
	and %111
.cute_charm_ok
; We need the gender ratio to do anything with this.
	push af
	ld a, [wCurPartySpecies]
	ld c, a
	ld a, [wPartyMon1Form]
	and SPECIESFORM_MASK
	ld b, a
	call GetGenderRatio
	pop af
; Ratios below the value are female, and vice-versa.
	cp c
	; a = carry (a < c) ? FEMALE : MALE (0)
	sbc a
	and FEMALE
	ld b, a

; Form from [wCurForm] (set by LoadEnemyMon)
	ld a, [wCurForm]
	add b
	ld [wDVAndPersonalityBuffer + 4], a

.initializetrainermonstats
	ld bc, wDVAndPersonalityBuffer
rept 5 ; DVs + Personality
	ld a, [bc]
	ld [de], a
	inc bc
	inc de
endr
	push hl
	push de
	inc hl
	inc hl
	predef FillPP
	pop de
	pop hl
rept NUM_MOVES
	inc de
endr
	ld a, [wMonType]
	and $f
	ld a, BASE_HAPPINESS
	jr z, .set_happiness
	ld a, [wBattleMode]
	dec a
	ld a, BASE_HAPPINESS
	jr z, .set_happiness
	ld a, MAX_RETURN_HAPPINESS
.set_happiness
	ld [de], a
	inc de
	xor a
rept 4 ; PokerusStatus + CaughtData
	ld [de], a
	inc de
endr
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de
	xor a
rept 2 ; Status
	ld [de], a
	inc de
endr
	pop hl
	push hl
	ld bc, MON_EVS - 1
	add hl, bc
	lb bc, FALSE, STAT_HP
	predef CalcPkmnStatC
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de
	pop hl
	ld bc, MON_EVS - 1
	add hl, bc
	ld b, TRUE
	push hl
	push de
	predef CalcPkmnStats
	pop hl
	push bc
	inc hl
	ld a, [hld]
	ld c, a
	ld a, [hld]
	ld b, a
	ld a, c
	ld [hld], a
	ld [hl], b
	pop bc
	pop hl
	scf ; When this function returns, the carry flag indicates success vs failure.
	ret

FillPP:
	push bc
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .next
	push hl
	push bc
	ld hl, Moves + MOVE_PP
	call GetMoveProperty
	pop bc
	pop hl
.next
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	pop bc
	ret

AddTempMonToParty:
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	scf
	ret z

	inc [hl]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld e, l
	ld d, h
	ld hl, wTempMonSpecies
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes

	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wTempMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes

	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wTempMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	ld hl, wNamedObjectIndex
	ld a, [wTempMonSpecies]
	ld c, a
	ld [hli], a
	ld [wCurPartySpecies], a
	ld a, [wTempMonForm]
	ld b, a
	ld [hl], a
	ld [wCurForm], a

	push bc
	ld hl, wPartyMon1IsEgg
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	pop bc
	bit MON_IS_EGG_F, [hl]
	jr nz, .done
	call SetSeenAndCaughtMon
	ld hl, wPartyMon1Happiness
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld [hl], BASE_HAPPINESS
.done
	and a
	ret

RetrievePokemonFromDayCareMan:
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	ld de, SFX_TRANSACTION
	call PlayWaitSFX
	call GetBreedMon1LevelGrowth
	ld a, b
	ld [wPrevPartyLevel], a
	ld a, e
	ld [wCurPartyLevel], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	jr RetrieveBreedmon

RetrievePokemonFromDayCareLady:
	ld a, [wBreedMon2Species]
	ld [wCurPartySpecies], a
	ld de, SFX_TRANSACTION
	call PlayWaitSFX
	call GetBreedMon2LevelGrowth
	ld a, b
	ld [wPrevPartyLevel], a
	ld a, e
	ld [wCurPartyLevel], a
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	; fallthrough

RetrieveBreedmon:
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jr nz, .room_in_party
	scf
	ret

.room_in_party
	inc [hl]
	ld h, a
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld a, [wBreedMon1Species]
	ld de, wBreedMon1Nickname
	jr z, .okay
	ld a, [wBreedMon2Species]
	ld de, wBreedMon2Nickname

.okay
	ld [wCurSpecies], a
	ld a, h
	ld hl, wPartyMonNicknames
	call SkipNames
	call SwapHLDE
	rst CopyBytes
	push hl
	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	pop hl
	rst CopyBytes
	push hl
	call GetLastPartyMon
	pop hl
	ld bc, BREEDMON_STRUCT_LENGTH
	rst CopyBytes
	call GetLastPartyMon
	ld hl, MON_FORM
	add hl, de
	ld a, [hl]
	ld [wCurForm], a
	call GetBaseData
	call GetLastPartyMon
	ld b, d
	ld c, e
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [wCurPartyLevel]
	ld [hl], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, $a ; 10 bytes = 5 stats * 2?
	add hl, bc
	push bc
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	call GetHyperTraining
	inc a
	ld b, a
	predef CalcPkmnStats
	ld hl, wPartyMon1Moves
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ld a, $1
	ld [wEvolutionOldSpecies], a
	ld a, [wCurSpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	predef FillMoves
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	call HealPartyMon
	ld a, [wCurPartyLevel]
	ld d, a
	farcall CalcExpAtLevel
	pop bc
	ld hl, $8 ; Experience
	add hl, bc
	ldh a, [hMultiplicand]
	ld [hli], a
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ldh a, [hMultiplicand + 2]
	ld [hl], a
	and a
	ret

Special_HyperTrain:
	farcall SelectMonFromParty
	jr c, .nope
	ld a, MON_IS_EGG
	call GetPartyParamLocationAndValue
	bit MON_IS_EGG_F, a
	ld hl, .TextCantTrainEgg
	jr nz, .print_and_fail

	call GetCurNickname
	ld hl, .TrainWhichStat
	call PrintText

	ld hl, .MenuHeader
	call LoadMenuHeader
	call _2DMenu
	push af
	call CloseWindow
	pop af
	jr c, .nope
	ld a, [wMenuCursorY]
	ld hl, wMenuCursorX
	dec [hl]
	jr z, .got_y
	add 3
.got_y
	ld c, a
	ld d, 1
.loop
	rrc d
	dec a
	jr nz, .loop

	; If modern EVs are enabled, require level 50 instead.
	ld a, [wInitialOptions2]
	and EV_OPTMASK
	cp EVS_OPT_MODERN
	jr nz, .not_modern_evs

	ld a, MON_LEVEL
	call GetPartyParamLocationAndValue
	cp HYPER_LEVEL_REQ
	jr nc, .allow_hyper_training
	ld hl, .TextNotEnoughLevels
	jr .print_and_fail

.not_modern_evs
	; Check if we've reached maximum effort on the stat
	ld a, MON_EVS - 1
	add c
	call GetPartyParamLocationAndValue
	cp MODERN_MAX_EV
	ld hl, .TextNotMaxEffort
	jr c, .print_and_fail

.allow_hyper_training
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1HyperTraining
	call SkipNames
	ld a, [hl]
	and d
	jr nz, .already_hyped
	or d
	or [hl]
	ld [hl], a

	call RecalculatePartyMonStats
	ld a, 1
	jr .return

.already_hyped
	ld hl, .TextAlreadyHypedUp
	; fallthrough
.print_and_fail
	call PrintText
.nope
	xor a
.return
	ldh [hScriptVar], a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 19, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $a0 ; flags
	dn 3, 2 ; rows, columns
	db 8 ; spacing
	dba .Strings
	dbw BANK(.MenuData), 0

.Strings:
	db "HP@"
	db "Speed@"
	db "Attack@"
	db "Sp.Atk@"
	db "Defense@"
	db "Sp.Def@"

.TrainWhichStat:
	text "Train which of"
	line ""
	text_ram wStringBuffer1
	text "'s stats?"
	done

.TextCantTrainEgg:
	text "An Egg? I get that"
	line "you're hyped to"
	cont "have it, but I"
	cont "can't train it yet!"
	prompt

.TextNotEnoughLevels:
	text "Oh no… No, no, no!"
	line ""
	text_ram wStringBuffer1
	text " hasn't"
	cont "leveled up enough"
	cont "to be ready!"
	prompt

.TextNotMaxEffort:
	text "Oh no… No, no, no!"
	line ""
	text_ram wStringBuffer1
	text " hasn't"
	cont "maxed their effort"
	cont "in that stat!"
	prompt

.TextAlreadyHypedUp:
	text "But "
	text_ram wStringBuffer1
	text " is"
	line "already hyped up"
	cont "in that stat!"
	prompt

RecalculatePartyMonStats:
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld [wCurSpecies], a
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	ld [wCurForm], a
	call GetBaseData

	ld a, MON_LEVEL
	call GetPartyParamLocationAndValue
	ld [wCurPartyLevel], a

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1HyperTraining
	call SkipNames
	ld b, [hl] ; b = hyper training
	inc b ; use EVs on calculation

	ld a, MON_MAXHP ; de = pointer to stats
	call GetPartyParamLocationAndValue
	push hl
	ld a, MON_EVS - 1 ; hl = pointer to EVs - 1
	call GetPartyParamLocationAndValue
	pop de

	; uses b, de, hl
	predef_jump CalcPkmnStats

GetLastPartyMon:
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ret

DepositMonWithDayCareMan:
	ld de, wBreedMon1Nickname
	jr _DepositBreedmon

DepositMonWithDayCareLady:
	ld de, wBreedMon2Nickname

_DepositBreedmon:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call SkipNames
	rst CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	call SkipNames
	rst CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld bc, BREEDMON_STRUCT_LENGTH
	rst CopyBytes
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef_jump RemoveMonFromParty

SentPkmnIntoBox:
; Sents the Pkmn into one of Bills Boxes
; the data comes mainly from wOTPartyMon1
	farcall NewStorageBoxPointer
	jr c, .full

	push bc
	lb bc, $81, 1
	farcall CopyBetweenPartyAndTemp

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld a, [wOTPartyMon1Form]
	ld [wCurForm], a
	call GetBaseData

	ld hl, wPlayerName
	ld de, wTempMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes

	call GetPartyPokemonName
	ld hl, wStringBuffer1
	ld de, wTempMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	ld a, [wCurPartySpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call SetSeenAndCaughtMon
	pop bc
	ld a, b
	ld [wTempMonBox], a
	ld a, c
	ld [wTempMonSlot], a
	farcall UpdateStorageBoxMonFromTemp
	scf
	ret

.full
	and a
	ret

RemoveMonFromParty:
; Done by writing a null entry to the party slot.
	ld b, 0
	ld a, [wCurPartyMon]
	inc a
	ld c, a
	ld e, 0
	farjp SetStorageBoxPointer

ComputeNPCTrademonStatsAndEggSteps:
	ld a, MON_LEVEL
	call GetPartyParamLocationAndValue
	ld [wCurPartyLevel], a
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld a, [hl]
	ld [wCurSpecies], a
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	ld [wCurForm], a
	call GetBaseData
	ld a, MON_MAXHP
	call GetPartyParamLocationAndValue
	ld d, h
	ld e, l
	push de
	ld a, MON_EVS - 1
	call GetPartyParamLocationAndValue
	ld b, TRUE
	predef CalcPkmnStats
	pop de
	ld a, MON_HP
	call GetPartyParamLocationAndValue
	xor a
	ld [hli], a
	ld [hld], a
	ld a, [wCurForm]
	and IS_EGG_MASK
	jr nz, .set_egg_steps
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ret

.set_egg_steps
	ld a, MON_HAPPINESS
	call GetPartyParamLocationAndValue
	ld a, [wBaseEggSteps]
	and $f
	inc a
	ld b, a
	add a
	add a
	add b
	ld [hl], a
	ret

FixPlayerEVsAndStats:
	farcall FixPlayerEVs
	ld a, [wPartyCount]
	ld [wCurPartyMon], a
.loop
	ld a, [wCurPartyMon]
	and a
	ret z
	dec a
	ld [wCurPartyMon], a
	call UpdatePkmnStats
	jr .loop

UpdatePkmnStats:
; Recalculates the stats of wCurPartyMon and also updates current HP accordingly
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld [wCurSpecies], a
	ld a, MON_FORM
	call GetPartyParamLocationAndValue
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, MON_LEVEL
	call GetPartyParamLocationAndValue
	ld [wCurPartyLevel], a
	ld a, MON_MAXHP + 1
	call GetPartyParamLocationAndValue
	dec hl
	ld c, a
	ld b, [hl]
	push bc
	ld d, h
	ld e, l
	ld a, MON_EVS - 1
	call GetPartyParamLocationAndValue
	call GetHyperTraining
	inc a
	ld b, a
	predef CalcPkmnStats
	ld a, MON_HP
	call GetPartyParamLocationAndValue
	pop bc

	; Don't change the current HP if we're fainted
	inc hl
	or [hl]
	ret z

	; Update current HP
	inc hl
	inc hl
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hld]
	sbc b
	ld b, a
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hli], a

	; Prevent the infamous Pomeg glitch (HP underflow)
	cp $80
	jr nc, .set_hp_to_one

	; Don't faint Pokémon who used to not be fainted
	or [hl]
	ret nz
.set_hp_to_one
	dec hl
	xor a
	ld [hli], a
	inc a
	ld [hl], a
	ret

GetHyperTraining:
	push hl
	call GetHyperTrainingAddr
	ld a, [hl]
	and HYPER_TRAINING_MASK
	pop hl
	ret

GetHyperTrainingAddr:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	push bc
	call SkipNames
	ld bc, PLAYER_NAME_LENGTH
	add hl, bc
	pop bc
	ret

GivePoke::
	push de
	push bc
	ld a, [wCurPartySpecies]
	ld [wEnemyMonSpecies], a
	xor a
	ld [wOTPartyCount], a
	ld [wCurOTMon], a
	inc a
	ld [wMonType], a
	ld [wBattleMode], a
	predef TryAddMonToParty
	lb bc, $81, 1
	farcall CopyBetweenPartyAndTemp

	xor a
	ld [wBattleMode], a
	ld hl, wTempMonItem
	ld a, [wCurItem]
	ld [hli], a
	ld a, [wCurPlayerMove]
	and a
	jr z, .no_move
	ld d, h
	ld e, l
	ld b, a
	ld c, NUM_MOVES
.move_loop
	ld a, [de]
	and a
	jr z, .add_move
	inc de
	dec c
	jr nz, .move_loop
	ld d, h
	ld e, l
.add_move
	ld a, b
	ld [de], a
	ld hl, Moves + MOVE_PP
	call GetMoveProperty
	ld hl, MON_PP - MON_MOVES
	add hl, de
	ld [hl], a

.no_move
	pop bc
	pop hl
	push bc
	ld a, b
	and a
	jmp nz, .trainer_data
	ld a, [wCurForm]
	bit MON_IS_EGG_F, a
	jr z, .not_egg
	ld hl, wTempMonHP
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wBaseEggSteps]
	and $f
	inc a
	ld b, a
	add a
	add a
	add b
	ld [wTempMonHappiness], a
	ld de, String_Egg
	ld hl, wTempMonNickname
	call CopyName2
.not_egg
	ld de, wTempMonNickname
	ld hl, wMonOrItemNameBuffer
	call CopyName2
	ld a, [wGiftMonBall]
	ld [wCurItem], a
	ld hl, wTempMonCaughtData
	farcall SetBoxmonOrEggmonCaughtData
	call AddTempMonToParty
	ld d, PARTYMON
	jr nc, .added
	call .SetUpBoxMon ; d = BOXMON if nc
	ld a, TEMPMON
	ld [wMonType], a
	jmp c, .FailedToGiveMon

.added
	push de
	call GetPartyPokemonName
	ld a, [wTempMonForm]
	bit MON_IS_EGG_F, a
	ld hl, ReceivedGiftEggText
	jr nz, .received_egg
	ld hl, ReceivedGiftMonText
.received_egg
	push af
	call PrintText
	pop af
	push af
	ld de, SFX_GET_EGG_FROM_DAYCARE_LADY
	jr nz, .received_egg_sfx
	ld de, SFX_CAUGHT_MON
.received_egg_sfx
	call PlayWaitSFX
	pop af
	pop bc
	jr nz, .skip_nickname
	push bc
	farcall GiveANickname_YesNo
	pop bc
	jr c, .skip_nickname
	push bc
	ld de, wTempMonNickname
	ld a, b
	and a
	jr nz, .got_nick
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	call SkipNames
	ld d, h
	ld e, l
.got_nick
	push de
	call InitNickname
	pop de
	ld hl, wMonOrItemNameBuffer
	call CopyName2
	pop bc
.skip_nickname
	pop de
	ld a, b
	inc b
	and a
	ret z
	push de
	farcall UpdateStorageBoxMonFromTemp
	pop de
	ld a, d
	and a
	ld b, 2
	ret nz

	farcall CurBoxFullCheck
	jr z, .box_not_full
	ld hl, GiftMonBoxFullText
	call PrintText
.box_not_full
	farcall GetCurBoxName
	ld a, [wTempMonForm]
	bit MON_IS_EGG_F, a
	ld hl, GiftEggSentToPCText
	jr nz, .egg_sent
	ld hl, GiftMonSentToPCText
.egg_sent
	jmp PrintText

.trainer_data
	ld de, wTempMonForm
	ld a, [wCurForm]
	ld b, a
	ld a, [de]
	and !GENDER_MASK
	or b
	ld [de], a
	push hl
	ldh a, [hScriptBank]
	ld b, a
	call GetFarWord
	ld a, b
	push bc
	ld de, wTempMonNickname
	ld bc, MON_NAME_LENGTH
	call FarCopyBytes
	pop bc
	pop hl
	inc hl
	inc hl
	push hl
	push bc
	ld a, b
	call GetFarWord
	ld a, b
	ld de, wTempMonOT
	ld bc, PLAYER_NAME_LENGTH
	call FarCopyBytes
	pop bc
	pop hl
	inc hl
	inc hl
	ld a, b
	call GetFarWord
	ld a, l
	ld [wTempMonID], a
	ld a, h
	ld [wTempMonID+1], a
	ld a, [wGiftMonBall]
	ld c, a
	ld hl, wTempMonCaughtData
	farcall SetGiftMonCaughtData
	call AddTempMonToParty
	ld b, PARTYMON
	jmp nc, .skip_nickname
	call .SetUpBoxMon
	ld b, d
	jmp nc, .skip_nickname

.FailedToGiveMon:
	pop bc
	ld b, 0
	ret

.SetUpBoxMon:
	farcall NewStorageBoxPointer
	ret c
	ld a, b
	ld [wTempMonBox], a
	ld a, c
	ld [wTempMonSlot], a
	ld a, [wCurForm]
	bit MON_IS_EGG_F, a
	jr nz, .done
	and SPECIESFORM_MASK
	ld b, a
	ld a, [wCurPartySpecies]
	ld c, a
	call SetSeenAndCaughtMon
.done
	ld d, BOXMON
	xor a ; resets wCurPartyMon for nickname screen, also clears carry flag
	ld [wCurPartyMon], a
	ret

GiftMonBoxFullText:
	; @ was full.
	text_far _CurBoxFullText
	text_end

ReceivedGiftMonText:
	; <PLAYER> received @!
	text_far _ReceivedGiftMonText
	text_end

GiftMonSentToPCText:
	; @ was sent to <BOX>.
	text_far _MonSentToPCText
	text_end

ReceivedGiftEggText:
	; <PLAYER> received an egg!
	text_far _ReceivedEggText
	text_end

GiftEggSentToPCText:
	; The Egg was sent to <BOX>.
	text_far _EggSentToPCText
	text_end

String_Egg:
	rawchar "Egg@"

InitNickname:
	push de
	call LoadStandardMenuHeader
	call DisableSpriteUpdates
	pop de
	push de
	ld b, $0 ; pokemon
	farcall NamingScreen
	pop hl
	ld de, wStringBuffer1
	call InitName
	jmp ExitAllMenus
