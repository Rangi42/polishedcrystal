Predef_LoadCGBLayout: ; 8d59
	ld a, b
	cp CGB_RAM
	jr nz, .not_ram
	ld a, [wMemCGBLayout]
.not_ram
	cp CGB_PARTY_MENU_HP_PALS
	jp z, ApplyPartyMenuHPPals
	call ResetBGPals
	ld l, a
	ld h, 0
	add hl, hl
	ld de, .dw
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .ReturnFromJumpTable
	push de
	jp hl
; 8d79

.ReturnFromJumpTable: ; 8d79
	ret
; 8d7a

.dw ; 8d7a
	dw _CGB_BattleGrayscale
	dw _CGB_BattleColors
	dw _CGB_PokegearPals
	dw _CGB_PokedexAreaPals
	dw _CGB_StatsScreenHPPals
	dw _CGB_Pokedex
	dw _CGB_SlotMachine
	dw _CGB_Diploma
	dw _CGB_MapPals
	dw _CGB_PartyMenu
	dw _CGB_Evolution
	dw _CGB_MoveList
	dw _CGB_PokedexSearchOption
	dw _CGB_BuyMenu
	dw _CGB_PackPals
	dw _CGB_TrainerCard
	dw _CGB_TrainerCard2
	dw _CGB_TrainerCard3
	dw _CGB_PokedexUnownMode
	dw _CGB_BillsPC
	dw _CGB_UnownPuzzle
	dw _CGB_GameFreakLogo
	dw _CGB_TradeTube
	dw _CGB_IntroPals
	dw _CGB_PlayerOrMonFrontpicPals
	dw _CGB_TrainerOrMonFrontpicPals
; 8db8


_CGB_BattleGrayscale: ; 8db8
	push bc
	ld de, wUnknBGPals
rept 8
	ld hl, DarkGrayPalette
	call LoadHLPaletteIntoDE
endr
	ld de, wUnknOBPals
rept 2
	ld hl, DarkGrayPalette
	call LoadHLPaletteIntoDE
endr
	jp _CGB_FinishBattleScreenLayout


_CGB_BattleColors: ; 8ddb
	push bc
	ld de, wUnknBGPals
	call GetBattlemonBackpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ld a, [wTempBattleMonSpecies]
	and a
	jr z, .player_backsprite
	push de
	; hl = DVs
	farcall GetPartyMonDVs
	; b = species
	ld a, [wTempBattleMonSpecies]
	ld b, a
	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	ld hl, wUnknBGPals palette PAL_BATTLE_BG_PLAYER + 2
	call VaryColorsByDVs
	pop de
.player_backsprite

	call GetEnemyFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ld a, [wTempEnemyMonSpecies]
	and a
	jr z, .trainer_sprite
	push de
	; hl = DVs
	farcall GetEnemyMonDVs
	; b = species
	ld a, [wTempEnemyMonSpecies]
	ld b, a
	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	ld hl, wUnknBGPals palette PAL_BATTLE_BG_ENEMY + 2
	call VaryColorsByDVs
	pop de
.trainer_sprite

	ld a, [wEnemyHPPal]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, HPBarInteriorPals
	add hl, bc
	call LoadPalette_White_Col1_Col2_Black

	ld a, [wPlayerHPPal]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, HPBarInteriorPals
	add hl, bc
	call LoadPalette_White_Col1_Col2_Black

	ld hl, GenderAndExpBarPals
	call LoadPalette_White_Col1_Col2_Black

	call LoadPlayerStatusIconPalette
	call LoadEnemyStatusIconPalette

	ld hl, wUnknBGPals palette PAL_BATTLE_BG_PLAYER
	ld de, wUnknBGPals palette PAL_BATTLE_BG_TYPE_CAT
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, wUnknBGPals palette PAL_BATTLE_BG_ENEMY
	ld de, wUnknOBPals palette PAL_BATTLE_OB_ENEMY
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, wUnknBGPals palette PAL_BATTLE_BG_PLAYER
	ld de, wUnknOBPals palette PAL_BATTLE_OB_PLAYER
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld a, CGB_BATTLE_COLORS
	ld [wMemCGBLayout], a
	call ApplyPals

_CGB_FinishBattleScreenLayout: ; 8e23
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $2
	call ByteFill
	pop bc

	hlcoord 0, 4, wAttrMap
	lb bc, 8, 10
	xor a
	call FillBoxCGB

	hlcoord 10, 0, wAttrMap
	lb bc, 7, 10
	ld a, $1
	call FillBoxCGB

	hlcoord 0, 0, wAttrMap
	lb bc, 4, 10
	ld a, $2
	call FillBoxCGB

	hlcoord 10, 7, wAttrMap
	lb bc, 5, 10
	ld a, $3
	call FillBoxCGB

	hlcoord 12, 11, wAttrMap
	lb bc, 1, 7
	ld a, $4
	call FillBoxCGB

	ld a, $4
	hlcoord 1, 1, wAttrMap
	ld [hl], a
	hlcoord 8, 1, wAttrMap
	ld [hl], a
	hlcoord 18, 8, wAttrMap
	ld [hl], a
	hlcoord 12, 8, wAttrMap
	lb bc, 1, 2
	ld a, $5
	call FillBoxCGB

	hlcoord 2, 1, wAttrMap
	lb bc, 1, 2
	ld a, $5
	call FillBoxCGB

	hlcoord 1, 9, wAttrMap
	lb bc, 1, 6
	ld a, $6
	call FillBoxCGB

	hlcoord 0, 12, wAttrMap
	ld bc, 6 * SCREEN_WIDTH
	ld a, $7
	call ByteFill

	ld hl, BattleObjectPals
	ld de, wUnknOBPals palette PAL_BATTLE_OB_GRAY
	ld bc, 6 palettes
	ld a, $5
	call FarCopyWRAM

	jp ApplyAttrMap
; 8e85


_CGB_PokegearPals: ; 8eb9
	ld hl, PokegearPals
	ld de, wUnknBGPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM

	ld a, [wPlayerGender]
	bit 0, a
	jr z, .male
	ld hl, FemalePokegearInterfacePalette
	ld de, wUnknBGPals palette 0
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
.male

	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 8edb


_CGB_PokedexAreaPals:
	ld hl, PokegearPals
	ld de, wUnknBGPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, .InvertedGrayPalette
	ld de, wUnknBGPals palette 0
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret

.InvertedGrayPalette:
if !DEF(MONOCHROME)
	RGB 00, 00, 00
	RGB 21, 00, 21
	RGB 13, 00, 13
	RGB 31, 31, 31
else
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
endc


_CGB_StatsScreenHPPals: ; 8edb
	ld de, wUnknBGPals
	ld a, [wCurHPPal]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, HPBarInteriorPals
	add hl, bc
	call LoadPalette_White_Col1_Col2_Black

	ld a, [wCurPartySpecies]
	ld bc, wTempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	push de
	call VaryBGPal1ByTempMonDVs
	pop de

	ld hl, GenderAndExpBarPals
	call LoadPalette_White_Col1_Col2_Black

	ld hl, StatsScreenPals
	ld bc, 4 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, CaughtBallPals
	ld bc, $4
	ld a, [wTempMonCaughtBall]
	and CAUGHTBALL_MASK
	rst AddNTimes
	ld de, wUnknBGPals palette 7
	call LoadPalette_White_Col1_Col2_Black

	call WipeAttrMap

	hlcoord 0, 0, wAttrMap
	lb bc, 8, SCREEN_WIDTH
	ld a, $1
	call FillBoxCGB

	hlcoord 12, 16, wAttrMap
	ld bc, 7
	ld a, $2
	call ByteFill

	hlcoord 11, 5, wAttrMap
	lb bc, 2, 2
	ld a, $3
	call FillBoxCGB

	hlcoord 13, 5, wAttrMap
	lb bc, 2, 2
	ld a, $4
	call FillBoxCGB

	hlcoord 15, 5, wAttrMap
	lb bc, 2, 2
	ld a, $5
	call FillBoxCGB

	hlcoord 17, 5, wAttrMap
	lb bc, 2, 2
	ld a, $6
	call FillBoxCGB

	hlcoord 8, 6, wAttrMap
	lb bc, 1, 1
	ld a, $7
	call FillBoxCGB

	jp _CGB_FinishLayout
; 8f52


_CGB_Pokedex: ; 8f70
	ld de, wUnknBGPals
	ld hl, PokedexRedPalette
	call LoadHLPaletteIntoDE

	ld a, [wCurPartySpecies]
	cp $ff
	jr nz, .is_pokemon
	ld hl, .GreenPicPalette
	call LoadHLPaletteIntoDE
	jr .got_palette
.is_pokemon
	ld bc, wDexMonShiny
	call GetMonNormalOrShinyPalettePointer
	call LoadPalette_White_Col1_Col2_Black
.got_palette

	call WipeAttrMap

	hlcoord 1, 1, wAttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB

	ld hl, PokegearOBPals
	ld de, wUnknOBPals
	ld bc, 2 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, .CursorPalette
	ld de, wUnknOBPals palette 7
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	jp _CGB_FinishLayout
; 8fba

.GreenPicPalette: ; 8fba
if !DEF(MONOCHROME)
	RGB 11, 23, 00
	RGB 07, 17, 00
	RGB 06, 16, 03
	RGB 05, 12, 01
else
	MONOCHROME_RGB_FOUR
endc

.CursorPalette: ; 8fc2
if !DEF(MONOCHROME)
	RGB 00, 00, 00
	RGB 11, 23, 00
	RGB 07, 17, 00
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc
; 8fca


_CGB_SlotMachine: ; 906e
	ld hl, SlotMachinePals
	ld de, wUnknBGPals
	ld bc, 16 palettes
	ld a, $5
	call FarCopyWRAM

	call WipeAttrMap

	hlcoord 0, 2, wAttrMap
	lb bc, 10, 3
	ld a, $2
	call FillBoxCGB

	hlcoord 17, 2, wAttrMap
	lb bc, 10, 3
	ld a, $2
	call FillBoxCGB

	hlcoord 0, 4, wAttrMap
	lb bc, 6, 3
	ld a, $3
	call FillBoxCGB

	hlcoord 17, 4, wAttrMap
	lb bc, 6, 3
	ld a, $3
	call FillBoxCGB

	hlcoord 0, 6, wAttrMap
	lb bc, 2, 3
	ld a, $4
	call FillBoxCGB

	hlcoord 17, 6, wAttrMap
	lb bc, 2, 3
	ld a, $4
	call FillBoxCGB

	hlcoord 4, 2, wAttrMap
	lb bc, 2, 12
	ld a, $1
	call FillBoxCGB

	hlcoord 3, 2, wAttrMap
	lb bc, 10, 1
	ld a, $1
	call FillBoxCGB

	hlcoord 16, 2, wAttrMap
	lb bc, 10, 1
	ld a, $1
	call FillBoxCGB

	hlcoord 0, 12, wAttrMap
	ld bc, $78
	ld a, $7
	call ByteFill

	jp _CGB_FinishLayout
; 90f8


_CGB_Diploma: ; 91ad
	ld hl, DiplomaPals
	ld de, wUnknBGPals
	ld bc, 16 palettes
	ld a, $5
	call FarCopyWRAM

	ld de, wUnknBGPals
	ld hl, .DiplomaPalette
	call LoadHLPaletteIntoDE

	call WipeAttrMap
	jp ApplyAttrMap
; 91c8

.DiplomaPalette
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 30, 22, 17
	RGB 16, 14, 19
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc

_CGB_MapPals: ; 91c8
	call LoadMapPals
	ld a, CGB_MAPPALS
	ld [wMemCGBLayout], a
	ret
; 91d1


_CGB_PartyMenu: ; 91d1
	ld de, wUnknBGPals
	ld hl, .PartyMenuBGPalette
	call LoadHLPaletteIntoDE

	ld hl, HPBarPals
	call LoadHLPaletteIntoDE
	call LoadHLPaletteIntoDE
	call LoadHLPaletteIntoDE

	ld hl, GenderAndExpBarPals
	call LoadPalette_White_Col1_Col2_Black

	ld de, wUnknBGPals palette 7
	ld hl, .PartyMenuBGPalette
	call LoadHLPaletteIntoDE

	call InitPartyMenuOBPals

	hlcoord 10, 2, wAttrMap
	lb bc, 11, 1
	ld a, $4
	call FillBoxCGB
	jp ApplyAttrMap
; 91e4

.PartyMenuBGPalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 17, 19, 31
	RGB 14, 16, 31
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc

_CGB_Evolution: ; 91e4
	ld de, wUnknBGPals
	ld a, c
	and a
	jr z, .pokemon
	ld hl, DarkGrayPalette
	call LoadHLPaletteIntoDE
	jr .got_palette

.pokemon
	ld hl, wPartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld c, l
	ld b, h
	ld a, [wPlayerHPPal]
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	; hl = DVs
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	rst AddNTimes
	; b = species
	ld a, [wCurPartySpecies]
	ld b, a
	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	ld hl, wUnknBGPals palette 0 + 2
	call VaryColorsByDVs

	ld hl, BattleObjectPals
	ld de, wUnknOBPals palette 2
	ld bc, 6 palettes
	ld a, $5
	call FarCopyWRAM

.got_palette
	call WipeAttrMap
	jp _CGB_FinishLayout
; 9228


_CGB_MoveList: ; 9373
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $7
	call ByteFill

	hlcoord 1, 12, wAttrMap
	ld bc, 6
	xor a
	call ByteFill

	ld a, [wCurMove]
	dec a
	ld hl, Moves + MOVE_CATEGORY
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	add a
	add a
	ld hl, CategoryIconPals
	ld c, a
	ld b, 0
	add hl, bc
	ld de, wUnknBGPals palette 0 + 2
	ld bc, 4
	ld a, $5
	call FarCopyWRAM

	ld a, [wCurMove]
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, TypeIconPals
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld de, wUnknBGPals palette 0 + 6
	ld bc, 2
	ld a, $5
	call FarCopyWRAM

	jp _CGB_FinishLayout
; 93a6


_CGB_PokedexSearchOption: ; 93ba
	ld de, wUnknBGPals
	ld hl, PokedexRedPalette
	call LoadHLPaletteIntoDE

	call WipeAttrMap
	jp _CGB_FinishLayout
; 93d3


_CGB_BuyMenu: ; 9499
	ld a, [wEngineBuffer1]
	cp MARTTYPE_BLUECARD
	ld hl, BlueCardMartMenuPals
	jr z, .ok
	cp MARTTYPE_BP
	ld hl, BTMartMenuPals
	jr z, .ok
	ld hl, MartMenuPals
.ok
	ld de, wUnknBGPals
	ld bc, 3 palettes
	ld a, $5
	call FarCopyWRAM

rept 2
	ld hl, CancelPalette
	call LoadPalette_White_Col1_Col2_Black
endr

	call WipeAttrMap

	hlcoord 6, 4, wAttrMap
	lb bc, 7, 1
	ld a, $2
	call FillBoxCGB

	hlcoord 1, 8, wAttrMap
	lb bc, 3, 3
	ld a, $7
	call FillBoxCGB

	jp _CGB_FinishLayout
; 94d0


_CGB_PackPals: ; 93d3
; pack pals
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .tutorial_female
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .male
.tutorial_female
	ld hl, FemalePackPals
	jr .got_gender
.male
	ld hl, MalePackPals
.got_gender
	ld de, wUnknBGPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM

	call WipeAttrMap

	hlcoord 0, 0, wAttrMap
	ld a, $2
rept 6
	ld [hli], a
endr
	inc a
rept 3
	ld [hli], a
endr
	inc a
rept 4
	ld [hli], a
endr
	inc a
rept 5
	ld [hli], a
endr
	inc a
	ld [hli], a
	ld [hl], a

	ld a, $1
	hlcoord 7, 2, wAttrMap
	ld [hl], a
	hlcoord 7, 4, wAttrMap
	ld [hl], a
	hlcoord 7, 6, wAttrMap
	ld [hl], a
	hlcoord 7, 8, wAttrMap
	ld [hl], a
	hlcoord 7, 10, wAttrMap
	ld [hl], a
	hlcoord 0, 2, wAttrMap
	lb bc, 5, 5
	call FillBoxCGB

	hlcoord 1, 8, wAttrMap
	lb bc, 3, 3
	ld a, $7
	call FillBoxCGB

	jp _CGB_FinishLayout
; 9439


_CGB_TrainerCard:
	call LoadFirstTwoTrainerCardPals

	ld hl, BronzeTrainerCardPals
	call LoadPalette_White_Col1_Col2_Black

	ld hl, SilverTrainerCardPals
	call LoadPalette_White_Col1_Col2_Black

	ld hl, GoldTrainerCardPals
	call LoadPalette_White_Col1_Col2_Black

	ld hl, CrystalTrainerCardPals
	call LoadPalette_White_Col1_Col2_Black

	; Trainer stars
	hlcoord 2, 16, wAttrMap
	ld a, $2 ; bronze
	ld [hli], a
	inc a ; silver
	ld [hli], a
	inc a ; gold
	ld [hli], a
	inc a ; crystal
	ld [hl], a

	jp _CGB_FinishLayout


_CGB_TrainerCard2: ; 9289
	call LoadFirstTwoTrainerCardPals

	ld a, FALKNER
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, BUGSY
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, WHITNEY
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, MORTY
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, JASMINE ; CHUCK
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, CLAIR ; PRYCE
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	; Badges
	ld hl, JohtoBadgePalettes
	ld de, wUnknOBPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM

	; Falkner
	hlcoord 3, 10, wAttrMap
	lb bc, 3, 3
	ld a, $2
	call FillBoxCGB

	; Bugsy
	hlcoord 7, 10, wAttrMap
	lb bc, 3, 3
	ld a, $3
	call FillBoxCGB

	; Whitney
	hlcoord 11, 10, wAttrMap
	lb bc, 3, 3
	ld a, $4
	call FillBoxCGB

	; Morty
	hlcoord 15, 10, wAttrMap
	lb bc, 3, 3
	ld a, $5
	call FillBoxCGB

	; Chuck
	hlcoord 3, 13, wAttrMap
	lb bc, 3, 3
	ld a, $6
	call FillBoxCGB

	; Jasmine
	hlcoord 7, 13, wAttrMap
	lb bc, 3, 3
	ld a, $6
	call FillBoxCGB

	; Pryce
	hlcoord 11, 13, wAttrMap
	lb bc, 3, 3
	ld a, $7
	call FillBoxCGB

	; Clair
	hlcoord 15, 13, wAttrMap
	lb bc, 3, 3
	ld a, $7
	call FillBoxCGB

	jp _CGB_FinishLayout
; 9373


_CGB_TrainerCard3:
	call LoadFirstTwoTrainerCardPals

	ld a, BROCK
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, SABRINA ; BLAINE
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, ERIKA ; LT_SURGE
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, MISTY
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, JANINE
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, BLUE
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	; Badges
	ld hl, KantoBadgePalettes
	ld de, wUnknOBPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM

	; Lt.Surge
	hlcoord 3, 10, wAttrMap
	lb bc, 3, 3
	ld a, $4
	call FillBoxCGB

	; Sabrina
	hlcoord 7, 10, wAttrMap
	lb bc, 3, 3
	ld a, $3
	call FillBoxCGB

	; Misty
	hlcoord 11, 10, wAttrMap
	lb bc, 3, 3
	ld a, $5
	call FillBoxCGB

	; Erika
	hlcoord 15, 10, wAttrMap
	lb bc, 3, 3
	ld a, $4
	call FillBoxCGB

	; Janine
	hlcoord 3, 13, wAttrMap
	lb bc, 3, 3
	ld a, $6
	call FillBoxCGB

	; Brock
	hlcoord 7, 13, wAttrMap
	lb bc, 3, 3
	ld a, $2
	call FillBoxCGB

	; Blaine
	hlcoord 11, 13, wAttrMap
	lb bc, 3, 3
	ld a, $3
	call FillBoxCGB

	; Blue
	hlcoord 15, 13, wAttrMap
	lb bc, 3, 3
	ld a, $7
	call FillBoxCGB

	jp _CGB_FinishLayout


LoadFirstTwoTrainerCardPals:
	; trainer card
	ld c, VAR_TRAINER_STARS
	farcall _GetVarAction
	ld a, [wStringBuffer2]
	ld bc, TrainerCardPals
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, bc
	ld de, wUnknBGPals
	call LoadPalette_White_Col1_Col2_Black

	; player sprite
	ld a, [wPlayerGender]
	and a
	ld a, CHRIS
	jr z, .got_gender
	ld a, KRIS
.got_gender
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	push de
	; border
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill

	; player
	hlcoord 14, 1, wAttrMap
	lb bc, 7, 5
	ld a, $1
	call FillBoxCGB

	pop de
	ret


_CGB_PokedexUnownMode: ; 903e
	ld de, wUnknBGPals
	ld hl, PokedexRedPalette
	call LoadHLPaletteIntoDE

	ld a, [wCurPartySpecies]
	call GetMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	call WipeAttrMap

	hlcoord 7, 5, wAttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB

	call InitPartyMenuOBPals

	jp _CGB_FinishLayout
; 906e


_CGB_BillsPC: ; 8fca
	ld de, wUnknBGPals
	ld hl, .MenuPalette
	call LoadHLPaletteIntoDE

	ld a, [wCurPartySpecies]
	and a
	jr nz, .GetMonPalette
	ld hl, .OrangePalette
	call LoadHLPaletteIntoDE
	jr .Resume

.GetMonPalette:
	ld bc, wTempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call VaryBGPal1ByTempMonDVs

.Resume:
	call WipeAttrMap

	hlcoord 1, 4, wAttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB

	call InitPartyMenuOBPals

	jp _CGB_FinishLayout
; 9009

.MenuPalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 31, 20, 10
	RGB 26, 10, 06
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc

.OrangePalette: ; 9036
if !DEF(MONOCHROME)
	RGB 31, 15, 00
	RGB 23, 12, 00
	RGB 15, 07, 00
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc
; 903e


_CGB_UnownPuzzle: ; 925e
	ld de, wUnknBGPals
	ld hl, .UnownPuzzlePalette
	call LoadHLPaletteIntoDE

	ld de, wUnknOBPals
	ld hl, .UnownPuzzlePalette
	call LoadHLPaletteIntoDE

	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld hl, wUnknOBPals
if DEF(NOIR)
	ld a, (palred 9 + palgreen 9 + palblue 9) % $100
	ld [hli], a
	ld a, (palred 9 + palgreen 9 + palblue 9) % $100
	ld [hl], a
elif !DEF(MONOCHROME)
; RGB 31, 00, 00
	ld a, (palred 31 + palgreen 0 + palblue 0) % $100
	ld [hli], a
	xor a ; (palred 31 + palgreen 0 + palblue 0) % $100
	ld [hl], a
else
	ld a, PAL_MONOCHROME_WHITE % $100
	ld [hli], a
	ld a, PAL_MONOCHROME_WHITE / $100
	ld [hl], a
endc
	pop af
	ld [rSVBK], a

	call WipeAttrMap
	jp ApplyAttrMap
; 9289

.UnownPuzzlePalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 24, 20, 11
	RGB 18, 13, 11
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc


_CGB_GameFreakLogo: ; 94fa
	ld de, wUnknBGPals
	ld hl, .GameFreakLogoPalette
	call LoadHLPaletteIntoDE

	ld de, wUnknOBPals
rept 2
	ld hl, .GameFreakDittoPalette
	call LoadHLPaletteIntoDE
endr
	ret

.GameFreakLogoPalette:
if !DEF(MONOCHROME)
	RGB 00, 00, 00
	RGB 08, 11, 11
	RGB 21, 21, 21
	RGB 31, 31, 31
else
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
endc

.GameFreakDittoPalette: ; 9521
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 13, 11, 00
	RGB 23, 12, 28
	RGB 00, 00, 00
else
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
endc
; 9529


_CGB_TradeTube: ; 9555
	ld de, wUnknBGPals
	ld hl, .TradeTubeBluePalette
	call LoadHLPaletteIntoDE

	ld hl, .TradeTubeRedPalette
	ld de, wUnknOBPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld de, wUnknOBPals palette 7
	ld hl, .TradeTubeBluePalette
	call LoadHLPaletteIntoDE

	jp WipeAttrMap
; 9578

.TradeTubeBluePalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 18, 20, 27
	RGB 11, 15, 23
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc

.TradeTubeRedPalette:
if !DEF(MONOCHROME)
	RGB 27, 31, 27
	RGB 31, 19, 10
	RGB 31, 07, 04
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc


_CGB_IntroPals: ; 9591
	ld de, wUnknBGPals
	ld a, [wCurPartySpecies]
	ld bc, wTempMonPersonality
	call GetFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	push de
	call VaryBGPal0ByTempMonDVs
	pop de

	ld hl, .IntroGradientPalette
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	call WipeAttrMap

	hlcoord 0, 0, wAttrMap
	lb bc, 3, 20
	ld a, $1
	call FillBoxCGB

	call ApplyAttrMap
	jp ApplyPals
; 95e0

.IntroGradientPalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 27, 31, 31
	RGB 19, 31, 31
	RGB 09, 30, 31
else
	MONOCHROME_RGB_FOUR
endc


_CGB_PlayerOrMonFrontpicPals: ; 9529
	ld de, wUnknBGPals
	ld a, [wCurPartySpecies]
	ld bc, wTempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call VaryBGPal0ByTempMonDVs
	call WipeAttrMap
	call ApplyAttrMap
	jp ApplyPals
; 9542


_CGB_TrainerOrMonFrontpicPals: ; 9578
	ld de, wUnknBGPals
	ld a, [wCurPartySpecies]
	ld bc, wTempMonPersonality
	call GetFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call VaryBGPal0ByTempMonDVs
	call WipeAttrMap
	call ApplyAttrMap
	jp ApplyPals
; 9591


_CGB_FinishLayout:
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
