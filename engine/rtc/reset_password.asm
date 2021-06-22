_ResetClock:
	farcall BlankScreen
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .text_askreset
	call PrintText
	ld hl, NoYesMenuDataHeader
	call CopyMenuHeader
	call VerticalMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	ret z
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	ld a, $80
	ld [sRTCStatusFlags], a
	call CloseSRAM
	ld hl, .text_okay
	jmp PrintText

.text_okay
	; Select CONTINUE & reset settings.
	text_far _PasswordAskResetText
	text_end

.text_askreset
	; Reset the clock?
	text_far _PasswordAskResetClockText
	text_end
