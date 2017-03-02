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
	jp [hl]
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
	dw _CGB06
	dw _CGB07
	dw _CGB08
	dw _CGB_MapPals
	dw _CGB0a
	dw _CGB0b
	dw _CGB0c
	dw _CGB0d
	dw _CGB0e
	dw _CGB0f
	dw _CGB_PokedexSearchOption
	dw _CGB11
	dw _CGB_Pokepic
	dw _CGB13
	dw _CGB_PackPals
	dw _CGB_TrainerCard
	dw _CGB_PokedexUnownMode
	dw _CGB17
	dw _CGB18
	dw _CGB19
	dw _CGB1a
	dw _CGB1b
	dw _CGB_FrontpicPals
	dw _CGB_IntroPals
	dw _CGB_IntroNamingPals
	dw _CGB_TrainerCard2
; 8db8

_CGB_BattleGrayscale: ; 8db8
	push bc
	ld hl, PalPacket_9c66 + 1
	ld de, UnknBGPals
	ld c, $4
	call CopyPalettes
	ld hl, PalPacket_9c66 + 1
	ld de, UnknBGPals + 4 palettes
	ld c, $4
	call CopyPalettes
	ld hl, PalPacket_9c66 + 1
	ld de, UnknOBPals
	ld c, $2
	call CopyPalettes
	jr _CGB_FinishBattleScreenLayout

_CGB_BattleColors: ; 8ddb
	push bc
	ld de, UnknBGPals
	call GetBattlemonBackpicPalettePointer
	push hl
	call LoadPalette_White_Col1_Col2_Black
	call GetEnemyFrontpicPalettePointer
	push hl
	call LoadPalette_White_Col1_Col2_Black
	ld a, [EnemyHPPal]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, Palettes_a8be
	add hl, bc
	call LoadPalette_White_Col1_Col2_Black
	ld a, [PlayerHPPal]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, Palettes_a8be
	add hl, bc
	call LoadPalette_White_Col1_Col2_Black
	ld hl, Palettes_a8ca
	call LoadPalette_White_Col1_Col2_Black
	call LoadPlayerStatusIconPalette
	call LoadEnemyStatusIconPalette
	ld hl, UnknBGPals
	ld de, UnknBGPals + 6 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	ld de, UnknOBPals
	pop hl
	call LoadPalette_White_Col1_Col2_Black
	pop hl
	call LoadPalette_White_Col1_Col2_Black
	ld a, SCGB_BATTLE_COLORS
	ld [SGBPredef], a
	call ApplyPals
_CGB_FinishBattleScreenLayout: ; 8e23
;	call InitPartyMenuBGPal7
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
	hlcoord 12, 8, AttrMap
	lb bc, 1, 2
	ld a, $5
	call FillBoxCGB
	hlcoord 2, 1, AttrMap
	lb bc, 1, 2
	ld a, $5
	call FillBoxCGB
	hlcoord 0, 8, AttrMap
	lb bc, 4, 10
	ld a, $6
	call FillBoxCGB
	hlcoord 0, 12, AttrMap
	ld bc, 6 * SCREEN_WIDTH
	ld a, $7
	call ByteFill
	ld hl, Palettes_979c
	ld de, UnknOBPals + 2 palettes
	ld bc, 6 palettes
	ld a, $5
	call FarCopyWRAM
	call ApplyAttrMap
	ret
; 8e85

LoadPlayerStatusIconPalette:
	ld a, [PlayerSubStatus2]
	ld de, BattleMonStatus
	farcall GetStatusConditionIndex
	ld hl, StatusIconPalettes
	ld a, b
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 5 palettes + 2
	ld bc, 2
	ld a, $5
	call FarCopyWRAM
	ret

LoadEnemyStatusIconPalette:
	ld a, [EnemySubStatus2]
	ld de, EnemyMonStatus
	farcall GetStatusConditionIndex
	ld hl, StatusIconPalettes
	ld a, b
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 5 palettes + 4
	ld bc, 2
	ld a, $5
	call FarCopyWRAM
	ret

StatusIconPalettes:
; OK
	RGB 31, 31, 31
; PSN
	RGB 26, 11, 23
; PAR
	RGB 24, 23, 05
; SLP
	RGB 20, 20, 16
; BRN
	RGB 31, 13, 09
; FRZ
	RGB 15, 22, 28
; FNT
	RGB 25, 00, 00
; TOX
	RGB 27, 06, 28

LoadBattleCategoryAndTypePalettes:
	ld hl, CategoryIconPalettes
	ld a, [wPlayerMoveStruct + MOVE_CATEGORY]
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 6 palettes + 2
	ld bc, 2
	ld a, $5
	call FarCopyWRAM

	ld hl, TypeIconPalettes
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 6 palettes + 4
	ld bc, 2
	ld a, $5
	call FarCopyWRAM
	ret

CategoryIconPalettes:
; PHYSICAL
	RGB 27, 04, 02
; SPECIAL
	RGB 00, 14, 29
; STATUS
	RGB 21, 21, 14

TypeIconPalettes:
; NORMAL
	RGB 21, 21, 14
; FIGHTING
	RGB 27, 04, 02
; FLYING
	RGB 22, 17, 30
; POISON
	RGB 22, 07, 19
; GROUND
	RGB 29, 24, 12
; ROCK
	RGB 24, 20, 07
; BUG
	RGB 21, 23, 06
; GHOST
	RGB 15, 11, 18
; STEEL
	RGB 23, 23, 25
; FIRE
	RGB 31, 15, 04
; WATER
	RGB 11, 18, 30
; GRASS
	RGB 11, 25, 11
; ELECTRIC
	RGB 31, 24, 06
; PSYCHIC
	RGB 31, 09, 15
; ICE
	RGB 16, 27, 27
; DRAGON
	RGB 15, 07, 31
; DARK
	RGB 15, 11, 09
; FAIRY
	RGB 31, 20, 29
; UNKNOWN T
	RGB 13, 19, 19

InitPartyMenuBGPal7: ; 8e85
	ld hl, Palette_b311
	ld de, UnknBGPals + 7 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	ret
; 8e9f

InitPartyMenuBGPal0: ; 8e9f
	ld hl, Palette_b311
	ld de, UnknBGPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	ret
; 8eb9

_CGB_PokegearPals: ; 8eb9
	ld a, [PlayerGender]
	bit 0, a
	jr z, .male
	ld hl, FemalePokegearPals
	jr .got_pals

.male
	ld hl, MalePokegearPals
.got_pals
	ld de, UnknBGPals
	ld bc, 8 palettes
	ld a, $5
	call FarCopyWRAM
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 8edb

_CGB_StatsScreenHPPals: ; 8edb
	ld de, UnknBGPals
	ld a, [wcda1]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld bc, Palettes_a8be
	add hl, bc
	call LoadPalette_White_Col1_Col2_Black
	ld a, [CurPartySpecies]
	ld bc, TempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ld hl, Palettes_a8ca
	call LoadPalette_White_Col1_Col2_Black

	ld hl, Palette8f52
	ld de, UnknBGPals + 3 palettes
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

	hlcoord 10, 16, AttrMap
	ld bc, 10
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

	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 8f52

Palette8f52: ; 8f52
; pink
	RGB 31, 31, 31
	RGB 31, 19, 31
	RGB 31, 15, 31
	RGB 00, 00, 00
; green
	RGB 31, 31, 31
	RGB 21, 31, 14
	RGB 17, 31, 00
	RGB 00, 00, 00
; blue
	RGB 31, 31, 31
	RGB 17, 31, 31
	RGB 17, 31, 31
	RGB 00, 00, 00
; orange
	RGB 31, 31, 31
	RGB 30, 24, 16
	RGB 30, 22, 12
	RGB 00, 00, 00
; 8f6a

StatsScreenPals: ; 8f6a
; pink
	RGB 31, 19, 31
; green
	RGB 21, 31, 14
; blue
	RGB 17, 31, 31
; orange
	RGB 30, 24, 16
; 8f70

_CGB_Pokedex: ; 8f70
	ld de, UnknBGPals
	ld a, $1d
	call GetPredefPal
	call LoadHLPaletteIntoDE
	ld a, [CurPartySpecies]
	cp $ff
	jr nz, .is_pokemon
	ld hl, Palette8fba
	call LoadHLPaletteIntoDE
	jr .got_palette

.is_pokemon
	call GetMonPalettePointer_
	call LoadPalette_White_Col1_Col2_Black
.got_palette
	call WipeAttrMap
	hlcoord 1, 1, AttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB
	call InitPartyMenuOBPals
	ld hl, Palette8fc2
	ld de, UnknOBPals + 7 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 8fba

Palette8fba: ; 8fba
	RGB 11, 23, 00
	RGB 07, 17, 00
	RGB 06, 16, 03
	RGB 05, 12, 01

Palette8fc2: ; 8fc2
	RGB 00, 00, 00
	RGB 11, 23, 00
	RGB 07, 17, 00
	RGB 00, 00, 00
; 8fca

_CGB17: ; 8fca
	ld de, UnknBGPals
	ld a, $1d
	call GetPredefPal
	call LoadHLPaletteIntoDE
	ld a, [CurPartySpecies]
	cp $ff
	jr nz, .GetMonPalette
	ld hl, Palette9036
	call LoadHLPaletteIntoDE
	jr .Resume

.GetMonPalette:
	ld bc, TempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
.Resume:
	call WipeAttrMap
	hlcoord 1, 4, AttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB
	call InitPartyMenuOBPals
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 9009

Palette9036: ; 9036
	RGB 31, 15, 00
	RGB 23, 12, 00
	RGB 15, 07, 00
	RGB 00, 00, 00
; 903e

_CGB_PokedexUnownMode: ; 903e
	ld de, UnknBGPals
	ld a, $1d
	call GetPredefPal
	call LoadHLPaletteIntoDE
	ld a, [CurPartySpecies]
	call GetMonPalettePointer_
	call LoadPalette_White_Col1_Col2_Black
	call WipeAttrMap
	hlcoord 7, 5, AttrMap
	lb bc, 7, 7
	ld a, $1
	call FillBoxCGB
	call InitPartyMenuOBPals
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 906e

_CGB_SlotMachine: ; 906e
	ld hl, Palettes_b7a9
	ld de, UnknBGPals
	ld bc, $80
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
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 90f8

_CGB06: ; 90f8
	ld hl, PalPacket_9ca6 + 1
	call CopyFourPalettes
	call WipeAttrMap
	ld de, UnknOBPals
	ld a, $3c
	call GetPredefPal
	call LoadHLPaletteIntoDE
	hlcoord 0, 6, AttrMap
	lb bc, 12, SCREEN_WIDTH
	ld a, $1
	call FillBoxCGB
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 9122

_CGB07: ; 9122
	ld b, 0
	ld hl, Jumptable_912d
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp [hl]
; 912d

Jumptable_912d: ; 912d
	dw Function9133
	dw Function9166
	dw Function9180
; 9133

Function9133: ; 9133
	ld hl, Palette_914e
	ld de, UnknBGPals
	call LoadHLPaletteIntoDE
	ld hl, Palette_9156
	ld de, UnknOBPals
	ld bc, 2 palettes
	ld a, $5
	call FarCopyWRAM
	call WipeAttrMap
	ret
; 914e

Palette_914e: ; 914e
	RGB 19, 31, 19
	RGB 18, 23, 31
	RGB 11, 21, 28
	RGB 04, 16, 24

Palette_9156: ; 9156
	RGB 29, 29, 29
	RGB 20, 19, 20
	RGB 19, 06, 04
	RGB 03, 04, 06

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 00, 00
	RGB 03, 04, 06
; 9166

Function9166: ; 9166
	ld de, UnknBGPals
	ld a, $38
	call GetPredefPal
	call LoadHLPaletteIntoDE

	ld de, UnknOBPals
	ld a, $39
	call GetPredefPal
	call LoadHLPaletteIntoDE
	call WipeAttrMap
	ret
; 9180

Function9180: ; 9180
	ld hl, PalPacket_9c36 + 1
	call CopyFourPalettes
	ld de, UnknOBPals
	ld a, $3a
	call GetPredefPal
	call LoadHLPaletteIntoDE
	call WipeAttrMap
	ret
; 9195

_CGB11: ; 9195
	ld hl, Palettes_b789
	ld de, UnknBGPals
	ld bc, 5 palettes
	ld a, $5
	call FarCopyWRAM
	call ApplyPals
	call WipeAttrMap
	call ApplyAttrMap
	ret
; 91ad

_CGB08: ; 91ad
	ld hl, Palettes_b641
	ld de, UnknBGPals
	ld bc, 16 palettes
	ld a, $5
	call FarCopyWRAM

	ld hl, PalPacket_9cb6 + 1
	call CopyFourPalettes
	call WipeAttrMap
	call ApplyAttrMap
	ret
; 91c8

_CGB_MapPals: ; 91c8
	call LoadMapPals
	ld a, SCGB_MAPPALS
	ld [SGBPredef], a
	ret
; 91d1

_CGB0a: ; 91d1
	ld hl, PalPacket_9c56 + 1
	call CopyFourPalettes
	call InitPartyMenuBGPal0
	call InitPartyMenuBGPal7
	call InitPartyMenuOBPals
	call ApplyAttrMap
	ret
; 91e4

_CGB0b: ; 91e4
	ld de, UnknBGPals
	ld a, c
	and a
	jr z, .pokemon
	ld a, $1a
	call GetPredefPal
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
	ld hl, Palettes_979c
	ld de, UnknOBPals + 2 palettes
	ld bc, 6 palettes
	ld a, $5
	call FarCopyWRAM

.got_palette
	call WipeAttrMap
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 9228

_CGB0c: ; 9228
	ld hl, Palettes_b6f1
	ld de, UnknBGPals
	ld bc, 5 palettes
	ld a, $5
	call FarCopyWRAM
	ld hl, Palettes_b719
	ld de, UnknOBPals
	ld bc, 2 palettes
	ld a, $5
	call FarCopyWRAM
	ld a, SCGB_08
	ld [SGBPredef], a
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 9251

_CGB0d: ; 9251
	ld hl, PalPacket_9cb6 + 1
	call CopyFourPalettes
	call WipeAttrMap
	call ApplyAttrMap
	ret
; 925e

_CGB18: ; 925e
	ld hl, PalPacket_9bc6 + 1
	call CopyFourPalettes
	ld de, UnknOBPals
	ld a, $4c
	call GetPredefPal
	call LoadHLPaletteIntoDE
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld hl, UnknOBPals
	ld a, $1f
	ld [hli], a
	xor a
	ld [hl], a
	pop af
	ld [rSVBK], a
	call WipeAttrMap
	call ApplyAttrMap
	ret
; 9289

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
	ld a, $5 ; BANK(UnknOBPals)
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
	ld a, 0 ; not xor a; preserve carry flag
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
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 9373

JohtoBadgePalettes:
; Zephyr Badge
	RGB 31, 31, 31
	RGB 21, 21, 24
	RGB 13, 13, 16
	RGB 00, 00, 00
; Hive Badge
	RGB 31, 31, 31
	RGB 31, 12, 12
	RGB 29, 00, 00
	RGB 00, 00, 00
; Plain Badge
	RGB 31, 31, 31
	RGB 29, 29, 29
	RGB 27, 24, 00
	RGB 00, 00, 00
; Fog Badge
	RGB 31, 31, 31
	RGB 23, 22, 26
	RGB 11, 10, 23
	RGB 00, 00, 00
; Storm Badge
	RGB 31, 31, 31
	RGB 27, 16, 08
	RGB 12, 07, 04
	RGB 00, 00, 00
; Mineral Badge
	RGB 31, 31, 31
	RGB 23, 26, 29
	RGB 15, 19, 23
	RGB 00, 00, 00
; Glacier Badge
	RGB 31, 31, 31
	RGB 19, 27, 30
	RGB 00, 22, 26
	RGB 00, 00, 00
; Rising Badge
	RGB 31, 31, 31
	RGB 30, 09, 05
	RGB 05, 05, 06
	RGB 00, 00, 00

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
	ld a, $5 ; BANK(UnknOBPals)
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
	ld a, 0 ; not xor a; preserve carry flag
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
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret

KantoBadgePalettes:
; Boulder Badge
	RGB 31, 31, 31
	RGB 23, 22, 22
	RGB 14, 13, 13
	RGB 00, 00, 00
; Cascade Badge
	RGB 31, 31, 31
	RGB 19, 31, 30
	RGB 00, 23, 30
	RGB 00, 00, 00
; Thunder Badge
	RGB 31, 31, 31
	RGB 31, 26, 05
	RGB 31, 11, 00
	RGB 00, 00, 00
; Rainbow Badge
	RGB 31, 31, 31
	RGB 31, 31, 14
	RGB 00, 29, 07
	RGB 00, 00, 00
; Marsh Badge
	RGB 31, 31, 31
	RGB 31, 19, 30
	RGB 31, 09, 30
	RGB 00, 00, 00
; Soul Badge
	RGB 31, 31, 31
	RGB 31, 22, 04
	RGB 19, 13, 01
	RGB 00, 00, 00
; Volcano Badge
	RGB 31, 31, 31
	RGB 31, 17, 23
	RGB 31, 00, 06
	RGB 00, 00, 00
; Earth Badge
	RGB 31, 31, 31
	RGB 19, 30, 12
	RGB 00, 16, 06
	RGB 00, 00, 00

_CGB0e: ; 9373
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $7
	call ByteFill

	ld a, [CurMove]
	dec a
	ld hl, Moves + MOVE_CATEGORY
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, CategoryIconPalettes
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 7 palettes + 2
	ld bc, 2
	ld a, $5
	call FarCopyWRAM

	ld a, [CurMove]
	dec a
	ld hl, Moves + MOVE_TYPE
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, TypeIconPalettes
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 7 palettes + 4
	ld bc, 2
	ld a, $5
	call FarCopyWRAM

	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 93a6

_CGB0f: ; 93a6
	ld hl, PalPacket_9c46 + 1
	call CopyFourPalettes
	call WipeAttrMap
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 93ba

_CGB_PokedexSearchOption: ; 93ba
	ld de, UnknBGPals
	ld a, $1d
	call GetPredefPal
	call LoadHLPaletteIntoDE
	call WipeAttrMap
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 93d3

_CGB_PackPals: ; 93d3
; pack pals
	ld a, [BattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .tutorial_female

	ld a, [PlayerGender]
	bit 0, a
	jr z, .male

.tutorial_female
	ld hl, .KrisPackPals
	jr .got_gender

.male
	ld hl, .ChrisPackPals

.got_gender
	ld de, UnknBGPals
	ld bc, 4 palettes
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
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 9439

.ChrisPackPals: ; 9439
	RGB 31, 31, 31
	RGB 15, 15, 31
	RGB 00, 00, 31
	RGB 00, 00, 00

	RGB 31, 11, 31
	RGB 15, 15, 31
	RGB 00, 00, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 15, 15, 31
	RGB 00, 00, 31
	RGB 31, 00, 00

	RGB 31, 31, 31
	RGB 07, 19, 07
	RGB 07, 19, 07
	RGB 00, 00, 00
; 9469

.KrisPackPals: ; 9469
	RGB 31, 31, 31
	RGB 31, 14, 31
	RGB 31, 07, 31
	RGB 00, 00, 00

	RGB 15, 15, 31
	RGB 31, 14, 31
	RGB 31, 07, 31
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 14, 31
	RGB 31, 07, 31
	RGB 31, 00, 00

	RGB 31, 31, 31
	RGB 07, 19, 07
	RGB 07, 19, 07
	RGB 00, 00, 00
; 9499

LoadItemIconPalette:
	ld a, [CurSpecies]
	ld hl, ItemIconPalettes
	ld c, a
	ld b, 0
rept 4
	add hl, bc
endr
	ld de, UnknBGPals + 4 palettes + 2
	ld bc, 4
	ld a, $5
	call FarCopyWRAM
	ret

ItemIconPalettes:
CaughtBallPals:
; NO ITEM
	RGB 20, 20, 20
	RGB 10, 10, 10
; POKE BALL
	RGB 30, 10, 06
	RGB 30, 10, 06
; GREAT BALL
	RGB 00, 17, 25
	RGB 30, 10, 06
; ULTRA BALL
	RGB 07, 07, 08
	RGB 31, 26, 07
; MASTER BALL
	RGB 12, 08, 18
	RGB 28, 02, 16
; SAFARI BALL
	RGB 06, 15, 10
	RGB 21, 21, 09
; LEVEL BALL
	RGB 31, 27, 04
	RGB 30, 10, 06
; LURE BALL
	RGB 00, 19, 21
	RGB 30, 10, 06
; MOON BALL
	RGB 00, 21, 23
	RGB 30, 24, 08
; FRIEND BALL
	RGB 07, 20, 00
	RGB 30, 10, 06
; FAST BALL
	RGB 30, 10, 06
	RGB 31, 25, 08
; HEAVY BALL
	RGB 07, 07, 08
	RGB 00, 15, 21
; LOVE BALL
	RGB 31, 16, 19
	RGB 31, 25, 26
; PARK BALL
	RGB 31, 15, 05
	RGB 31, 27, 04
; REPEAT BALL
	RGB 30, 10, 06
	RGB 31, 30, 08
; TIMER BALL
	RGB 07, 07, 08
	RGB 30, 10, 06
; NEST BALL
	RGB 00, 19, 07
	RGB 21, 15, 00
; NET BALL
	RGB 00, 22, 25
	RGB 07, 07, 08
; DIVE BALL
	RGB 16, 25, 30
	RGB 06, 13, 22
; LUXURY BALL
	RGB 31, 28, 03
	RGB 31, 08, 00
; HEAL BALL
	RGB 29, 10, 19
	RGB 10, 17, 24
; QUICK BALL
	RGB 00, 16, 24
	RGB 30, 29, 07
; DUSK BALL
	RGB 00, 20, 09
	RGB 25, 00, 01
; PREMIER BALL
	RGB 30, 10, 06
	RGB 30, 10, 06
; CHERISH BALL
	RGB 31, 06, 04
	RGB 31, 06, 04
; POTION
	RGB 20, 25, 23
	RGB 16, 12, 21
; SUPER POTION
	RGB 28, 23, 13
	RGB 24, 12, 11
; HYPER POTION
	RGB 24, 27, 29
	RGB 31, 12, 21
; MAX POTION
	RGB 20, 20, 20
	RGB 10, 10, 10
; ANTIDOTE
	RGB 31, 29, 12
	RGB 31, 22, 05
; BURN HEAL
	RGB 17, 30, 17
	RGB 13, 26, 13
; PARLYZ HEAL
	RGB 31, 31, 18
	RGB 27, 27, 11
; AWAKENING
	RGB 16, 29, 31
	RGB 11, 24, 26
; ICE HEAL
	RGB 31, 23, 22
	RGB 30, 17, 17
; FULL HEAL
	RGB 27, 29, 00
	RGB 21, 23, 00
; FULL RESTORE
	RGB 20, 20, 20
	RGB 10, 10, 10
; REVIVE
	RGB 28, 28, 15
	RGB 20, 20, 07
; MAX REVIVE
	RGB 28, 28, 15
	RGB 20, 20, 07
; ETHER
	RGB 20, 24, 24
	RGB 19, 13, 20
; MAX ETHER
	RGB 25, 25, 27
	RGB 16, 24, 14
; ELIXER
	RGB 25, 25, 16
	RGB 24, 16, 14
; MAX ELIXER
	RGB 26, 26, 11
	RGB 14, 24, 24
; HP UP
	RGB 13, 20, 29
	RGB 18, 11, 07
; PROTEIN
	RGB 30, 20, 00
	RGB 18, 11, 07
; IRON
	RGB 06, 20, 00
	RGB 18, 11, 07
; CARBOS
	RGB 05, 20, 30
	RGB 18, 11, 07
; CALCIUM
	RGB 30, 08, 00
	RGB 18, 11, 07
; ZINC
	RGB 16, 27, 00
	RGB 18, 11, 07
; RARE CANDY
	RGB 15, 18, 29
	RGB 10, 12, 24
; PP UP
	RGB 23, 11, 23
	RGB 18, 11, 07
; PP MAX
	RGB 31, 28, 11
	RGB 11, 18, 07
; FRESH WATER
	RGB 20, 20, 20
	RGB 10, 10, 10
; SODA POP
	RGB 20, 20, 20
	RGB 10, 10, 10
; LEMONADE
	RGB 20, 20, 20
	RGB 10, 10, 10
; MOOMOO MILK
	RGB 20, 20, 20
	RGB 10, 10, 10
; RAGECANDYBAR
	RGB 20, 20, 20
	RGB 10, 10, 10
; SACRED ASH
	RGB 20, 20, 20
	RGB 10, 10, 10
; ENERGYPOWDER
	RGB 20, 20, 20
	RGB 10, 10, 10
; ENERGY ROOT
	RGB 20, 20, 20
	RGB 10, 10, 10
; HEAL POWDER
	RGB 20, 20, 20
	RGB 10, 10, 10
; REVIVAL HERB
	RGB 20, 20, 20
	RGB 10, 10, 10
; X ATTACK
	RGB 28, 16, 15
	RGB 20, 09, 09
; X DEFEND
	RGB 15, 16, 28
	RGB 09, 09, 20
; X SPEED
	RGB 13, 25, 25
	RGB 09, 19, 19
; X SPCL ATK
	RGB 25, 25, 13
	RGB 19, 19, 09
; X SPCL DEF
	RGB 11, 22, 22
	RGB 08, 17, 17
; DIRE HIT
	RGB 28, 23, 11
	RGB 22, 16, 06
; GUARD SPEC
	RGB 13, 26, 14
	RGB 09, 20, 09
; X ACCURACY
	RGB 25, 14, 23
	RGB 20, 10, 18
; REPEL
	RGB 10, 22, 10
	RGB 23, 06, 02
; SUPER REPEL
	RGB 18, 18, 21
	RGB 17, 10, 10
; MAX REPEL
	RGB 23, 21, 13
	RGB 17, 14, 10
; ESCAPE ROPE
	RGB 20, 20, 20
	RGB 10, 10, 10
; POKE DOLL
	RGB 20, 20, 20
	RGB 10, 10, 10
; ABILITY CAP
	RGB 20, 20, 20
	RGB 10, 10, 10
; LEAF STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; FIRE STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; WATER STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; THUNDERSTONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; MOON STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; SUN STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; DUSK STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; SHINY STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; ICE STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; EVERSTONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; BICYCLE
	RGB 20, 20, 20
	RGB 10, 10, 10
; OLD ROD
	RGB 20, 20, 20
	RGB 10, 10, 10
; GOOD ROD
	RGB 20, 20, 20
	RGB 10, 10, 10
; SUPER ROD
	RGB 20, 20, 20
	RGB 10, 10, 10
; COIN CASE
	RGB 20, 20, 20
	RGB 10, 10, 10
; ITEMFINDER
	RGB 20, 20, 20
	RGB 10, 10, 10
; EXP SHARE
	RGB 20, 20, 20
	RGB 10, 10, 10
; MYSTERY EGG
	RGB 20, 20, 20
	RGB 10, 10, 10
; SQUIRTBOTTLE
	RGB 20, 20, 20
	RGB 10, 10, 10
; SECRETPOTION
	RGB 20, 20, 20
	RGB 10, 10, 10
; RED SCALE
	RGB 20, 20, 20
	RGB 10, 10, 10
; CARD KEY
	RGB 20, 20, 20
	RGB 10, 10, 10
; BASEMENT KEY
	RGB 20, 20, 20
	RGB 10, 10, 10
; S S TICKET
	RGB 20, 20, 20
	RGB 10, 10, 10
; PASS
	RGB 20, 20, 20
	RGB 10, 10, 10
; MACHINE PART
	RGB 20, 20, 20
	RGB 10, 10, 10
; LOST ITEM
	RGB 20, 20, 20
	RGB 10, 10, 10
; RAINBOW WING
	RGB 20, 20, 20
	RGB 10, 10, 10
; SILVER WING
	RGB 20, 20, 20
	RGB 10, 10, 10
; CLEAR BELL
	RGB 20, 20, 20
	RGB 10, 10, 10
; GS BALL
	RGB 20, 20, 20
	RGB 10, 10, 10
; BLUE CARD
	RGB 20, 20, 20
	RGB 10, 10, 10
; ORANGETICKET
	RGB 20, 20, 20
	RGB 10, 10, 10
; MYSTICTICKET
	RGB 20, 20, 20
	RGB 10, 10, 10
; OLD SEA MAP
	RGB 20, 20, 20
	RGB 10, 10, 10
; SHINY CHARM
	RGB 20, 20, 20
	RGB 10, 10, 10
; OVAL CHARM
	RGB 20, 20, 20
	RGB 10, 10, 10
; SILPHSCOPE2
	RGB 20, 20, 20
	RGB 10, 10, 10
; ORAN BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; SITRUS BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; PECHA BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; RAWST BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; CHERI BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; CHESTO BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; ASPEAR BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; PERSIM BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; LUM BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; LEPPA BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; POMEG BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; KELPSY BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; QUALOT BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; HONDEW BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; GREPA BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; TAMATO BERRY
	RGB 20, 20, 20
	RGB 10, 10, 10
; RED APRICORN
	RGB 31, 08, 06
	RGB 21, 12, 05
; BLU APRICORN
	RGB 06, 15, 30
	RGB 21, 12, 05
; YLW APRICORN
	RGB 30, 26, 06
	RGB 21, 12, 05
; GRN APRICORN
	RGB 07, 24, 12
	RGB 21, 12, 05
; WHT APRICORN
	RGB 23, 25, 27
	RGB 21, 12, 05
; BLK APRICORN
	RGB 09, 09, 09
	RGB 21, 12, 05
; PNK APRICORN
	RGB 31, 18, 23
	RGB 21, 12, 05
; SILK SCARF
	RGB 20, 20, 20
	RGB 10, 10, 10
; BLACK BELT
	RGB 20, 20, 20
	RGB 10, 10, 10
; SHARP BEAK
	RGB 20, 20, 20
	RGB 10, 10, 10
; POISON BARB
	RGB 20, 20, 20
	RGB 10, 10, 10
; SOFT SAND
	RGB 20, 20, 20
	RGB 10, 10, 10
; HARD STONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; SILVERPOWDER
	RGB 20, 20, 20
	RGB 10, 10, 10
; SPELL TAG
	RGB 20, 20, 20
	RGB 10, 10, 10
; METAL COAT
	RGB 20, 20, 20
	RGB 10, 10, 10
; CHARCOAL
	RGB 20, 20, 20
	RGB 10, 10, 10
; MYSTIC WATER
	RGB 20, 20, 20
	RGB 10, 10, 10
; MIRACLE SEED
	RGB 20, 20, 20
	RGB 10, 10, 10
; MAGNET
	RGB 20, 20, 20
	RGB 10, 10, 10
; TWISTEDSPOON
	RGB 20, 20, 20
	RGB 10, 10, 10
; NEVERMELTICE
	RGB 20, 20, 20
	RGB 10, 10, 10
; DRAGON FANG
	RGB 20, 20, 20
	RGB 10, 10, 10
; BLACKGLASSES
	RGB 20, 20, 20
	RGB 10, 10, 10
; PINK BOW
	RGB 20, 20, 20
	RGB 10, 10, 10
; BRIGHTPOWDER
	RGB 20, 20, 20
	RGB 10, 10, 10
; SCOPE LENS
	RGB 20, 20, 20
	RGB 10, 10, 10
; QUICK CLAW
	RGB 20, 20, 20
	RGB 10, 10, 10
; KINGS ROCK
	RGB 20, 20, 20
	RGB 10, 10, 10
; FOCUS BAND
	RGB 20, 20, 20
	RGB 10, 10, 10
; LEFTOVERS
	RGB 20, 20, 20
	RGB 10, 10, 10
; LUCKY EGG
	RGB 20, 20, 20
	RGB 10, 10, 10
; AMULET COIN
	RGB 20, 20, 20
	RGB 10, 10, 10
; CLEANSE TAG
	RGB 20, 20, 20
	RGB 10, 10, 10
; SMOKE BALL
	RGB 20, 20, 20
	RGB 10, 10, 10
; BERSERK GENE
	RGB 20, 20, 20
	RGB 10, 10, 10
; LIGHT BALL
	RGB 20, 20, 20
	RGB 10, 10, 10
; STICK
	RGB 20, 20, 20
	RGB 10, 10, 10
; THICK CLUB
	RGB 20, 20, 20
	RGB 10, 10, 10
; LUCKY PUNCH
	RGB 20, 20, 20
	RGB 10, 10, 10
; METAL POWDER
	RGB 20, 20, 20
	RGB 10, 10, 10
; QUICK POWDER
	RGB 20, 20, 20
	RGB 10, 10, 10
; ARMOR SUIT
	RGB 20, 20, 20
	RGB 10, 10, 10
; AIR BALLOON
	RGB 20, 20, 20
	RGB 10, 10, 10
; ASSAULT VEST
	RGB 20, 20, 20
	RGB 10, 10, 10
; BIG ROOT
	RGB 20, 20, 20
	RGB 10, 10, 10
; BINDING BAND
	RGB 20, 20, 20
	RGB 10, 10, 10
; DESTINY KNOT
	RGB 20, 20, 20
	RGB 10, 10, 10
; EVIOLITE
	RGB 20, 20, 20
	RGB 10, 10, 10
; EXPERT BELT
	RGB 20, 20, 20
	RGB 10, 10, 10
; FOCUS SASH
	RGB 20, 20, 20
	RGB 10, 10, 10
; GRIP CLAW
	RGB 20, 20, 20
	RGB 10, 10, 10
; LIFE ORB
	RGB 20, 20, 20
	RGB 10, 10, 10
; LIGHT CLAY
	RGB 20, 20, 20
	RGB 10, 10, 10
; METRONOME I
	RGB 20, 20, 20
	RGB 10, 10, 10
; MUSCLE BAND
	RGB 20, 20, 20
	RGB 10, 10, 10
; PROTECT PADS
	RGB 20, 20, 20
	RGB 10, 10, 10
; ROCKY HELMET
	RGB 20, 20, 20
	RGB 10, 10, 10
; SAFE GOGGLES
	RGB 20, 20, 20
	RGB 10, 10, 10
; SHED SHELL
	RGB 20, 20, 20
	RGB 10, 10, 10
; SHELL BELL
	RGB 20, 20, 20
	RGB 10, 10, 10
; SOOTHE BELL
	RGB 20, 20, 20
	RGB 10, 10, 10
; WEAK POLICY
	RGB 20, 20, 20
	RGB 10, 10, 10
; WIDE LENS
	RGB 20, 20, 20
	RGB 10, 10, 10
; WISE GLASSES
	RGB 20, 20, 20
	RGB 10, 10, 10
; ZOOM LENS
	RGB 20, 20, 20
	RGB 10, 10, 10
; MENTAL HERB
	RGB 20, 20, 20
	RGB 10, 10, 10
; POWER HERB
	RGB 20, 20, 20
	RGB 10, 10, 10
; WHITE HERB
	RGB 20, 20, 20
	RGB 10, 10, 10
; DAMP ROCK
	RGB 20, 20, 20
	RGB 10, 10, 10
; HEAT ROCK
	RGB 20, 20, 20
	RGB 10, 10, 10
; SMOOTH ROCK
	RGB 20, 20, 20
	RGB 10, 10, 10
; ICY ROCK
	RGB 20, 20, 20
	RGB 10, 10, 10
; CHOICE BAND
	RGB 20, 20, 20
	RGB 10, 10, 10
; CHOICE SCARF
	RGB 20, 20, 20
	RGB 10, 10, 10
; CHOICE SPECS
	RGB 20, 20, 20
	RGB 10, 10, 10
; FLAME ORB
	RGB 20, 20, 20
	RGB 10, 10, 10
; TOXIC ORB
	RGB 20, 20, 20
	RGB 10, 10, 10
; BLACK SLUDGE
	RGB 20, 20, 20
	RGB 10, 10, 10
; MACHO BRACE
	RGB 20, 20, 20
	RGB 10, 10, 10
; POWER WEIGHT
	RGB 20, 20, 20
	RGB 10, 10, 10
; POWER BRACER
	RGB 20, 20, 20
	RGB 10, 10, 10
; POWER BELT
	RGB 20, 20, 20
	RGB 10, 10, 10
; POWER LENS
	RGB 20, 20, 20
	RGB 10, 10, 10
; POWER BAND
	RGB 20, 20, 20
	RGB 10, 10, 10
; POWER ANKLET
	RGB 20, 20, 20
	RGB 10, 10, 10
; DRAGON SCALE
	RGB 20, 20, 20
	RGB 10, 10, 10
; UP GRADE
	RGB 20, 20, 20
	RGB 10, 10, 10
; DUBIOUS DISC
	RGB 20, 20, 20
	RGB 10, 10, 10
; PROTECTOR
	RGB 20, 20, 20
	RGB 10, 10, 10
; ELECTIRIZER
	RGB 20, 20, 20
	RGB 10, 10, 10
; MAGMARIZER
	RGB 20, 20, 20
	RGB 10, 10, 10
; RAZOR FANG
	RGB 20, 20, 20
	RGB 10, 10, 10
; RAZOR CLAW
	RGB 20, 20, 20
	RGB 10, 10, 10
; ODD SOUVENIR
	RGB 20, 20, 20
	RGB 10, 10, 10
; NUGGET
	RGB 20, 20, 20
	RGB 10, 10, 10
; BIG NUGGET
	RGB 20, 20, 20
	RGB 10, 10, 10
; TINYMUSHROOM
	RGB 20, 20, 20
	RGB 10, 10, 10
; BIG MUSHROOM
	RGB 20, 20, 20
	RGB 10, 10, 10
; BALMMUSHROOM
	RGB 20, 20, 20
	RGB 10, 10, 10
; PEARL
	RGB 20, 20, 20
	RGB 10, 10, 10
; BIG PEARL
	RGB 20, 20, 20
	RGB 10, 10, 10
; PEARL STRING
	RGB 20, 20, 20
	RGB 10, 10, 10
; STARDUST
	RGB 20, 20, 20
	RGB 10, 10, 10
; STAR PIECE
	RGB 20, 20, 20
	RGB 10, 10, 10
; BRICK PIECE
	RGB 31, 22, 10
	RGB 25, 12, 02
; RARE BONE
	RGB 20, 20, 20
	RGB 10, 10, 10
; SILVER LEAF
	RGB 20, 20, 20
	RGB 10, 10, 10
; GOLD LEAF
	RGB 20, 20, 20
	RGB 10, 10, 10
; SLOWPOKETAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; BOTTLE CAP
	RGB 20, 20, 20
	RGB 10, 10, 10
; HELIX FOSSIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; DOME FOSSIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; OLD AMBER
	RGB 20, 20, 20
	RGB 10, 10, 10
; MULCH
	RGB 20, 20, 20
	RGB 10, 10, 10
; SWEET HONEY
	RGB 20, 20, 20
	RGB 10, 10, 10
; FLOWER MAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; SURF MAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; LITEBLUEMAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; PORTRAITMAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; LOVELY MAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; EON MAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; MORPH MAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; BLUESKY MAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; MUSIC MAIL
	RGB 20, 20, 20
	RGB 10, 10, 10
; MIRAGE MAIL
	RGB 20, 20, 20
	RGB 10, 10, 10

_CGB_Pokepic: ; 9499
	call _CGB_MapPals
	ld de, SCREEN_WIDTH
	hlcoord 0, 0, AttrMap
	ld a, [wMenuBorderTopCoord]
.loop
	and a
	jr z, .found_top
	dec a
	add hl, de
	jr .loop

.found_top
	ld a, [wMenuBorderLeftCoord]
	ld e, a
	ld d, $0
	add hl, de
	ld a, [wMenuBorderTopCoord]
	ld b, a
	ld a, [wMenuBorderBottomCoord]
	inc a
	sub b
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	ld a, [wMenuBorderRightCoord]
	sub c
	inc a
	ld c, a
	xor a
	call FillBoxCGB
	call ApplyAttrMap
	ret
; 94d0

_CGB13: ; 94d0
	ld hl, PalPacket_9ba6 + 1
	call CopyFourPalettes
	call WipeAttrMap
	hlcoord 0, 4, AttrMap
	lb bc, 10, SCREEN_WIDTH
	ld a, $2
	call FillBoxCGB
	hlcoord 0, 6, AttrMap
	lb bc, 6, SCREEN_WIDTH
	ld a, $1
	call FillBoxCGB
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; 94fa

_CGB19: ; 94fa
	ld de, UnknBGPals
	ld a, $4e
	call GetPredefPal
	call LoadHLPaletteIntoDE
	ld hl, .Palette
	ld de, UnknOBPals
	call LoadHLPaletteIntoDE
	ld hl, .Palette
	ld de, UnknOBPals + 1 palettes
	call LoadHLPaletteIntoDE
	call WipeAttrMap
	call ApplyAttrMap
	call ApplyPals
	ret
; 9521

.Palette: ; 9521
	RGB 31, 31, 31
	RGB 13, 11, 00
	RGB 23, 12, 28
	RGB 00, 00, 00
; 9529

_CGB1a: ; 9529
	ld de, UnknBGPals
	ld a, [CurPartySpecies]
	ld bc, TempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call WipeAttrMap
	call ApplyAttrMap
	call ApplyPals
	ret
; 9542

_CGB1b: ; 9555
	ld hl, PalPacket_9cc6 + 1
	call CopyFourPalettes
	ld hl, Palettes_b681
	ld de, UnknOBPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	ld de, UnknOBPals + 7 palettes
	ld a, $1c
	call GetPredefPal
	call LoadHLPaletteIntoDE
	call WipeAttrMap
	ret
; 9578

_CGB_FrontpicPals: ; 9578
	ld de, UnknBGPals
	ld a, [CurPartySpecies]
	ld bc, TempMonDVs
	call GetFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call WipeAttrMap
	call ApplyAttrMap
	call ApplyPals
	ret
; 9591

_CGB_IntroPals: ; 9591
	ld de, UnknBGPals
	ld a, [CurPartySpecies]
	ld bc, TempMonPersonality
	call GetFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ld hl, IntroGradientPalette
	ld de, UnknBGPals + 1 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	call ApplyPals
	call WipeAttrMap
	hlcoord 0, 0, AttrMap
	lb bc, 3, 20
	ld a, $1
	call FillBoxCGB
	call ApplyAttrMap
	ret
; 95e0

_CGB_IntroNamingPals: ; 9542
	ld de, UnknBGPals
	ld a, [CurPartySpecies]
	ld bc, TempMonPersonality
	call GetFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ld hl, IntroGradientPalette
	ld de, UnknBGPals + 1 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	call ApplyPals
	call WipeAttrMap
	hlcoord 11, 0, AttrMap
	lb bc, 3, 9
	ld a, $1
	call FillBoxCGB
	hlcoord 0, 0, AttrMap
	lb bc, 3, 11
	xor a
	call FillBoxCGB
	call ApplyAttrMap
	ret
; 9555

IntroGradientPalette:
	RGB 31, 31, 31
	RGB 27, 31, 31
	RGB 19, 31, 31
	RGB 09, 30, 31

