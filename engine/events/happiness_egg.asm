GetFirstPokemonHappiness: ; 718d
	ld hl, PartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, PartySpecies
.loop
	ld a, [de]
	cp EGG
	jr nz, .done
	inc de
	add hl, bc
	jr .loop

.done
	ld [wd265], a
	ld a, [hl]
	ld [ScriptVar], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

CheckFirstMonIsEgg: ; 71ac
	ld a, [PartySpecies]
	ld [wd265], a
	cp EGG
	ld a, $1
	jr z, .egg
	xor a

.egg
	ld [ScriptVar], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

ChangeHappiness: ; 71c2
; Perform happiness action c on CurPartyMon

	ld a, [CurPartyMon]
	inc a
	ld e, a
	ld d, 0
	ld hl, PartySpecies - 1
	add hl, de
	ld a, [hl]
	cp EGG
	ret z

	push bc
	ld hl, PartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [CurPartyMon]
	call AddNTimes
	pop bc

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
	dec c
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
	ld a, [CurPartyMon]
	ld b, a
	ld a, [wPartyMenuCursor]
	cp b
	ret nz
	ld a, [de]
	ld [BattleMonHappiness], a
	ret

INCLUDE "data/events/happiness_changes.asm"

GetExtraHappiness:
; Increase happiness in 'a' based on ther factors
	push af

	ld b, a

	cp 255
	jr nc, .no_soothe_bell ; already at maximum

	ld a, [CurPartyMon]
	push bc
	ld hl, PartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [CurPartyMon]
	call AddNTimes
	pop bc
	ld a, [hl]
	cp SOOTHE_BELL
	jr nz, .no_soothe_bell

	; Soothe Bell adds 1
	inc b

.no_soothe_bell
	ld a, b
	cp 255
	jr nc, .no_luxury_ball ; already at maximum

	ld a, [CurPartyMon]
	push bc
	ld hl, PartyMon1CaughtBall
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [CurPartyMon]
	call AddNTimes
	pop bc
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

StepHappiness:: ; 725a
; Raise the party's happiness by 1 point every other step cycle.

	ld hl, wHappinessStepCount
	ld a, [hl]
	inc a
	and 1
	ld [hl], a
	ret nz

	ld de, PartyCount
	ld a, [de]
	and a
	ret z

	ld c, a
	ld hl, PartyMon1Happiness
.loop
	inc de
	ld a, [de]
	cp EGG
	jr z, .next
	inc [hl]
	jr nz, .next
	ld [hl], $ff

.next
	push de
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	dec c
	jr nz, .loop
	ret

DaycareStep:: ; 7282

	ld a, [wDaycareMan]
	bit 0, a
	jr z, .daycare_lady

	ld de, wBreedMon1Level
	ld hl, wBreedMon1Exp + 2
	call .daycare_exp

.daycare_lady
	ld a, [wDaycareLady]
	bit 0, a
	jr z, .check_egg

	ld de, wBreedMon2Level
	ld hl, wBreedMon2Exp + 2
	call .daycare_exp

.check_egg
	ld hl, wDaycareMan
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
	ld [CurItem], a
	push bc
	ld hl, NumKeyItems
	call CheckItem
	pop bc
	jr nc, .no_oval_charm
	ld b, c
.no_oval_charm
	ld a, 100
	call RandomRange
	cp b
	ret nc
	ld hl, wDaycareMan
	res 5, [hl]
	set 6, [hl]
	ret

.daycare_exp
	ld a, [de]
	cp 100
	ret nc

	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret nz
	dec hl
	ld a, [hl]
	cp 5242800 / $10000
	ret nc
	inc [hl]
	ret
