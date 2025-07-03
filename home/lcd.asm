LCDGeneric::
; Unlike vanilla, it's *not* assume we're in BANK(wLYOverrides),
; since interrupts can now occur during VBlank
	ldh a, [rLY]
	cp SCREEN_HEIGHT_PX
	jr c, .continue
	xor a
.continue
	push bc
	ld c, a
	ld b, HIGH(wLYOverrides)
	ldh a, [rWBK]
	push af
	ld a, BANK(wLYOverrides)
	ldh [rWBK], a
	ld a, [bc]
	ld b, a
	ldh a, [hLCDCPointer]
	ld c, a
	ld a, b
	ldh [c], a
	pop af
	ldh [rWBK], a
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
	bit B_STAT_LYCF, a
	jr z, LCDSummaryScreenDone
	ldh a, [rSTAT]
	and 3
	jr nz, LCDSummaryScreenDone
	ld a, 200
	ldh [rWX], a
	jr LCDSummaryScreenProgress

LCDSummaryScreenShowWindow::
	ldh a, [rSTAT]
	bit B_STAT_LYCF, a
	jr z, LCDSummaryScreenDone
	ldh a, [hWX]
	ldh [rWX], a
	jr LCDSummaryScreenProgress

LCDSummaryScreenScrollBackground::
	ldh a, [rSTAT]
	bit B_STAT_LYCF, a
	jr z, LCDSummaryScreenDone
	ldh a, [rSCY]
	add 4
	ldh [rSCY], a
	; fallthrough

LCDSummaryScreenProgress::
	push hl
	push bc
	ld b, 0
	ld a, [wSummaryScreenStep]
	ld c, a
	ld hl, wSummaryScreenInterrupts
	add hl, bc
	ld a, [hli]
	inc a
	jr nz, .continue
	; return to start of list
	ld [wSummaryScreenStep], a
	ld hl, wSummaryScreenInterrupts
	ld a, [hli]
	inc a
.continue
	dec a
	ldh [rLYC], a
	ld a, [hl]
	assert SUMMARY_LCD_SHOW_WINDOW == 1
	dec a
	jr z, .show
	assert SUMMARY_LCD_SCROLL_BACKGROUND == 2
	dec a
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
	inc [hl]
	inc [hl]
	pop bc
	pop hl
LCDSummaryScreenDone::
	pop af
	reti

DisableLCD::
; Turn the LCD off

; Don't need to do anything if the LCD is already off
	ldh a, [rLCDC]
	bit B_LCDC_ENABLE, a
	ret z

	xor a
	ldh [rIF], a
	ldh a, [rIE]
	ld b, a

; Disable VBlank
	res B_IE_VBLANK, a
	ldh [rIE], a

.wait
; Wait until VBlank would normally happen
	ldh a, [rLY]
	cp LY_VBLANK
	jr c, .wait
	cp LY_VBLANK + 9
	jr z, .wait

	ldh a, [rLCDC]
	res B_LCDC_ENABLE, a
	ldh [rLCDC], a

	xor a
	ldh [rIF], a
	ld a, b
	ldh [rIE], a
	ret
