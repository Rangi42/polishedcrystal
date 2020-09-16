MainMenu:
	call DeleteSavedMusic
	farcall NewGame_ClearTileMapEtc
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call SetPalettes
	ld hl, wGameTimerPause
	res 0, [hl]
	call MainMenu_GetWhichMenu
	ld [wWhichIndexSet], a
	call MainMenu_PrintCurrentTimeAndDay
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	call MainMenuJoypadLoop
	call CloseWindow
	ret c
	call ClearTileMap
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	call JumpTable
	jr MainMenu

.MenuDataHeader:
	db $40 ; flags
	db 00, 00 ; start coords
	db 07, 16 ; end coords
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

CONTINUE       EQU 0
NEW_GAME       EQU 1
NEW_GAME_PLUS  EQU 2
OPTION         EQU 3
MUSIC_PLAYER   EQU 4

MainMenuItems:
; .NewGameMenu:
	db 3
	db NEW_GAME
	db OPTION
	db MUSIC_PLAYER
	db -1
; .ContinueMenu:
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

MainMenu_GetWhichMenu:
	ld a, [wSaveFileExists]
	and a
	jr nz, .next
	xor a ; New Game
	ret

.next
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + (wEventFlags + (EVENT_BEAT_LEAF >> 3)) - wPlayerData
	ld de, wEventFlags + (EVENT_BEAT_LEAF >> 3)
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

MainMenuJoypadLoop:
	call SetUpMenu
.loop
	call MainMenu_PrintCurrentTimeAndDay
	ld a, [w2DMenuFlags1]
	set 5, a
	ld [w2DMenuFlags1], a
	call ReadMenuJoypad
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_button
	cp A_BUTTON
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
	jp nz, SpeechTextbox
	hlcoord 0, 14
	lb bc, 2, 18
	jp Textbox

.PlaceTime:
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
	rst CopyBytes
	call CloseSRAM
endc

	call UpdateTime
	bccoord 1, 15
	call Text_WeekDay
	decoord 4, 16
	ldh a, [hHours]
	ld c, a
	farcall PrintHour
	ld [hl], ":"
	inc hl
	ld de, hMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jp PrintNum

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
