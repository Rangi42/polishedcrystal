MainMenu: ; 49cdc
	call DeleteSavedMusic
	xor a
	ld [wDisableTextAcceleration], a
	call Function49ed0
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call SetPalettes
	ld hl, GameTimerPause
	res 0, [hl]
	call MainMenu_GetWhichMenu
	ld [wWhichIndexSet], a
	call MainMenu_PrintCurrentTimeAndDay
	ld hl, .MenuDataHeader
	call LoadMenuDataHeader
	call MainMenuJoypadLoop
	call CloseWindow
	ret c
	call ClearTileMap
	ld a, [MenuSelection]
	ld hl, .Jumptable
	rst JumpTable
	jr MainMenu
; 49d14

.MenuDataHeader: ; 49d14
	db $40 ; flags
	db 00, 00 ; start coords
	db 07, 16 ; end coords
	dw .MenuData2
	db 1 ; default option
; 49d1c

.MenuData2: ; 49d1c
	db $80 ; flags
	db 0 ; items
	dw MainMenuItems
	dw PlaceMenuStrings
	dw .Strings
; 49d20

.Strings: ; 49d24
	db "Continue@"
	db "New Game@"
	db "New Game+@"
	db "Options@"
	db "Music Player@"

.Jumptable: ; 0x49d60
	dw MainMenu_Continue
	dw MainMenu_NewGame
	dw MainMenu_NewGamePlus
	dw MainMenu_Options
	dw MainMenu_MusicPlayer
; 0x49d6c

CONTINUE       EQU 0
NEW_GAME       EQU 1
NEW_GAME_PLUS  EQU 2
OPTION         EQU 3
MUSIC_PLAYER   EQU 4

MainMenuItems:
; .NewGameMenu: ; 0x49d6c
	db 3
	db NEW_GAME
	db OPTION
	db MUSIC_PLAYER
	db -1
; .ContinueMenu: ; 0x49d70
	db 4
	db CONTINUE
	db NEW_GAME
	db OPTION
	db MUSIC_PLAYER
	db -1
; .NewGamePlusMenu:
	db 5
	db CONTINUE
	db NEW_GAME
	db NEW_GAME_PLUS
	db OPTION
	db MUSIC_PLAYER
	db -1

MainMenu_GetWhichMenu: ; 49da4
	ld a, [wSaveFileExists]
	and a
	jr nz, .next
	xor a ; New Game
	ret

.next
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + (EventFlags + (EVENT_BEAT_LEAF >> 3)) - wPlayerData
	ld de, EventFlags + (EVENT_BEAT_LEAF >> 3)
	ld a, [hl]
	ld [de], a
	call CloseSRAM
	eventflagcheck EVENT_BEAT_LEAF
	jr nz, .next2
	ld a, $1 ; Continue
	ret

.next2
	ld a, $2 ; New Game+
	ret
; 49de4

MainMenuJoypadLoop: ; 49de4
	call SetUpMenu
.loop
	call MainMenu_PrintCurrentTimeAndDay
	ld a, [w2DMenuFlags1]
	set 5, a
	ld [w2DMenuFlags1], a
	call GetScrollingMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_button
	cp A_BUTTON
	jr z, .a_button
	jr .loop

.a_button
	call PlayClickSFX
	and a
	ret

.b_button
	scf
	ret
; 49e09

MainMenu_PrintCurrentTimeAndDay: ; 49e09
	ld a, [wSaveFileExists]
	and a
	ret z
	xor a
	ld [hBGMapMode], a
	call .PlaceBox
	ld hl, Options1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .PlaceTime
	pop af
	ld [Options1], a
	ld a, $1
	ld [hBGMapMode], a
	ret
; 49e27


.PlaceBox: ; 49e27
	call CheckRTCStatus
	and $80
	jr nz, .TimeFail
	hlcoord 0, 14
	lb bc, 2, 18
	jp TextBox

.TimeFail:
	jp SpeechTextBox
; 49e3d

.PlaceTime: ; 49e3d
	ld a, [wSaveFileExists]
	and a
	ret z
	call CheckRTCStatus
	and $80
	jp nz, .PrintTimeNotSet

;; kroc - NoRTC patch
;; to get the main menu to show the correct time of the save,
;; we need to pull the backed-up RTC time from the save file
if DEF(NO_RTC)
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + wNoRTC - wPlayerData
	ld de, wNoRTC
	ld bc, 5
	call CopyBytes
	call CloseSRAM
endc

	call UpdateTime
	call GetWeekday
	ld b, a
	decoord 1, 15
	call .PlaceCurrentDay
	decoord 4, 16
	ld a, [hHours]
	ld c, a
	farcall PrintHour
	ld [hl], ":"
	inc hl
	ld de, hMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jp PrintNum
; 49e75

.PrintTimeNotSet: ; 49e75
	hlcoord 1, 14
	ld de, .TimeNotSet
	jp PlaceString
; 49e7f

.TimeNotSet: ; 49e7f
	db "Time not set@"
; 49e8c

.PlaceCurrentDay: ; 49e91
	push de
	ld hl, .Days
	ld a, b
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	jp PlaceString
; 49ea8

.Days:
	db "Sun@"
	db "Mon@"
	db "Tues@"
	db "Wednes@"
	db "Thurs@"
	db "Fri@"
	db "Satur@"
.Day:
	db "day@"
; 49ed0

Function49ed0: ; 49ed0
	xor a
	ld [hMapAnims], a
	call ClearTileMap
	call LoadFontsExtra
	call LoadStandardFont
	jp ClearWindowData
; 49ee0


MainMenu_NewGame: ; 49ee0
	farjp NewGame
; 49ee7

MainMenu_NewGamePlus:
	farjp NewGamePlus

MainMenu_Options: ; 49ee7
	farjp OptionsMenu
; 49eee

MainMenu_Continue: ; 49eee
	farjp Continue
; 49ef5

MainMenu_MusicPlayer:
	farjp MusicPlayer
