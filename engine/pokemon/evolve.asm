EvolvePokemon:
	ld hl, wEvolvableFlags
	xor a
	ld [hl], a
	ld a, [wCurPartyMon]
	ld c, a
	ld b, SET_FLAG
	call EvoFlagAction
EvolveAfterBattle:
	xor a
	ld [wMonTriedToEvolve], a
	dec a
	ld [wCurPartyMon], a
	push hl
	push bc
	push de
	ld a, [wPartyCount]
	and a
	jr z, EvolveAfterBattle_ReturnToMap
	push af
EvolveAfterBattle_MasterLoop:
	ld hl, wCurPartyMon
	inc [hl]

	pop af
	cp [hl]
	jr z, EvolveAfterBattle_ReturnToMap

	push af
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld [wEvolutionOldSpecies], a
	ld bc, MON_FORM - MON_SPECIES
	add hl, bc
	ld a, [hl]
	ld [wEvolutionOldForm], a

	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wEvolvableFlags
	ld b, CHECK_FLAG
	call EvoFlagAction
	ld a, c
	and a
	jr z, EvolveAfterBattle_MasterLoop

	call CheckHowToEvolve
	jr z, EvolveAfterBattle_MasterLoop

	ld a, $1
	ld [wMonTriedToEvolve], a

	call TryToEvolve
	call c, CancelEvolution

	jr EvolveAfterBattle_MasterLoop

EvolveAfterBattle_ReturnToMap:
	pop de
	pop bc
	pop hl
	ld a, [wLinkMode]
	and a
	ret nz
	ld a, [wBattleMode]
	and a
	ret nz
	ld a, [wMonTriedToEvolve]
	and a
	call nz, RestartMapMusic
	ret

CheckHowToEvolve:
	ld a, [wEvolutionOldSpecies]
	ld c, a
	ld a, [wEvolutionOldForm]
	ld b, a
	call GetEvosAttacksPointer

	push hl
	xor a
	ld [wMonType], a
	predef CopyPkmnToTempMon
	pop hl

.loop
	ld a, [hli]
	inc a
	ret z ; cannot evolve
	dec a
	ld b, a

	ld a, [wLinkMode]
	and a
	jmp nz, .dont_evolve_2

	ld a, b
	cp EVOLVE_ITEM
	jmp z, .item

	ld a, [wForceEvolution]
	and a
	jmp nz, .dont_evolve_2

	ld a, b
	cp EVOLVE_CRIT
	jmp z, .crit
	cp EVOLVE_HOLDING
	jmp z, .holding
	cp EVOLVE_LOCATION
	jmp z, .location
	cp EVOLVE_MOVE
	jmp z, .move
	cp EVOLVE_LEVEL
	jmp z, .level
	cp EVOLVE_PARTY
	jmp z, .party
	cp EVOLVE_HAPPINESS
	jr z, .happiness

; EVOLVE_STAT
	ld a, [wTempMonLevel]
	cp [hl]
	jmp c, .dont_evolve_1

	call IsMonHoldingEverstone
	jmp z, .dont_evolve_1

	push hl

	; If EVs affecting stats is disabled, compare based on IVs, not actual
	; stats. This way, if the player also has IVs and Natures disabled
	; (perfect stats in the case of IVs), they still retain access to
	; all stat evolutions.
	ld a, [wInitialOptions2]
	and EV_OPTMASK ; sets z if EVS_OPT_DISABLED
	jr nz, .evs_enabled

	ld hl, wTempMonHPAtkDV
	ld a, [hli]
	and $f
	ld c, a ; c = atk
	ld a, [hl]
	and $f0
	swap a ; a = def
	cp c ; set carry if atk > def
	jr .stat_cmp_done

.evs_enabled
	ld hl, wTempMonAttack
	ld de, wTempMonDefense
	ld c, 2
	call StringCmp ; set carry if atk > def

.stat_cmp_done
	ld a, ATK_EQ_DEF
	jr z, .got_tyrogue_evo
	; a = carry ? ATK_GT_DEF : ATK_LT_DEF
	assert ATK_GT_DEF + 1 == ATK_LT_DEF
	sbc a
	add ATK_LT_DEF
.got_tyrogue_evo
	pop hl

	inc hl
	cp [hl]
	jmp nz, .dont_evolve_2

	inc hl
	jmp .proceed

.happiness
	ld a, [wTempMonHappiness]
	cp HAPPINESS_TO_EVOLVE
	jmp c, .dont_evolve_2

	call IsMonHoldingEverstone
	jmp z, .dont_evolve_2

	; Spiky-eared Pichu cannot evolve
	ld a, [wTempMonSpecies]
	cp LOW(PICHU)
	jr nz, .not_spiky_eared_pichu
	ld a, [wTempMonForm]
	assert !HIGH(PICHU)
	and SPECIESFORM_MASK
	cp PICHU_SPIKY_EARED_FORM
	jmp z, .dont_evolve_2

.not_spiky_eared_pichu
	ld a, [hli]
	cp TR_ANYTIME
	jmp z, .proceed
	cp TR_MORNDAY
	jr z, .happiness_daylight

.happiness_nighttime
	ld a, [wTimeOfDay]
	cp NITE
	jmp c, .dont_evolve_3
	jmp .proceed

.happiness_daylight
	ld a, [wTimeOfDay]
	cp NITE
	jmp nc, .dont_evolve_3
	jmp .proceed

.item
	ld a, [hli]
	ld b, a
	ld a, [wCurItem]
	cp b
	jmp nz, .dont_evolve_3

	ld a, [wForceEvolution]
	and a
	jmp z, .dont_evolve_3
	ld a, [wLinkMode]
	and a
	jmp nz, .dont_evolve_3
	jmp .proceed

.party
	ld a, [hli]
	ld d, a ; species
	ld a, [hli]
	ld e, a ; ext species + form
	push hl
	ld hl, wPartyMon1Species
	ld a, [wPartyCount]
	ld b, a
.party_loop
	ld a, [hl]
	cp d
	jr nz, .party_next
	push hl
	push de
	ld de, MON_FORM - MON_SPECIES
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	and SPECIESFORM_MASK
	cp e
	jr z, .party_ok
.party_next
	push de
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	dec b
	jr nz, .party_loop
	pop hl
	jmp .dont_evolve_3

.party_ok
	pop hl
	jr .proceed

.holding
	ld a, [hli]
	ld b, a
	ld a, [wTempMonItem]
	cp b
	jmp nz, .dont_evolve_2
	ld a, [hli]
	cp TR_ANYTIME
	jr z, .ok
	cp TR_MORNDAY
	ld a, [wTimeOfDay]
	jr z, .holding_daylight
	cp NITE
	jmp c, .dont_evolve_3
	jr .ok
.holding_daylight
	cp NITE
	jmp nc, .dont_evolve_3
.ok
	xor a
	ld [wTempMonItem], a
	jr .proceed

.location
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	push hl
	call GetWorldMapLocation
	pop hl
	ld b, a
	ld a, [hli]
	cp b
	jr nz, .dont_evolve_3
	jr .proceed

.move
	ld a, [hli]
	push hl
	push bc
	ld b, a
	ld hl, wTempMonMoves
rept NUM_MOVES - 1
	ld a, [hli]
	cp b
	jr z, .move_proceed
endr
	ld a, [hl]
	cp b
.move_proceed
	pop bc
	pop hl
	jr nz, .dont_evolve_3
	jr .proceed

.crit
	inc hl
	push hl
	push bc
	ld hl, wCriticalCount
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp 3
	pop bc
	pop hl
	jr c, .dont_evolve_3
	jr .proceed

.level
	ld a, [hli]
	ld b, a
	ld a, [wTempMonLevel]
	cp b
	jr c, .dont_evolve_3
	call IsMonHoldingEverstone
	jr z, .dont_evolve_3

.proceed
	ld a, [wTempMonLevel]
	ld [wCurPartyLevel], a

	ld a, [hli]
	ld [wEvolutionNewSpecies], a
	ld a, [hl]
	ld c, a
	and FORM_MASK
	ld a, [wTempMonForm]
	jr z, .keep_old_form
	and ~SPECIESFORM_MASK
.keep_old_form
	and ~EXTSPECIES_MASK
	or c
	ld [wEvolutionNewForm], a
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	call CopyName1

	ld a, TRUE
	and a
	ret

.dont_evolve_1
	inc hl
.dont_evolve_2
	inc hl
.dont_evolve_3
	inc hl
	inc hl
	jmp .loop

TryToEvolve:
	ld hl, Text_WhatEvolving
	call PrintText

	ld c, 50
	call DelayFrames

	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, 12, 20
	call ClearBox

	ld a, $1
	ldh [hBGMapMode], a
	call ClearSprites

	farcall EvolutionAnimation

	push af
	call ClearSprites
	pop af
	ret c

	ld hl, Text_CongratulationsYourPokemon
	call PrintText

	ld hl, wEvolutionNewSpecies
	ld a, [hli]
	ld [wCurSpecies], a
	ld [wTempMonSpecies], a
	ld [wNamedObjectIndex], a

	ld a, [hl]
	ld [wCurForm], a
	ld [wTempMonForm], a
	ld [wNamedObjectIndex+1], a

	call GetPokemonName
	ld hl, Text_EvolvedIntoPKMN
	call PrintTextboxText

	ld e, MUSIC_NONE
	call PlayMusic
	ld de, SFX_CAUGHT_MON
	call PlayWaitSFX

	ld c, 40
	call DelayFrames

	call ClearTileMap
	call UpdateSpeciesNameIfNotNicknamed
	call GetBaseData

	ld hl, wTempMonEVs - 1
	ld de, wTempMonMaxHP
	farcall GetHyperTraining
	inc a ; factor in EVs
	ld b, a
	predef CalcPkmnStats

	ld a, [wCurPartyMon]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld e, l
	ld d, h
	ld bc, MON_MAXHP
	add hl, bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wTempMonMaxHP + 1
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a
	ld hl, wTempMonHP + 1
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a

	ld hl, wTempMonSpecies
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes

	xor a
	ld [wMonType], a
	ld a, [wCurSpecies]
	ld [wTempSpecies], a
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call SetSeenAndCaughtMon

	call LearnEvolutionMove
	call LearnLevelMoves

	and a
	ret

UpdateSpeciesNameIfNotNicknamed:
	ld hl, wNamedObjectIndex
	ld a, [wEvolutionOldSpecies]
	ld [hli], a
	ld a, [wEvolutionOldForm]
	ld [hl], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
.loop
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	ret nz
	cp "@"
	jr nz, .loop

	ld a, [wCurPartyMon]
	ld bc, MON_NAME_LENGTH
	ld hl, wPartyMonNicknames
	rst AddNTimes
	push hl
	ld hl, wNamedObjectIndex
	ld a, [wCurSpecies]
	ld [hli], a
	ld a, [wCurForm]
	ld [hl], a
	call GetPokemonName
	ld hl, wStringBuffer1
	pop de
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ret

CancelEvolution:
	ld hl, Text_StoppedEvolving
	call PrintText
	jmp ClearTileMap

IsMonHoldingEverstone:
	push hl
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	cp EVERSTONE
	pop hl
	ret

Text_CongratulationsYourPokemon:
	; Congratulations! Your @ @
	text_far _CongratulationsYourPokemonText
	text_end

Text_EvolvedIntoPKMN:
	; evolved into @ !
	text_far _EvolvedIntoText
	text_end

Text_StoppedEvolving:
	; Huh? @ stopped evolving!
	text_far _StoppedEvolvingText
	text_end

Text_WhatEvolving:
	; What? @ is evolving!
	text_far _EvolvingText
	text_end

LearnEvolutionMove:
	; c = species
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	ld c, a
	; b = form
	ld a, [wCurForm]
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	ld hl, EvolutionMoves
	add hl, bc
	ld a, [hl]
	and a
	ret z

	ld d, a
	ld hl, wPartyMon1Moves
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	ld b, NUM_MOVES
.check_move
	ld a, [hli]
	cp d
	ret z
	dec b
	jr nz, .check_move

	ld a, d
	ld [wPutativeTMHMMove], a
	ld [wNamedObjectIndex], a
	call GetMoveName
	call CopyName1
	ld a, [wCurPartySpecies]
	push af
	predef LearnMove
	pop af
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ret

LearnLevelMoves:
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	ld c, a
	; b = form
	ld a, [wCurForm]
	ld b, a
	call GetEvosAttacksPointer

.skip_evos
	ld a, [hli]
	inc a
	jr nz, .skip_evos

.find_move
	ld a, [hli]
	inc a
	ret z
	dec a
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	ld a, [hli]
	jr nz, .find_move

	push hl
	ld d, a
	ld hl, wPartyMon1Moves
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	ld b, NUM_MOVES
.check_move
	ld a, [hli]
	cp d
	jr z, .has_move
	dec b
	jr nz, .check_move

	ld a, d
	ld [wPutativeTMHMMove], a
	ld [wNamedObjectIndex], a
	call GetMoveName
	call CopyName1
	ld a, [wCurPartySpecies]
	push af
	predef LearnMove
	pop af
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
.has_move
	pop hl
	jr .find_move

FillMoves:
; Fill in moves at de for species c form b at wCurPartyLevel

	push hl
	push de
	push bc
	call GetEvosAttacksPointer
.GoToAttacks:
	ld a, [hli]
	inc a
	jr nz, .GoToAttacks
	jr .GetLevel

.NextMove:
	pop de
.GetMove:
	inc hl
.GetLevel:
	ld a, [hli]
	and a
	jr z, .done
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr c, .done
	ld a, [wEvolutionOldSpecies]
	and a
	jr z, .CheckMove
	ld a, [wPrevPartyLevel]
	cp b
	jr nc, .GetMove

.CheckMove:
	push de
	ld c, NUM_MOVES
.CheckRepeat:
	ld a, [de]
	inc de
	cp [hl]
	jr z, .NextMove
	dec c
	jr nz, .CheckRepeat
	pop de
	push de
	ld c, NUM_MOVES
.CheckSlot:
	ld a, [de]
	and a
	jr z, .LearnMove
	inc de
	dec c
	jr nz, .CheckSlot
	pop de
	push de
	push hl
	ld h, d
	ld l, e
	call ShiftMoves
	ld a, [wEvolutionOldSpecies]
	and a
	jr z, .ShiftedMove
	push de
	ld bc, wPartyMon1PP - (wPartyMon1Moves + NUM_MOVES - 1)
	add hl, bc
	ld d, h
	ld e, l
	call ShiftMoves
	pop de

.ShiftedMove:
	pop hl

.LearnMove:
	ld a, [hl]
	ld [de], a
	ld a, [wEvolutionOldSpecies]
	and a
	jr z, .NextMove
	push hl
	ld a, [hl]
	ld hl, MON_PP - MON_MOVES
	add hl, de
	push hl
	ld hl, Moves + MOVE_PP
	call GetMoveProperty
	pop hl
	ld [hl], a
	pop hl
	jr .NextMove

.done
	jmp PopBCDEHL

ShiftMoves:
	ld c, NUM_MOVES - 1
.loop
	inc de
	ld a, [de]
	ld [hli], a
	dec c
	jr nz, .loop
	ret

EvoFlagAction:
	push de
	ld d, $0
	predef FlagPredef
	pop de
	ret

GetEvosAttacksPointer:
; input: b = form, c = species
; output: bc = index, hl = pointer
	call GetSpeciesAndFormIndex
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

GetEvolutionData:
; input: b = form, c = species
; output: a = EVOLVE_* constant, wStringBuffer4 = parameter 1, wStringBuffer5 = parameter 2
	assert MON_IS_EGG == MON_EXTSPECIES && MON_EXTSPECIES == MON_FORM
	bit MON_IS_EGG_F, b
	jr z, .not_egg
	ld a, EVOLVE_EGG
	ret
.not_egg
	ld a, b
	and SPECIESFORM_MASK
	ld b, a
	ld hl, MultipleEvolutions
	ld de, 3
	call IsInWordArray
	jr nc, .not_multiple
	inc hl
	inc hl
	ld a, [hl]
	ret
.not_multiple
	call GetEvosAttacksPointer
	ld a, [hli]
	inc a ; no evolutions?
	ret z ; EVOLVE_NONE == 0
	dec a
	push af
	ld a, [hld] ; parameter 1
	ld [wStringBuffer4], a
	ld a, [hli] ; evolution method
	cp EVOLVE_ITEM
	jr z, .get_item_name
	cp EVOLVE_HOLDING
	jr z, .get_item_name_and_time
	cp EVOLVE_LOCATION
	jr z, .get_landmark_name
	cp EVOLVE_MOVE
	jr z, .get_move_name
	cp EVOLVE_PARTY
	jr z, .get_mon_name
.done
	pop af
	ret

.get_item_name_and_time:
	inc hl
	ld a, [hld] ; parameter 2 (time)
	ld [wStringBuffer5], a
.get_item_name:
	ld a, [hl] ; parameter 1 (item)
	ld [wNamedObjectIndex], a
	call GetItemName
	jr .copy_string

.get_landmark_name:
	ld e, [hl] ; parameter 1 (landmark)
	farcall GetLandmarkName
	jr .copy_string

.get_move_name:
	ld a, [hl] ; parameter 1 (move)
	ld [wNamedObjectIndex], a
	call GetMoveName
	jr .copy_string

.get_mon_name:
	ld a, [hli] ; parameter 1 low (species)
	ld e, a
	ld a, [hl] ; parameter 1 high (ext species/form)
	ld hl, wNamedObjectIndex
	ld [hld], a
	ld [hl], e
	call GetPokemonName
.copy_string:
	ld de, wStringBuffer1
	ld hl, wStringBuffer4
	call CopyName2
	jr .done

INCLUDE "data/pokemon/multi_evos.asm"

GetNextMove:
; input: b = form, c = species, d = level
; output: a = level of next move (0 if none, -1 if egg), d = id of next move (0 if none/egg)
	assert MON_IS_EGG == MON_EXTSPECIES && MON_EXTSPECIES == MON_FORM
	bit MON_IS_EGG_F, b
	jr z, .not_egg
	ld a, -1
.no_move
	ld d, 0
	ret
.not_egg
	call GetEvosAttacksPointer
.skip_evos
	ld a, [hli]
	inc a
	jr nz, .skip_evos
.find_move
	ld a, [hli]
	inc a
	jr z, .no_move
	dec a
	cp d
	jr c, .next_move
	jr z, .next_move
	; got move
	ld d, [hl]
	ret
.next_move
	inc hl
	jr .find_move
