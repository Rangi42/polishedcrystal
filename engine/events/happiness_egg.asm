GetFirstPokemonHappiness:
; returns first non-Egg party mon's happiness
	ld hl, wPartyMon1Species
.loop
	ld a, [hl]
	ld bc, MON_IS_EGG - MON_SPECIES
	add hl, bc
	bit MON_IS_EGG_F, [hl]
	jr z, .done
	ld bc, PARTYMON_STRUCT_LENGTH - MON_IS_EGG
	add hl, bc
	jr .loop

.done
	ld [wNamedObjectIndex], a
	assert MON_IS_EGG == MON_FORM
	ld a, [hl]
	ld [wNamedObjectIndex+1], a
	ld bc, MON_HAPPINESS - MON_IS_EGG
	add hl, bc
	ld a, [hl]
	ldh [hScriptVar], a
	call GetPokemonName
	jmp CopyPokemonName_Buffer1_Buffer3

CheckFirstMonIsEgg:
	ld a, [wPartyMon1Species]
	ld [wNamedObjectIndex], a
	ld a, [wPartyMon1IsEgg]
	assert MON_IS_EGG == MON_FORM
	ld [wNamedObjectIndex+1], a
	bit MON_IS_EGG_F, a
	ld a, TRUE
	jr nz, .egg
	xor a
.egg
	ldh [hScriptVar], a
	call GetPokemonName
	jmp CopyPokemonName_Buffer1_Buffer3

ChangeHappiness:
; Perform happiness action c on wCurPartyMon

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1IsEgg
	push af
	call GetPartyLocation
	pop af
	bit MON_IS_EGG_F, [hl]
	ret nz

	ld hl, wPartyMon1Happiness
	call GetPartyLocation

	ld d, h
	ld e, l

	push de
	ld a, [de]
	cp HAPPINESS_THRESHOLD_1
	ld e, 0
	jr c, .ok
	inc e
	cp HAPPINESS_THRESHOLD_2
	jr c, .ok
	inc e

.ok
	ld b, 0
	ld hl, HappinessChanges
	add hl, bc
	add hl, bc
	add hl, bc
	ld d, 0
	add hl, de
	ld a, [hl]
	cp $80
	pop de

	ld a, [de]
	jr nc, .negative
	add [hl]
	jr nc, .extra
	ld a, 255
	jr .done

.extra
	call GetExtraHappiness
	jr .done

.negative
	add [hl]
	jr c, .done
	xor a

.done
	ld [de], a
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wPartyMenuCursor]
	cp b
	ret nz
	ld a, [de]
	ld [wBattleMonHappiness], a
	ret

INCLUDE "data/events/happiness_changes.asm"

GetExtraHappiness:
; Increase happiness in 'a' based on ther factors
	push af

	ld b, a

	cp 255
	jr nc, .no_soothe_bell ; already at maximum

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Item
	call GetPartyLocation
	ld a, [hl]
	cp SOOTHE_BELL
	jr nz, .no_soothe_bell

	; Soothe Bell adds 1
	inc b

.no_soothe_bell
	ld a, b
	cp 255
	jr nc, .no_luxury_ball ; already at maximum

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1CaughtBall
	call GetPartyLocation
	ld a, [hl]
	and CAUGHT_BALL_MASK
	cp LUXURY_BALL
	jr nz, .no_luxury_ball

	; Luxury Ball adds 1
	inc b

.no_luxury_ball
	pop af
	ld a, b
	ret

StepHappiness::
; Raise the party's happiness by 1 point every other step cycle.
	ld a, [wPartyCount]
.loop
	and a
	ret z
	dec a
	ld [wCurPartyMon], a
	ld c, HAPPINESS_STEP
	predef ChangeHappiness
	ld a, [wCurPartyMon]
	jr .loop

DayCareStep::
	ld a, [wDayCareMan]
	bit 0, a
	push af
	jr z, .daycare_lady

	ld de, wBreedMon1Level
	ld hl, wBreedMon1Exp + 2
	call .daycare_exp

.daycare_lady
	ld a, [wDayCareLady]
	bit 0, a
	pop bc
	jr z, .check_egg

	; If both a (lady) and b (man) has bit 0 set, both of them are managing
	; Pokémon. See if we should proc Mirror Herb.
	and b
	rrca
	call c, .HandleMirrorHerb

	ld de, wBreedMon2Level
	ld hl, wBreedMon2Exp + 2
	call .daycare_exp

.check_egg
	ld hl, wDayCareMan
	bit DAYCAREMAN_MONS_COMPATIBLE_F, [hl] ; egg
	ret z
	ld hl, wStepsToEgg
	dec [hl]
	ret nz

	farcall CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	; Egg initialization shouldn't happen if incompatible, but just in case
	and a
	ret z

	dec a ; 1: Semi-compatible
	lb bc, 20, 40
	jr z, .got_odds
	dec a ; 2: Compatible
	lb bc, 50, 80
	jr z, .got_odds
	; 3: Very compatible
	lb bc, 70, 88
.got_odds
	ld a, OVAL_CHARM
	ld [wCurKeyItem], a
	push bc
	call CheckKeyItem
	pop bc
	jr nc, .no_oval_charm
	ld b, c
.no_oval_charm
	ld a, 100
	call RandomRange
	cp b
	ret nc
	ld hl, wDayCareMan
	res DAYCAREMAN_MONS_COMPATIBLE_F, [hl]
	set DAYCAREMAN_HAS_EGG_F, [hl]
	ret

.daycare_exp
	ld a, [de]
	cp MAX_LEVEL
	ret nc

	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret nz
	dec hl
	ld a, [hl]
	cp (MAX_DAY_CARE_EXP >> 16) - 1
	ret nc
	inc [hl]
	ret

.HandleMirrorHerb:
; Do nothing 255/256 of the time.
	call Random
	ret nz

	; de is meant to address the other's move list, it's not a mistake.
	ld hl, wBreedMon1Item
	ld de, wBreedMon2Moves
	call .HandleEachMirrorHerb
	ld hl, wBreedMon2Item
	ld de, wBreedMon1Moves
.HandleEachMirrorHerb
	; Are we actually holding a Mirror Herb?
	ld a, [hl]
	cp MIRROR_HERB
	ret nz

	; Do we have a free move slot?
	ld bc, MON_MOVES - MON_ITEM
	add hl, bc
	ld b, NUM_MOVES
	push hl
.freemoveslot_loop
	ld a, [hli]
	and a
	jr z, .found_free_slot
	dec b
	jr nz, .freemoveslot_loop
	pop hl
	ret

.found_free_slot
	; Get the correct egg move pointer.
	pop hl
	push hl
	ld bc, MON_SPECIES - MON_MOVES
	add hl, bc
	ld a, [hl]
	ld bc, MON_FORM - MON_SPECIES
	add hl, bc
	ld b, [hl]
	ld c, a
	call GetSpeciesAndFormIndex
	ld hl, EggSpeciesMovesPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EggSpeciesMovesPointers)
	call GetFarWord
	ld b, h
	ld c, l
	inc bc
	inc bc ; first two bytes are base evolution
	pop hl

	; Check each move slot for the other mon for whether we already know the
	; move. If we don't, check if it's an egg move. If it is, learn it.
	ld a, e
	add NUM_MOVES - 1
	dec hl

.checkmove_loop
	push hl
	push af
	ld a, [de]

.ownmove_loop
	; Check if we have a matching move. This also catches de==hl==0.
	inc hl
	cp [hl]
	jr z, .next

	; Have we reached the (first) empty move slot for the inheriting mon?
	inc [hl]
	dec [hl]
	jr nz, .ownmove_loop

	; We can learn this move, assuming it's part of our egg move table.
	push hl
	push de
	push bc
	ld h, b
	ld l, c
	ld c, a
	ld a, BANK(EggSpeciesMoves)
	call FarIsInByteArray
	ld a, c
	pop bc
	pop de
	pop hl
	jr nc, .next

	; This is a valid egg move. Inherit it.
	ld [hl], a
	pop af
	pop hl
	ret

.next
	pop af
	pop hl
	cp e
	inc de
	jr nz, .checkmove_loop
	ret
