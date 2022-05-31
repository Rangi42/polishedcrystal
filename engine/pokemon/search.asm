SpecialBeastsCheck:
; Check if the player has caught all three legendary beasts.
; Return the result in hScriptVar.

	ld a, [wPlayerCaught]
	and CAUGHT_BEASTS_MASK
	cp CAUGHT_BEASTS_MASK
	jr nz, SpecialMonCheckFailed
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialBirdsCheck:
; Check if the player has caught all three legendary birds.
; Return the result in hScriptVar.

	ld a, [wPlayerCaught]
	and CAUGHT_BIRDS_MASK
	cp CAUGHT_BIRDS_MASK
	jr nz, SpecialMonCheckFailed
	ld a, 1
	ldh [hScriptVar], a
	ret

SpecialDuoCheck:
; Check if the player has caught Lugia and Ho-Oh.
; Return the result in hScriptVar.

	ld a, [wPlayerCaught]
	and CAUGHT_DUO_MASK
	cp CAUGHT_DUO_MASK
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
	bit 6, a
	jr z, .false
	ld a, $1
	ldh [hScriptVar], a
	ret

.false
	xor a
	ldh [hScriptVar], a
	ret
