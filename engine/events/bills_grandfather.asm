Special_BillsGrandfather:
	farcall SelectMonFromParty
	jr c, .cancel
	ld hl, wNamedObjectIndex
	ld a, [wCurPartySpecies]
	ldh [hScriptVar], a
	ld [hli], a
	ld a, [wCurForm]
	ldh [hScriptVar+1], a
	ld [hl], a
	call GetPokemonName
	jmp CopyPokemonName_Buffer1_Buffer3

.cancel
	xor a
	ldh [hScriptVar], a
	ret
