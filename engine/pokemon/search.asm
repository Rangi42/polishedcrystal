SpecialBeastsCheck::
; Check if the player has caught all three legendary beasts.
; Return the result in hScriptVar.

	ld a, [wPlayerCaught]
	or ~CAUGHT_BEASTS_MASK
	inc a
	jr nz, SpecialMonCheckFailed
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialBirdsCheck::
; Check if the player has caught all three legendary birds.
; Return the result in hScriptVar.

	ld a, [wPlayerCaught]
	or ~CAUGHT_BIRDS_MASK
	inc a
	jr nz, SpecialMonCheckFailed
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialDuoCheck:
; Check if the player has caught Lugia and Ho-Oh.
; Return the result in hScriptVar.

	ld a, [wPlayerCaught]
	or ~CAUGHT_DUO_MASK
	inc a
	jr nz, SpecialMonCheckFailed
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialMonCheckFailed:
	xor a
	ldh [hScriptVar], a
	ret

CheckBattleCaughtResult:
	ld a, [wBattleResult]
	and 1 << BATTLERESULT_CAUGHT_POKEMON_F
	rlca
	rlca
	ldh [hScriptVar], a
	ret

.false
	xor a
	ldh [hScriptVar], a
	ret
