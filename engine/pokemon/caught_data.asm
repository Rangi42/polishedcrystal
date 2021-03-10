CheckPartyFullAfterContest:
	ld a, [wContestMon]
	and a
	jp z, .DidntCatchAnything
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld a, [wContestMonForm]
	and BASEMON_MASK
	ld [wCurForm], a
	call GetBaseData
	ld hl, wPartyCount
	ld a, [hl]
	cp 6
	jp nc, .TryAddToBox
	inc a
	ld [hl], a
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [wContestMon]
	ld [hli], a
	ld [wCurSpecies], a
	ld [hl], $ff
	ld hl, wPartyMon1Species
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, wContestMon
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonOT
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	rst CopyBytes
	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call GiveANickname_YesNo
	jr c, .Party_SkipNickname
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	xor a
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	farcall InitNickname

.Party_SkipNickname:
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wMonOrItemNameBuffer
	rst CopyBytes
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Level
	call GetPartyLocation
	ld a, [hl]
	ld [wCurPartyLevel], a
	xor a ; PARK_BALL
	ld [wCurItem], a
	call SetCaughtData
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1CaughtLocation
	call GetPartyLocation
	ld [hl], NATIONAL_PARK
	xor a
	ld [wContestMon], a
	ldh [hScriptVar], a
	ret

.TryAddToBox:
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld hl, sBoxCount
	ld a, [hl]
	cp MONS_PER_BOX
	call CloseSRAM
	jr nc, .BoxFull
	xor a
	ld [wCurPartyMon], a
	ld hl, wContestMon
	ld de, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	rst CopyBytes
	ld hl, wPlayerName
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH
	rst CopyBytes
	farcall InsertPokemonIntoBox
	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName
	call GiveANickname_YesNo
	ld hl, wStringBuffer1
	jr c, .Box_SkipNickname
	ld a, BOXMON
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	farcall InitNickname
	ld hl, wMonOrItemNameBuffer

.Box_SkipNickname:
	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank
	ld de, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	call CloseSRAM

.BoxFull:
	ld a, BANK(sBoxMon1Level)
	call GetSRAMBank
	ld a, [sBoxMon1Level]
	ld [wCurPartyLevel], a
	call CloseSRAM
	xor a ; PARK_BALL
	ld [wCurItem], a
	call SetBoxMonCaughtData
	ld a, BANK(sBoxMon1CaughtLocation)
	call GetSRAMBank
	ld hl, sBoxMon1CaughtLocation
	ld [hl], NATIONAL_PARK
	call CloseSRAM
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
	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .AlwaysNickname
	ld hl, TextJump_GiveANickname
	call PrintText
	jp YesNoBox

.AlwaysNickname:
	ld a, TRUE
	and a
	ret

TextJump_GiveANickname:
	; Give a nickname to the @  you received?
	text_jump _CaughtAskNicknameText
	text_end

SetCaughtData:
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1CaughtData
	call GetPartyLocation
SetBoxmonOrEggmonCaughtData:
	; CaughtGender
	ld a, [wPlayerGender]
	and a
	assert !MALE
	jr z, .ok
	ld a, FEMALE
.ok
	ld b, a
	; CaughtTime
	ld a, [wTimeOfDay]
	inc a
	rrca
	rrca
	rrca
	and CAUGHTTIME_MASK
	or b
	ld b, a
	; CaughtBall
	ld a, [wCurItem]
	and CAUGHTBALL_MASK
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
	ld a, BANK(sBoxMon1CaughtData)
	call GetSRAMBank
	ld hl, sBoxMon1CaughtData
	call SetBoxmonOrEggmonCaughtData
	jp CloseSRAM

SetGiftBoxMonCaughtData:
	push bc
	ld a, BANK(sBoxMon1CaughtData)
	call GetSRAMBank
	ld hl, sBoxMon1CaughtData
	pop bc
	call SetGiftMonCaughtData
	jp CloseSRAM

SetGiftPartyMonCaughtData:
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1CaughtData
	call GetPartyLocation
SetGiftMonCaughtData:
	; CaughtGender
	; b contains it
	; CaughtTime
	ld a, [wTimeOfDay]
	inc a
	rrca
	rrca
	rrca
	and CAUGHTTIME_MASK
	or b
	ld b, a
	; CaughtBall
	; c contains it
	ld a, c
	and CAUGHTBALL_MASK
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
	ld a, EGG_LEVEL
	ld [wCurPartyLevel], a
	ld a, POKE_BALL
	ld [wCurItem], a
	call SetBoxmonOrEggmonCaughtData
	pop af
	ld [wCurPartyLevel], a
	ret
