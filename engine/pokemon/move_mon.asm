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
	inc a
	cp PARTY_LENGTH + 1
	ret nc
	; Increase the party count
	ld [de], a
	ldh [hMoveMon], a ; HRAM backup
	; de += a
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	; Load the species of the Pokemon into the party list.
	; The terminator is usually here, but it'll be back.
	ld a, [wCurPartySpecies]
	ld [de], a
	; Load the terminator into the next slot.
	inc de
	ld a, -1
	ld [de], a
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
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
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

; Cases to set [wCurForm] before calling GetBaseData:
; - Gift Pokémon or Egg: givepoke/giveegg already set it
; - Wild Pokémon: LoadEnemyMon already set it
; - Roaming Pokémon: get it from wRoamMon#Form
; - Trainer Pokémon: get it from party data (pushed by ReadTrainerParty)

	ld a, [wMonType]
	and $f
	jr z, .not_trainer_form
	ld a, [wBattleMode]
	dec a
	jr z, .not_trainer_form
	; hl = party data, deep off the stack
	; Here the stack contains:
	; - sp+$6: party data for [wCurPartyMon], just past the level and species
	; - sp+$4: return address for 'predef TryAddMonToParty'
	; - sp+$2: af from _Predef (ReturnFarCall will pop this)
	; - sp+$0: return address for 'call RetrieveAHLAndCallFunction'
	ld hl, sp+$6
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOtherTrainerType]
	bit TRNTYPE_ITEM, a
	jr z, .no_skip_trainer_item
	inc hl
.no_skip_trainer_item
	bit TRNTYPE_EVS, a
	jr z, .no_skip_trainer_evs
	inc hl
.no_skip_trainer_evs
	bit TRNTYPE_DVS, a
	jr z, .no_skip_trainer_dvs
	inc hl
	inc hl
	inc hl
.no_skip_trainer_dvs
	bit TRNTYPE_PERSONALITY, a
	ld a, NO_FORM
	jr z, .got_trainer_form
	inc hl
	ld a, [wTrainerGroupBank]
	call GetFarByte
	and SPECIESFORM_MASK
.got_trainer_form
	ld [wCurForm], a
.not_trainer_form

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
	ld [wBuffer1], a
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
	ld [wTempSpecies], a
	dec a
	push de
	call CheckCaughtMon
	ld a, [wTempSpecies]
	dec a
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
	ld a, $ff
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
	call CalcPkmnStatC
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
	ld c, [hl]
	dec hl
	ld b, [hl]
	dec hl
	ld [hl], c
	dec hl
	ld [hl], b
	pop bc
	pop hl

	ld a, [wMonType]
	and $f
	jr nz, .done
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .done
	ld hl, wPartyMon1Form
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	predef GetVariant
	farcall UpdateUnownDex

.done
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

	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurPartySpecies]
	ld [hli], a
	ld [hl], $ff

	ld hl, wPartyMon1Species
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld e, l
	ld d, h
	ld hl, wTempMonSpecies
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

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a

	ld hl, wPartyMon1IsEgg
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	bit MON_IS_EGG_F, [hl]
	jr nz, .egg
	ld a, [wCurPartySpecies]
	dec a
	call SetSeenAndCaughtMon
	ld hl, wPartyMon1Happiness
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld [hl], BASE_HAPPINESS
.egg

	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .not_unown
	ld hl, wPartyMon1Form
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	predef GetVariant
	farcall UpdateUnownDex
	ld a, [wFirstUnownSeen]
	and a
	jr nz, .done
	ld a, [wCurForm]
	ld [wFirstUnownSeen], a
.not_unown

	ld a, [wCurPartySpecies]
	cp MAGIKARP
	jr nz, .done
	ld hl, wPartyMon1Form
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	predef GetVariant
	ld a, [wFirstMagikarpSeen]
	and a
	jr nz, .done
	ld a, [wCurForm]
	ld [wFirstMagikarpSeen], a

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
	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld a, [wBreedMon1Species]
	ld de, wBreedMon1Nickname
	jr z, .okay
	ld a, [wBreedMon2Species]
	ld de, wBreedMon2Nickname

.okay
	ld [hli], a
	ld [wCurSpecies], a
	ld [hl], $ff
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
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
	ld hl, MON_FORM
	add hl, de
	ld a, [hl]
	ld [wCurForm], a
	pop hl
	ld bc, BREEDMON_STRUCT_LENGTH
	rst CopyBytes
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
	ld [wBuffer1], a
	ld a, [wCurSpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	predef FillMoves
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	call HealPartyMonEvenForNuzlocke
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
	jmp c, .nope
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
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

	; Check if we've reached maximum effort on the stat
	ld a, MON_EVS - 1
	add c
	call GetPartyParamLocation
	cp 252
	ld hl, .TextNotMaxEffort
	jr c, .print_and_fail

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1HyperTraining
	call SkipNames
	ld a, [hl]
	and d
	jr nz, .already_hyped
	or d
	or [hl]
	ld [hl], a
	ld b, a

	; Recalculate stats.
	push bc
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld [wCurSpecies], a
	ld a, MON_FORM
	call GetPartyParamLocation
	ld [wCurForm], a
	call GetBaseData
	pop bc

	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld [wCurPartyLevel], a

	ld a, MON_MAXHP
	call GetPartyParamLocation
	push hl
	ld a, MON_EVS - 1
	call GetPartyParamLocation
	pop de
	predef CalcPkmnStats

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
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 19 ; end coords
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
	db "Spcl.Atk@"
	db "Defense@"
	db "Spcl.Def@"

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
	ld hl, wOTPartyMon1Form
	predef GetVariant
	call GetBaseData

	ld hl, wPlayerName
	ld de, wTempMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName

	ld hl, wStringBuffer1
	ld de, wTempMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	ld a, [wCurPartySpecies]
	dec a
	call SetSeenAndCaughtMon

	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .not_unown
	farcall UpdateUnownDex
.not_unown
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

ComputeNPCTrademonStats:
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [MON_LEVEL], a ; wow
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurSpecies], a
	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld d, h
	ld e, l
	push de
	ld a, MON_EVS - 1
	call GetPartyParamLocation
	ld b, TRUE
	predef CalcPkmnStats
	pop de
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ret

UpdatePkmnStats:
; Recalculates the stats of wCurPartyMon and also updates current HP accordingly
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurSpecies], a
	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, MON_MAXHP + 1
	call GetPartyParamLocation
	ld a, [hld]
	ld c, a
	ld b, [hl]
	push bc
	ld d, h
	ld e, l
	ld a, MON_EVS - 1
	call GetPartyParamLocation
	call GetHyperTraining
	inc a
	ld b, a
	predef CalcPkmnStats
	ld a, MON_HP
	call GetPartyParamLocation
	pop bc

	; Don't change the current HP if we're fainted
	ld a, [hli]
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
	ld [hl], a

	; Prevent the infamous Pomeg glitch (HP underflow)
	cp $80
	jr nc, .set_hp_to_one

	; Don't faint Pokémon who used to not be fainted
	inc hl
	or [hl]
	ret nz
.set_hp_to_one
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

CalcPkmnStats:
; Calculates all 6 Stats of a Pkmn
; b: Hyper Training (bit 7-2), apply EVs (bit 0)
; 'c' counts from 1-6 and points with 'wBaseStats' to the base value
; hl is the path to the EVs - 1
; de is a pointer where the 6 stats are placed

	ld c, 0
.loop
	inc c
	call CalcPkmnStatC
	ldh a, [hMultiplicand + 1]
	ld [de], a
	inc de
	ldh a, [hMultiplicand + 2]
	ld [de], a
	inc de
	ld a, c
	cp STAT_SDEF
	jr nz, .loop
	ret

CalcPkmnStatC:
; 'c' is 1-6 and points to the BaseStat
; 1: HP
; 2: Attack
; 3: Defense
; 4: Speed
; 5: SpAtk
; 6: SpDef
	push hl
	push de
	push bc
	ld a, b
	ld d, a
	push hl
	ld hl, wBaseStats - 1 ; has to be decreased, because 'c' begins with 1
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld e, a
	pop hl
	push hl
	ld a, d
	and a
	jr z, .no_evs
	add hl, bc
	ld a, [hl]
	ld b, a
.no_evs
	pop hl
	push bc
	ld bc, MON_DVS - (MON_EVS - 1)
	add hl, bc ; hl points to DVs
	pop bc
	ld a, [wInitialOptions]
	bit PERFECT_IVS_OPT, a
	ld a, $f
	jr nz, .GotDV
	ld a, d
	push bc
.hyper_training_loop
	rlca
	dec c
	jr nz, .hyper_training_loop
	pop bc
	ld a, $f
	jr c, .GotDV

.not_hyper_trained
	ld a, c
	cp STAT_ATK
	jr z, .Attack
	cp STAT_DEF
	jr z, .Defense
	cp STAT_SPD
	jr z, .Speed
	cp STAT_SATK
	jr z, .SpclAtk
	cp STAT_SDEF
	jr z, .SpclDef
.HP
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Attack:
	ld a, [hl]
	and $f
	jr .GotDV

.Defense:
	inc hl
	ld a, [hld]
	swap a
	and $f
	jr .GotDV

.Speed:
	inc hl
	ld a, [hld]
	and $f
	jr .GotDV

.SpclAtk:
	inc hl
	inc hl
	ld a, [hld]
	dec hl
	swap a
	and $f
	jr .GotDV

.SpclDef:
	inc hl
	inc hl
	ld a, [hld]
	dec hl
	and $f

.GotDV:
	; de = e + a
	add e
	ld e, a
	adc 0
	sub e
	ld d, a
	; de = (de * 2) + 1
	sla e
	inc e
	rl d
	srl b
	srl b
	ld a, b
	add e
	jr nc, .no_overflow_1
	inc d

.no_overflow_1
	ldh [hMultiplicand + 2], a
	ld a, d
	ldh [hMultiplicand + 1], a
	xor a
	ldh [hMultiplicand + 0], a
	ld a, [wCurPartyLevel]
	ldh [hMultiplier], a
	call Multiply
	ldh a, [hProduct + 1]
	ldh [hDividend + 0], a
	ldh a, [hProduct + 2]
	ldh [hDividend + 1], a
	ldh a, [hProduct + 3]
	ldh [hDividend + 2], a
	ld a, 100
	ldh [hDivisor], a
	ld a, 3
	ld b, a
	call Divide
	ld a, c
	cp STAT_HP
	ld a, STAT_MIN_NORMAL
	jr nz, .not_hp
	ld a, [wCurPartyLevel]
	ld b, a
	ldh a, [hQuotient + 2]
	add b
	ldh [hMultiplicand + 2], a
	jr nc, .no_overflow_2
	ldh a, [hQuotient + 1]
	inc a
	ldh [hMultiplicand + 1], a

.no_overflow_2
	ld a, STAT_MIN_HP

.not_hp
	ld b, a
	ldh a, [hQuotient + 2]
	add b
	ldh [hMultiplicand + 2], a
	jr nc, .no_overflow_3
	ldh a, [hQuotient + 1]
	inc a
	ldh [hMultiplicand + 1], a

.no_overflow_3
	ldh a, [hQuotient + 1]
	cp HIGH(1000) + 1
	jr nc, .max_stat
	cp HIGH(1000)
	jr c, .stat_value_okay
	ldh a, [hQuotient + 2]
	cp LOW(1000)
	jr c, .stat_value_okay

.max_stat
	ld a, HIGH(999)
	ldh [hMultiplicand + 1], a
	ld a, LOW(999)
	ldh [hMultiplicand + 2], a

.stat_value_okay
	; do natures here
	xor a
	ldh [hMultiplicand + 0], a
	push hl
	push bc
	ld bc, MON_NATURE - MON_DVS
	add hl, bc ; hl points to Nature
	ld a, [hl]
	and NATURE_MASK
	pop bc
	push bc
	call GetNatureStatMultiplier
	pop bc
	pop hl
	ldh [hMultiplier], a
	call Multiply
	ldh a, [hProduct + 1]
	ldh [hDividend + 0], a
	ldh a, [hProduct + 2]
	ldh [hDividend + 1], a
	ldh a, [hProduct + 3]
	ldh [hDividend + 2], a
	ld a, 10
	ldh [hDivisor], a
	ld a, 3
	ld b, a
	call Divide
	ldh a, [hQuotient + 1]
	ldh [hMultiplicand + 1], a
	ldh a, [hQuotient + 2]
	ldh [hMultiplicand + 2], a
	jmp PopBCDEHL

GetNatureStatMultiplier::
; a points to Nature
; c is 1-6 according to the stat (STAT_HP to STAT_SDEF)
; returns (sets a to) 9 if c is lowered, 11 if raised, 10 if neutral
; (to be used in calculations in CalcPkmnStatC)
	push de
	ld d, a
	ld a, c
	cp STAT_HP
	jr z, .neutral
	ld a, d
	ld b, a
	call GetNature
	ld a, b
	cp NO_NATURE
	jr z, .neutral
	ld d, STAT_HP
.loop
	inc d
	sub 5
	jr nc, .loop
	add 7 ; Atk-SpD is 2-6, not 0-4
	cp c
	jr z, .penalty
	ld a, d
	cp c
	jr z, .bonus
.neutral
	ld a, 10
	pop de
	ret
.bonus
	ld a, 11
	pop de
	ret
.penalty
	; Neutral natures (divisible by 6) raise and lower the same stat,
	; but +10% -10% isn't neutral (the result is 99%), so we need to
	; avoid messing with it altogether.
	cp d
	jr z, .neutral
	ld a, 9
	pop de
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
	ld a, [wTempMonForm]
	bit MON_IS_EGG_F, a
	jr z, .not_egg
	ld de, String_Egg
	ld hl, wTempMonNickname
	call CopyName2
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
.not_egg
	ld de, wTempMonNickname
	ld hl, wMonOrItemNameBuffer
	call CopyName2
	ld a, [wGiftMonBall]
	ld [wCurItem], a
	ld hl, wTempMonCaughtData
	farcall SetBoxmonOrEggmonCaughtData
.try_add
	call AddTempMonToParty
	ld d, PARTYMON
	jr nc, .added
	call .SetUpBoxMon
	jmp c, .FailedToGiveMon
	ld d, BOXMON

.added
	push de
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
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
	push bc
	call PrintText
	pop bc
.box_not_full
	farcall GetBoxName
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
	ld a, [wScriptBank]
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
	push hl
	ld a, b
	call GetFarWord
	ld a, l
	ld [wTempMonID], a
	ld a, h
	ld [wTempMonID+1], a
	pop hl
	inc hl
	inc hl
	ld a, b
	call GetFarByte
	ld b, a
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
	ld a, [wTempMonForm]
	bit MON_IS_EGG_F, a
	jr nz, .done
	ld a, [wCurPartySpecies]
	dec a
	call SetSeenAndCaughtMon
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .check_magikarp
	farcall UpdateUnownDex
	ld a, [wFirstUnownSeen]
	and a
	jr nz, .check_magikarp
	ld a, [wTempMonForm]
	and FORM_MASK
	ld [wFirstUnownSeen], a
.check_magikarp
	ld a, [wCurPartySpecies]
	cp MAGIKARP
	jr nz, .done
	ld a, [wFirstMagikarpSeen]
	and a
	jr nz, .done
	ld a, [wTempMonForm]
	and FORM_MASK
	ld [wFirstMagikarpSeen], a
.done
	ld d, BOXMON
	and a
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
