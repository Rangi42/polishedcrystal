BattleIntroSlidingPics:
	ld hl, rIE
	set LCD_STAT, [hl]
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	call .subfunction1
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	call .subfunction2
	xor a
	ldh [hLCDCPointer], a
	pop af
	ldh [rSVBK], a
	ld hl, rIE
	res LCD_STAT, [hl]
	ret

.subfunction1
	call .subfunction4
	ld a, $90
	ldh [hSCX], a
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	jmp DmgToCgbObjPals

.subfunction2
	lb de, $90, $72
	ld a, $48 + 1
.loop1
	push af
.loop2
	ldh a, [rLY]
	cp $60
	jr c, .loop2
	ld a, d
	ldh [hSCX], a
	call .subfunction5
	inc e
	inc e
	dec d
	dec d
	pop af
	push af
	cp $1
	jr z, .skip1
	push de
	call .subfunction3
	pop de

.skip1
	call DelayFrame
	pop af
	dec a
	jr nz, .loop1
	ret

.subfunction3
	ld hl, wVirtualOAM + 1 ; x pixel
	ld c, $12 ; 18
	ld de, $4
.loop3
	dec [hl]
	dec [hl]
	add hl, de
	dec c
	jr nz, .loop3
	ret

.subfunction4
	ld hl, wLYOverrides
	ld a, $90
	ld bc, SCREEN_HEIGHT_PX
	rst ByteFill
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
	ld c, $22 ; 34
.loop5
	ld [hli], a
	dec c
	jr nz, .loop5
	xor a
	ld c, $30 ; 48
.loop6
	ld [hli], a
	dec c
	jr nz, .loop6
	ret
