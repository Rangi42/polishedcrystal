ResetClock_GetWraparoundTime:
	push hl
	dec a
	ld e, a
	ld d, 0
	ld hl, .WrapAroundTimes
rept 4
	add hl, de
endr
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld b, a
	ld c, [hl]
	pop hl
	ret

.WrapAroundTimes:
	dw wRestartClockDay
	db 7, 4

	dw wRestartClockHour
	db 24, 12

	dw wRestartClockMin
	db 60, 15

RestartClock:
; If we're here, we had an RTC overflow.
	ld hl, .Text_ClockTimeMayBeWrong
	call PrintText
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call LoadStandardMenuHeader
	ld a, '<BLACK>'
	call FillTileMap
	ld hl, .Text_SetWithControlPad
	call PrintText
	call .SetClock
	call ExitMenu
	pop bc
	ld hl, wOptions1
	ld [hl], b
	ld c, a
	ret

.Text_ClockTimeMayBeWrong:
	; The clock's time may be wrong. Please reset the time.
	text_far _ClockTimeMayBeWrongText
	text_end

.Text_SetWithControlPad:
	; Set with the Control Pad. Confirm: A Button Cancel:  B Button
	text_far _ClockSetWithControlPadText
	text_end

.SetClock:
	ld a, 1
	ld [wRestartClockCurDivision], a ; which digit
	ld [wRestartClockPrevDivision], a
	ld a, 8
	ld [wRestartClockUpArrowYCoord], a
	call UpdateTime
	call GetWeekday
	ld [wRestartClockDay], a
	ldh a, [hHours]
	ld [wRestartClockHour], a
	ldh a, [hMinutes]
	ld [wRestartClockMin], a

.loop
	call .joy_loop
	jr nc, .loop
	and a
	ret nz
	call .PrintTime
	ld hl, .Text_IsThisOK
	call PrintText
	call YesNoBox
	jr c, .cancel
	ld a, [wRestartClockDay]
	ld [wStringBuffer2], a
	ld a, [wRestartClockHour]
	ld [wStringBuffer2 + 1], a
	ld a, [wRestartClockMin]
	ld [wStringBuffer2 + 2], a
	xor a
	ld [wStringBuffer2 + 3], a
	call InitTime
	call .PrintTime
	ld hl, .Text_ClockReset
	call PrintText
	call WaitPressAorB_BlinkCursor
	xor a
	ret

.cancel
	ld a, $1
	ret

.Text_IsThisOK:
	; Is this OK?
	text_far _ClockIsThisOKText
	text_end

.Text_ClockReset:
	; The clock has been reset.
	text_far _ClockHasResetText
	text_end

.joy_loop
	call JoyTextDelay_ForcehJoyDown
	ld c, a
	push af
	call .PrintTime
	pop af
	bit 0, a
	jr nz, .press_A
	bit 1, a
	jr nz, .press_B
	bit 6, a
	jr nz, .pressed_up
	bit 7, a
	jr nz, .pressed_down
	bit 5, a
	jr nz, .pressed_left
	bit 4, a
	jr nz, .pressed_right
	jr .joy_loop

.press_A
	xor a
	scf
	ret

.press_B
	ld a, $1
	scf
	ret

.pressed_up
	ld a, [wRestartClockCurDivision]
	call ResetClock_GetWraparoundTime
	ld a, [de]
	inc a
	ld [de], a
	cp b
	jr c, .done_scroll
	xor a
	ld [de], a
	jr .done_scroll

.pressed_down
	ld a, [wRestartClockCurDivision]
	call ResetClock_GetWraparoundTime
	ld a, [de]
	dec a
	ld [de], a
	cp -1
	jr nz, .done_scroll
	ld a, b
	dec a
	ld [de], a
	jr .done_scroll

.pressed_left
	ld hl, wRestartClockCurDivision
	dec [hl]
	jr nz, .done_scroll
	ld [hl], $3
	jr .done_scroll

.pressed_right
	ld hl, wRestartClockCurDivision
	inc [hl]
	ld a, [hl]
	cp $4
	jr c, .done_scroll
	ld [hl], $1

.done_scroll
	xor a
	ret

.PrintTime:
	hlcoord 0, 5
	lb bc, 5, 18
	call Textbox
	bccoord 1, 8
	ld a, [wRestartClockDay]
	call PrintDayOfWeek
	ld a, [wRestartClockHour]
	ld b, a
	ld a, [wRestartClockMin]
	ld c, a
	decoord 11, 8
	farcall PrintHoursMins
	ld a, [wRestartClockPrevDivision]
	lb de, ' ', ' '
	call .PlaceChars
	ld a, [wRestartClockCurDivision]
	lb de, '▲', '▼'
	call .PlaceChars
	ld a, [wRestartClockCurDivision]
	ld [wRestartClockPrevDivision], a
	ret

.PlaceChars:
	push de
	call ResetClock_GetWraparoundTime
	ld a, [wRestartClockUpArrowYCoord]
	dec a
	ld b, a
	call Coord2Tile
	pop de
	ld [hl], d
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	ld [hl], e
	ret
