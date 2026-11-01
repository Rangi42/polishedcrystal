BattleIntroSlidingPics:
	ld a, BANK(wLYOverrides)
	call StackCallInWRAMBankA

	ld a, $90
	ldh [hSCX], a
	farcall StartUniformSCXOverrides.withCustomX

	call .subfunction1

	ld hl, rIE
	res B_IE_STAT, [hl]
	xor a
	ldh [hLCDCPointer], a
	ret

.subfunction1
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	; fallthrough

.subfunction2
	lb de, $90, $72
	ld a, $48 + 1
.loop1
	push af
.loop2
	ldh a, [rLY]
	cp $5f
	jr nz, .loop2
	ld a, d
	ldh [hSCX], a
	call .subfunction5
	inc e
	inc e
	dec d
	dec d
	pop af
	push af
	dec a
	call nz, .subfunction3
	call DelayFrame
	pop af
	dec a
	jr nz, .loop1
	ret

.subfunction3
	push de
	ld hl, wShadowOAMSprite00XCoord
	ld c, $12 ; 18
	ld de, OBJ_SIZE
.loop3
	dec [hl]
	dec [hl]
	add hl, de
	dec c
	jr nz, .loop3
	pop de
	ret

.subfunction5
	ld hl, wLYOverrides
	ld a, d
	ld c, $3e ; 62
.loop4
	ld [hli], a
	dec c
	jr nz, .loop4
	ld a, e
	ld c, $21 ; 33
.loop5
	ld [hli], a
	dec c
	jr nz, .loop5
	xor a
	ld c, $31 ; 49
.loop6
	ld [hli], a
	dec c
	jr nz, .loop6
	ret
