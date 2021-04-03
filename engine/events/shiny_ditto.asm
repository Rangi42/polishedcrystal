SpecialGiveShinyDitto:
; Adding to the party.
	xor a
	ld [wMonType], a

; Level 5 Ditto.
	ld a, DITTO
	ld [wCurPartySpecies], a
	ld a, 5
	ld [wCurPartyLevel], a

	predef TryAddMonToParty
	jr nc, .NotGiven

; Caught data.
	lb bc, MALE, PREMIER_BALL
	farcall SetGiftPartyMonCaughtData

; Holding an Everstone for breeding natures.
	ld hl, wPartyMon1Item
	call _GetLastPartyMonAttribute
	ld [hl], EVERSTONE

; OT ID. Guaranteed to not be the same as the player's for Masuda method breeding.
	ld hl, wPartyMon1ID + 1
	call _GetLastPartyMonAttribute
	ld a, [wPlayerID + 1]
	add %01100101
	ld [hld], a
	ld a, [wPlayerID]
	adc %10100110
	ld [hl], a

; DVs and personality.
	ld hl, wPartyMon1DVs
	call _GetLastPartyMonAttribute
; Max IVs.
rept 3
	ld a, $ff
	ld [hli], a
endr
; Shiny with hidden ability.
	ld a, SHINY_MASK | HIDDEN_ABILITY | QUIRKY
	ld [hli], a
	ld [hl], MALE

; Recalculate stats after changing DVs and Nature
	ld hl, wPartyMon1MaxHP
	call _GetLastPartyMonAttribute
	ld d, h
	ld e, l
	ld hl, wPartyMon1EVs - 1
	call _GetLastPartyMonAttribute
	ld b, TRUE
	predef CalcPkmnStats

; Nickname.
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	call SkipNames
	ld de, .Nickname
	call CopyName2

; OT and Extra.
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonOTs
	call SkipNames
	ld d, h
	ld e, l
	ld hl, .OTAndExtra
	ld bc, PLAYER_NAME_LENGTH + 3
	rst CopyBytes

	ld a, TRUE
	ldh [hScriptVar], a
	ret

.NotGiven:
	xor a ; ld a, FALSE
	ldh [hScriptVar], a
	ret

.OTAndExtra:
	rawchar "Mr.<PK><MN>@@@"
	db 0, 0, 0

.Nickname:
	rawchar "Masuda@"

_GetLastPartyMonAttribute:
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ret
