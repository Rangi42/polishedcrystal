; Replaces the functionality of sgb.asm to work with CGB hardware.

Predef_LoadCGBLayout: ; 8d59
	ld a, b
	cp SCGB_RAM
	jr nz, .not_ram
	ld a, [SGBPredef]
.not_ram
	cp SCGB_PARTY_MENU_HP_PALS
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
	ld de, UnknBGPals
rept 8
	ld hl, DarkGrayPalette
	call LoadHLPaletteIntoDE
endr
	ld de, UnknOBPals
rept 2
	ld hl, DarkGrayPalette
	call LoadHLPaletteIntoDE
endr
	jp _CGB_FinishBattleScreenLayout


_CGB_BattleColors: ; 8ddb
	push bc
	ld de, UnknBGPals
	call GetBattlemonBackpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ld a, [TempBattleMonSpecies]
	and a
	jr z, .player_backsprite
	push de
	; hl = DVs
	farcall GetPartyMonDVs
	; b = species
	ld a, [TempBattleMonSpecies]
	ld b, a
	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	ld hl, UnknBGPals + 2
	call VaryColorsByDVs
	pop de
.player_backsprite

	call GetEnemyFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	push de
	; hl = DVs
	farcall GetEnemyMonDVs
	; b = species
	ld a, [TempEnemyMonSpecies]
	ld b, a
	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	ld hl, UnknBGPals + 1 palettes + 2
	call VaryColorsByDVs
	pop de

	ld a, [EnemyHPPal]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, HPBarInteriorPals
	add hl, bc
	call LoadPalette_White_Col1_Col2_Black

	ld a, [PlayerHPPal]
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

	ld hl, UnknBGPals
	ld de, UnknBGPals + 6 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, UnknBGPals + 1 palettes
	ld de, UnknOBPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, UnknBGPals
	ld de, UnknOBPals + 1 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld a, SCGB_BATTLE_COLORS
	ld [SGBPredef], a
	call ApplyPals

_CGB_FinishBattleScreenLayout: ; 8e23
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $2
	call ByteFill
	pop bc

	hlcoord 0, 4, AttrMap
	lb bc, 8, 10
	xor a
	call FillBoxCGB

	hlcoord 10, 0, AttrMap
	lb bc, 7, 10
	ld a, $1
	call FillBoxCGB

	hlcoord 0, 0, AttrMap
	lb bc, 4, 10
	ld a, $2
	call FillBoxCGB

	hlcoord 10, 7, AttrMap
	lb bc, 5, 10
	ld a, $3
	call FillBoxCGB

	hlcoord 12, 11, AttrMap
	lb bc, 1, 7
	ld a, $4
	call FillBoxCGB

	ld a, $4
	hlcoord 1, 1, AttrMap
	ld [hl], a
	hlcoord 8, 1, AttrMap
	ld [hl], a
	hlcoord 18, 8, AttrMap
	ld [hl], a
	hlcoord 12, 8, AttrMap
	lb bc, 1, 2
	ld a, $5
	call FillBoxCGB

	hlcoord 2, 1, AttrMap
	lb bc, 1, 2
	ld a, $5
	call FillBoxCGB

	hlcoord 1, 9, AttrMap
	lb bc, 1, 6
	ld a, $6
	call FillBoxCGB

	hlcoord 0, 12, AttrMap
	ld bc, 6 * SCREEN_WIDTH
	ld a, $7
	call ByteFill

	ld hl, BattleObjectPals
	ld de, UnknOBPals + 2 palettes
	ld bc, 6 palettes
	ld a, $5
	call FarCopyWRAM

	jp ApplyAttrMap
; 8e85


_CGB_PokegearPals: ; 8eb9
	ld hl, PokegearPals
	ld de, UnknBGPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM

	ld a, [PlayerGender]
	bit 0, a
	jr z, .male
	ld hl, FemalePokegearInterfacePalette
	ld de, UnknBGPals + 3 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
.male

	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 8edb


_CGB_StatsScreenHPPals: ; 8edb
	ld de, UnknBGPals
	ld a, [wCurHPPal]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, HPBarInteriorPals
	add hl, bc
	call LoadPalette_White_Col1_Col2_Black

	ld a, [CurPartySpecies]
	ld bc, TempMonPersonality
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
	ld a, [TempMonCaughtBall]
	and CAUGHTBALL_MASK
	call AddNTimes
	ld de, UnknBGPals + 7 palettes
	call LoadPalette_White_Col1_Col2_Black

	call WipeAttrMap

	hlcoord 0, 0, AttrMap
	lb bc, 8, SCREEN_WIDTH
	ld a, $1
	call FillBoxCGB

	hlcoord 12, 16, AttrMap
	ld bc, 7
	ld a, $2
	call ByteFill

	hlcoord 11, 5, AttrMap
	lb bc, 2, 2
	ld a, $3
	call FillBoxCGB

	hlcoord 13, 5, AttrMap
	lb bc, 2, 2
	ld a, $4
	call FillBoxCGB

	hlcoord 15, 5, AttrMap
	lb bc, 2, 2
	ld a, $5
	call FillBoxCGB

	hlcoord 17, 5, AttrMap
	lb bc, 2, 2
	ld a, $6
	call FillBoxCGB

	hlcoord 8, 6, AttrMap
	lb bc, 1, 1
	ld a, $7
	call FillBoxCGB

	jp _CGB_FinishLayout
; 8f52


_CGB_Pokedex: ; 8f70
	ld de, UnknBGPals
	ld hl, PokedexRedPalette
	call LoadHLPaletteIntoDE

	ld a, [CurPartySpecies]
	cp $ff
	jr nz, .is_pokemon
	ld hl, .GreenPicPalette
	call LoadHLPaletteIntoDE
	jr .got_palette
.is_pokemon
	call GetMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
.got_palette

	call WipeAttrMap

	hlcoord 1, 1, AttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB

	ld hl, .SlowpokePalette
	ld de, UnknOBPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, .CursorPalette
	ld de, UnknOBPals + 7 palettes
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

.SlowpokePalette:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 14, 14, 14
	RGB 31, 07, 01
	RGB 00, 00, 00
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
	ld de, UnknBGPals
	ld bc, 16 palettes
	ld a, $5
	call FarCopyWRAM

	call WipeAttrMap

	hlcoord 0, 2, AttrMap
	lb bc, 10, 3
	ld a, $2
	call FillBoxCGB

	hlcoord 17, 2, AttrMap
	lb bc, 10, 3
	ld a, $2
	call FillBoxCGB

	hlcoord 0, 4, AttrMap
	lb bc, 6, 3
	ld a, $3
	call FillBoxCGB

	hlcoord 17, 4, AttrMap
	lb bc, 6, 3
	ld a, $3
	call FillBoxCGB

	hlcoord 0, 6, AttrMap
	lb bc, 2, 3
	ld a, $4
	call FillBoxCGB

	hlcoord 17, 6, AttrMap
	lb bc, 2, 3
	ld a, $4
	call FillBoxCGB

	hlcoord 4, 2, AttrMap
	lb bc, 2, 12
	ld a, $1
	call FillBoxCGB

	hlcoord 3, 2, AttrMap
	lb bc, 10, 1
	ld a, $1
	call FillBoxCGB

	hlcoord 16, 2, AttrMap
	lb bc, 10, 1
	ld a, $1
	call FillBoxCGB

	hlcoord 0, 12, AttrMap
	ld bc, $78
	ld a, $7
	call ByteFill

	jp _CGB_FinishLayout
; 90f8


_CGB_Diploma: ; 91ad
	ld hl, DiplomaPals
	ld de, UnknBGPals
	ld bc, 16 palettes
	ld a, $5
	call FarCopyWRAM

	ld de, UnknBGPals
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
	ld a, SCGB_MAPPALS
	ld [SGBPredef], a
	ret
; 91d1


_CGB_PartyMenu: ; 91d1
	ld de, UnknBGPals
	ld hl, .PartyMenuBGPalette
	call LoadHLPaletteIntoDE

	ld hl, HPBarPals
rept 3
	call LoadHLPaletteIntoDE
endr

	ld hl, GenderAndExpBarPals
	call LoadPalette_White_Col1_Col2_Black

	ld de, UnknBGPals + 7 palettes
	ld hl, .PartyMenuBGPalette
	call LoadHLPaletteIntoDE

	call InitPartyMenuOBPals

	hlcoord 10, 2, AttrMap
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
	ld de, UnknBGPals
	ld a, c
	and a
	jr z, .pokemon
	ld hl, DarkGrayPalette
	call LoadHLPaletteIntoDE
	jr .got_palette

.pokemon
	ld hl, PartyMon1Personality
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [CurPartyMon]
	call AddNTimes
	ld c, l
	ld b, h
	ld a, [PlayerHPPal]
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	; hl = DVs
	ld hl, PartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [CurPartyMon]
	call AddNTimes
	; b = species
	ld a, [CurPartySpecies]
	ld b, a
	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	ld hl, UnknBGPals + 2
	call VaryColorsByDVs

	ld hl, BattleObjectPals
	ld de, UnknOBPals + 2 palettes
	ld bc, 6 palettes
	ld a, $5
	call FarCopyWRAM

.got_palette
	call WipeAttrMap
	jp _CGB_FinishLayout
; 9228


_CGB_MoveList: ; 9373
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $7
	call ByteFill

	hlcoord 1, 12, AttrMap
	ld bc, 6
	xor a
	call ByteFill

	ld a, [CurMove]
	dec a
	ld hl, Moves + MOVE_CATEGORY
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, CategoryIconPals
	ld c, a
	ld b, 0
rept 4
	add hl, bc
endr
	ld de, UnknBGPals + 2
	ld bc, 4
	ld a, $5
	call FarCopyWRAM

	ld a, [CurMove]
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, TypeIconPals
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 6
	ld bc, 2
	ld a, $5
	call FarCopyWRAM

	jp _CGB_FinishLayout
; 93a6


_CGB_PokedexSearchOption: ; 93ba
	ld de, UnknBGPals
	ld hl, PokedexRedPalette
	call LoadHLPaletteIntoDE

	call WipeAttrMap
	jp _CGB_FinishLayout
; 93d3


_CGB_BuyMenu: ; 9499
	ld hl, BuyMenuPals
	ld de, UnknBGPals
	ld bc, 5 palettes
	ld a, $5
	call FarCopyWRAM

	call WipeAttrMap

	hlcoord 6, 4, AttrMap
	lb bc, 7, 1
	ld a, $2
	call FillBoxCGB

	hlcoord 1, 8, AttrMap
	lb bc, 3, 3
	ld a, $4
	call FillBoxCGB

	jp _CGB_FinishLayout
; 94d0


_CGB_PackPals: ; 93d3
; pack pals
	ld a, [BattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .tutorial_female
	ld a, [PlayerGender]
	bit 0, a
	jr z, .male
.tutorial_female
	ld hl, FemalePackPals
	jr .got_gender
.male
	ld hl, MalePackPals
.got_gender
	ld de, UnknBGPals
	ld bc, 5 palettes
	ld a, $5
	call FarCopyWRAM

	call WipeAttrMap

	hlcoord 0, 0, AttrMap
	lb bc, 1, 10
	ld a, $0
	call FillBoxCGB

	hlcoord 10, 0, AttrMap
	lb bc, 1, 10
	ld a, $1
	call FillBoxCGB

	hlcoord 7, 2, AttrMap
	lb bc, 9, 1
	ld a, $2
	call FillBoxCGB

	hlcoord 0, 2, AttrMap
	lb bc, 5, 5
	ld a, $3
	call FillBoxCGB

	hlcoord 1, 8, AttrMap
	lb bc, 3, 3
	ld a, $4
	call FillBoxCGB

	jp _CGB_FinishLayout
; 9439


_CGB_TrainerCard: ; 9289
	ld de, UnknBGPals

	xor a ; CHRIS
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, KRIS ; also FALKNER
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

	ld a, CHUCK
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, JASMINE
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, CLAIR ; also PRYCE
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	; Badges
	ld hl, JohtoBadgePalettes
	ld de, UnknOBPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM

	; Border
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, [PlayerGender]
	and a
	ld a, $1
	jr z, .got_gender
	xor a
.got_gender
	call ByteFill

	; Player
	hlcoord 14, 1, AttrMap
	lb bc, 7, 5
	ld a, [PlayerGender]
	and a
	ld a, $0 ; not xor a; preserve carry flag
	jr z, .got_gender2
	ld a, $1
.got_gender2
	call FillBoxCGB

	; Falkner
	hlcoord 3, 10, AttrMap
	lb bc, 3, 3
	ld a, $1
	call FillBoxCGB

	; Bugsy
	hlcoord 7, 10, AttrMap
	lb bc, 3, 3
	ld a, $2
	call FillBoxCGB

	; Whitney
	hlcoord 11, 10, AttrMap
	lb bc, 3, 3
	ld a, $3
	call FillBoxCGB

	; Morty
	hlcoord 15, 10, AttrMap
	lb bc, 3, 3
	ld a, $4
	call FillBoxCGB

	; Chuck
	hlcoord 3, 13, AttrMap
	lb bc, 3, 3
	ld a, $5
	call FillBoxCGB

	; Jasmine
	hlcoord 7, 13, AttrMap
	lb bc, 3, 3
	ld a, $6
	call FillBoxCGB

	; Pryce
	hlcoord 11, 13, AttrMap
	lb bc, 3, 3
	ld a, $7
	call FillBoxCGB

	; Clair
	hlcoord 15, 13, AttrMap
	lb bc, 3, 3
	ld a, $7
	call FillBoxCGB

	jp _CGB_FinishLayout
; 9373


_CGB_TrainerCard2:
	ld de, UnknBGPals
	xor a ; CHRIS
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, KRIS
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, BROCK
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, SABRINA ; also BLAINE
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	ld a, ERIKA ; also LT_SURGE
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
	ld de, UnknOBPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM

	; Border
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, [PlayerGender]
	and a
	ld a, $1
	jr z, .got_gender
	xor a
.got_gender
	call ByteFill

	; Player
	hlcoord 14, 1, AttrMap
	lb bc, 7, 5
	ld a, [PlayerGender]
	and a
	ld a, $0 ; not xor a; preserve carry flag
	jr z, .got_gender2
	ld a, $1
.got_gender2
	call FillBoxCGB

	; Lt.Surge
	hlcoord 3, 10, AttrMap
	lb bc, 3, 3
	ld a, $4
	call FillBoxCGB

	; Sabrina
	hlcoord 7, 10, AttrMap
	lb bc, 3, 3
	ld a, $3
	call FillBoxCGB

	; Misty
	hlcoord 11, 10, AttrMap
	lb bc, 3, 3
	ld a, $5
	call FillBoxCGB

	; Erika
	hlcoord 15, 10, AttrMap
	lb bc, 3, 3
	ld a, $4
	call FillBoxCGB

	; Janine
	hlcoord 3, 13, AttrMap
	lb bc, 3, 3
	ld a, $6
	call FillBoxCGB

	; Brock
	hlcoord 7, 13, AttrMap
	lb bc, 3, 3
	ld a, $2
	call FillBoxCGB

	; Blaine
	hlcoord 11, 13, AttrMap
	lb bc, 3, 3
	ld a, $3
	call FillBoxCGB

	; Blue
	hlcoord 15, 13, AttrMap
	lb bc, 3, 3
	ld a, $7
	call FillBoxCGB

	jp _CGB_FinishLayout


_CGB_PokedexUnownMode: ; 903e
	ld de, UnknBGPals
	ld hl, PokedexRedPalette
	call LoadHLPaletteIntoDE

	ld a, [CurPartySpecies]
	call GetMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	call WipeAttrMap

	hlcoord 7, 5, AttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB

	call InitPartyMenuOBPals

	jp _CGB_FinishLayout
; 906e


_CGB_BillsPC: ; 8fca
	ld de, UnknBGPals
	ld hl, PokedexRedPalette
	call LoadHLPaletteIntoDE

	ld a, [CurPartySpecies]
	cp $ff
	jr nz, .GetMonPalette
	ld hl, .OrangePalette
	call LoadHLPaletteIntoDE
	jr .Resume

.GetMonPalette:
	ld bc, TempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call VaryBGPal1ByTempMonDVs

.Resume:
	call WipeAttrMap

	hlcoord 1, 4, AttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB

	call InitPartyMenuOBPals

	jp _CGB_FinishLayout
; 9009

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
	ld de, UnknBGPals
	ld hl, .UnownPuzzlePalette
	call LoadHLPaletteIntoDE

	ld de, UnknOBPals
	ld hl, .UnownPuzzlePalette
	call LoadHLPaletteIntoDE

	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld hl, UnknOBPals
if !DEF(MONOCHROME)
	; RGB 31, 00, 00
	ld a, $1f
	ld [hli], a
	xor a
	ld [hl], a
else
	; RGB 31, 31, 31
	xor a
	ld a, $ff
	ld [hli], a
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
	ld de, UnknBGPals
	ld hl, .GameFreakLogoPalette
	call LoadHLPaletteIntoDE

	ld de, UnknOBPals
rept 2
	ld hl, .GameFreakDittoPalette
	call LoadHLPaletteIntoDE
endr

	call WipeAttrMap
	call ApplyAttrMap
	jp ApplyPals
; 9521

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
	ld de, UnknBGPals
	ld hl, .TradeTubeBluePalette
	call LoadHLPaletteIntoDE

	ld hl, .TradeTubeRedPalette
	ld de, UnknOBPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	ld de, UnknOBPals + 7 palettes
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
	ld de, UnknBGPals
	ld a, [CurPartySpecies]
	ld bc, TempMonPersonality
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

	hlcoord 0, 0, AttrMap
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
	ld de, UnknBGPals
	ld a, [CurPartySpecies]
	ld bc, TempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call VaryBGPal0ByTempMonDVs
	call WipeAttrMap
	call ApplyAttrMap
	jp ApplyPals
; 9542


_CGB_TrainerOrMonFrontpicPals: ; 9578
	ld de, UnknBGPals
	ld a, [CurPartySpecies]
	ld bc, TempMonPersonality
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
