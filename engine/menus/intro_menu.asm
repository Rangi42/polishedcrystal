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
	jmp Get2bpp

.IntroGradientGFX:
INCBIN "gfx/new_game/intro_gradient.2bpp"

_MainMenu:
	ld e, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld e, MUSIC_MAIN_MENU
	ld a, e
	ld [wMapMusic], a
	call PlayMusic
	farcall MainMenu
	jmp StartTitleScreen

NewGame_ClearTileMapEtc:
	xor a
	ldh [hMapAnims], a
	ld a, '<BLACK>'
	call FillTileMap
	call LoadFrame
	call LoadStandardFont
	jmp ClearWindowData

NewGamePlus:
	ld hl, .text
	call PrintText
	call YesNoBox
	jr c, _MainMenu
	xor a
	ldh [hBGMapMode], a
	farcall TryLoadSaveFile
	ret c
	jr _NewGame_FinishSetup

.text
	text "New Game+ will"
	line "keep your previous"

	para "game's money,"
	line "Battle Points, and"

	para "any #mon stored"
	line "in the PC!"

	para "Are you sure you"
	line "you want to start"
	cont "New Game+?"
	done

NewGame:
	xor a
	ldh [hBGMapMode], a
	call ResetWRAM_NotPlus
_NewGame_FinishSetup:
	call ResetWRAM
	farcall ClearSavedObjPals
	call NewGame_ClearTileMapEtc
	call WarnVBA
	call SetInitialOptions
	call ProfElmSpeech
	call InitializeWorld
	ld a, 1
	ld [wPrevLandmark], a

	ld a, SPAWN_HOME
	ld [wDefaultSpawnpoint], a

	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	jmp FinishContinueFunction

ResetWRAM_NotPlus:
	xor a
	ld [wSavedAtLeastOnce], a

	; Key items are 0-terminated, just load 0 into the first entry.
	xor a
	ld [wKeyItems], a

	ld [wBattlePoints], a
	ld [wBattlePoints + 1], a

	ld [wCurBox], a

	farcall InitializeBoxes
	call CloseSRAM

	ld hl, wMoney
	xor a
	assert START_MONEY < $10000
	ld [hli], a
	ld a, HIGH(START_MONEY)
	ld [hli], a
	ld a, LOW(START_MONEY)
	ld [hli], a
	; clear mom's money
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

ResetWRAM:
	ld hl, wShadowOAM
	ld bc, wMusic - wShadowOAM
	xor a
	rst ByteFill

	ld hl, wMusicEnd
	ld bc, wOptions3 - wMusicEnd
	rst ByteFill

	ld hl, wRAM1Start
	ld bc, wGameData - wRAM1Start
	rst ByteFill

	; erase wGameData, but keep wMoney and wBattlePoints
	ld hl, wGameData
	ld bc, wMoney - wGameData
	rst ByteFill
	ld hl, wMoneyEnd
	ld bc, wKeyItems - wMoneyEnd
	rst ByteFill
	ld hl, wKeyItemsEnd
	ld bc, wBattlePoints - wKeyItemsEnd
	rst ByteFill
	ld hl, wBattlePointsEnd
	ld bc, wGameDataEnd - wBattlePointsEnd
	rst ByteFill

	call Random
	call DelayFrame
	ldh a, [hRandomSub]
	ld [wPlayerID], a
	call DelayFrame
	ldh a, [hRandomAdd]
	ld [wPlayerID + 1], a

	call Random
	ld [wSecretID], a
	call DelayFrame
	call Random
	ld [wSecretID + 1], a

	xor a
	ld [wPartyCount], a
	ld [wMonStatusFlags], a
	inc a ; PLAYER_FEMALE
	ld [wPlayerGender], a

	ld hl, wNumItems
	call _ResetWRAM_InitList

	ld hl, wNumMedicine
	call _ResetWRAM_InitList

	ld hl, wNumBalls
	call _ResetWRAM_InitList

	; We want to preserve charms, so track those down and put on top.
	ld hl, wKeyItems
	push de
	ld d, h
	ld e, l
.charms_loop
	ld a, [hli]
	and a
	jr z, .charms_done
	cp CHARMS_START
	jr c, .charms_loop
	ld [de], a
	inc de
	jr .charms_loop
.charms_done
	; Place a terminator after any charms, effectively deleting other items.
	; xor a (implicit from the "jr z" above)
	ld [de], a
	pop de

	ld hl, wNumBerries
	call _ResetWRAM_InitList

	ld hl, wNumPCItems
	call _ResetWRAM_InitList

	xor a

	ld hl, wTMsHMs
rept ((NUM_TMS + NUM_HMS) + 7) / 8 - 1
	ld [hli], a
endr
	ld [hl], a

	ld [wRoamMon1Species], a
	ld [wRoamMon2Species], a
	ld [wRoamMon3Species], a
	dec a ; -1
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

	ld hl, wMomItemTriggerBalance
	xor a
	assert MOM_MONEY < $10000
	ld [hli], a
	ld a, HIGH(MOM_MONEY)
	ld [hli], a
	ld [hl], LOW(MOM_MONEY)

	call InitializeNPCNames

	farcall InitDecorations

	farcall DeletePartyMonMail

	jmp ResetGameTime

_ResetWRAM_InitList:
; Loads 0 in the count and -1 in the first item or mon slot.
	xor a
	ld [hli], a
	dec a
	ld [hl], a
	ret

InitializeMagikarpHouse:
	ld hl, wBestMagikarpLengthMmHi
	ld a, HIGH(BEST_MAGIKARP_LENGTH)
	ld [hli], a
	ld a, LOW(BEST_MAGIKARP_LENGTH)
	ld [hli], a
	ld de, .Ralph
	jmp CopyName2

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
	jmp CloseSRAM

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
	jmp c, CloseWindow
	call WarnVBA
	call Continue_CheckRTC_RestartClock
	jmp c, CloseWindow
	call Continue_CheckEGO_ResetInitialOptions
	ld a, $8
	ld [wMusicFade], a
	xor a ; MUSIC_NONE
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a
	call ClearBGPalettes
	call CloseWindow
	call ClearTileMap
	farcall ClearSavedObjPals
	farcall FixPlayerEVsAndStats
	farcall JumpRoamMons
	farcall ClockContinue ; time-related
	ld a, [wSpawnAfterChampion]
	cp SPAWN_LANCE
	jr z, .SpawnAfterE4
	ld a, MAPSETUP_CONTINUE
	ldh [hMapEntryMethod], a
	jr FinishContinueFunction

.SpawnAfterE4:
	ld a, SPAWN_NEW_BARK
	ld [wDefaultSpawnpoint], a
	call PostCreditsSpawn
	jr FinishContinueFunction

SpawnAfterLeaf:
	ld a, SPAWN_HOME
	ld [wDefaultSpawnpoint], a
	; fallthrough

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
	bit B_PAD_A, [hl]
	ret nz
	bit B_PAD_B, [hl]
	jr z, .loop
	scf
	ret

WarnVBA:
	call CheckVBA
	ret z
if !DEF(DEBUG)
	ld hl, .WarnVBAText
	jmp PrintText
else
	ld hl, wOptions1
	push hl
	set NO_TEXT_SCROLL, [hl]
	ld hl, .WarnVBAText
	call PrintText
	pop hl
	res NO_TEXT_SCROLL, [hl]
	ret
endc

.WarnVBAText:
	text_far _WarnVBAText
	text_end

Continue_CheckRTC_RestartClock:
	call CheckRTCStatus
	and %10000000 ; Day count exceeded 16383
	jr z, Continue_FinishReset
	farcall RestartClock
	ld a, c
	and a
	jr z, Continue_FinishReset
	scf
	ret

Continue_CheckEGO_ResetInitialOptions:
	ld a, [wInitialOptions2]
	bit RESET_INIT_OPTS, a
	call nz, SetInitialOptions
	; fallthrough
Continue_FinishReset:
	xor a
	ret

FinishContinueFunction:
.loop
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ld [wLinkMode], a
	inc a ; TRUE
	ld [wGameTimerPaused], a
	ld hl, wEnteredMapFromContinue
	set 1, [hl]
	farcall OverworldLoop
	ld a, [wSpawnAfterChampion]
	cp SPAWN_LEAF
	jmp nz, SoftReset
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
	call LoadFrame
	jmp UpdateSprites

DisplayContinueDataWithRTCError:
	call Continue_LoadMenuHeader
	call Continue_DisplayBadgesDexPlayerName
	call Continue_UnknownGameTime
	call LoadFrame
	jmp UpdateSprites

Continue_LoadMenuHeader:
	xor a
	ldh [hBGMapMode], a
	ld hl, .MenuDataHeader_Dex
	ld a, [wStatusFlags]
	bit STATUSFLAGS_POKEDEX_F, a
	jr nz, .pokedex_header
	ld hl, .MenuDataHeader_NoDex

.pokedex_header
	call _OffsetMenuDataHeader
	call MenuBox
	jmp PlaceVerticalMenuItems

.MenuDataHeader_Dex:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 15, 9
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
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 15, 9
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
	jr Continue_DisplayGameTime

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
	ld hl, wBadges
	ld b, wBadgesEnd - wBadges
	call CountSetBits
	pop hl
	ld de, wNumSetBits
	lb bc, 1, 2
	jmp PrintNum

Continue_DisplayPokedexNumCaught:
	ld a, [wStatusFlags]
	bit STATUSFLAGS_POKEDEX_F, a
	ret z
	farcall Pokedex_CountSeenOwn
	ld de, wTempDexOwn
	lb bc, 2, 3
	jmp PrintNum

Continue_DisplayGameTime:
	ld de, wGameTimeHours
	lb bc, 2, 3
	call PrintNum
	ld a, ':'
	ld [hli], a
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jmp PrintNum

ProfElmSpeech:
	farcall InitClock
	ld c, 31
	call FadeToBlack
	call ClearTileMap

	ld e, MUSIC_ROUTE_30
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

	ld a, LOW(GLACEON)
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	ld a, HIGH(GLACEON) << MON_EXTSPECIES_F
	ld [wCurForm], a
	ld [wTempMonForm], a
	call GetBaseData

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
	call LoadFrame
	call ApplyTilemapInVBlank
	call DrawIntroPlayerPic

	ld a, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, ElmText7
	jmp PrintText

ElmText1:
	text_far _ElmText1
	text_end

ElmText2:
	text_far _ElmText2
	text_asm
	lp bc, GLACEON
	call PlayMonCry
	ld hl, ElmText3
	ret

ElmText3:
	text_far Text_Waitbutton_2
	text_end

ElmText4:
	text_far _ElmText4
	text_end

ElmText5:
	text_far _ElmText5
	text_end

ElmText6:
	text_far _ElmText6
	text_end

ElmText7:
	text_far _ElmText7
	text_end

InitGender:
	ld c, 15
	call FadeToWhite
	call ClearTileMap

	call InitGenderGraphics

	ld a, CGB_INTRO_GENDER_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, AreYouABoyOrAreYouAGirlText
	call PrintText

	call ApplyAttrAndTilemapInVBlank
	call GenderMenu

	ld c, 15
	call FadeToWhite
	call ClearTileMap
	call ClearTileMap

	call DrawIntroPlayerPic

	ld a, CGB_INTRO_PALS
	call GetCGBLayout
	call InitIntroGradient
	call Intro_RotatePalettesLeftFrontpic

	ld hl, SoThisIsYouText
	call PrintText

	call YesNoBox
	jr c, InitGender
	ret

GenderMenu::
	; erase previous cursors
	ld a, ' '
	hlcoord 2, 3
	ld [hli], a
	ld [hl], a
	hlcoord 9, 3
	ld [hli], a
	ld [hl], a
	hlcoord 16, 3
	ld [hli], a
	ld [hl], a

	ld a, [wPlayerGender]
	and a ; PLAYER_MALE
	jr z, .male
	dec a ; PLAYER_FEMALE
	jr z, .female

; PLAYER_ENBY
	; place cursor
	ld a, $69
	hlcoord 16, 3
	ld [hli], a
	inc a
	ld [hl], a
	; load opaque palettes
	call SetDefaultBGPAndOBP
	; make other palettes transparent
	ld hl, wBGPals2 palette 0 + 2
	call .MakeTransparent
	ld hl, wBGPals2 palette 2 + 2
	call .MakeTransparent
	jr .ready

.male
	; place cursor
	ld a, $69
	hlcoord 2, 3
	ld [hli], a
	inc a
	ld [hl], a
	; load opaque palettes
	call SetDefaultBGPAndOBP
	; make other palettes transparent
	ld hl, wBGPals2 palette 2 + 2
	call .MakeTransparent
	ld hl, wBGPals2 palette 3 + 2
	call .MakeTransparent
	jr .ready

.female
	; place cursor
	ld a, $69
	hlcoord 9, 3
	ld [hli], a
	inc a
	ld [hl], a
	; load opaque palettes
	call SetDefaultBGPAndOBP
	; make other paletees transparent
	ld hl, wBGPals2 palette 0 + 2
	call .MakeTransparent
	ld hl, wBGPals2 palette 3 + 2
	call .MakeTransparent
	; fallthrough

.ready
	ld a, BANK(wPlayerGender)
	ldh [rWBK], a

	ld b, 1
	call SafeCopyTilemapAtOnce

.loop
	call DelayFrame
	call GetJoypad
	ldh a, [hJoyPressed]
	bit B_PAD_A, a
	ret nz
	bit B_PAD_RIGHT, a
	jr nz, .d_right
	bit B_PAD_LEFT, a
	jr z, .loop

	ld a, [wPlayerGender]
	and a ; PLAYER_MALE
	jr z, .got_gender
	dec a ; female->male, enby->female
	jr .got_gender

.d_right
	ld a, [wPlayerGender]
	cp PLAYER_ENBY
	jr z, .got_gender
	inc a ; male->female, female->enby
.got_gender
	ld [wPlayerGender], a
	jmp GenderMenu

.MakeTransparent:
	ld a, BANK(wBGPals2)
	ldh [rWBK], a
	ld d, 3
.transparency_loop
	ld a, [hli]
	ld c, a
	ld a, [hld]
	ld b, a
	farcall ApplyWhiteTransparency
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	dec d
	jr nz, .transparency_loop
	ret

AreYouABoyOrAreYouAGirlText:
	; Are you a boy? Or are you a girl?
	text_far Text_AreYouABoyOrAreYouAGirl
	text_end

SoThisIsYouText:
	; So this is you?
	text_far Text_SoThisIsYou
	text_end

InitGenderGraphics:
	ld hl, ChrisCardPic
	ld de, vTiles2 tile $00
	lb bc, BANK(ChrisCardPic), 5 * 7
	call DecompressRequest2bpp
	ld hl, KrisCardPic
	ld de, vTiles2 tile $23
	lb bc, BANK(KrisCardPic), 5 * 7
	call DecompressRequest2bpp
	ld hl, CrysCardPic
	ld de, vTiles2 tile $46
	lb bc, BANK(CrysCardPic), 5 * 7
	call DecompressRequest2bpp

; Shift the "▼" character three pixels to the right across two tiles
	farcall LoadStandardFontPointer
	ld de, ('▼' - $80) * TILE_1BPP_SIZE
	add hl, de
	ld de, wOverworldMapBlocks
	ld c, TILE_1BPP_SIZE
.loop
	ld a, BANK(FontTiles)
	call GetFarByte
	ld b, 0
rept 3
	srl a
	rr b
endr
	ld [de], a
	push hl
	ld hl, TILE_SIZE
	add hl, de
	ld [hl], b ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], b
	pop hl
	inc hl
	inc de
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ld hl, vTiles2 tile $69
	ld de, wOverworldMapBlocks
	ld c, 2
	call Request2bppInWRA6

	xor a
	ldh [hGraphicStartTile], a
	hlcoord 0, 4
	lb bc, 5, 7
	predef PlaceGraphic
	ld a, $23
	ldh [hGraphicStartTile], a
	hlcoord 7, 4
	lb bc, 5, 7
	predef PlaceGraphic
	ld a, $46
	ldh [hGraphicStartTile], a
	hlcoord 14, 4
	lb bc, 5, 7
	predef_jump PlaceGraphic

NamePlayer:
	ld b, $1 ; player
	ld de, wPlayerName
	farcall NamingScreen
	ld hl, wPlayerName
	ld a, [wPlayerGender]
	ld de, DefaultMalePlayerName
	and a ; PLAYER_MALE
	jr z, .done
	ld de, DefaultFemalePlayerName
	dec a ; PLAYER_FEMALE
	jr z, .done
	; PLAYER_ENBY
	ld de, DefaultEnbyPlayerName
.done:
	jmp InitName

INCLUDE "data/default_player_names.asm"

ShrinkPlayer:
	ld a, 0 << 7 | 32 ; fade out
	ld [wMusicFade], a
	xor a ; MUSIC_NONE
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a

	ld de, SFX_ESCAPE_ROPE
	call PlaySFX

	ld c, 16
	call DelayFrames

	ld hl, Shrink1Pic
	call ShrinkFrame

	ld c, 16
	call DelayFrames

	ld hl, Shrink2Pic
	call ShrinkFrame

	ld c, 16
	call DelayFrames

	hlcoord 6, 4
	lb bc, 7, 7
	call ClearBox

	ld c, 6
	call DelayFrames

	call Intro_PlacePlayerSprite
	call LoadFrame

	ld c, 50
	call DelayFrames

	ld c, 15
	call FadeToWhite
	jmp ClearTileMap

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
	ld b, CAL
	and a ; PLAYER_MALE
	jr z, .ok
	assert CAL - 1 == CARRIE
	dec b
	dec a ; PLAYER_FEMALE
	jr z, .ok
	; PLAYER_ENBY
	ld b, JACKY
.ok
	ld a, b
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

	ld hl, wShadowOAM
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
	ld a, [wPlayerGender] ; 0=male, 1=female, or 2=enby
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
	farcall SplashScreen
	jr c, StartTitleScreen
	farcall CrystalIntro

StartTitleScreen:
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a

	farcall _TitleScreen
	call DelayFrame
.loop
	call RunTitleScreen
	jr nc, .loop

	call ClearSprites
	call ClearBGPalettes

	pop af
	ldh [rWBK], a

	ld hl, rLCDC
	res B_LCDC_OBJ_SIZE, [hl]
	call ClearScreen
	call ApplyAttrAndTilemapInVBlank
	ld hl, rIE
	res B_IE_STAT, [hl]
	xor a
	ldh [hLCDCPointer], a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	ld a, CGB_PLAIN
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

	ld hl, rIE
	res B_IE_STAT, [hl]
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
	ld e, MUSIC_TITLE
	ld a, [wSaveFileExists]
	and a
	jr z, .ok
	ld hl, wStatusFlags
	bit 6, [hl] ; hall of fame
	jr z, .ok
	ld e, MUSIC_TITLE_XY
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
	ld hl, wTitleScreenTimer
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

TitleScreenMain:
; Run the timer down.
	ld hl, wTitleScreenTimer
	ld a, [hli]
	ld d, [hl]
	ld e, a
	or d
	jr z, .end

	dec de
	ld a, d
	ld [hld], a
	ld [hl], e

	call GetJoypad
	ld hl, hJoyDown

; Save data can be deleted by pressing Up + B + Select.
	ld a, [hl]
	or ~(PAD_UP + PAD_B + PAD_SELECT)
	inc a
	jr z, .delete_save_data

; The clock can be reset by pressing Down + B.
	ld a, [hl]
	or ~(PAD_DOWN + PAD_B)
	inc a
	jr z, .clock_reset

; The early game options can be reset by pressing Left + B.
	ld a, [hl]
	or ~(PAD_LEFT + PAD_B)
	inc a
	jr z, .early_option_reset

; Press Start or A to start the game.
	ld a, [hl]
	and PAD_START | PAD_A
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

	ld hl, wTitleScreenTimer
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

	ld hl, wTitleScreenTimer
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
	jmp Init

ResetClock:
	farcall _ResetClock
	jmp Init

ResetInitialOptions:
	farcall _ResetInitialOptions
	jmp Init

Copyright:
	call ClearTileMap
	call LoadFrame
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
	db $60, $61, $62, $63, $64, $65, $66
	db $67, $68, $69, $6a, $6b, $6c

	; ©1995-2001 Creatures inc.
	db "<NEXT>"
	db $60, $61, $62, $63, $64, $65, $66
	db $6d, $6e, $6f, $70, $71, $72, $7a, $7b, $7c

	; ©1995-2001 GAME FREAK inc.
	db "<NEXT>"
	db $60, $61, $62, $63, $64, $65, $66
	db $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c, "@"
