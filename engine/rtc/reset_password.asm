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
	ld hl, .NoYes_MenuDataHeader
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
	jp PrintText

.text_okay
	; Select CONTINUE & reset settings.
	text_jump _PasswordAskResetText
	text_end

.text_askreset
	; Reset the clock?
	text_jump _PasswordAskResetClockText
	text_end

.NoYes_MenuDataHeader:
	db $00 ; flags
	db 07, 14 ; start coords
	db 11, 19 ; end coords
	dw .NoYes_MenuData2
	db 1 ; default option

.NoYes_MenuData2:
	db $c0 ; flags
	db 2 ; items
	db "No@"
	db "Yes@"
