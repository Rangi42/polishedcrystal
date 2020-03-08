_DeleteSaveData:
	farcall BlankScreen
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .Text_ClearAllSaveData
	call PrintText
	ld hl, TitleScreenNoYesMenuDataHeader
	call CopyMenuDataHeader
	call VerticalMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	ret z
	farjp EmptyAllSRAMBanks

.Text_ClearAllSaveData:
	; Clear all save data?
	text_jump UnknownText_0x1c564a
	db "@"

_ResetInitialOptions:
	farcall BlankScreen
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .Text_ResetInitialOptions
	call PrintText
	ld hl, TitleScreenNoYesMenuDataHeader
	call CopyMenuDataHeader
	call VerticalMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	ret z
	ld a, [wInitialOptions2]
	set RESET_INIT_OPTS, a
	ld [wInitialOptions2], a
	ld a, BANK(sOptions)
	call GetSRAMBank
	ld a, [wInitialOptions2]
	ld [sOptions + wInitialOptions2 - wOptions1], a ; sInitialOptions2
	jp CloseSRAM

.Text_ResetInitialOptions: ; 0x4d580
	; Reset the initial game options?
	text_jump ResetInitialOptionsText
	db "@"

TitleScreenNoYesMenuDataHeader: ; 0x4d585
	db $00 ; flags
	db 07, 14 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2: ; 0x4d58d
	db $c0 ; flags
	db 2 ; items
	db "No@"
	db "Yes@"
