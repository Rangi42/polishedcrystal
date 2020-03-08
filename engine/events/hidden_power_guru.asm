Special_HiddenPowerGuru:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .egg
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	call CopyPokemonName_Buffer1_Buffer3
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1DVs
	call GetPartyLocation
	farcall GetHiddenPowerType
	ld [wNamedObjectIndexBuffer], a
	farcall GetTypeName
	ld a, $2
.done
	ld [hScriptVar], a
	ret

.cancel
	ld a, $0
	jr .done

.egg
	ld a, $1
	jr .done
