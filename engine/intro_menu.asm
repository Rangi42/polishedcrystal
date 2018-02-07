InitIntroGradient::
	; top stripe
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH
	ld a, $70
	call ByteFill
	; middle stripe
	; hlcoord 0, 1
	ld bc, SCREEN_WIDTH
	ld a, $71
	call ByteFill
	; bottom stripe
	; hlcoord 0, 2
	ld bc, SCREEN_WIDTH
	ld a, $72
	call ByteFill

	ld de, .IntroGradientGFX
	ld hl, VTiles2 tile $70
	lb bc, BANK(.IntroGradientGFX), 3
	jp Get2bpp

.IntroGradientGFX:
INCBIN "gfx/new_game/intro_gradient.2bpp"

_MainMenu: ; 5ae8
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_MAIN_MENU
	ld a, e
	ld [wMapMusic], a
	call PlayMusic
	farcall MainMenu
	jp StartTitleScreen
; 5b04

PrintDayOfWeek: ; 5b05
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
; 5b1c

.Days: ; 5b1c
	db "Sun@"
	db "Mon@"
	db "Tues@"
	db "Wednes@"
	db "Thurs@"
	db "Fri@"
	db "Satur@"
; 5b40

.Day: ; 5b40
	db "day@"
; 5b44

NewGame_ClearTileMapEtc: ; 5b44
	xor a
	ld [hMapAnims], a
	call ClearTileMap
	call LoadFontsExtra
	call LoadStandardFont
	jp ClearWindowData
; 5b54

OptionsMenu: ; 5b64
	farjp _OptionsMenu
; 5b6b

NewGamePlus:
	xor a
	ld [hBGMapMode], a
	farcall TryLoadSaveFile
	ret c
	jr _NewGame_FinishSetup

NewGame: ; 5b6b
	xor a
	ld [hBGMapMode], a
	call ResetWRAM_NotPlus
_NewGame_FinishSetup:
	call ResetWRAM
	call NewGame_ClearTileMapEtc
	call SetInitialOptions
	call ProfElmSpeech
	call InitializeWorld
	ld a, 1
	ld [wPreviousLandmark], a

	ld a, SPAWN_HOME
	ld [DefaultSpawnpoint], a

	ld a, MAPSETUP_WARP
	ld [hMapEntryMethod], a
	jp FinishContinueFunction
; 5b8f

ResetWRAM_NotPlus:
	xor a
	ld [wSaveFileExists], a
	ld [wSavedAtLeastOnce], a

	ld [BattlePoints], a

	ld [wCurBox], a

	call SetDefaultBoxNames

	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld hl, sBoxCount
	call _ResetWRAM_InitList
	call CloseSRAM

START_MONEY EQU 3000
	ld hl, Money
	ld [hl], START_MONEY / $10000
	inc hl
	ld [hl], START_MONEY / $100 % $100
	inc hl
	ld [hl], START_MONEY % $100
	ret

ResetWRAM: ; 5ba7
	ld hl, Sprites
	ld bc, Options1 - Sprites
	xor a
	call ByteFill

	ld hl, wRAM1Start
	ld bc, wGameData - wRAM1Start
	xor a
	call ByteFill

	; erase wGameData, but keep Money, wCurBox, wBoxNames, and BattlePoints
	ld hl, wGameData
	ld bc, Money - wGameData
	xor a
	call ByteFill
	ld hl, MoneyEnd
	ld bc, wCurBox - MoneyEnd
	xor a
	call ByteFill
	ld hl, wBoxNamesEnd
	ld bc, BattlePoints - wBoxNamesEnd
	xor a
	call ByteFill
	ld hl, BattlePoints + 1
	ld bc, wGameDataEnd - (BattlePoints + 1)
	xor a
	call ByteFill

	call Random
	ld a, [rLY]
	ld [hSecondsBackup], a
	call DelayFrame
	ld a, [hRandomSub]
	ld [PlayerID], a
	ld a, [rLY]
	ld [hSecondsBackup], a
	call DelayFrame
	ld a, [hRandomAdd]
	ld [PlayerID + 1], a

	call Random
	ld [wSecretID], a
	call DelayFrame
	call Random
	ld [wSecretID + 1], a

	ld hl, PartyCount
	call _ResetWRAM_InitList

	xor a
	ld [wMonStatusFlags], a

	ld [PlayerGender], a

	ld hl, NumItems
	call _ResetWRAM_InitList

	ld hl, NumMedicine
	call _ResetWRAM_InitList

	ld hl, NumBalls
	call _ResetWRAM_InitList

	ld hl, NumBerries
	call _ResetWRAM_InitList

	ld hl, NumKeyItems
	call _ResetWRAM_InitList

	ld hl, PCItems
	call _ResetWRAM_InitList

	ld hl, TMsHMs
	xor a
rept ((NUM_TMS + NUM_HMS) + 7) / 8
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
	ld [MonType], a

	ld [JohtoBadges], a
	ld [KantoBadges], a

	ld [Coins], a
	ld [Coins + 1], a

	ld [RegisteredItem], a

	ld [wWhichMomItem], a

START_ITEM_TRIGGER_BALANCE EQU 2300
	ld hl, MomItemTriggerBalance
	ld [hl], START_ITEM_TRIGGER_BALANCE / $10000
	inc hl
	ld [hl], START_ITEM_TRIGGER_BALANCE / $100 % $100
	inc hl
	ld [hl], START_ITEM_TRIGGER_BALANCE % $100

	call InitializeNPCNames

	farcall InitDecorations

	farcall DeletePartyMonMail

	jp ResetGameTime
; 5ca1

_ResetWRAM_InitList: ; 5ca1
; Loads 0 in the count and -1 in the first item or mon slot.
	xor a
	ld [hli], a
	dec a
	ld [hl], a
	ret
; 5ca6

SetDefaultBoxNames: ; 5ca6
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
; 5cd3

InitializeMagikarpHouse: ; 5cd3
	ld hl, wBestMagikarpLengthMmHi
	ld a, $3
	ld [hli], a
	ld a, $6
	ld [hli], a
	ld de, .Ralph
	jp CopyName2
; 5ce3

.Ralph: ; 5ce3
	db "Ralph@"
; 5ce9

InitializeNPCNames: ; 5ce9
	ld hl, .Rival
	ld de, RivalName
	call .Copy

	ld hl, .Backup
	ld de, BackupName
	call .Copy

	ld hl, .Trendy
	ld de, TrendyPhrase

.Copy:
	ld bc, NAME_LENGTH
	jp CopyBytes

.Rival:
.Backup: db "???@"
.Trendy: db "Prism@"
; 5d23

InitializeWorld: ; 5d23
	call ShrinkPlayer
	farcall SpawnPlayer
	farjp _InitializeStartDay
; 5d33

LoadOrRegenerateLuckyIDNumber: ; 5d33
	ld a, BANK(sLuckyIDNumber)
	call GetSRAMBank
	ld a, [CurDay]
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
; 5d65

Continue: ; 5d65
	farcall TryLoadSaveFile
	ret c

	call LoadStandardMenuDataHeader
	call DisplaySaveInfoOnContinue
	ld a, $1
	ld [hBGMapMode], a
	ld c, 20
	call DelayFrames
	call ConfirmContinue
	jr nc, .Check1Pass
	jp CloseWindow

.Check1Pass:
	call Continue_CheckRTC_RestartClock
	jr nc, .Check2Pass
	jp CloseWindow

.Check2Pass:
	call Continue_CheckEGO_ResetInitialOptions
;	jr nc, .Check3Pass
;	jp CloseWindow

;.Check3Pass:
	ld a, $8
	ld [MusicFade], a
	ld a, MUSIC_NONE % $100
	ld [MusicFadeIDLo], a
	ld a, MUSIC_NONE / $100
	ld [MusicFadeIDHi], a
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
	ld [hMapEntryMethod], a
	jp FinishContinueFunction

.SpawnAfterE4:
	ld a, SPAWN_NEW_BARK
	ld [DefaultSpawnpoint], a
	call PostCreditsSpawn
	jp FinishContinueFunction
; 5de2

SpawnAfterLeaf: ; 5de2
	ld a, SPAWN_HOME
	ld [DefaultSpawnpoint], a
; 5de7

PostCreditsSpawn: ; 5de7
	xor a
	ld [wSpawnAfterChampion], a
	ld a, MAPSETUP_WARP
	ld [hMapEntryMethod], a
	ret
; 5df0

ConfirmContinue: ; 5e34
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
; 5e48

Continue_CheckRTC_RestartClock: ; 5e48
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
; 5e5d

Continue_CheckEGO_ResetInitialOptions:
	ld a, [InitialOptions]
	bit RESET_INIT_OPTS, a
	jr z, .pass
	farcall SetInitialOptions
.pass
	xor a
	ret

FinishContinueFunction: ; 5e5d
.loop
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ld [wLinkMode], a
	ld hl, GameTimerPause
	set 0, [hl]
	res 7, [hl]
	ld hl, wEnteredMapFromContinue
	set 1, [hl]
	farcall OverworldLoop
	ld a, [wSpawnAfterChampion]
	cp SPAWN_LEAF
	jr z, .AfterLeaf
	jp SoftReset

.AfterLeaf:
	call SpawnAfterLeaf
	jr .loop
; 5e85

DisplaySaveInfoOnContinue: ; 5e85
	call CheckRTCStatus
	and %10000000
	jr z, .clock_ok
	lb de, 4, 8
	jr DisplayContinueDataWithRTCError

.clock_ok
	lb de, 4, 8
	jr DisplayNormalContinueData
; 5e9a

DisplaySaveInfoOnSave: ; 5e9a
	lb de, 0, 0
	; fallthrough
; 5e9f

DisplayNormalContinueData: ; 5e9f
	call Continue_LoadMenuHeader
	call Continue_DisplayBadgesDexPlayerName
	call Continue_PrintGameTime
	call LoadFontsExtra
	jp UpdateSprites
; 5eaf

DisplayContinueDataWithRTCError: ; 5eaf
	call Continue_LoadMenuHeader
	call Continue_DisplayBadgesDexPlayerName
	call Continue_UnknownGameTime
	call LoadFontsExtra
	jp UpdateSprites
; 5ebf

Continue_LoadMenuHeader: ; 5ebf
	xor a
	ld [hBGMapMode], a
	ld hl, .MenuDataHeader_Dex
	ld a, [StatusFlags]
	bit 0, a ; pokedex
	jr nz, .pokedex_header
	ld hl, .MenuDataHeader_NoDex

.pokedex_header
	call _OffsetMenuDataHeader
	call MenuBox
	jp PlaceVerticalMenuItems
; 5ed9

.MenuDataHeader_Dex: ; 5ed9
	db $40 ; flags
	db 00, 00 ; start coords
	db 09, 15 ; end coords
	dw .MenuData2_Dex
	db 1 ; default option
; 5ee1

.MenuData2_Dex: ; 5ee1
	db $00 ; flags
	db 4 ; items
	db "Player@"
	db "Badges@"
	db "#dex@"
	db "Time@"
; 5efb

.MenuDataHeader_NoDex: ; 5efb
	db $40 ; flags
	db 00, 00 ; start coords
	db 09, 15 ; end coords
	dw .MenuData2_NoDex
	db 1 ; default option
; 5f03

.MenuData2_NoDex: ; 5f03
	db $00 ; flags
	db 4 ; items
	db "Player <PLAYER>@"
	db "Badges@"
	db " @"
	db "Time@"
; 5f1c


Continue_DisplayBadgesDexPlayerName: ; 5f1c
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
	call PlaceString
	pop hl
	ret

.Player:
	db "<PLAYER>@"
; 5f40

Continue_PrintGameTime: ; 5f40
	decoord 9, 8, 0
	add hl, de
	jp Continue_DisplayGameTime
; 5f48

Continue_UnknownGameTime: ; 5f48
	decoord 9, 8, 0
	add hl, de
	ld de, .three_question_marks
	jp PlaceString

.three_question_marks
	db " ???@"
; 5f58

Continue_DisplayBadgeCount: ; 5f58
	push hl
	ld hl, JohtoBadges
	ld b, 2
	call CountSetBits
	pop hl
	ld de, wd265
	lb bc, 1, 2
	jp PrintNum
; 5f6b

Continue_DisplayPokedexNumCaught: ; 5f6b
	ld a, [StatusFlags]
	bit 0, a ; Pokedex
	ret z
	push hl
	ld hl, PokedexCaught
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
; 5f84

Continue_DisplayGameTime: ; 5f84
	ld de, GameTimeHours
	lb bc, 2, 3
	call PrintNum
	ld [hl], ":"
	inc hl
	ld de, GameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jp PrintNum
; 5f99

ProfElmSpeech: ; 0x5f99
	farcall InitClock
	call RotateFourPalettesLeft
	call ClearTileMap

	ld de, MUSIC_ROUTE_30
	call PlayMusic

	call RotateFourPalettesRight
	call RotateThreePalettesRight

	xor a
	ld [CurPartySpecies], a
	ld a, PROF_ELM
	ld [TrainerClass], a
	call Intro_PrepTrainerPic

	ld b, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, ElmText1
	call PrintText
if !DEF(DEBUG)
	call RotateThreePalettesRight
	call ClearTileMap

	ld a, SYLVEON
	ld [CurSpecies], a
	ld [CurPartySpecies], a
	call GetBaseData

	hlcoord 6, 4
	call PrepMonFrontpic

	xor a
	ld [TempMonDVs], a
	ld [TempMonDVs + 1], a
	ld [TempMonDVs + 2], a

	ld b, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, ElmText2
	call PrintText
	ld hl, ElmText4
	call PrintText
	call RotateThreePalettesRight
	call ClearTileMap

	xor a
	ld [CurPartySpecies], a
	ld a, PROF_ELM
	ld [TrainerClass], a
	call Intro_PrepTrainerPic

	ld b, CGB_INTRO_PALS
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
	call WaitBGMap
	call DrawIntroPlayerPic

	ld b, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, ElmText7
	jp PrintText

ElmText1: ; 0x6045
	text_jump _ElmText1
	db "@"

ElmText2: ; 0x604a
	text_jump _ElmText2
	start_asm
	ld a, SYLVEON
	call PlayCry
	call WaitSFX
	ld hl, ElmText3
	ret

ElmText3: ; 0x605b
	text_jump _ElmText3
	db "@"

ElmText4: ; 0x6060
	text_jump _ElmText4
	db "@"

ElmText5: ; 0x6065
	text_jump _ElmText5
	db "@"

ElmText6: ; 0x606a
	text_jump _ElmText6
	db "@"

ElmText7: ; 0x606f
	text_jump _ElmText7
	db "@"

InitGender: ; 48dcb (12:4dcb)
	call RotateThreePalettesRight
	call ClearTileMap
	call WaitBGMap2
	call SetPalettes

	ld b, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient

	ld hl, AreYouABoyOrAreYouAGirlText
	call PrintText

	ld hl, .MenuDataHeader
	call LoadMenuDataHeader
	call WaitBGMap2
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	dec a
	ld [PlayerGender], a

	call ClearTileMap
	call DrawIntroPlayerPic

	ld b, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, SoYoureABoyText
	ld a, [PlayerGender]
	and a
	jr z, .boy
	ld hl, SoYoureAGirlText
.boy
	call PrintText

	call YesNoBox
	jr c, InitGender
	ret
; 48dfc (12:4dfc)

.MenuDataHeader: ; 0x48dfc
	db $40 ; flags
	db 7, 13 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x48e04

.MenuData2: ; 0x48e04
	db $c1 ; flags
	db 2 ; items
	db "Boy@"
	db "Girl@"
; 0x48e0f

AreYouABoyOrAreYouAGirlText: ; 0x48e0f
	; Are you a boy? Or are you a girl?
	text_jump Text_AreYouABoyOrAreYouAGirl
	db "@"
; 0x48e14

SoYoureABoyText:
	; So you're a boy?
	text_jump Text_SoYoureABoy
	db "@"

SoYoureAGirlText:
	; So you're a girl?
	text_jump Text_SoYoureAGirl
	db "@"

NamePlayer: ; 0x6074
	ld b, $1 ; player
	ld de, PlayerName
	farcall NamingScreen
	ld hl, PlayerName
	ld de, DefaultMalePlayerName
	ld a, [PlayerGender]
	bit 0, a
	jr z, .Male
	ld de, DefaultFemalePlayerName
.Male:
	jp InitName

INCLUDE "data/default_player_names.asm"

ShrinkPlayer: ; 610f

	ld a, [hROMBank]
	push af

	ld a, 0 << 7 | 32 ; fade out
	ld [MusicFade], a
	ld de, MUSIC_NONE
	ld a, e
	ld [MusicFadeIDLo], a
	ld a, d
	ld [MusicFadeIDHi], a

	ld de, SFX_ESCAPE_ROPE
	call PlaySFX
	pop af
	rst Bankswitch

	ld c, 8
	call DelayFrames

	ld hl, Shrink1Pic
	ld b, BANK(Shrink1Pic)
	call ShrinkFrame

	ld c, 8
	call DelayFrames

	ld hl, Shrink2Pic
	ld b, BANK(Shrink2Pic)
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

	call RotateThreePalettesRight
	jp ClearTileMap
; 616a

Intro_RotatePalettesLeftFrontpic: ; 616a
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
; 617c

IntroFadePalettes: ; 0x617c
	db %01010100
	db %10101000
	db %11111100
	db %11111000
	db %11110100
	db %11100100
IntroFadePalettesEnd
; 6182

DrawIntroPlayerPic:
	xor a
	ld [CurPartySpecies], a
	ld a, [PlayerGender]
	bit 0, a
	jr z, .male
	ld a, CARRIE
	jr .ok
.male
	ld a, CAL
.ok
	ld [TrainerClass], a
Intro_PrepTrainerPic: ; 619c
	ld de, VTiles2
	farcall GetTrainerPic
	jr FinishPrepIntroPic
; 61b4

ShrinkFrame: ; 61b4
	ld de, VTiles2
	ld c, $31
	predef DecompressPredef
FinishPrepIntroPic:
	xor a
	ld [hGraphicStartTile], a
	hlcoord 6, 4
	lb bc, 7, 7
	predef PlaceGraphic
	ret
; 61cd

Intro_PlacePlayerSprite: ; 61cd
	farcall GetPlayerIcon
	ld c, $c
	ld hl, VTiles0
	call Request2bpp

	ld hl, Sprites
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
	ld a, [PlayerGender]
	bit 0, a
	jr z, .male
	ld b, 1
.male
	ld a, b

	ld [hli], a
	dec c
	jr nz, .loop
	ret
; 61fe

.sprites ; 61fe
	db 4
	db  9 * 8 + 4,  9 * 8, 0
	db  9 * 8 + 4, 10 * 8, 1
	db 10 * 8 + 4,  9 * 8, 2
	db 10 * 8 + 4, 10 * 8, 3
; 620b


CrystalIntroSequence: ; 620b
	farcall Copyright_GFPresents
	jr c, StartTitleScreen
	farcall CrystalIntro

StartTitleScreen: ; 6219
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a

	farcall _TitleScreen
	call DelayFrame
.loop
	call RunTitleScreen
	jr nc, .loop

	call ClearSprites
	call ClearBGPalettes

	pop af
	ld [rSVBK], a

	ld hl, rLCDC
	res 2, [hl] ; 8x8 sprites
	call ClearScreen
	call WaitBGMap2
	xor a
	ld [hLCDCPointer], a
	ld [hSCX], a
	ld [hSCY], a
	ld a, $7
	ld [hWX], a
	ld a, $90
	ld [hWY], a
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call UpdateTimePals
	ld a, [wIntroSceneFrameCounter]
	cp $6
	jr c, .ok
	xor a
.ok
	ld e, a
	ld d, 0
	ld hl, .dw
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; 626a

.dw
	dw _MainMenu
	dw DeleteSaveData
	dw CrystalIntroSequence
	dw CrystalIntroSequence
	dw ResetClock
	dw ResetInitialOptions
; 6274


RunTitleScreen: ; 627b
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
; 6292

TitleScreenScene: ; 62a3
	ld e, a
	ld d, 0
	ld hl, .scenes
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; 62af

.scenes
	dw TitleScreenEntrance
	dw TitleScreenTimer
	dw TitleScreenMain
	dw TitleScreenEnd
; 62b7


TitleScreenEntrance: ; 62bc

; Animate the logo:
; Move each line by 4 pixels until our count hits 0.
	ld a, [hSCX]
	and a
	jr z, .done
	sub 4
	ld [hSCX], a

; Lay out a base (all lines scrolling together).
	ld e, a
	ld hl, LYOverrides
	ld bc, 8 * 10 ; logo height
	call ByteFill

; Reversed signage for every other line's position.
; This is responsible for the interlaced effect.
	ld a, e
	cpl
	inc a

	ld b, 8 * 10 / 2 ; logo height / 2
	ld hl, LYOverrides + 1
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
	ld [hLCDCPointer], a

	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + StatusFlags - wPlayerData
	ld de, StatusFlags
	ld a, [hl]
	ld [de], a
	call CloseSRAM

; Play the title screen music.
	ld de, MUSIC_TITLE
	ld a, [wSaveFileExists]
	and a
	jr z, .ok
	ld hl, StatusFlags
	bit 6, [hl] ; hall of fame
	jr z, .ok
	ld de, MUSIC_TITLE_XY
.ok
	call PlayMusic

	ld a, $88
	ld [hWY], a
	ret
; 62f6


TitleScreenTimer: ; 62f6

; Next scene
	ld hl, wJumptableIndex
	inc [hl]

	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + StatusFlags - wPlayerData
	ld de, StatusFlags
	ld a, [hl]
	ld [de], a
	call CloseSRAM

; Start a timer
	ld de, 73 * 60 + 36
	ld a, [wSaveFileExists]
	and a
	jr z, .ok
	ld hl, StatusFlags
	bit 6, [hl] ; hall of fame
	jr z, .ok
	ld de, 56 * 60
.ok
	ld hl, wcf65
	ld [hl], e
	inc hl
	ld [hl], d
	ret
; 6304

TitleScreenMain: ; 6304

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
	xor a
	ld [MusicFadeIDLo], a
	ld [MusicFadeIDHi], a
	ld hl, MusicFade
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

; 6375

TitleScreenEnd: ; 6375

; Wait until the music is done fading.

	ld hl, wcf65
	inc [hl]

	ld a, [MusicFade]
	and a
	ret nz

	ld a, 2
	ld [wIntroSceneFrameCounter], a

; Back to the intro.
	ld hl, wJumptableIndex
	set 7, [hl]
	ret
; 6389

DeleteSaveData: ; 6389
	farcall _DeleteSaveData
	jp Init
; 6392

ResetClock: ; 6392
	farcall _ResetClock
	jp Init
; 639b

ResetInitialOptions:
	farcall _ResetInitialOptions
	jp Init

Copyright: ; 63e2
	call ClearTileMap
	call LoadFontsExtra
	ld de, CopyrightGFX
	ld hl, VTiles2 tile $60
	lb bc, BANK(CopyrightGFX), $1d
	call Request2bpp
	hlcoord 2, 7
	ld de, CopyrightString
	jp PlaceString
; 63fd

CopyrightString: ; 63fd
	; ©1995-2001 Nintendo
	db   $60, $61, $62, $63, $64, $65, $66
	db   $67, $68, $69, $6a, $6b, $6c

	; ©1995-2001 Creatures inc.
	next $60, $61, $62, $63, $64, $65, $66
	db   $6d, $6e, $6f, $70, $71, $72, $7a, $7b, $7c

	; ©1995-2001 GAME FREAK inc.
	next $60, $61, $62, $63, $64, $65, $66
	db   $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c

	db "@"
; 642e

GameInit:: ; 642e
	farcall TryLoadSaveData
	call ClearWindowData
	call ClearBGPalettes
	call ClearTileMap
	ld a, VBGMap0 / $100
	ld [hBGMapAddress + 1], a
	xor a
	ld [hBGMapAddress], a
	ld [hJoyDown], a
	ld [hSCX], a
	ld [hSCY], a
	ld a, $90
	ld [hWY], a
	call WaitBGMap
	jp CrystalIntroSequence
; 6454
