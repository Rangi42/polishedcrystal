Special_BillsGrandfather:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	ldh [hScriptVar], a
	ld a, [wCurForm]
	ldh [hScriptVar+1], a
	call GetPartyPokemonName
	jmp CopyPokemonName_Buffer1_Buffer3

.cancel
	xor a
	ldh [hScriptVar], a
	ret
