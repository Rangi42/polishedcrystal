Special_BillsGrandfather:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	ldh [hScriptVar], a
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

.cancel
	xor a
	ldh [hScriptVar], a
	ret
