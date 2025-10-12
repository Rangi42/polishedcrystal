DEF INVER_PREFIX = 1 + STRLEN("Inver@") + 1 ; length + name + trainer flags

PickPsychicInverParty:
	ld hl, wInverIndexes
	ld c, NUM_INVER_MONS
	call ShuffleRange

	ld hl, wInverGroup
	ld de, PsychicInverGroup
	ld b, INVER_PREFIX
	call .CopyBytes

	ld c, PARTY_LENGTH
.party_loop
	; de = &PsychicInverMons[wInverIndexes[c]]
	push hl
	; de = wInverIndexes[c]
	ld a, c
	add LOW(wInverIndexes)
	ld l, a
	adc HIGH(wInverIndexes)
	sub l
	ld h, a
	ld e, [hl]
	ld d, 0
	; hl = de * 12
	ld h, d
	ld l, e
	add hl, de
	add hl, de
	add hl, hl
	add hl, hl
	; de = PsychicInverGroup + INVER_PREFIX + hl
	ld de, PsychicInverGroup + INVER_PREFIX
	add hl, de
	ld d, h
	ld e, l
	pop hl
	; copy the next mon
	ld b, 12
	call .CopyBytes
	dec c
	jr nz, .party_loop
	ret

.CopyBytes:
; copy b bytes from de to hl
.copy_loop
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .copy_loop
	ret

ShuffleRange:
; Generates shuffled array from 0 to c-1 in hl.
	push hl
	ld b, c
	xor a
.index_loop
	ld [hli], a
	inc a
	dec b
	jr nz, .index_loop
	pop hl
.shuffle_loop
	dec c
	ret z
	ld b, 0
	ld a, c
	inc a
	call RandomRange
	push hl
	push bc
	ld c, a
	push hl
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	pop hl
	jr .shuffle_loop
