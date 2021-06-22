BugContest_SetCaughtContestMon:
	ld a, [wContestMon]
	and a
	jr z, .firstcatch
	ld [wNamedObjectIndex], a
	call DisplayAlreadyCaughtText
	call DisplayCaughtContestMonStats
	call YesNoBox
	ret c

.firstcatch
	call .generatestats
	ld a, [wTempEnemyMonSpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, .caughttext
	jmp PrintText

.generatestats
	ld a, [wTempEnemyMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	ld a, [wOTPartyMon1Form]
	ld [wCurForm], a
	call GetBaseData
	xor a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wContestMon
	rst ByteFill
	xor a
	ld [wMonType], a
	ld hl, wOTPartyMon1
	ld de, wContestMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ret

.caughttext
	; Caught @ !
	text_far _ContestCaughtMonText
	text_end

DisplayAlreadyCaughtText:
	call GetPokemonName
	ld hl, .AlreadyCaughtText
	jmp PrintText

.AlreadyCaughtText:
	; You already caught a @ .
	text_far _ContestAlreadyCaughtText
	text_end
