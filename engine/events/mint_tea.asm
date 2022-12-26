Special_MintTeaPickMon:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, MON_IS_EGG
	call GetPartyParamLocationAndValue
	bit MON_IS_EGG_F, a
	jr nz, .egg
	call GetPartyPokemonName
	ld a, [wCurPartyMon]
	ld [wMintTeaPartyMon], a
	ld a, 2
.done
	ldh [hScriptVar], a
	ret

.cancel
	xor a
	jr .done

.egg
	ld a, 1
	jr .done

Special_MintTeaChangeNature:
	; new nature = (liked - 1) * 5 + (disliked - 1)
	ld a, [wMintTeaLikedFlavor]
	dec a
	ld b, a
	add a
	add a
	add b
	ld b, a
	ld a, [wMintTeaDislikedFlavor]
	dec a
	add b
	ld b, a
	; update nature
	ld a, [wMintTeaPartyMon]
	ld [wCurPartyMon], a
	ld a, MON_NATURE
	call GetPartyParamLocationAndValue
	and ~NATURE_MASK
	or b
	ld [hl], a
	farcall RecalculatePartyMonStats
	; return whether nature is not neutral
	ld a, [wMintTeaLikedFlavor]
	ld b, a
	ld a, [wMintTeaDislikedFlavor]
	sub b
	ldh [hScriptVar], a
	ret
