Special_OlderHaircutBrother:
	ld hl, Data_OlderHaircutBrother
	jr MassageOrHaircut

Special_YoungerHaircutBrother:
	ld hl, Data_YoungerHaircutBrother
	jr MassageOrHaircut

Special_DaisyMassage:
	ld hl, Data_DaisyMassage
	jr MassageOrHaircut

Special_CianwoodPhotograph:
	ld hl, Data_CianwoodPhotograph
	jr MassageOrHaircut

Special_ReiBlessing:
	ld hl, Data_ReiBlessing

MassageOrHaircut:
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, MON_IS_EGG
	push hl
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	pop hl
	jr nz, .egg
	push hl
	call GetCurNickname
	call CopyPokemonName_Buffer1_Buffer3
	pop hl
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop

.ok
	inc hl
	ld a, [hli]
	ldh [hScriptVar], a
	ld c, [hl]
	predef_jump ChangeHappiness

.nope
	xor a
	ldh [hScriptVar], a
	ret

.egg
	ld a, 1
	ldh [hScriptVar], a
	ret

INCLUDE "data/events/happiness_probabilities.asm"

CopyPokemonName_Buffer1_Buffer3:
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ret
