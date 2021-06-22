Special_BillsGrandfather:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	ldh [hScriptVar], a
	ld [wNamedObjectIndex], a
	call GetPokemonName
	jmp CopyPokemonName_Buffer1_Buffer3

.cancel
	xor a
	ldh [hScriptVar], a
	ret
