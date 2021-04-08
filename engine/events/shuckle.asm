ReturnShuckie:
	farcall SelectMonFromParty
	jr c, .refused

	ld a, [wCurPartySpecies]
	cp SHUCKLE
	jr nz, .DontReturn

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

; OT ID
	ld a, [hli]
	cp HIGH(KIRK_SHUCKIE_ID)
	jr nz, .DontReturn
	ld a, [hl]
	cp LOW(KIRK_SHUCKIE_ID)
	jr nz, .DontReturn

; OT
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	call SkipNames
	ld de, SpecialShuckleOTAndExtra
.CheckOT:
	ld a, [de]
	cp [hl]
	jr nz, .DontReturn
	cp "@"
	jr z, .done
	inc de
	inc hl
	jr .CheckOT

.done
	farcall CheckCurPartyMonFainted
	jr c, .fainted
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	cp 150
	ld a, $3
	jr nc, .HappyToStayWithYou
	predef RemoveMonFromParty
	ld a, $2
.HappyToStayWithYou:
	ldh [hScriptVar], a
	ret

.refused
	ld a, $1
	ldh [hScriptVar], a
	ret

.DontReturn:
	xor a
	ldh [hScriptVar], a
	ret

.fainted
	ld a, $4
	ldh [hScriptVar], a
	ret

SpecialShuckleOTAndExtra:
	rawchar "Kirk@@@@"
	db 0, 0, 0
