LCDGeneric::
; At this point it's assumed we're in WRAM bank 5!
	ldh a, [rLY]
	cp SCREEN_HEIGHT_PX
	jr c, .continue
	xor a
.continue
	push bc
	ld c, a
	ld b, HIGH(wLYOverrides)
	ld a, [bc]
	ld b, a
	ldh a, [hLCDCPointer]
	ld c, a
	ld a, b
	ldh [c], a
	pop bc
	pop af
	reti

LCDMusicPlayer::
	ldh a, [rLY]
	cp PIANO_ROLL_HEIGHT_PX
	jr nc, .done

	push hl

	ld l, a
	add SCREEN_HEIGHT - 1
	ld [oamSprite00YCoord], a
	ld [oamSprite01YCoord], a
	ld [oamSprite02YCoord], a

	ldh a, [hMPState]
	inc a
	assert PIANO_ROLL_HEIGHT_PX + 1 < $80
	add l
	add a
	ld l, a
	assert wMPNotes & ((1 << 9) - 1) == 0
	adc wMPNotes >> 9 ; HIGH(wMPNotes) >> 1
	sub l
	ld h, a
	add hl, hl

	ld a, [hli]
	ld [oamSprite00XCoord], a
	ld a, [hli]
	ld [oamSprite01XCoord], a
	ld a, [hl]
	ld [oamSprite02XCoord], a
	pop hl

.done
	pop af
	reti

LCDSummaryScreenHideWindow::
	ldh a, [rSTAT]
	bit rSTAT_LYC_CMP, a
	jr z, LCDSummaryScreenDone
	ldh a, [rSTAT]
	and 3
	jr nz, LCDSummaryScreenDone
	ld a, 200
	ldh [rWX], a
	jr LCDSummaryScreenProgress

LCDSummaryScreenShowWindow::
	ldh a, [rSTAT]
	bit rSTAT_LYC_CMP, a
	jr z, LCDSummaryScreenDone
	ld a, [hWX]
	ldh [rWX], a
	jr LCDSummaryScreenProgress

LCDSummaryScreenScrollBackground::
	ldh a, [rSTAT]
	bit rSTAT_LYC_CMP, a
	jr z, LCDSummaryScreenDone
	ld a, [rSCY]
	add a, 4
	ldh [rSCY], a
	jr LCDSummaryScreenProgress

LCDSummaryScreen::
LCDSummaryScreenProgress::
	push hl
	push bc
	ld b, 0
	ld hl, wSummaryScreenStep
	ld c, [hl]
	ld hl, wSummaryScreenInterrupts
	add hl, bc
	ld a, [hli]
	inc a
	jr nz, .continue
	; return to start of list
	ld hl, wSummaryScreenStep
	ld [hl], a
	ld hl, wSummaryScreenInterrupts
	ld a, [hli]
	inc a
.continue
	dec a
	ld [rLYC], a
	ld a, [hl]
	dec a ; cp a, 1 ; SUMMARY_LCD_SHOW_WINDOW
	jr z, .show
	dec a ; cp a, 2 ; SUMMARY_LCD_SCROLL_BACKGROUND
	jr z, .nudge
	ld hl, LCDSummaryScreenHideWindow
	jr .setupNext
.show
	ld hl, LCDSummaryScreenShowWindow
	jr .setupNext
.nudge
	ld hl, LCDSummaryScreenScrollBackground
	; fallthrough
.setupNext
	ld a, l
	ldh [hFunctionTargetLo], a
	ld a, h
	ldh [hFunctionTargetHi], a

	; procede to next step
	ld hl, wSummaryScreenStep
	ld a, [hl]
	add a, 2
	ld [hl], a
	pop bc
	pop hl
LCDSummaryScreenDone::
	pop af
	reti

DisableLCD::
; Turn the LCD off

; Don't need to do anything if the LCD is already off
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z

	xor a
	ldh [rIF], a
	ldh a, [rIE]
	ld b, a

; Disable VBlank
	res VBLANK, a
	ldh [rIE], a

.wait
; Wait until VBlank would normally happen
	ldh a, [rLY]
	cp LY_VBLANK
	jr c, .wait
	cp LY_VBLANK + 9
	jr z, .wait

	ldh a, [rLCDC]
	res rLCDC_ENABLE, a
	ldh [rLCDC], a

	xor a
	ldh [rIF], a
	ld a, b
	ldh [rIE], a
	ret
