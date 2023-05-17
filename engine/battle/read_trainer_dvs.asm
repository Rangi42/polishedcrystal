GetTrainerEVsDVsAndPersonality:
; Return the EVs, DVs and personality of wOtherTrainerClass in bc
	ld a, [wOtherTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerClassDVsAndPersonality
rept 5
	add hl, bc
endr

	ld a, [hli] ; EVs
	farcall DivideModernEVs
rept 6 ; reuse EV value for all six stats
	ld [de], a
	inc de
endr
	ld a, [hli] ; HP/Atk DV
	ld [wDVAndPersonalityBuffer], a
	ld a, [hli] ; Def/Spe DV
	ld [wDVAndPersonalityBuffer + 1], a
	ld a, [hli] ; SAt/SDf DV
	ld [wDVAndPersonalityBuffer + 2], a

	ld a, [wOtherTrainerType]
	bit TRNTYPE_PERSONALITY, a
	ld a, [wCurForm]
	jr nz, .skip_class_gender
	and SPECIESFORM_MASK
	or [hl] ; gender
	ld [wCurForm], a
.skip_class_gender
	ld [wDVAndPersonalityBuffer + 4], a

	; pseudorandom ability 1 or 2 based on trainer+mon
	ldh a, [hMoveMon]
	ld h, a
	ld a, [wOtherTrainerID]
	ld l, a
	ld a, [wCurPartySpecies]
	xor h
	xor l
	; low bits vary more, use them for the ability
	assert ABILITY_MASK == %01100000
	and 1 ; just ability 1 or 2
	inc a ; (%01 or %10, HA is %11)
	rrca
	rrca
	rrca
	assert NAT_NEUTRAL == 0
	ld [wDVAndPersonalityBuffer + 3], a
	ret

INCLUDE "data/trainers/dvs.asm"
