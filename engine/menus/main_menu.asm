MainMenu:
	call DeleteSavedMusic
	farcall NewGame_ClearTileMapEtc
	ld a, CGB_PLAIN
	call GetCGBLayout
	call SetDefaultBGPAndOBP
	xor a ; FALSE
	ld [wGameTimerPaused], a
	call MainMenu_GetWhichMenu
	ld [wWhichIndexSet], a
	call MainMenu_PrintCurrentTimeAndDay
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	call MainMenuJoypadLoop
	call CloseWindow
	ret c
	ld a, "<BLACK>"
	call FillTileMap
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	call JumpTable
	jr MainMenu

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 16, 7
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 0 ; items
	dw MainMenuItems
	dw PlaceMenuStrings
	dw .Strings

.Strings:
	db "Continue@"
	db "New Game@"
	db "New Game+@"
	db "Options@"
	db "Music Player@"

.Jumptable:
	dw MainMenu_Continue
	dw MainMenu_NewGame
	dw MainMenu_NewGamePlus
	dw MainMenu_Options
	dw MainMenu_MusicPlayer

	const_def
	const MAINMENU_ITEM_CONTINUE      ; 0
	const MAINMENU_ITEM_NEW_GAME      ; 1
	const MAINMENU_ITEM_NEW_GAME_PLUS ; 2
	const MAINMENU_ITEM_OPTION        ; 3
	const MAINMENU_ITEM_MUSIC_PLAYER  ; 4

MainMenuItems:
; MAINMENU_MENU_NEW_GAME
	db 3
	db MAINMENU_ITEM_NEW_GAME
	db MAINMENU_ITEM_OPTION
	db MAINMENU_ITEM_MUSIC_PLAYER
	db -1
; MAINMENU_MENU_CONTINUE
	db 4
	db MAINMENU_ITEM_CONTINUE
	db MAINMENU_ITEM_NEW_GAME
	db MAINMENU_ITEM_OPTION
	db MAINMENU_ITEM_MUSIC_PLAYER
	db -1
; MAINMENU_MENU_NEW_GAME_PLUS
	db 5
	db MAINMENU_ITEM_CONTINUE
	db MAINMENU_ITEM_NEW_GAME
	db MAINMENU_ITEM_NEW_GAME_PLUS
	db MAINMENU_ITEM_OPTION
	db MAINMENU_ITEM_MUSIC_PLAYER
	db -1

	const_def
	const MAINMENU_MENU_NEW_GAME      ; 0
	const MAINMENU_MENU_CONTINUE      ; 1
	const MAINMENU_MENU_NEW_GAME_PLUS ; 2

MainMenu_GetWhichMenu:
	ld a, [wSaveFileExists]
	and a
	ld a, MAINMENU_MENU_NEW_GAME
	ret z

	ld a, BANK(sPlayerData)
	call GetSRAMBank

	flagcheck sPlayerData - wPlayerData + wEventFlags, EVENT_BEAT_LEAF
	ld a, MAINMENU_MENU_NEW_GAME_PLUS
	jr nz, .done

	assert MAINMENU_MENU_NEW_GAME_PLUS - 1 == MAINMENU_MENU_CONTINUE
	dec a ; MAINMENU_MENU_CONTINUE
.done
	jmp CloseSRAM

MainMenuJoypadLoop:
	call SetUpMenu
.loop
	call MainMenu_PrintCurrentTimeAndDay
	ld a, [w2DMenuFlags1]
	set 5, a
	ld [w2DMenuFlags1], a
	call ReadMenuJoypad
	ld a, [wMenuJoypad]
	cp PAD_B
	jr z, .b_button
	cp PAD_A
	jr nz, .loop

.a_button
	call PlayClickSFX
	and a
	ret

.b_button
	scf
	ret

MainMenu_PrintCurrentTimeAndDay:
	ld a, [wSaveFileExists]
	and a
	ret z
	xor a
	ldh [hBGMapMode], a
	call .PlaceBox
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .PlaceTime
	pop af
	ld [wOptions1], a
	ld a, $1
	ldh [hBGMapMode], a
	ret

.PlaceBox:
	call CheckRTCStatus
	and $80
	jmp nz, SpeechTextbox
	hlcoord 0, 14
	lb bc, 2, 18
	jmp Textbox

.PlaceTime:
	ld a, [wSaveFileExists]
	and a
	ret z
	call CheckRTCStatus
	and $80
	jr nz, .PrintTimeNotSet

;; kroc - NoRTC patch
;; to get the main menu to show the correct time of the save,
;; we need to pull the backed-up RTC time from the save file
	ld a, [wInitialOptions2]
	and 1 << RTC_OPT
	jr nz, .using_rtc
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + wRTCDayHi - wPlayerData
	ld de, wRTCDayHi
	ld bc, 5
	rst CopyBytes
	call CloseSRAM
.using_rtc

	call UpdateTime
	bccoord 1, 15
	call TextCommand_DAY
	decoord 4, 16
	ldh a, [hHours]
	ld c, a
	farcall PrintHour
	ld a, ":"
	ld [hli], a
	ld de, hMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jmp PrintNum

.PrintTimeNotSet:
	hlcoord 1, 14
	ld de, .TimeNotSet
	rst PlaceString
	ret

.TimeNotSet:
	db "Time not set@"

MainMenu_NewGame:
	farjp NewGame

MainMenu_NewGamePlus:
	farjp NewGamePlus

MainMenu_Options:
	farjp OptionsMenu

MainMenu_Continue:
	farjp Continue

MainMenu_MusicPlayer:
	farjp MusicPlayer
