InsertPokemonIntoBox:
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld hl, sBoxCount
	call InsertSpeciesIntoBoxOrParty
	ld a, [sBoxCount]
	dec a
	ld [wd265], a
	ld hl, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	ld de, wBufferMonNickname
	call InsertDataIntoBoxOrParty
	ld a, [sBoxCount]
	dec a
	ld [wd265], a
	ld hl, sBoxMonOTs
	ld bc, NAME_LENGTH
	ld de, wBufferMonOT
	call InsertDataIntoBoxOrParty
	ld a, [sBoxCount]
	dec a
	ld [wd265], a
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	ld de, wBufferMon
	call InsertDataIntoBoxOrParty
	ld hl, wBufferMonMoves
	ld de, wTempMonMoves
	ld bc, NUM_MOVES
	rst CopyBytes
	ld hl, wBufferMonPP
	ld de, wTempMonPP
	ld bc, NUM_MOVES
	rst CopyBytes
	ld a, [wCurPartyMon]
	ld b, a
	farcall RestorePPofDepositedPokemon
	jp CloseSRAM

InsertPokemonIntoParty:
	ld hl, wPartyCount
	call InsertSpeciesIntoBoxOrParty
	ld a, [wPartyCount]
	dec a
	ld [wd265], a
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld de, wBufferMonNickname
	call InsertDataIntoBoxOrParty
	ld a, [wPartyCount]
	dec a
	ld [wd265], a
	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	ld de, wBufferMonOT
	call InsertDataIntoBoxOrParty
	ld a, [wPartyCount]
	dec a
	ld [wd265], a
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, wBufferMon
	jp InsertDataIntoBoxOrParty

InsertSpeciesIntoBoxOrParty:
	inc [hl]
	inc hl
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurPartySpecies]
	ld c, a
.loop
	ld a, [hl]
	ld [hl], c
	inc hl
	inc c
	ld c, a
	jr nz, .loop
	ret

InsertDataIntoBoxOrParty:
	push de
	push hl
	push bc
	ld a, [wd265]
	dec a
	rst AddNTimes
	push hl
	add hl, bc
	ld d, h
	ld e, l
	pop hl
.loop
	push bc
	ld a, [wd265]
	ld b, a
	ld a, [wCurPartyMon]
	cp b
	pop bc
	jr z, .insert
	push hl
	push de
	push bc
	rst CopyBytes
	pop bc
	pop de
	pop hl
	push hl
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	pop de
	ld a, [wd265]
	dec a
	ld [wd265], a
	jr .loop

.insert
	pop bc
	pop hl
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld d, h
	ld e, l
	pop hl
	rst CopyBytes
	ret
