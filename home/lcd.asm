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
	cp PIANO_ROLL_HEIGHT_PX - 1
	jr nc, .done

	push hl
	push de

	ld l, a
	add SCREEN_HEIGHT - 1
	ld [oamSprite00YCoord], a
	ld [oamSprite01YCoord], a
	ld [oamSprite02YCoord], a

	ldh a, [hMPState]
	add l
	ld e, a
	ld d, 0
	ld hl, wMPNotes
	add hl, de
	add hl, de
	add hl, de

	ld a, [hli]
	ld [oamSprite00XCoord], a
	ld a, [hli]
	ld [oamSprite01XCoord], a
	ld a, [hl]
	ld [oamSprite02XCoord], a

	pop de
	pop hl
	pop af
	reti
.done
	; this ideally runs once but there's no harm letting it run
	; for the remaining blanks
	ldh a, [hNextMPState]
	ldh [hMPState], a
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

; Heal machine ball palette HBlank swap handlers
; These swap OBJ palettes 0-5 mid-frame so the pokeballs can have
; per-ball colors without conflicting with player/NPC palettes below.

LCDHealMachineSwapPals::
; Triggered by LYC before the ball area.
; Writes ball palettes from wHealBallPalBuffer to OBJ palette HW regs 0-5.
; Then sets LYC to the restore line.
; First check if this is actually a LYC match, since Mode 0 STAT fires every HBlank.
	ldh a, [rSTAT]
	bit B_STAT_LYCF, a
	jp z, LCDGeneric ; not a LYC match, do normal per-scanline behavior

	push hl
	push bc
	push de

	ldh a, [rWBK]
	push af
	ld a, BANK(wHealBallPalBuffer)
	ldh [rWBK], a

	; Set OCPS to auto-increment starting at palette 0
	ld a, OBPI_AUTOINC
	ldh [rOBPI], a
	ld hl, wHealBallPalBuffer
	ld c, LOW(rOBPD)
	ld b, 6 ; 6 palettes to write
.swap_loop:
	; Wait for HBlank (mode 0) before writing each palette
.swap_wait_hblank:
	ldh a, [rSTAT]
	and 3
	jr nz, .swap_wait_hblank
	; Write 1 palette = 8 bytes (safe in HBlank + Mode 2 of next line)
rept 8
	ld a, [hli]
	ldh [c], a
endr
	dec b
	jr nz, .swap_loop

	; Set LYC to restore line and switch handler
	ld a, HEAL_BALL_PAL_RESTORE_LINE
	ldh [rLYC], a
	ld a, LOW(LCDHealMachineRestorePals)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDHealMachineRestorePals)
	ldh [hFunctionTargetHi], a

	pop af
	ldh [rWBK], a
	pop de
	pop bc
	pop hl
	pop af
	reti

LCDHealMachineRestorePals::
; Triggered by LYC after the ball area.
; Restores original OBJ palettes 0-5 from wHealOrigPalBuffer.
; Then sets LYC back to the swap line for the next frame.
; First check if this is actually a LYC match.
	ldh a, [rSTAT]
	bit B_STAT_LYCF, a
	jp z, LCDGeneric ; not a LYC match, do normal per-scanline behavior

	push hl
	push bc
	push de

	ldh a, [rWBK]
	push af
	ld a, BANK(wHealOrigPalBuffer)
	ldh [rWBK], a

	; Set OCPS to auto-increment starting at palette 0
	ld a, OBPI_AUTOINC
	ldh [rOBPI], a
	ld hl, wHealOrigPalBuffer
	ld c, LOW(rOBPD)
	ld b, 6 ; 6 palettes to restore
.restore_loop:
	; Wait for HBlank (mode 0)
.restore_wait_hblank:
	ldh a, [rSTAT]
	and 3
	jr nz, .restore_wait_hblank
	; Write 1 palette = 8 bytes
rept 8
	ld a, [hli]
	ldh [c], a
endr
	dec b
	jr nz, .restore_loop

	; Set LYC back to swap line and switch handler
	ld a, HEAL_BALL_PAL_SWAP_LINE
	ldh [rLYC], a
	ld a, LOW(LCDHealMachineSwapPals)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDHealMachineSwapPals)
	ldh [hFunctionTargetHi], a

	pop af
	ldh [rWBK], a
	pop de
	pop bc
	pop hl
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
