_DeleteSaveData:
	farcall BlankScreen
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .Text_ClearAllSaveData
	call PrintText
	ld hl, NoYesMenuDataHeader
	call CopyMenuHeader
	call VerticalMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	ret z

	xor a
	call .EmptyBank
	ld a, 1
	call .EmptyBank
	ld a, 2
	call .EmptyBank
	ld a, 3
.EmptyBank:
	call GetSRAMBank
	ld hl, SRAM_Begin
	ld bc, SRAM_End - SRAM_Begin
	xor a
	rst ByteFill
	jmp CloseSRAM

.Text_ClearAllSaveData:
	; Clear all save data?
	text_far _ClearAllSaveDataText
	text_end

_ResetInitialOptions:
	farcall BlankScreen
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .Text_ResetInitialOptions
	call PrintText
	ld hl, NoYesMenuDataHeader
	call CopyMenuHeader
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
	ld [sOptions + wInitialOptions2 - wOptions], a ; sInitialOptions2
	jmp CloseSRAM

.Text_ResetInitialOptions:
	; Reset the initial game options?
	text_far ResetInitialOptionsText
	text_end
