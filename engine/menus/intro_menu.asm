InitIntroGradient::
	; top stripe
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH
	ld a, $70
	rst ByteFill
	; middle stripe
	; hlcoord 0, 1
	ld bc, SCREEN_WIDTH
	ld a, $71
	rst ByteFill
	; bottom stripe
	; hlcoord 0, 2
	ld bc, SCREEN_WIDTH
	ld a, $72
	rst ByteFill

	ld de, .IntroGradientGFX
	ld hl, vTiles2 tile $70
	lb bc, BANK(.IntroGradientGFX), 3
	jp Get2bpp

.IntroGradientGFX:
INCBIN "gfx/new_game/intro_gradient.2bpp"

_MainMenu:
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_MAIN_MENU
	ld a, e
	ld [wMapMusic], a
	call PlayMusic
	farcall MainMenu
	jp StartTitleScreen

NewGame_ClearTileMapEtc:
	xor a
	ldh [hMapAnims], a
	call ClearTileMap
	call LoadFontsExtra
	call LoadStandardFont
	jp ClearWindowData

NewGamePlus:
	xor a
	ldh [hBGMapMode], a
	farcall TryLoadSaveFile
	ret c
	jr _NewGame_FinishSetup

NewGame:
	xor a
	ldh [hBGMapMode], a
	call ResetWRAM_NotPlus
_NewGame_FinishSetup:
	call ResetWRAM
	call NewGame_ClearTileMapEtc
	call SetInitialOptions
	call ProfElmSpeech
	call InitializeWorld
	ld a, 1
	ld [wPrevLandmark], a

	ld a, SPAWN_HOME
	ld [wDefaultSpawnpoint], a

	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	jp FinishContinueFunction

ResetWRAM_NotPlus:
	xor a
	ld [wSavedAtLeastOnce], a

	ld [wBattlePoints], a
	ld [wBattlePoints + 1], a

	ld [wCurBox], a

	call SetDefaultBoxNames

	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld hl, sBoxCount
	call _ResetWRAM_InitList
	call CloseSRAM

START_MONEY EQU 3000
	ld hl, wMoney
	ld [hl], LOW(START_MONEY / $10000)
	inc hl
	ld [hl], LOW(START_MONEY / $100)
	inc hl
	ld [hl], LOW(START_MONEY)
	ret

ResetWRAM:
	ld hl, wVirtualOAM
	ld bc, wOptions1 - wVirtualOAM
	xor a
	rst ByteFill

	ld hl, wRAM1Start
	ld bc, wGameData - wRAM1Start
	xor a
	rst ByteFill

	; erase wGameData, but keep Money, wCurBox, wBoxNames, and wBattlePoints
	ld hl, wGameData
	ld bc, wMoney - wGameData
	xor a
	rst ByteFill
	ld hl, wMoneyEnd
	ld bc, wCurBox - wMoneyEnd
	xor a
	rst ByteFill
	ld hl, wBoxNamesEnd
	ld bc, wBattlePoints - wBoxNamesEnd
	xor a
	rst ByteFill
	ld hl, wBattlePointsEnd
	ld bc, wGameDataEnd - wBattlePointsEnd
	xor a
	rst ByteFill

	call Random
	ldh a, [rLY]
	ldh [hSecondsBackup], a
	call DelayFrame
	ldh a, [hRandomSub]
	ld [wPlayerID], a
	ldh a, [rLY]
	ldh [hSecondsBackup], a
	call DelayFrame
	ldh a, [hRandomAdd]
	ld [wPlayerID + 1], a

	call Random
	ld [wSecretID], a
	call DelayFrame
	call Random
	ld [wSecretID + 1], a

	ld hl, wPartyCount
	call _ResetWRAM_InitList

	xor a
	ld [wMonStatusFlags], a

	ld [wPlayerGender], a

	ld hl, wNumItems
	call _ResetWRAM_InitList

	ld hl, wNumMedicine
	call _ResetWRAM_InitList

	ld hl, wNumBalls
	call _ResetWRAM_InitList

	ld hl, wNumBerries
	call _ResetWRAM_InitList

;	ld hl, wNumKeyItems
;	call _ResetWRAM_InitList

	ld hl, wNumPCItems
	call _ResetWRAM_InitList

	ld hl, wTMsHMs
	xor a
rept ((NUM_TMS + NUM_HMS) + 7) / 8
	ld [hli], a
endr

	ld hl, wKeyItems
	xor a
rept ((NUM_KEY_ITEMS) + 7) / 8
	ld [hli], a
endr

	xor a
	ld [wRoamMon1Species], a
	ld [wRoamMon2Species], a
	ld [wRoamMon3Species], a
	ld a, -1
	ld [wRoamMon1MapGroup], a
	ld [wRoamMon2MapGroup], a
	ld [wRoamMon3MapGroup], a
	ld [wRoamMon1MapNumber], a
	ld [wRoamMon2MapNumber], a
	ld [wRoamMon3MapNumber], a

	call LoadOrRegenerateLuckyIDNumber
	call InitializeMagikarpHouse

	xor a
	ld [wMonType], a

	ld [wJohtoBadges], a
	ld [wKantoBadges], a

	ld [wCoins], a
	ld [wCoins + 1], a

	ld [wRegisteredItemFlags], a

	ld [wRegisteredItems], a
	ld [wRegisteredItems + 1], a
	ld [wRegisteredItems + 2], a
	ld [wRegisteredItems + 3], a

	ld [wWhichMomItem], a

START_ITEM_TRIGGER_BALANCE EQU 2300
	ld hl, wMomItemTriggerBalance
	ld [hl], LOW(START_ITEM_TRIGGER_BALANCE / $10000)
	inc hl
	ld [hl], LOW(START_ITEM_TRIGGER_BALANCE / $100)
	inc hl
	ld [hl], LOW(START_ITEM_TRIGGER_BALANCE)

	call InitializeNPCNames

	farcall InitDecorations

	farcall DeletePartyMonMail

	jp ResetGameTime

_ResetWRAM_InitList:
; Loads 0 in the count and -1 in the first item or mon slot.
	xor a
	ld [hli], a
	dec a
	ld [hl], a
	ret

SetDefaultBoxNames:
	ld hl, wBoxNames
	ld c, 0
.loop
	push hl
	ld de, .Box
	call CopyName2
	dec hl
	ld a, c
	inc a
	cp 10
	jr c, .less
	sub 10
	ld [hl], "1"
	inc hl

.less
	add "0"
	ld [hli], a
	ld [hl], "@"
	pop hl
	ld de, 9
	add hl, de
	inc c
	ld a, c
	cp NUM_BOXES
	jr c, .loop
	ret

.Box:
	db "Box@"

InitializeMagikarpHouse:
	ld hl, wBestMagikarpLengthMmHi
	ld a, $3
	ld [hli], a
	ld a, $6
	ld [hli], a
	ld de, .Ralph
	jp CopyName2

.Ralph:
	db "Ralph@"

InitializeNPCNames:
	ld hl, .Rival
	ld de, wRivalName
	call .Copy

	ld hl, .Backup
	ld de, wBackupName
	call .Copy

	ld hl, .Trendy
	ld de, wTrendyPhrase

.Copy:
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

.Rival:
.Backup: db "???@"
.Trendy: db "Prism@"

InitializeWorld:
	call ShrinkPlayer
	farcall SpawnPlayer
	farcall InitializeStartDay
	farjp InitializeEvents

LoadOrRegenerateLuckyIDNumber:
	ld a, BANK(sLuckyIDNumber)
	call GetSRAMBank
	ld a, [wCurDay]
	inc a
	ld b, a
	ld a, [sLuckyNumberDay]
	cp b
	ld a, [sLuckyIDNumber + 1]
	ld c, a
	ld a, [sLuckyIDNumber]
	jr z, .skip
	ld a, b
	ld [sLuckyNumberDay], a
	call Random
	ld c, a
	call Random

.skip
	ld [wLuckyIDNumber], a
	ld [sLuckyIDNumber], a
	ld a, c
	ld [wLuckyIDNumber + 1], a
	ld [sLuckyIDNumber + 1], a
	jp CloseSRAM

Continue:
	farcall TryLoadSaveFile
	ret c

	call LoadStandardMenuHeader
	call DisplaySaveInfoOnContinue
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 20
	call DelayFrames
	call ConfirmContinue
	jp c, CloseWindow
	call Continue_CheckRTC_RestartClock
	jp c, CloseWindow
	call Continue_CheckEGO_ResetInitialOptions
;	jp c, CloseWindow
	ld a, $8
	ld [wMusicFade], a
	xor a ; MUSIC_NONE
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a
	call ClearBGPalettes
	call CloseWindow
	call ClearTileMap
	ld c, 20
	call DelayFrames
	farcall JumpRoamMons
	farcall Function140ae ; time-related
	ld a, [wSpawnAfterChampion]
	cp SPAWN_LANCE
	jr z, .SpawnAfterE4
	ld a, MAPSETUP_CONTINUE
	ldh [hMapEntryMethod], a
	jp FinishContinueFunction

.SpawnAfterE4:
	ld a, SPAWN_NEW_BARK
	ld [wDefaultSpawnpoint], a
	call PostCreditsSpawn
	jp FinishContinueFunction

SpawnAfterLeaf:
	ld a, SPAWN_HOME
	ld [wDefaultSpawnpoint], a

PostCreditsSpawn:
	xor a
	ld [wSpawnAfterChampion], a
	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	ret

ConfirmContinue:
.loop
	call DelayFrame
	call GetJoypad
	ld hl, hJoyPressed
	bit A_BUTTON_F, [hl]
	ret nz
	bit B_BUTTON_F, [hl]
	jr z, .loop
	scf
	ret

Continue_CheckRTC_RestartClock:
	call CheckRTCStatus
	and %10000000 ; Day count exceeded 16383
	jr z, .pass
	farcall RestartClock
	ld a, c
	and a
	jr z, .pass
	scf
	ret

.pass
	xor a
	ret

Continue_CheckEGO_ResetInitialOptions:
	ld a, [wInitialOptions2]
	bit RESET_INIT_OPTS, a
	jr z, .pass
	farcall SetInitialOptions
.pass
	xor a
	ret

FinishContinueFunction:
.loop
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ld [wLinkMode], a
	ld hl, wGameTimerPause
	set 0, [hl]
	res 7, [hl]
	ld hl, wEnteredMapFromContinue
	set 1, [hl]
	farcall OverworldLoop
	ld a, [wSpawnAfterChampion]
	cp SPAWN_LEAF
	jp nz, SoftReset
	call SpawnAfterLeaf
	jr .loop

DisplaySaveInfoOnContinue:
	call CheckRTCStatus
	and %10000000
	jr z, .clock_ok
	lb de, 4, 8
	jr DisplayContinueDataWithRTCError

.clock_ok
	lb de, 4, 8
	jr DisplayNormalContinueData

DisplaySaveInfoOnSave:
	lb de, 0, 0
	; fallthrough

DisplayNormalContinueData:
	call Continue_LoadMenuHeader
	call Continue_DisplayBadgesDexPlayerName
	call Continue_PrintGameTime
	call LoadFontsExtra
	jp UpdateSprites

DisplayContinueDataWithRTCError:
	call Continue_LoadMenuHeader
	call Continue_DisplayBadgesDexPlayerName
	call Continue_UnknownGameTime
	call LoadFontsExtra
	jp UpdateSprites

Continue_LoadMenuHeader:
	xor a
	ldh [hBGMapMode], a
	ld hl, .MenuDataHeader_Dex
	ld a, [wStatusFlags]
	bit 0, a ; pokedex
	jr nz, .pokedex_header
	ld hl, .MenuDataHeader_NoDex

.pokedex_header
	call _OffsetMenuDataHeader
	call MenuBox
	jp PlaceVerticalMenuItems

.MenuDataHeader_Dex:
	db $40 ; flags
	db 00, 00 ; start coords
	db 09, 15 ; end coords
	dw .MenuData2_Dex
	db 1 ; default option

.MenuData2_Dex:
	db $00 ; flags
	db 4 ; items
	db "Player@"
	db "Badges@"
	db "#dex@"
	db "Time@"

.MenuDataHeader_NoDex:
	db $40 ; flags
	db 00, 00 ; start coords
	db 09, 15 ; end coords
	dw .MenuData2_NoDex
	db 1 ; default option

.MenuData2_NoDex:
	db $00 ; flags
	db 4 ; items
	db "Player <PLAYER>@"
	db "Badges@"
	db " @"
	db "Time@"

Continue_DisplayBadgesDexPlayerName:
	call MenuBoxCoord2Tile
	push hl
	decoord 13, 4, 0
	add hl, de
	call Continue_DisplayBadgeCount
	pop hl
	push hl
	decoord 12, 6, 0
	add hl, de
	call Continue_DisplayPokedexNumCaught
	pop hl
	push hl
	decoord 8, 2, 0
	add hl, de
	ld de, .Player
	rst PlaceString
	pop hl
	ret

.Player:
	db "<PLAYER>@"

Continue_PrintGameTime:
	decoord 9, 8, 0
	add hl, de
	jp Continue_DisplayGameTime

Continue_UnknownGameTime:
	decoord 9, 8, 0
	add hl, de
	ld de, .three_question_marks
	rst PlaceString
	ret

.three_question_marks
	db " ???@"

Continue_DisplayBadgeCount:
	push hl
	ld hl, wJohtoBadges
	ld b, 2
	call CountSetBits
	pop hl
	ld de, wd265
	lb bc, 1, 2
	jp PrintNum

Continue_DisplayPokedexNumCaught:
	ld a, [wStatusFlags]
	bit 0, a ; Pokedex
	ret z
	push hl
	ld hl, wPokedexCaught
IF NUM_POKEMON % 8
	ld b, NUM_POKEMON / 8 + 1
ELSE
	ld b, NUM_POKEMON / 8
ENDC
	call CountSetBits
	pop hl
	ld de, wd265
	lb bc, 1, 3
	jp PrintNum

Continue_DisplayGameTime:
	ld de, wGameTimeHours
	lb bc, 2, 3
	call PrintNum
	ld [hl], ":"
	inc hl
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jp PrintNum

ProfElmSpeech:
	farcall InitClock
	ld c, 31
	call FadeToBlack
	call ClearTileMap

	ld de, MUSIC_ROUTE_30
	call PlayMusic

	ld c, 31
	call FadeToWhite

	xor a
	ld [wCurPartySpecies], a
	ld a, PROF_ELM
	ld [wTrainerClass], a
	call Intro_PrepTrainerPic

	ld a, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, ElmText1
	call PrintText
if !DEF(DEBUG)
	ld c, 15
	call FadeToWhite
	call ClearTileMap

	ld a, SYLVEON
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData ; [wCurForm] doesn't matter for Sylveon

	hlcoord 6, 4
	call PrepMonFrontpic

	xor a
	ld [wTempMonDVs], a
	ld [wTempMonDVs + 1], a
	ld [wTempMonDVs + 2], a

	ld a, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, ElmText2
	call PrintText
	ld hl, ElmText4
	call PrintText
	ld c, 15
	call FadeToWhite
	call ClearTileMap

	xor a
	ld [wCurPartySpecies], a
	ld a, PROF_ELM
	ld [wTrainerClass], a
	call Intro_PrepTrainerPic

	ld a, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, ElmText5
	call PrintText
endc

	call InitGender

	ld c, 10
	call DelayFrames

	ld hl, ElmText6
	call PrintText

	call NamePlayer

	call ClearTileMap
	call LoadFontsExtra
	call ApplyTilemapInVBlank
	call DrawIntroPlayerPic

	ld a, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, ElmText7
	jp PrintText

ElmText1:
	text_jump _ElmText1
	text_end

ElmText2:
	text_jump _ElmText2
	start_asm
	ld a, SYLVEON
	call PlayCry
	call WaitSFX
	ld hl, ElmText3
	ret

ElmText3:
	text_jump Text_Waitbutton_2
	text_end

ElmText4:
	text_jump _ElmText4
	text_end

ElmText5:
	text_jump _ElmText5
	text_end

ElmText6:
	text_jump _ElmText6
	text_end

ElmText7:
	text_jump _ElmText7
	text_end

InitGender:
	ld hl, .WhitePal
	ld de, wBGPals1 palette 0
	ld bc, 1 palettes
	call FarCopyColorWRAM
	ld c, 15
	call FadePalettes

	call ClearTileMap
	call ApplyAttrAndTilemapInVBlank
	call SetPalettes

	ld a, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call SetPalettes

	ld hl, AreYouABoyOrAreYouAGirlText
	call PrintText

	ld hl, .MenuDataHeader
	call LoadMenuHeader
	call ApplyAttrAndTilemapInVBlank
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	dec a
	ld [wPlayerGender], a

	call ClearTileMap
	call DrawIntroPlayerPic

	ld a, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, SoYoureABoyText
	ld a, [wPlayerGender]
	and a
	jr z, .boy
	ld hl, SoYoureAGirlText
.boy
	call PrintText

	call YesNoBox
	jr c, InitGender
	ret

.WhitePal:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
else
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endc

.MenuDataHeader:
	db $40 ; flags
	db 7, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $c1 ; flags
	db 2 ; items
	db "Boy@"
	db "Girl@"

AreYouABoyOrAreYouAGirlText:
	; Are you a boy? Or are you a girl?
	text_jump Text_AreYouABoyOrAreYouAGirl
	text_end

SoYoureABoyText:
	; So you're a boy?
	text_jump Text_SoYoureABoy
	text_end

SoYoureAGirlText:
	; So you're a girl?
	text_jump Text_SoYoureAGirl
	text_end

NamePlayer:
	ld b, $1 ; player
	ld de, wPlayerName
	farcall NamingScreen
	ld hl, wPlayerName
	ld de, DefaultMalePlayerName
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .Male
	ld de, DefaultFemalePlayerName
.Male:
	jp InitName

INCLUDE "data/default_player_names.asm"

ShrinkPlayer:

	ldh a, [hROMBank]
	push af

	ld a, 0 << 7 | 32 ; fade out
	ld [wMusicFade], a
	ld de, MUSIC_NONE
	ld a, e
	ld [wMusicFadeIDLo], a
	ld a, d
	ld [wMusicFadeIDHi], a

	ld de, SFX_ESCAPE_ROPE
	call PlaySFX
	pop af
	rst Bankswitch

	ld c, 8
	call DelayFrames

	ld hl, Shrink1Pic
	call ShrinkFrame

	ld c, 8
	call DelayFrames

	ld hl, Shrink2Pic
	call ShrinkFrame

	ld c, 8
	call DelayFrames

	hlcoord 6, 4
	lb bc, 7, 7
	call ClearBox

	ld c, 3
	call DelayFrames

	call Intro_PlacePlayerSprite
	call LoadFontsExtra

	ld c, 50
	call DelayFrames

	ld c, 15
	call FadeToWhite
	jp ClearTileMap

Intro_RotatePalettesLeftFrontpic:
	ld hl, IntroFadePalettes
	ld b, IntroFadePalettesEnd - IntroFadePalettes
.loop
	ld a, [hli]
	call DmgToCgbBGPals
	ld c, 10
	call DelayFrames
	dec b
	jr nz, .loop
	ret

IntroFadePalettes:
	db %01010100
	db %10101000
	db %11111100
	db %11111000
	db %11110100
	db %11100100
IntroFadePalettesEnd:

DrawIntroPlayerPic:
	xor a
	ld [wCurPartySpecies], a
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .male
	ld a, CARRIE
	jr .ok
.male
	ld a, CAL
.ok
	ld [wTrainerClass], a
Intro_PrepTrainerPic:
	ld de, vTiles2
	farcall GetTrainerPic
	jr FinishPrepIntroPic

ShrinkFrame:
	ld de, vTiles2
	lb bc, BANK("Shrink Graphics"), $31
	call DecompressRequest2bpp
FinishPrepIntroPic:
	xor a
	ldh [hGraphicStartTile], a
	hlcoord 6, 4
	lb bc, 7, 7
	predef_jump PlaceGraphic

Intro_PlacePlayerSprite:
	farcall GetPlayerIcon
	ld c, $c
	ld hl, vTiles0
	call Request2bppInWRA6

	ld hl, wVirtualOAM
	ld de, .sprites
	ld a, [de]
	inc de

	ld c, a
.loop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a

	ld b, 0
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .male
	ld b, 1
.male
	ld a, b

	ld [hli], a
	dec c
	jr nz, .loop
	ret

.sprites
	db 4
	db  9 * 8 + 4,  9 * 8, 0
	db  9 * 8 + 4, 10 * 8, 1
	db 10 * 8 + 4,  9 * 8, 2
	db 10 * 8 + 4, 10 * 8, 3

CrystalIntroSequence:
	farcall Copyright_GFPresents
	jr c, StartTitleScreen
	farcall CrystalIntro

StartTitleScreen:
	ld hl, rIE
	set LCD_STAT, [hl]
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	farcall _TitleScreen
	call DelayFrame
.loop
	call RunTitleScreen
	jr nc, .loop

	call ClearSprites
	call ClearBGPalettes

	pop af
	ldh [rSVBK], a

	ld hl, rIE
	res LCD_STAT, [hl]
	ld hl, rLCDC
	res 2, [hl] ; 8x8 sprites
	call ClearScreen
	call ApplyAttrAndTilemapInVBlank
	xor a
	ldh [hLCDCPointer], a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call UpdateTimePals
	ld a, [wIntroSceneFrameCounter]
	cp $6
	jr c, .ok
	xor a
.ok
	call StackJumpTable

.Jumptable
	dw _MainMenu
	dw DeleteSaveData
	dw CrystalIntroSequence
	dw CrystalIntroSequence
	dw ResetClock
	dw ResetInitialOptions

RunTitleScreen:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done_title
	call TitleScreenScene
	farcall SuicuneFrameIterator
	call DelayFrame
	and a
	ret

.done_title
	scf
	ret

TitleScreenScene:
	call StackJumpTable

.scenes
	dw TitleScreenEntrance
	dw TitleScreenTimer
	dw TitleScreenMain
	dw TitleScreenEnd

TitleScreenEntrance:

; Animate the logo:
; Move each line by 4 pixels until our count hits 0.
	ldh a, [hSCX]
	and a
	jr z, .done
	sub 4
	ldh [hSCX], a

; Lay out a base (all lines scrolling together).
	ld e, a
	ld hl, wLYOverrides
	ld bc, 8 * 10 ; logo height
	rst ByteFill

; Reversed signage for every other line's position.
; This is responsible for the interlaced effect.
	ld a, e
	cpl
	inc a

	ld b, 8 * 10 / 2 ; logo height / 2
	ld hl, wLYOverrides + 1
.loop
	ld [hli], a
	inc hl
	dec b
	jr nz, .loop

	farjp AnimateTitleCrystal

.done
; Next scene
	ld hl, wJumptableIndex
	inc [hl]

	xor a
	ldh [hLCDCPointer], a

	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + wStatusFlags - wPlayerData
	ld de, wStatusFlags
	ld a, [hl]
	ld [de], a
	call CloseSRAM

; Play the title screen music.
	ld de, MUSIC_TITLE
	ld a, [wSaveFileExists]
	and a
	jr z, .ok
	ld hl, wStatusFlags
	bit 6, [hl] ; hall of fame
	jr z, .ok
	ld de, MUSIC_TITLE_XY
.ok
	call PlayMusic

	ld a, $88
	ldh [hWY], a
	ret

TitleScreenTimer:

; Next scene
	ld hl, wJumptableIndex
	inc [hl]

	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + wStatusFlags - wPlayerData
	ld de, wStatusFlags
	ld a, [hl]
	ld [de], a
	call CloseSRAM

; Start a timer
	ld de, 73 * 60 + 36
	ld a, [wSaveFileExists]
	and a
	jr z, .ok
	ld hl, wStatusFlags
	bit 6, [hl] ; hall of fame
	jr z, .ok
	ld de, 56 * 60
.ok
	ld hl, wcf65
	ld [hl], e
	inc hl
	ld [hl], d
	ret

TitleScreenMain:

; Run the timer down.
	ld hl, wcf65
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, e
	or d
	jr z, .end

	dec de
	ld [hl], d
	dec hl
	ld [hl], e

; Save data can be deleted by pressing Up + B + Select.
	call GetJoypad
	ld hl, hJoyDown

	ld a, [hl]
	and D_UP + B_BUTTON + SELECT
	cp  D_UP + B_BUTTON + SELECT
	jr z, .delete_save_data

; The clock can be reset by pressing Down + B.
	ld a, [hl]
	and D_DOWN + B_BUTTON
	cp  D_DOWN + B_BUTTON
	jr z, .clock_reset

; The early game options can be reset by pressing Left + B.
	ld a, [hl]
	and D_LEFT + B_BUTTON
	cp  D_LEFT + B_BUTTON
	jr z, .early_option_reset

; Press Start or A to start the game.
.check_start
	ld a, [hl]
	and START | A_BUTTON
	jr nz, .start_game
	ret

.done
	ld [wIntroSceneFrameCounter], a
; Return to the intro sequence.
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.end
; Next scene
	ld hl, wJumptableIndex
	inc [hl]

; Fade out the title screen music
	xor a ; MUSIC_NONE
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a
	ld hl, wMusicFade
	ld [hl], 8 ; 1 second

	ld hl, wcf65
	inc [hl]
	ret

.start_game
	xor a
	jr .done

.delete_save_data
	ld a, 1
	jr .done

.clock_reset
	ld a, 4
	jr .done

.early_option_reset
	ld a, 5
	jr .done

TitleScreenEnd:

; Wait until the music is done fading.

	ld hl, wcf65
	inc [hl]

	ld a, [wMusicFade]
	and a
	ret nz

	ld a, 2
	ld [wIntroSceneFrameCounter], a

; Back to the intro.
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

DeleteSaveData:
	farcall _DeleteSaveData
	jp Init

ResetClock:
	farcall _ResetClock
	jp Init

ResetInitialOptions:
	farcall _ResetInitialOptions
	jp Init

Copyright:
	call ClearTileMap
	call LoadFontsExtra
	ld hl, CopyrightGFX
	ld de, vTiles2 tile $60
	lb bc, BANK(CopyrightGFX), $1d
	call DecompressRequest2bpp
	hlcoord 2, 7
	ld de, CopyrightString
	rst PlaceString
	ret

CopyrightString:
	; ©1995-2001 Nintendo
	db   $60, $61, $62, $63, $64, $65, $66
	db   $67, $68, $69, $6a, $6b, $6c

	; ©1995-2001 Creatures inc.
	next $60, $61, $62, $63, $64, $65, $66
	db   $6d, $6e, $6f, $70, $71, $72, $7a, $7b, $7c

	; ©1995-2001 GAME FREAK inc.
	next $60, $61, $62, $63, $64, $65, $66
	db   $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c, "@"

GameInit::
	farcall TryLoadSaveData
	call ClearWindowData
	call ClearBGPalettes
	call ClearTileMap
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	xor a
	ldh [hBGMapAddress], a
	ldh [hJoyDown], a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $90
	ldh [hWY], a
	call ApplyTilemapInVBlank
	jp CrystalIntroSequence
