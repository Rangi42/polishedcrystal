HealParty:
	ld a, [wPartyCount]
	ld c, a
	xor a
.loop
	cp c
	ret z
	ld [wCurPartyMon], a
	push bc
	ld a, MON_IS_EGG
	call GetPartyParamLocationAndValue
	bit MON_IS_EGG_F, a
	call z, HealPartyMon
	pop bc
	ld a, [wCurPartyMon]
	inc a
	jr .loop

HealPartyMon:
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld d, h
	ld e, l

	ld hl, MON_STATUS
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a

	ld hl, MON_MAXHP
	add hl, de

	; bc = MON_HP
	ld b, h
	ld c, l
	dec bc
	dec bc

	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	ld [bc], a

	jmp RestoreAllPP

ComputeHPBarPixels:
; e = bc * (6 * 8) / de
	ld a, b
	or c
	jr z, .zero
	push hl
	xor a
	ldh [hMultiplicand + 0], a
	ld a, b
	ldh [hMultiplicand + 1], a
	ld a, c
	ldh [hMultiplicand + 2], a
	ld a, 6 * 8
	ldh [hMultiplier], a
	farcall Multiply
	; We need de to be under 256 because hDivisor is only 1 byte.
	ld a, d
	and a
	jr z, .divide
	; divide de and hProduct by 4
	srl d
	rr e
	srl d
	rr e
	ldh a, [hProduct + 1]
	srl a ; get the 17th bit into the carry bit
	ldh [hProduct + 1], a
	ldh a, [hProduct + 2]
	ld b, a
	ldh a, [hProduct + 3]
	rr b
	rra
	srl b
	rra
	ldh [hDividend + 3], a
	ld a, b
	ldh [hDividend + 2], a
.divide
	ld a, e
	ldh [hDivisor], a
	ld b, 4
	farcall Divide
	ldh a, [hQuotient + 2]
	ld e, a
	pop hl
	and a
	ret nz
	ld e, 1
	ret

.zero
	ld e, 0
	ret
