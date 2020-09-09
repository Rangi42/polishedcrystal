GetFirstPokemonHappiness:
; returns first non-Egg party mon's happiness
	ld hl, wPartyMon1Species
.loop
	ld a, [hl]
	push hl
	ld bc, wPartyMon1IsEgg - wPartyMon1Species
	add hl, bc
	bit MON_IS_EGG_F, [hl]
	pop hl
	jr z, .done
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	jr .loop

.done
	ld bc, wPartyMon1Happiness - wPartyMon1Species
	add hl, bc
	ld [wd265], a
	ld a, [hl]
	ldh [hScriptVar], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

CheckFirstMonIsEgg:
	ld a, [wPartyMon1Species]
	ld [wd265], a
	ld a, [wPartyMon1IsEgg]
	bit MON_IS_EGG_F, a
	ld a, $1
	jr nz, .egg
	xor a

.egg
	ldh [hScriptVar], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

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
	cp 100
	ld e, 0
	jr c, .ok
	inc e
	cp 200
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
	cp 100
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
	and CAUGHTBALL_MASK
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

	ld hl, wHappinessStepCount
	ld a, [hl]
	inc a
	and 1
	ld [hl], a
	ret nz

	ld de, wPartyCount
	ld a, [de]
	and a
	ret z

	ld c, a
	ld hl, wPartyMon1Happiness
.loop
	push hl
	ld de, wPartyMon1IsEgg - wPartyMon1Happiness
	add hl, de
	bit MON_IS_EGG_F, [hl]
	pop hl
	jr nz, .next
	inc [hl]
	jr nz, .next
	dec [hl]

.next
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ret

DayCareStep::

	ld a, [wDayCareMan]
	bit 0, a
	jr z, .daycare_lady

	ld de, wBreedMon1Level
	ld hl, wBreedMon1Exp + 2
	call .daycare_exp

.daycare_lady
	ld a, [wDayCareLady]
	bit 0, a
	jr z, .check_egg

	ld de, wBreedMon2Level
	ld hl, wBreedMon2Exp + 2
	call .daycare_exp

.check_egg
	ld hl, wDayCareMan
	bit 5, [hl] ; egg
	ret z
	ld hl, wStepsToEgg
	dec [hl]
	ret nz

	farcall CheckBreedmonCompatibility
	ld a, [wd265]
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
	res 5, [hl]
	set 6, [hl]
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
	cp ($500000 / $10000) - 1 ; max daycare exp
	ret nc
	inc [hl]
	ret
