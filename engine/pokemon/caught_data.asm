CheckPartyFullAfterContest:
	ld a, [wContestMon]
	and a
	jmp z, .DidntCatchAnything
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld a, [wContestMonForm]
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld hl, wPartyCount
	ld a, [hl]
	cp 6
	jr nc, .TryAddToBox
	inc [hl]
	ld [wCurPartyMon], a
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld d, h
	ld e, l
	ld hl, wContestMon
	ld a, [hl]
	ld [wCurSpecies], a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	rst CopyBytes
	call GetPartyPokemonName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call GiveANickname_YesNo
	jr c, .Party_SkipNickname
	xor a
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	farcall InitNickname

.Party_SkipNickname:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wMonOrItemNameBuffer
	rst CopyBytes
	ld a, MON_LEVEL
	call GetPartyParamLocationAndValue
	ld [wCurPartyLevel], a
	xor a ; PARK_BALL
	ld [wCurItem], a
	call SetCaughtData
	ld a, MON_CAUGHTLOCATION
	call GetPartyParamLocationAndValue
	ld [hl], NATIONAL_PARK
	xor a
	ld [wContestMon], a
	ldh [hScriptVar], a
	ret

.TryAddToBox:
	farcall NewStorageBoxPointer
	jr c, .BoxFull
	push bc
	xor a
	ld [wCurPartyMon], a
	ld hl, wContestMon
	ld de, wTempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ld hl, wPlayerName
	ld de, wTempMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes
	pop bc
	ld a, b
	ld [wTempMonBox], a
	ld a, c
	ld [wTempMonSlot], a
	farcall UpdateStorageBoxMonFromTemp
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	call GiveANickname_YesNo
	ld hl, wStringBuffer1
	jr c, .Box_SkipNickname
	ld a, TEMPMON
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	farcall InitNickname
	ld hl, wMonOrItemNameBuffer

.Box_SkipNickname:
	ld de, wTempMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	farcall UpdateStorageBoxMonFromTemp

.BoxFull:
	ld a, [wTempMonLevel]
	ld [wCurPartyLevel], a
	xor a ; PARK_BALL
	ld [wCurItem], a
	call SetBoxMonCaughtData
	ld hl, wTempMonCaughtLocation
	ld [hl], NATIONAL_PARK
	farcall UpdateStorageBoxMonFromTemp
	xor a
	ld [wContestMon], a
	ld a, $1
	ldh [hScriptVar], a
	ret

.DidntCatchAnything:
	ld a, $2
	ldh [hScriptVar], a
	ret

GiveANickname_YesNo:
	ld hl, TextJump_GiveANickname
	call PrintText
	jmp YesNoBox

TextJump_GiveANickname:
	; Give a nickname to the @  you received?
	text_far _CaughtAskNicknameText
	text_end

SetCaughtData:
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1CaughtData
	call GetPartyLocation
SetBoxmonOrEggmonCaughtData:
	; CaughtTime
	ld a, [wTimeOfDay]
	inc a
	rrca
	rrca
	rrca
	and CAUGHT_TIME_MASK
	ld b, a
	; CaughtBall
	ld a, [wCurItem]
	and CAUGHT_BALL_MASK
	or b
	ld [hli], a
	; CaughtLevel
	ld a, [wCurPartyLevel]
	ld [hli], a
	; CaughtLocation
	call GetCurrentLandmark
	ld [hl], a
	ret

SetBoxMonCaughtData:
	ld hl, wTempMonCaughtData
	call SetBoxmonOrEggmonCaughtData
	farjp UpdateStorageBoxMonFromTemp

SetGiftPartyMonCaughtData:
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1CaughtData
	call GetPartyLocation
SetGiftMonCaughtData:
	; CaughtTime
	ld a, [wTimeOfDay]
	inc a
	rrca
	rrca
	rrca
	and CAUGHT_TIME_MASK ; no-optimize a = (a & MASK) | (b|c|d|e|h|l & ~MASK) (false detection)
	ld b, a
	; CaughtBall
	; c contains it
	ld a, c
	and CAUGHT_BALL_MASK
	or b
	ld [hli], a
	; CaughtLevel
	; Met in a trade
	xor a
	ld [hli], a
	; CaughtLocation
	; Unknown location
	ld [hl], a
	ret

SetEggMonCaughtData:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1CaughtData
	call GetPartyLocation
	ld a, [wCurPartyLevel]
	push af
	ld a, -1 ; marks that the mon is hatched
	ld [wCurPartyLevel], a
	ld a, [hl] ; reused poke ball data
	ld [wCurItem], a
	call SetBoxmonOrEggmonCaughtData
	pop af
	ld [wCurPartyLevel], a
	ret
