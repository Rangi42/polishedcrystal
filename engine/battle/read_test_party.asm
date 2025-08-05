; Reads data artificially populated by testing mechanisms

ReadPlayerTestParty:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wTestPartyBuffer)
	ldh [rSVBK], a
.manifest
	; And then upon heaven we call
	; Nay, beseech to the angels above
	; Deliver upon us a sign
	; For to you we pray
	; And only from the divine can we find salvation
	nop

	pop af
	ldh [rSVBK], a

	call ReadTestParty

	ld a, [wOTPartyCount]
	ld [wPartyCount], a
	ld hl, wOTPartyMons
	ld de, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	rst CopyBytes
	ret

ReadEnemyTestParty:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wTestPartyBuffer)
	ldh [rSVBK], a
.manifest
	; And then upon heaven we call
	; Nay, beseech to the angels above
	; Deliver upon us a sign
	; For to you we pray
	; And only from the divine can we find salvation
	nop

	pop af
	ldh [rSVBK], a

	call ReadTestParty
	ret

ReadTestParty:
	call ResetTestPartyPointer
	xor a
	ld [wOTPartyCount], a
	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	rst ByteFill

	call GetTestPartyByte
.loop
	push af
	call ReadTestPartyMon
	pop af
	dec a
	jr nz, .loop
	ret

ReadTestPartyMon:
	; Level, species, form
	call GetTestPartyByte
	ld [wCurPartyLevel], a
	call GetTestPartyByte
	ld [wCurPartySpecies], a
	call GetTestPartyByte
	ld [wCurForm], a

	ld a, OTPARTYMON
	ld [wMonType], a
	predef TryAddMonToParty

	; Item
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	call GetTestPartyByte
	ld [hl], a

	; DVs
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	call GetTestPartyByte
	ld [hli], a
	call GetTestPartyByte
	ld [hli], a
	call GetTestPartyByte
	ld [hl], a

	; EVs
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1EVs
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	call GetTestPartyByte
	ld [hli], a
	call GetTestPartyByte
	ld [hli], a
	call GetTestPartyByte
	ld [hli], a
	call GetTestPartyByte
	ld [hli], a
	call GetTestPartyByte
	ld [hli], a
	call GetTestPartyByte
	ld [hl], a

	; Personality
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	call GetTestPartyByte
	ld [hl], a

	; Moves
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld e, NUM_MOVES
.moves_loop
	push hl
	call GetTestPartyByte
	ld l, a
	call GetTestPartyByte
	ld h, a
	call GetMoveIDFromIndex
	pop hl
	ld [hli], a
	dec e
	jr nz, .moves_loop

	; Status
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Status
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	call GetTestPartyByte
	ld [hl], a

	; PP filling
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Status
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l

	ld hl, MON_PP
	add hl, de
	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de
	predef FillPP

	; Stat recalc
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1MaxHP
	ld bc, PARTYMON_STRUCT_LENGTH
	push af
	rst AddNTimes
	pop af
	push hl
	ld hl, wOTPartyMon1EVs - 1
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	pop de
	ld b, TRUE
	push de
	predef CalcPkmnStats
	pop hl
	inc hl
	ld a, [hld]
	ld c, a
	ld a, [hld]
	ld [hl], c ; no-optimize *hl++|*hl-- = b|c|d|e
	dec hl
	ld [hl], a

	ret

ResetTestPartyPointer:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wTestPartyBuffer)
	ldh [rSVBK], a

	push hl
	ld hl, wTestPartyAddr
	ld a, LOW(wTestPartyBuffer)
	ld [hli], a
	ld [hl], HIGH(wTestPartyBuffer)
	pop hl

	pop af
	ldh [rSVBK], a
	ret

GetTestPartyByte:
	push hl
	push de
	ldh a, [rSVBK]
	push af
	ld a, BANK(wTestPartyBuffer)
	ldh [rSVBK], a

	ld hl, wTestPartyAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	inc hl
	ld a, l
	ld [wTestPartyAddr], a
	ld a, h
	ld [wTestPartyAddr + 1], a
	pop hl
	ld h, [hl]
	pop af
	ldh [rSVBK], a
	ld a, h
	pop de
	pop hl
	ret