TryAddMonToParty: ; d88c
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
	ld a, [de] ; Why are we doing this?
	ld [hMoveMon], a ; HRAM backup
	add e
	ld e, a
	jr nc, .loadspecies
	inc d

.loadspecies
	; Load the species of the Pokemon into the party list.
	; The terminator is usually here, but it'll be back.
	ld a, [wCurPartySpecies]
	ld [de], a
	; Load the terminator into the next slot.
	inc de
	ld a, -1
	ld [de], a
	; Now let's load the OT name.
	ld hl, wPartyMonOT
	ld a, [wMonType]
	and $f
	jr z, .loadOTname
	ld hl, wOTPartyMonOT

.loadOTname
	ld a, [hMoveMon] ; Restore index from backup
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName
	ld a, [wMonType]
	and $f
	ld hl, wOTPartyMonNicknames
	jr nz, .got_target_nick
	ld hl, wPartyMonNicknames
.got_target_nick
	ld a, [hMoveMon]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes

.skipnickname
	ld hl, wPartyMon1Species
	ld a, [wMonType]
	and $f
	jr z, .initializeStats
	ld hl, wOTPartyMon1Species

.initializeStats
	ld a, [hMoveMon]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
GeneratePartyMonStats: ; d906
	ld e, l
	ld d, h
	push hl
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wCurSpecies]
	ld [de], a
	inc de
	xor a

.skipitem
	ld [de], a
	inc de
	push de
	ld h, d
	ld l, e

	xor a
rept NUM_MOVES + -1
	ld [hli], a
endr
	ld [hl], a
	ld [wBuffer1], a
	predef FillMoves

.next
	pop de
rept NUM_MOVES
	inc de
endr
	ld a, [wPlayerID]
	ld [de], a
	inc de
	ld a, [wPlayerID + 1]
	ld [de], a
	inc de
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	farcall CalcExpAtLevel
	pop de
	ld a, [hProduct + 1]
	ld [de], a
	inc de
	ld a, [hProduct + 2]
	ld [de], a
	inc de
	ld a, [hProduct + 3]
	ld [de], a
	inc de

	; EVs, DVs, personality
	pop hl
	push hl
	ld a, [wMonType]
	and $f
	jr z, .generateEVsDVsAndPersonality
	ld a, [wBattleMode]
	dec a
	jr z, .generateEVsDVsAndPersonality
	farcall GetTrainerEVsDVsAndPersonality
	pop hl
	push hl
	jp .initializetrainermonstats

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
	ld [wd265], a
	dec a
	push de
	call CheckCaughtMon
	ld a, [wd265]
	dec a
	call SetSeenAndCaughtMon
	pop de
	pop hl
	push hl
	jr .random_dvs

.wildmon
	push bc
	farcall GetRoamMonDVsAndPersonality
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
	jp .initializetrainermonstats

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
; This overwrites the base data struct, so reload it afterwards
	ld a, [wCurSpecies]
	push af
	ld a, [wPartyMon1Ability]
	ld b, a
	ld a, [wPartyMon1Species]
	ld c, a
	call GetAbility
	pop af
	push bc
	ld [wCurSpecies], a
	call GetBaseData
	pop bc
	ld a, b
	cp SYNCHRONIZE
	jr nz, .no_synchronize
	call Random
	and $1
	jr z, .no_synchronize
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
	ld a, %000
	jr .cute_charm_ok

.not_cute_charm
; Random gender
; Derived from base ratio
; Random gender selection value
	call Random
	and %111
.cute_charm_ok
	ld b, a
; We need the gender ratio to do anything with this.
	push hl
	push bc
	ld a, [wCurPartySpecies]
	dec a
	ld hl, BASEMON_GENDER
	ld bc, BASEMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, BANK(BaseData)
	call GetFarByte
	swap a
	and $f
	pop bc
	pop hl
	ld c, a
	ld a, b
; Ratios below the value are female, and vice-versa.
	cp c
	ld a, FEMALE
	jr c, .Female
	xor a ; ld a, MALE
.Female:
	ld b, a

; Form 1
	ld a, 1
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
	ld a, [hProduct + 2]
	ld [de], a
	inc de
	ld a, [hProduct + 3]
	ld [de], a
	inc de
	pop hl
	ld bc, MON_EVS - 1
	add hl, bc
	ld b, TRUE
	push hl
	push de
	call CalcPkmnStats
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

.next3
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
; da6d

FillPP: ; da6d
	push bc
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .next
	dec a
	push hl
	push de
	push bc
	ld hl, Moves
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld de, wStringBuffer1
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc
	pop de
	pop hl
	ld a, [wStringBuffer1 + MOVE_PP]

.next
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	pop bc
	ret
; da96

AddTempmonToParty: ; da96
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

	ld hl, wPartyMonOT
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonOT
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, NAME_LENGTH
	rst CopyBytes

	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a

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

SentGetPkmnIntoFromBox: ; db3f
; Sents/Gets Pkmn into/from Box depending on Parameter
; wPokemonWithdrawDepositParameter == 0: get Pkmn into Party
; wPokemonWithdrawDepositParameter == 1: sent Pkmn into Box
; wPokemonWithdrawDepositParameter == 2: get Pkmn from DayCare
; wPokemonWithdrawDepositParameter == 3: put Pkmn into DayCare
	; Failsafe: never allow writing $ff to species bytes
	ld a, [wCurPartySpecies]
	cp EGG
	jr nz, .species_valid
	rst 0 ; crash
.species_valid
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .check_IfPartyIsFull
	cp DAYCARE_WITHDRAW
	jr z, .check_IfPartyIsFull
	cp DAYCARE_DEPOSIT
	ld hl, wBreedMon1Species
	jr z, .breedmon

	; we want to sent a Pkmn into the Box
	; so check if there's enough space
	ld hl, sBoxCount
	ld a, [hl]
	cp MONS_PER_BOX
	jr nz, .there_is_room
	jp CloseSRAM_And_SetCarryFlag

.check_IfPartyIsFull
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jp z, CloseSRAM_And_SetCarryFlag

.there_is_room
	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	cp DAYCARE_WITHDRAW
	ld a, [wBreedMon1Species]
	jr z, .okay1
	ld a, [wCurPartySpecies]

.okay1
	ld [hli], a
	ld [hl], $ff
	ld a, [wPokemonWithdrawDepositParameter]
	dec a
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPartyCount]
	jr nz, .okay2
	ld hl, sBoxMon1Species
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [sBoxCount]

.okay2
	dec a ; wPartyCount - 1
	rst AddNTimes

.breedmon
	push hl
	ld e, l
	ld d, h
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld hl, sBoxMon1Species
	ld bc, BOXMON_STRUCT_LENGTH
	jr z, .okay3
	cp DAYCARE_WITHDRAW
	ld hl, wBreedMon1Species
	jr z, .okay4
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH

.okay3
	ld a, [wCurPartyMon]
	rst AddNTimes

.okay4
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp DAYCARE_DEPOSIT
	ld de, wBreedMon1OT
	jr z, .okay5
	dec a
	ld hl, wPartyMonOT
	ld a, [wPartyCount]
	jr nz, .okay6
	ld hl, sBoxMonOT
	ld a, [sBoxCount]

.okay6
	dec a
	call SkipNames
	ld d, h
	ld e, l

.okay5
	ld hl, sBoxMonOT
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay7
	ld hl, wBreedMon1OT
	cp DAYCARE_WITHDRAW
	jr z, .okay8
	ld hl, wPartyMonOT

.okay7
	ld a, [wCurPartyMon]
	call SkipNames

.okay8
	ld bc, NAME_LENGTH
	rst CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp DAYCARE_DEPOSIT
	ld de, wBreedMon1Nick
	jr z, .okay9
	dec a
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	jr nz, .okay10
	ld hl, sBoxMonNicknames
	ld a, [sBoxCount]

.okay10
	dec a
	call SkipNames
	ld d, h
	ld e, l

.okay9
	ld hl, sBoxMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay11
	ld hl, wBreedMon1Nick
	cp DAYCARE_WITHDRAW
	jr z, .okay12
	ld hl, wPartyMonNicknames

.okay11
	ld a, [wCurPartyMon]
	call SkipNames

.okay12
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes
	pop hl

	ld a, [wPokemonWithdrawDepositParameter]
	cp PC_DEPOSIT
	jr z, .took_out_of_box
	cp DAYCARE_DEPOSIT
	jp z, .CloseSRAM_And_ClearCarryFlag

	push hl
	srl a
	add $2
	ld [wMonType], a
	predef CopyPkmnToTempMon
	farcall CalcLevel
	ld a, d
	ld [wCurPartyLevel], a
	pop hl

	ld b, h
	ld c, l
	ld hl, MON_LEVEL
	add hl, bc
	ld [hl], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_EVS - 1
	add hl, bc

	push bc
	ld b, TRUE
	call CalcPkmnStats
	pop bc

	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr nz, .CloseSRAM_And_ClearCarryFlag
	ld hl, MON_STATUS
	add hl, bc
	xor a
	ld [hl], a
	ld hl, MON_HP
	add hl, bc
	ld d, h
	ld e, l
	push hl
	ld hl, MON_IS_EGG
	add hl, bc
	bit MON_IS_EGG_F, [hl]
	pop hl
	jr nz, .egg
	inc hl
	inc hl
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	inc de
	ld [de], a
	jr .CloseSRAM_And_ClearCarryFlag

.egg
	xor a
	ld [de], a
	inc de
	ld [de], a
	jr .CloseSRAM_And_ClearCarryFlag

.took_out_of_box
	ld a, [sBoxCount]
	dec a
	ld b, a
	call RestorePPofDepositedPokemon
.CloseSRAM_And_ClearCarryFlag:
	call CloseSRAM
	and a
	ret
; dcb1

CloseSRAM_And_SetCarryFlag: ; dcb1
	call CloseSRAM
	scf
	ret
; dcb6

RestorePPofDepositedPokemon: ; dcb6
	ld a, b
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	rst AddNTimes
	ld b, h
	ld c, l
	ld hl, MON_PP
	add hl, bc
	push hl
	push bc
	ld de, wTempMonPP
	ld bc, NUM_MOVES
	rst CopyBytes
	pop bc
	ld hl, MON_MOVES
	add hl, bc
	push hl
	ld de, wTempMonMoves
	ld bc, NUM_MOVES
	rst CopyBytes
	pop hl
	pop de

	ld a, [wMenuCursorY]
	push af
	ld a, [wMonType]
	push af
	ld b, 0
.loop
	ld a, [hli]
	and a
	jr z, .done
	ld [wTempMonMoves], a
	ld a, BOXMON
	ld [wMonType], a
	ld a, b
	ld [wMenuCursorY], a
	push bc
	push hl
	push de
	farcall GetMaxPPOfMove
	pop de
	pop hl
	ld a, [wd265]
	ld b, a
	ld a, [de]
	and %11000000
	add b
	ld [de], a
	pop bc
	inc de
	inc b
	ld a, b
	cp NUM_MOVES
	jr c, .loop

.done
	pop af
	ld [wMonType], a
	pop af
	ld [wMenuCursorY], a
	ret
; dd21

RetrievePokemonFromDaycareMan: ; dd21
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	call GetBreedMon1LevelGrowth
	ld a, b
	ld [wd002], a
	ld a, e
	ld [wCurPartyLevel], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	jr Functiondd64
; dd42

RetrievePokemonFromDaycareLady: ; dd42
	ld a, [wBreedMon2Species]
	ld [wCurPartySpecies], a
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	call GetBreedMon2LevelGrowth
	ld a, b
	ld [wd002], a
	ld a, e
	ld [wCurPartyLevel], a
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	; fallthrough
; dd64

Functiondd64: ; dd64
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
	ld de, wBreedMon1Nick
	jr z, .okay
	ld a, [wBreedMon2Species]
	ld de, wBreedMon2Nick

.okay
	ld [hli], a
	ld [wCurSpecies], a
	ld a, $ff
	ld [hl], a
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	push hl
	ld h, d
	ld l, e
	pop de
	rst CopyBytes
	push hl
	ld hl, wPartyMonOT
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	pop hl
	rst CopyBytes
	push hl
	call Functionde1a
	pop hl
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	call GetBaseData
	call Functionde1a
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
	ld b, TRUE
	call CalcPkmnStats
	ld hl, wPartyMon1Moves
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ld a, $1
	ld [wBuffer1], a
	predef FillMoves
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall HealPartyMonEvenForNuzlocke
	ld a, [wCurPartyLevel]
	ld d, a
	farcall CalcExpAtLevel
	pop bc
	ld hl, $8 ; Experience
	add hl, bc
	ld a, [hMultiplicand]
	ld [hli], a
	ld a, [hMultiplicand + 1]
	ld [hli], a
	ld a, [hMultiplicand + 2]
	ld [hl], a
	and a
	ret
; de1a

Functionde1a: ; de1a
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ret
; de2a

DepositMonWithDaycareMan: ; de2a
	ld de, wBreedMon1Nick
	call DepositBreedmon
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	jp RemoveMonFromPartyOrBox
; de37

DepositMonWithDaycareLady: ; de37
	ld de, wBreedMon2Nick
	call DepositBreedmon
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	jp RemoveMonFromPartyOrBox
; de44

DepositBreedmon: ; de44
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call SkipNames
	rst CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOT
	call SkipNames
	rst CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	ret

SentPkmnIntoBox: ; de6e
; Sents the Pkmn into one of Bills Boxes
; the data comes mainly from 'wEnemyMon:'
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld de, sBoxCount
	ld a, [de]
	cp MONS_PER_BOX
	jp nc, .full
	inc a
	ld [de], a

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld c, a
.loop
	inc de
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	inc a
	jr nz, .loop

	call GetBaseData
	call ShiftBoxMon

	ld hl, wPlayerName
	ld de, sBoxMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes

	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName

	ld de, sBoxMonNicknames
	ld hl, wStringBuffer1
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes

	ld hl, wOTPartyMon1
	ld de, sBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes

	ld a, [wCurPartySpecies]
	dec a
	call SetSeenAndCaughtMon
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr nz, .not_unown
	ld hl, sBoxMon1Form
	predef GetVariant
	farcall UpdateUnownDex

.not_unown
	ld hl, sBoxMon1Moves
	ld de, wTempMonMoves
	ld bc, NUM_MOVES
	rst CopyBytes

	ld hl, sBoxMon1PP
	ld de, wTempMonPP
	ld bc, NUM_MOVES
	rst CopyBytes

	ld b, 0
	call RestorePPofDepositedPokemon

	call CloseSRAM
	scf
	ret
; df42

.full ; df42
	call CloseSRAM
	and a
	ret
; df47

ShiftBoxMon: ; df47
	ld hl, sBoxMonOT
	ld bc, NAME_LENGTH
	call .shift

	ld hl, sBoxMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call .shift

	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH

.shift
	ld a, [sBoxCount]
	cp 2
	ret c

	push hl
	rst AddNTimes
	dec hl
	ld e, l
	ld d, h
	pop hl

	ld a, [sBoxCount]
	dec a
	rst AddNTimes
	dec hl

	push hl
	ld a, [sBoxCount]
	dec a
	ld hl, 0
	rst AddNTimes
	ld c, l
	ld b, h
	pop hl
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret
; df8c

GiveEgg:: ; df8c
	ld a, [wCurPartySpecies]
	push af
	farcall GetPreEvolution
	farcall GetPreEvolution
	ld a, [wCurPartySpecies]
	dec a

; TryAddMonToParty sets Seen and Caught flags
; when it is successful.  This routine will make
; sure that we aren't newly setting flags.
	push af
	call CheckCaughtMon
	pop af
	push bc
	call CheckSeenMon
	push bc

	call TryAddMonToParty

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1IsEgg
	call GetPartyLocation
	ld a, [hl]
	or IS_EGG_MASK
	ld [hl], a

; If we haven't caught this Pokemon before receiving
; the Egg, reset the flag that was just set by
; TryAddMonToParty.
	pop bc
	ld a, c
	and a
	jr nz, .skip_caught_flag
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, $0
	ld hl, wPokedexCaught
	ld b, RESET_FLAG
	predef FlagPredef

.skip_caught_flag
; If we haven't seen this Pokemon before receiving
; the Egg, reset the flag that was just set by
; TryAddMonToParty.
	pop bc
	ld a, c
	and a
	jr nz, .skip_seen_flag
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, $0
	ld hl, wPokedexSeen
	ld b, RESET_FLAG
	predef FlagPredef

.skip_seen_flag
	pop af
	ld [wCurPartySpecies], a
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Species
	rst AddNTimes
	ld a, [wCurPartySpecies]
	ld [hl], a
	ld hl, wPartyCount
	ld a, [hl]
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [wCurPartySpecies]
	ld [hl], a
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	call SkipNames
	ld de, String_Egg
	call CopyName2
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [wMonStatusFlags]
	bit 1, a
	ld a, 1
	jr nz, .got_init_happiness
	ld a, [wBaseEggSteps]
	and $f
	inc a
	ld b, a
	add a
	add a
	add b

.got_init_happiness
	ld [hl], a
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
	and a
	ret
; e035

String_Egg: ; e035
	db "Egg@"
; e039

RemoveMonFromPartyOrBox: ; e039
	ld hl, wPartyCount

	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay

	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld hl, sBoxCount

.okay
	ld a, [hl]
	dec a
	ld [hli], a
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld e, l
	ld d, h
	inc de
.loop
	ld a, [de]
	inc de
	ld [hli], a
	inc a
	jr nz, .loop
	ld hl, wPartyMonOT
	ld d, PARTY_LENGTH - 1
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party
	ld hl, sBoxMonOT
	ld d, MONS_PER_BOX - 1

.party
	; If this is the last mon in our party (box),
	; shift all the other mons up to close the gap.
	ld a, [wCurPartyMon]
	call SkipNames
	ld a, [wCurPartyMon]
	cp d
	jr nz, .delete_inside
	ld [hl], -1
	jp .finish

.delete_inside
	; Shift the OT names
	ld d, h
	ld e, l
	ld bc, PKMN_NAME_LENGTH
	add hl, bc
	ld bc, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party2
	ld bc, sBoxMonNicknames
.party2
	call CopyDataUntil
	; Shift the struct
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party4
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
.party4
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld d, h
	ld e, l
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party5
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	ld bc, sBoxMonOT
	jr .copy

.party5
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	ld bc, wPartyMonOT
.copy
	call CopyDataUntil
	; Shift the nicknames
	ld hl, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party6
	ld hl, sBoxMonNicknames
.party6
	ld bc, PKMN_NAME_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld d, h
	ld e, l
	ld bc, PKMN_NAME_LENGTH
	add hl, bc
	ld bc, wPartyMonNicknamesEnd
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party7
	ld bc, sBoxMonNicknamesEnd
.party7
	call CopyDataUntil
	; Mail time!
.finish
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jp nz, CloseSRAM
	ld a, [wLinkMode]
	and a
	ret nz
	; Shift mail
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	; If this is the last mon in our party, no need to shift mail.
	ld hl, wPartyCount
	ld a, [wCurPartyMon]
	cp [hl]
	jr z, .close_sram
	; Shift our mail messages up.
	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	push hl
	add hl, bc
	pop de
	ld a, [wCurPartyMon]
	ld b, a
.loop2
	push bc
	push hl
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	pop hl
	push hl
	ld bc, MAIL_STRUCT_LENGTH
	add hl, bc
	pop de
	pop bc
	inc b
	ld a, [wPartyCount]
	cp b
	jr nz, .loop2
.close_sram
	jp CloseSRAM
; e134


ComputeNPCTrademonStats: ; e134
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [MON_LEVEL], a ; wow
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld d, h
	ld e, l
	push de
	ld a, MON_EVS - 1
	call GetPartyParamLocation
	ld b, TRUE
	call CalcPkmnStats
	pop de
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a
	ret
; e167

UpdatePkmnStats:
; Recalculates the stats of wCurPartyMon and also updates current HP accordingly
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurSpecies], a
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
	ld b, TRUE
	call CalcPkmnStats
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

CalcPkmnStats: ; e167
; Calculates all 6 Stats of a Pkmn
; b: Hyper Training (bit 7-2), apply EVs (bit 0)
; 'c' counts from 1-6 and points with 'wBaseStats' to the base value
; hl is the path to the EVs
; de is a pointer where the 6 stats are placed

	ld c, $0
.loop
	inc c
	call CalcPkmnStatC
	ld a, [hMultiplicand + 1]
	ld [de], a
	inc de
	ld a, [hMultiplicand + 2]
	ld [de], a
	inc de
	ld a, c
	cp STAT_SDEF
	jr nz, .loop
	ret
; e17b

CalcPkmnStatC: ; e17b
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
	ld hl, wBaseStats
	dec hl ; has to be decreased, because 'c' begins with 1
	ld b, $0
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
	ld a, [hl]
	dec hl
	swap a
	and $f
	jr .GotDV

.Speed:
	inc hl
	ld a, [hl]
	dec hl
	and $f
	jr .GotDV

.SpclAtk:
	inc hl
	inc hl
	ld a, [hl]
	dec hl
	dec hl
	swap a
	and $f
	jr .GotDV

.SpclDef:
	inc hl
	inc hl
	ld a, [hl]
	dec hl
	dec hl
	and $f

.GotDV:
	ld d, 0
	add e
	ld e, a
	jr nc, .no_overflow_1
	inc d

.no_overflow_1
	sla e
	inc e
	rl d
	srl b
	srl b
	ld a, b
	add e
	jr nc, .no_overflow_2
	inc d

.no_overflow_2
	ld [hMultiplicand + 2], a
	ld a, d
	ld [hMultiplicand + 1], a
	xor a
	ld [hMultiplicand + 0], a
	ld a, [wCurPartyLevel]
	ld [hMultiplier], a
	call Multiply
	ld a, [hProduct + 1]
	ld [hDividend + 0], a
	ld a, [hProduct + 2]
	ld [hDividend + 1], a
	ld a, [hProduct + 3]
	ld [hDividend + 2], a
	ld a, 100
	ld [hDivisor], a
	ld a, 3
	ld b, a
	call Divide
	ld a, c
	cp STAT_HP
	ld a, STAT_MIN_NORMAL
	jr nz, .not_hp
	ld a, [wCurPartyLevel]
	ld b, a
	ld a, [hQuotient + 2]
	add b
	ld [hMultiplicand + 2], a
	jr nc, .no_overflow_3
	ld a, [hQuotient + 1]
	inc a
	ld [hMultiplicand + 1], a

.no_overflow_3
	ld a, STAT_MIN_HP

.not_hp
	ld b, a
	ld a, [hQuotient + 2]
	add b
	ld [hMultiplicand + 2], a
	jr nc, .no_overflow_4
	ld a, [hQuotient + 1]
	inc a
	ld [hMultiplicand + 1], a

.no_overflow_4
	ld a, [hQuotient + 1]
	cp (1000 / $100) + 1
	jr nc, .max_stat
	cp 1000 / $100
	jr c, .stat_value_okay
	ld a, [hQuotient + 2]
	cp 1000 % $100
	jr c, .stat_value_okay

.max_stat
	ld a, 999 / $100
	ld [hMultiplicand + 1], a
	ld a, 999 % $100
	ld [hMultiplicand + 2], a

.stat_value_okay
	; do natures here
	xor a
	ld [hMultiplicand + 0], a
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
	ld [hMultiplier], a
	call Multiply
	ld a, [hProduct + 1]
	ld [hDividend + 0], a
	ld a, [hProduct + 2]
	ld [hDividend + 1], a
	ld a, [hProduct + 3]
	ld [hDividend + 2], a
	ld a, 10
	ld [hDivisor], a
	ld a, 3
	ld b, a
	call Divide
	ld a, [hQuotient + 1]
	ld [hMultiplicand + 1], a
	ld a, [hQuotient + 2]
	ld [hMultiplicand + 2], a
	pop bc
	pop de
	pop hl
	ret
; e277

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

GivePoke:: ; e277
	push de
	push bc
	xor a ; PARTYMON
	ld [wMonType], a
	call TryAddMonToParty
	jr nc, .failed
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	call SkipNames
	ld d, h
	ld e, l
	pop bc
	ld a, b
	ld b, 0
	push bc
	push de
	push af
	ld a, [wCurItem]
	and a
	jr z, .done
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [wCurItem]
	ld [hl], a
	jr .done

.failed
	ld a, [wCurPartySpecies]
	ld [wTempEnemyMonSpecies], a
	farcall LoadEnemyMon
	call SentPkmnIntoBox
	jp nc, .FailedToGiveMon
	ld a, BOXMON
	ld [wMonType], a
	xor a
	ld [wCurPartyMon], a
	ld de, wMonOrItemNameBuffer
	pop bc
	ld a, b
	ld b, 1
	push bc
	push de
	push af
	ld a, [wCurItem]
	and a
	jr z, .done
	ld a, [wCurItem]
	ld [sBoxMon1Item], a

.done
	ld a, [wCurPartySpecies]
	ld [wd265], a
	ld [wTempEnemyMonSpecies], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes
	pop af
	and a
	jp z, .wildmon
	pop de
	pop bc
	pop hl
	push bc
	push hl
	ld a, [wScriptBank]
	call GetFarHalfword
	ld bc, PKMN_NAME_LENGTH
	ld a, [wScriptBank]
	call FarCopyBytes
	pop hl
	inc hl
	inc hl
	ld a, [wScriptBank]
	call GetFarHalfword
	pop bc
	ld a, b
	and a
	push de
	push bc
	jr nz, .send_to_box

	push hl
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOT
	call SkipNames
	ld d, h
	ld e, l
	pop hl
.otnameloop
	ld a, [wScriptBank]
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	cp "@"
	jr nz, .otnameloop
	ld a, [wScriptBank]
	call GetFarByte
	ld b, a
	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, 01001 / $100 ; ld a, $3
	ld [hli], a
	ld [hl], 01001 % $100 ; ld a, $e9
	pop bc
	ld a, POKE_BALL
	ld c, a
	farcall SetGiftPartyMonCaughtData
	jr .skip_nickname

.send_to_box
	ld a, BANK(sBoxMonOT)
	call GetSRAMBank
	ld de, sBoxMonOT
.loop
	ld a, [wScriptBank]
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	cp "@"
	jr nz, .loop
	ld a, [wScriptBank]
	call GetFarByte
	ld b, a
	ld a, POKE_BALL
	ld c, a
	ld hl, sBoxMon1ID
	call Random
	ld [hli], a
	call Random
	ld [hl], a
	call CloseSRAM
	farcall SetGiftBoxMonCaughtData
	jr .skip_nickname

.wildmon
	pop de
	pop bc
	push bc
	push de
	ld a, b
	and a
	jr z, .party
	farcall SetBoxMonCaughtData
	jr .set_caught_data

.party
	ld a, POKE_BALL
	ld [wCurItem], a
	farcall SetCaughtData
.set_caught_data
	farcall GiveANickname_YesNo
	pop de
	jr c, .skip_nickname
	call InitNickname

.skip_nickname
	pop bc
	pop de
	ld a, b
	and a
	ret z
	ld hl, TextJump_WasSentToBillsPC
	call PrintText
	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank
	ld hl, wMonOrItemNameBuffer
	ld de, sBoxMonNicknames
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes
	call CloseSRAM
	ld b, $1
	ret
; e3d4

.FailedToGiveMon: ; e3d4
	pop bc
	pop de
	ld b, $2
	ret
; e3d9

TextJump_WasSentToBillsPC: ; 0xe3d9
	; was sent to BILL's PC.
	text_jump Text_WasSentToBillsPC
	db "@"
; 0xe3de

InitNickname: ; e3de
	push de
	call LoadStandardMenuDataHeader
	call DisableSpriteUpdates
	pop de
	push de
	ld b, $0 ; pokemon
	farcall NamingScreen
	pop hl
	ld de, wStringBuffer1
	call InitName
	jp ExitAllMenus
; e3fd
