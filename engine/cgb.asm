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
	ld hl, GenderAndExpPalettes
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
	hlcoord 8, 1, AttrMap
	ld a, $4
	ld [hl], a
	hlcoord 18, 8, AttrMap
	ld a, $4
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
	RGB 27, 11, 27
; PAR
	RGB 30, 20, 00
; SLP
	RGB 17, 17, 17
; BRN
	RGB 31, 08, 02
; FRZ
	RGB 09, 18, 31
; FNT
	RGB 25, 00, 00
; TOX
	RGB 27, 06, 28

LoadBattleCategoryAndTypePalettes:
	ld hl, CategoryIconPalettes
	ld a, [wPlayerMoveStruct + MOVE_CATEGORY]
	ld c, a
	ld b, 0
rept 4
	add hl, bc
endr
	ld de, UnknBGPals + 6 palettes + 2
	ld bc, 4
	ld a, $5
	call FarCopyWRAM

	ld hl, TypeIconPalettes
	ld a, [wPlayerMoveStruct + MOVE_TYPE]
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 6 palettes + 6
	ld bc, 2
	ld a, $5
	call FarCopyWRAM
	ret

CategoryIconPalettes:
; PHYSICAL
	RGB 31, 28, 00
	RGB 27, 04, 02
; SPECIAL
	RGB 27, 31, 31
	RGB 00, 14, 29
; STATUS
	RGB 31, 31, 31
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
	ld hl, CategoryIconPalettes
	ld c, a
	ld b, 0
rept 4
	add hl, bc
endr
	ld de, UnknBGPals + 0 palettes + 2
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
	ld hl, TypeIconPalettes
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld de, UnknBGPals + 0 palettes + 6
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

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
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

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
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
	ld hl, BlackPalette
	ld bc, 2
	ld a, $5
	call FarCopyWRAM
	ret

LoadTMHMIconPalette:
	ld a, [CurTMHM]
	cp NUM_TMS + NUM_HMS + 1
	jr nc, .cancel
	dec a
	ld hl, TMHMTypes
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld hl, TMHMTypeIconPalettes
	ld c, a
	ld b, 0
rept 4
	add hl, bc
endr
	ld de, UnknBGPals + 4 palettes + 2
	ld bc, 4
	ld a, $5
	call FarCopyWRAM
	ld hl, BlackPalette
	ld bc, 2
	ld a, $5
	call FarCopyWRAM
	ret

.cancel:
	ld hl, TMHMCancelPalette
	ld de, UnknBGPals + 4 palettes + 2
	ld bc, 6
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
	RGB 31, 15, 00
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
	RGB 30, 26, 12
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
	RGB 19, 09, 07
; CHERISH BALL
	RGB 31, 06, 04
	RGB 20, 07, 05
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
	RGB 22, 22, 16
	RGB 15, 24, 04
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
	RGB 22, 22, 24
	RGB 08, 19, 28
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
	RGB 18, 20, 27
	RGB 08, 16, 06
; SODA POP
	RGB 13, 23, 28
	RGB 07, 16, 22
; LEMONADE
	RGB 31, 24, 19
	RGB 24, 24, 16
; MOOMOO MILK
	RGB 28, 28, 22
	RGB 22, 13, 22
; RAGECANDYBAR
	RGB 13, 19, 08
	RGB 20, 08, 06
; SACRED ASH
	RGB 19, 19, 19
	RGB 21, 21, 05
; ENERGYPOWDER
	RGB 27, 27, 19
	RGB 24, 14, 14
; ENERGY ROOT
	RGB 28, 25, 16
	RGB 25, 19, 10
; HEAL POWDER
	RGB 11, 21, 11
	RGB 29, 29, 12
; REVIVAL HERB
	RGB 22, 28, 14
	RGB 14, 20, 10
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
	RGB 27, 24, 14
	RGB 18, 15, 05
; POKE DOLL
	RGB 30, 22, 26
	RGB 26, 18, 22
; ABILITY CAP
	RGB 13, 21, 29
	RGB 21, 13, 31
; LEAF STONE
	RGB 15, 20, 15
	RGB 11, 13, 07
; FIRE STONE
	RGB 27, 25, 02
	RGB 30, 18, 06
; WATER STONE
	RGB 18, 22, 27
	RGB 12, 10, 25
; THUNDERSTONE
	RGB 26, 29, 15
	RGB 09, 18, 09
; MOON STONE
	RGB 21, 24, 22
	RGB 13, 16, 14
; SUN STONE
	RGB 30, 16, 09
	RGB 24, 12, 05
; DUSK STONE
	RGB 21, 15, 21
	RGB 14, 10, 15
; SHINY STONE
	RGB 24, 28, 20
	RGB 31, 27, 01
; ICE STONE
	RGB 18, 27, 28
	RGB 07, 19, 22
; EVERSTONE
	RGB 22, 25, 26
	RGB 13, 17, 19
; BICYCLE
	RGB 22, 12, 12
	RGB 12, 12, 12
; OLD ROD
	RGB 24, 19, 08
	RGB 19, 13, 01
; GOOD ROD
	RGB 22, 25, 08
	RGB 25, 11, 07
; SUPER ROD
	RGB 18, 16, 16
	RGB 10, 10, 17
; COIN CASE
	RGB 24, 21, 07
	RGB 21, 07, 07
; ITEMFINDER
	RGB 08, 17, 25
	RGB 26, 12, 12
; EXP SHARE
	RGB 21, 23, 21
	RGB 13, 15, 13
; MYSTERY EGG
	RGB 29, 26, 18
	RGB 08, 19, 11
; SQUIRTBOTTLE
	RGB 10, 15, 31
	RGB 22, 18, 08
; SECRETPOTION
	RGB 23, 13, 04
	RGB 28, 27, 02
; RED SCALE
	RGB 31, 18, 18
	RGB 29, 07, 07
; CARD KEY
	RGB 31, 14, 00
	RGB 04, 15, 29
; BASEMENT KEY
	RGB 20, 21, 23
	RGB 11, 12, 16
; S S TICKET
	RGB 12, 22, 29
	RGB 06, 13, 17
; PASS
	RGB 13, 23, 00
	RGB 26, 13, 12
; MACHINE PART
	RGB 19, 19, 21
	RGB 13, 13, 16
; LOST ITEM
	RGB 31, 20, 25
	RGB 28, 15, 23
; RAINBOW WING
	RGB 29, 09, 08
	RGB 17, 24, 13
; SILVER WING
	RGB 21, 24, 30
	RGB 16, 19, 24
; CLEAR BELL
	RGB 29, 21, 13
	RGB 23, 17, 08
; GS BALL
	RGB 28, 19, 05
	RGB 15, 14, 16
; BLUE CARD
	RGB 15, 22, 31
	RGB 05, 15, 31
; ORANGETICKET
	RGB 31, 24, 18
	RGB 31, 18, 06
; MYSTICTICKET
	RGB 28, 20, 27
	RGB 17, 09, 21
; OLD SEA MAP
	RGB 27, 23, 17
	RGB 22, 18, 13
; SHINY CHARM
	RGB 07, 26, 31
	RGB 10, 15, 29
; OVAL CHARM
	RGB 28, 17, 21
	RGB 16, 10, 28
; SILPHSCOPE2
	RGB 17, 20, 17
	RGB 13, 20, 27
; ORAN BERRY
	RGB 10, 20, 30
	RGB 13, 13, 23
; SITRUS BERRY
	RGB 31, 29, 13
	RGB 28, 22, 08
; PECHA BERRY
	RGB 31, 24, 19
	RGB 29, 18, 14
; RAWST BERRY
	RGB 18, 26, 26
	RGB 16, 18, 21
; CHERI BERRY
	RGB 29, 12, 10
	RGB 15, 23, 09
; CHESTO BERRY
	RGB 18, 14, 28
	RGB 21, 21, 13
; ASPEAR BERRY
	RGB 30, 28, 10
	RGB 25, 22, 09
; PERSIM BERRY
	RGB 31, 25, 19
	RGB 28, 19, 14
; LUM BERRY
	RGB 18, 27, 09
	RGB 10, 20, 09
; LEPPA BERRY
	RGB 31, 18, 06
	RGB 25, 09, 06
; POMEG BERRY
	RGB 31, 18, 06
	RGB 25, 09, 06
; KELPSY BERRY
	RGB 14, 21, 31
	RGB 12, 10, 19
; QUALOT BERRY
	RGB 31, 26, 16
	RGB 29, 19, 14
; HONDEW BERRY
	RGB 18, 27, 09
	RGB 10, 19, 09
; GREPA BERRY
	RGB 31, 28, 07
	RGB 27, 23, 09
; TAMATO BERRY
	RGB 31, 18, 06
	RGB 25, 09, 06
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
	RGB 29, 30, 30
	RGB 24, 25, 25
; BLACK BELT
	RGB 12, 11, 12
	RGB 09, 08, 09
; SHARP BEAK
	RGB 30, 27, 11
	RGB 17, 12, 04
; POISON BARB
	RGB 26, 26, 26
	RGB 24, 18, 24
; SOFT SAND
	RGB 25, 21, 14
	RGB 19, 12, 19
; HARD STONE
	RGB 22, 21, 21
	RGB 10, 09, 09
; SILVERPOWDER
	RGB 24, 24, 24
	RGB 13, 23, 13
; SPELL TAG
	RGB 18, 18, 18
	RGB 31, 16, 16
; METAL COAT
	RGB 22, 24, 24
	RGB 13, 16, 16
; CHARCOAL
	RGB 17, 17, 17
	RGB 08, 08, 08
; MYSTIC WATER
	RGB 19, 27, 31
	RGB 11, 11, 26
; MIRACLE SEED
	RGB 29, 29, 11
	RGB 24, 24, 06
; MAGNET
	RGB 18, 20, 18
	RGB 27, 07, 07
; TWISTEDSPOON
	RGB 19, 21, 21
	RGB 13, 16, 16
; NEVERMELTICE
	RGB 20, 26, 28
	RGB 14, 20, 24
; DRAGON FANG
	RGB 23, 20, 19
	RGB 16, 13, 12
; BLACKGLASSES
	RGB 12, 11, 12
	RGB 09, 08, 09
; PINK BOW
	RGB 31, 18, 23
	RGB 28, 12, 17
; BRIGHTPOWDER
	RGB 21, 28, 21
	RGB 09, 14, 09
; SCOPE LENS
	RGB 18, 20, 22
	RGB 29, 24, 09
; QUICK CLAW
	RGB 27, 24, 13
	RGB 25, 19, 10
; KINGS ROCK
	RGB 28, 26, 11
	RGB 20, 18, 04
; FOCUS BAND
	RGB 23, 10, 10
	RGB 28, 21, 06
; LEFTOVERS
	RGB 28, 10, 10
	RGB 15, 18, 04
; LUCKY EGG
	RGB 27, 29, 30
	RGB 20, 21, 22
; AMULET COIN
	RGB 31, 30, 06
	RGB 30, 22, 06
; CLEANSE TAG
	RGB 23, 10, 10
	RGB 18, 18, 18
; SMOKE BALL
	RGB 24, 18, 26
	RGB 18, 12, 20
; BERSERK GENE
	RGB 31, 22, 16
	RGB 17, 14, 18
; LIGHT BALL
	RGB 28, 27, 05
	RGB 20, 20, 02
; STICK
	RGB 22, 22, 17
	RGB 15, 23, 01
; THICK CLUB
	RGB 26, 26, 21
	RGB 19, 19, 16
; LUCKY PUNCH
	RGB 27, 14, 07
	RGB 17, 17, 17
; METAL POWDER
	RGB 25, 18, 26
	RGB 19, 19, 19
; QUICK POWDER
	RGB 15, 23, 29
	RGB 19, 19, 19
; ARMOR SUIT
	RGB 20, 19, 22
	RGB 12, 08, 16
; AIR BALLOON
	RGB 31, 16, 16
	RGB 30, 09, 09
; ASSAULT VEST
	RGB 26, 10, 10
	RGB 23, 07, 08
; BIG ROOT
	RGB 22, 16, 07
	RGB 17, 11, 02
; BINDING BAND
	RGB 26, 20, 10
	RGB 19, 12, 04
; DESTINY KNOT
	RGB 31, 12, 12
	RGB 24, 09, 09
; EVIOLITE
	RGB 26, 18, 29
	RGB 22, 15, 28
; EXPERT BELT
	RGB 12, 11, 12
	RGB 09, 08, 09
; FOCUS SASH
	RGB 31, 28, 10
	RGB 23, 06, 06
; GRIP CLAW
	RGB 18, 21, 21
	RGB 10, 14, 12
; LIFE ORB
	RGB 28, 08, 28
	RGB 24, 06, 25
; LIGHT CLAY
	RGB 23, 28, 15
	RGB 17, 23, 10
; METRONOME I
	RGB 15, 23, 28
	RGB 08, 13, 09
; MUSCLE BAND
	RGB 26, 23, 03
	RGB 26, 04, 04
; PROTECT PADS
	RGB 21, 22, 22
	RGB 12, 13, 20
; ROCKY HELMET
	RGB 31, 25, 00
	RGB 19, 19, 19
; SAFE GOGGLES
	RGB 10, 16, 10
	RGB 22, 07, 08
; SHED SHELL
	RGB 29, 30, 14
	RGB 26, 23, 09
; SHELL BELL
	RGB 19, 25, 24
	RGB 15, 17, 17
; SOOTHE BELL
	RGB 19, 25, 24
	RGB 15, 17, 17
; WEAK POLICY
	RGB 21, 25, 27
	RGB 29, 18, 18
; WIDE LENS
	RGB 27, 14, 06
	RGB 03, 25, 31
; WISE GLASSES
	RGB 12, 11, 12
	RGB 09, 08, 09
; ZOOM LENS
	RGB 26, 09, 09
	RGB 24, 23, 07
; MENTAL HERB
	RGB 18, 28, 28
	RGB 07, 18, 18
; POWER HERB
	RGB 29, 07, 07
	RGB 22, 06, 06
; WHITE HERB
	RGB 28, 26, 28
	RGB 18, 15, 18
; DAMP ROCK
	RGB 11, 23, 24
	RGB 07, 17, 18
; HEAT ROCK
	RGB 31, 15, 20
	RGB 19, 15, 13
; SMOOTH ROCK
	RGB 27, 22, 02
	RGB 24, 17, 13
; ICY ROCK
	RGB 11, 23, 28
	RGB 24, 17, 13
; CHOICE BAND
	RGB 22, 22, 24
	RGB 27, 11, 11
; CHOICE SCARF
	RGB 19, 27, 31
	RGB 10, 21, 30
; CHOICE SPECS
	RGB 31, 31, 11
	RGB 30, 03, 03
; FLAME ORB
	RGB 31, 17, 12
	RGB 31, 07, 07
; TOXIC ORB
	RGB 24, 12, 29
	RGB 14, 05, 27
; BLACK SLUDGE
	RGB 17, 17, 21
	RGB 14, 14, 17
; MACHO BRACE
	RGB 25, 25, 08
	RGB 09, 16, 10
; POWER WEIGHT
	RGB 12, 29, 15
	RGB 08, 25, 10
; POWER BRACER
	RGB 30, 14, 14
	RGB 23, 10, 10
; POWER BELT
	RGB 29, 22, 12
	RGB 22, 14, 07
; POWER LENS
	RGB 31, 12, 31
	RGB 24, 08, 26
; POWER BAND
	RGB 29, 28, 12
	RGB 24, 20, 03
; POWER ANKLET
	RGB 12, 26, 29
	RGB 04, 18, 24
; DRAGON SCALE
	RGB 19, 27, 31
	RGB 13, 21, 25
; UP GRADE
	RGB 20, 26, 20
	RGB 31, 27, 00
; DUBIOUS DISC
	RGB 21, 19, 23
	RGB 31, 04, 29
; PROTECTOR
	RGB 27, 11, 04
	RGB 17, 09, 06
; ELECTIRIZER
	RGB 31, 31, 02
	RGB 20, 19, 00
; MAGMARIZER
	RGB 29, 13, 13
	RGB 22, 06, 06
; RAZOR FANG
	RGB 19, 20, 21
	RGB 13, 14, 15
; RAZOR CLAW
	RGB 19, 20, 21
	RGB 16, 17, 18
; ODD SOUVENIR
	RGB 19, 16, 08
	RGB 12, 10, 03
; NUGGET
	RGB 31, 25, 09
	RGB 19, 14, 02
; BIG NUGGET
	RGB 31, 25, 09
	RGB 19, 14, 02
; TINYMUSHROOM
	RGB 31, 14, 11
	RGB 26, 07, 04
; BIG MUSHROOM
	RGB 31, 14, 11
	RGB 26, 07, 04
; BALMMUSHROOM
	RGB 31, 31, 10
	RGB 29, 19, 05
; PEARL
	RGB 19, 25, 24
	RGB 15, 17, 17
; BIG PEARL
	RGB 19, 25, 24
	RGB 15, 17, 17
; PEARL STRING
	RGB 19, 25, 24
	RGB 15, 17, 17
; STARDUST
	RGB 27, 14, 14
	RGB 12, 19, 26
; STAR PIECE
	RGB 30, 20, 20
	RGB 27, 14, 14
; BRICK PIECE
	RGB 31, 22, 10
	RGB 25, 12, 02
; RARE BONE
	RGB 26, 26, 21
	RGB 19, 19, 16
; SILVER LEAF
	RGB 26, 26, 28
	RGB 15, 15, 18
; GOLD LEAF
	RGB 31, 25, 10
	RGB 22, 15, 00
; SLOWPOKETAIL
	RGB 31, 23, 24
	RGB 28, 14, 16
; BOTTLE CAP
	RGB 22, 23, 24
	RGB 13, 15, 18
; HELIX FOSSIL
	RGB 20, 15, 00
	RGB 15, 10, 00
; DOME FOSSIL
	RGB 20, 15, 00
	RGB 15, 10, 00
; OLD AMBER
	RGB 30, 22, 00
	RGB 22, 14, 00
; MULCH
	RGB 22, 17, 09
	RGB 06, 25, 08
; SWEET HONEY
	RGB 31, 23, 09
	RGB 29, 18, 00
; FLOWER MAIL
	RGB 20, 31, 11
	RGB 31, 19, 00
; SURF MAIL
	RGB 15, 20, 31
	RGB 31, 12, 00
; LITEBLUEMAIL
	RGB 24, 17, 31
	RGB 08, 11, 31
; PORTRAITMAIL
	RGB 31, 25, 17
	RGB 28, 12, 05
; LOVELY MAIL
	RGB 19, 26, 31
	RGB 31, 09, 31
; EON MAIL
	RGB 31, 19, 28
	RGB 12, 22, 00
; MORPH MAIL
	RGB 19, 17, 23
	RGB 31, 12, 00
; BLUESKY MAIL
	RGB 07, 26, 31
	RGB 31, 11, 11
; MUSIC MAIL
	RGB 21, 31, 21
	RGB 31, 12, 00
; MIRAGE MAIL
	RGB 07, 26, 31
	RGB 00, 21, 00
TMHMCancelPalette:
; CANCEL
	RGB 31, 31, 31
	RGB 31, 31, 31
WhitePalette:
	RGB 31, 31, 31
BlackPalette:
	RGB 00, 00, 00

TMHMTypes:
; This merges data from battle/moves/moves.asm:Moves and engine/tmhm.asm:TMHMMoves
; for efficiency.
	db FIGHTING ; DYNAMICPUNCH
	db DRAGON   ; DRAGON_CLAW
	db GHOST    ; CURSE
	db PSYCHIC  ; CALM_MIND
	db NORMAL   ; ROAR
	db POISON   ; TOXIC
	db ICE      ; HAIL
	db FIGHTING ; BULK_UP
	db NORMAL   ; SWORDS_DANCE
if DEF(FAITHFUL)
	db NORMAL   ; HIDDEN_POWER
else
	db UNKNOWN_T ; HIDDEN_POWER
endc
	db FIRE     ; SUNNY_DAY
	db DARK     ; HONE_CLAWS
	db ICE      ; ICE_BEAM
	db ICE      ; BLIZZARD
	db NORMAL   ; HYPER_BEAM
	db PSYCHIC  ; LIGHT_SCREEN
	db NORMAL   ; PROTECT
	db WATER    ; RAIN_DANCE
	db GRASS    ; GIGA_DRAIN
	db NORMAL   ; SAFEGUARD
	db DRAGON   ; DRAGONBREATH
	db GRASS    ; SOLAR_BEAM
	db STEEL    ; IRON_TAIL
	db ELECTRIC ; THUNDERBOLT
	db ELECTRIC ; THUNDER
	db GROUND   ; EARTHQUAKE
	db NORMAL   ; RETURN
	db GROUND   ; DIG
	db PSYCHIC  ; PSYCHIC_M
	db GHOST    ; SHADOW_BALL
	db GROUND   ; MUD_SLAP
	db NORMAL   ; DOUBLE_TEAM
	db PSYCHIC  ; REFLECT
	db STEEL    ; FLASH_CANNON
	db FIRE     ; FLAMETHROWER
	db POISON   ; SLUDGE_BOMB
	db GROUND   ; SANDSTORM
	db FIRE     ; FIRE_BLAST
	db NORMAL   ; SWIFT
	db FLYING   ; AERIAL_ACE
	db ROCK     ; STONE_EDGE
	db NORMAL   ; FACADE
	db ELECTRIC ; WILD_CHARGE
	db PSYCHIC  ; REST
	db NORMAL   ; ATTRACT
	db DARK     ; THIEF
	db STEEL    ; STEEL_WING
	db ROCK     ; ROCK_SLIDE
	db BUG      ; FURY_CUTTER
	db FIGHTING ; ROCK_SMASH
	db BUG      ; LEECH_LIFE
	db FIGHTING ; FOCUS_BLAST
	db GRASS    ; ENERGY_BALL
	db NORMAL   ; FALSE_SWIPE
	db WATER    ; SCALD
	db BUG      ; X_SCISSOR
	db DARK     ; DARK_PULSE
	db NORMAL   ; ENDURE
	db DRAGON   ; DRAGON_PULSE
	db FAIRY    ; DAZZLINGLEAM
	db FIRE     ; WILL_O_WISP
	db FLYING   ; ACROBATICS
	db ELECTRIC ; THUNDER_WAVE
	db NORMAL   ; EXPLOSION
	db GHOST    ; SHADOW_CLAW
	db POISON   ; POISON_JAB
	db ICE      ; AVALANCHE
	db FIGHTING ; GIGA_IMPACT
	db BUG      ; U_TURN
	db NORMAL   ; FLASH
if DEF(FAITHFUL)
	db NORMAL   ; CUT
else
	db STEEL    ; CUT
endc
	db FLYING   ; FLY
	db WATER    ; SURF
if DEF(FAITHFUL)
	db NORMAL   ; STRENGTH
else
	db FIGHTING ; STRENGTH
endc
	db WATER    ; WHIRLPOOL
	db WATER    ; WATERFALL

TMHMTypeIconPalettes:
; NORMAL
	RGB 28, 28, 29
	RGB 24, 24, 23
; FIGHTING
	RGB 30, 24, 18
	RGB 31, 13, 00
; FLYING
	RGB 21, 29, 31
	RGB 24, 24, 23
; POISON
	RGB 31, 25, 20
	RGB 24, 11, 26
; GROUND
	RGB 31, 31, 18
	RGB 28, 24, 08
; ROCK
	RGB 30, 27, 20
	RGB 27, 21, 08
; BUG
	RGB 27, 30, 24
	RGB 17, 29, 13
; GHOST
	RGB 29, 25, 30
	RGB 24, 11, 26
; STEEL
	RGB 26, 26, 25
	RGB 05, 19, 19
; FIRE
	RGB 31, 27, 18
	RGB 31, 20, 03
; WATER
	RGB 21, 26, 30
	RGB 00, 20, 29
; GRASS
	RGB 22, 30, 26
	RGB 00, 29, 20
; ELECTRIC
	RGB 31, 28, 14
	RGB 31, 24, 00
; PSYCHIC
	RGB 31, 26, 24
	RGB 31, 20, 18
; ICE
	RGB 22, 30, 31
	RGB 11, 26, 29
; DRAGON
	RGB 17, 24, 31
	RGB 31, 21, 14
; DARK
	RGB 22, 26, 25
	RGB 05, 19, 19
; FAIRY
	RGB 29, 23, 30
	RGB 31, 17, 26
; UNKNOWN T
	RGB 17, 26, 24
	RGB 10, 20, 17

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

