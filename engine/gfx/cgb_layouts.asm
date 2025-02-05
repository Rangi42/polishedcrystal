LoadCGBLayout::
	assert CGB_RAM == 0
	and a ; CGB_RAM?
	jr nz, .not_ram
	ld a, [wMemCGBLayout]
.not_ram
	assert CGB_PARTY_MENU_HP_PALS == NUM_CGB_LAYOUTS - 1
	cp CGB_PARTY_MENU_HP_PALS
	jmp z, ApplyPartyMenuHPPals
	cp CGB_MAPPALS
	call nz, ResetBGPals
	dec a
	call StackJumpTable

.Jumptable:
	table_width 2
	dw _CGB_BattleGrayscale
	dw _CGB_BattleColors
	dw _CGB_PokegearPals
	dw _CGB_StatsScreenHPPals
	dw _CGB_Pokedex
	dw _CGB_Pokedex_PrepareOnly
	dw _CGB_SlotMachine
	dw _CGB_Plain
	dw _CGB_MapPals
	dw _CGB_PartyMenu
	dw _CGB_Evolution
	dw _CGB_MoveList
	dw _CGB_BuyMenu
	dw _CGB_PackPals
	dw _CGB_TrainerCard
	dw _CGB_TrainerCard2
	dw _CGB_TrainerCard3
	dw _CGB_BillsPC
	dw _CGB_UnownPuzzle
	dw _CGB_GameFreakLogo
	dw _CGB_TradeTube
	dw _CGB_IntroPals
	dw _CGB_IntroGenderPals
	dw _CGB_PlayerOrMonFrontpicPals
	dw _CGB_TrainerOrMonFrontpicPals
	dw _CGB_JudgeSystem
	dw _CGB_NamingScreen
	dw _CGB_Mail
	dw _CGB_FlyMap
	dw _CGB_NewDiploma
	assert_table_length NUM_CGB_LAYOUTS - 2 ; discount CGB_RAM and CGB_PARTY_MENU_HP_PALS

_CGB_BattleGrayscale:
	push bc
	ld de, wBGPals1
rept 8
	ld hl, DarkGrayPalette
	call LoadOnePalette
endr
	ld de, wOBPals1
rept 2
	ld hl, DarkGrayPalette
	call LoadOnePalette
endr
	jmp _CGB_FinishBattleScreenLayout

if !DEF(MONOCHROME)
WhitePalette:
	RGB 31, 31, 31
CancelPalette:
	RGB 31, 31, 31
	RGB 31, 31, 31
WhiteColor:
DarkGrayPalette:
	RGB 31, 31, 31
	RGB 07, 07, 07
	RGB 02, 03, 03
BlackColor:
	RGB 00, 00, 00

else
WhitePalette:
	RGB_MONOCHROME_WHITE
CancelPalette:
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
WhiteColor:
DarkGrayPalette:
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
BlackColor:
	RGB_MONOCHROME_BLACK
endc

BattleObjectPals:
INCLUDE "gfx/battle_anims/battle_anims.pal"

GetDefaultBattlePalette:
	ld a, BANK(wTempBattleMonSpecies)
	call StackCallInWRAMBankA
.Function:
	ld a, h
	and a ; PAL_BATTLE_BG_PLAYER
	jr z, SetBattlePal_Player
	dec a ; PAL_BATTLE_BG_ENEMY
	jr z, SetBattlePal_Enemy
	dec a ; PAL_BATTLE_BG_ENEMY_HP
	jr z, SetBattlePal_EnemyHP
	dec a ; PAL_BATTLE_BG_PLAYER_HP
	jr z, SetBattlePal_PlayerHP
	dec a ; PAL_BATTLE_BG_EXP_GENDER
	jr z, SetBattlePal_ExpGender
	dec a ; PAL_BATTLE_BG_STATUS
	jr z, SetBattlePal_Status
	dec a ; PAL_BATTLE_BG_TYPE_CAT
	jr z, SetBattlePal_Player ; type+cat uses player pal normally.
	dec a ; PAL_BATTLE_BG_TEXT
	jr z, SetBattlePal_Text
	dec a ; PAL_BATTLE_OB_ENEMY
	jr z, SetBattlePal_Enemy
	dec a ; PAL_BATTLE_OB_PLAYER
	jr z, SetBattlePal_Player

	; At this point, a is 1-6. Load a battle object pal.
	ld hl, BattleObjectPals - 1 palettes
	ld bc, 1 palettes
	rst AddNTimes
	jmp FarCopyWRAM

GetPartyMonDVs:
	ld hl, wPartyMon1DVs
	ld a, [wCurBattleMon]
	jmp GetPartyLocation

GetEnemyMonDVs:
	ld hl, wOTPartyMon1DVs
	ld a, [wCurOTMon]
	jmp GetPartyLocation

SetBattlePal_Player:
	ld hl, wTempBattleMonSpecies
	push hl
	call GetBattlemonBackpicPalettePointer
	ld bc, GetPartyMonDVs
	jr SetBattlePal_Pokepic

SetBattlePal_Enemy:
	ld hl, wTempEnemyMonSpecies
	push hl
	call GetEnemyFrontpicPalettePointer
	ld bc, GetEnemyMonDVs
	; fallthrough
SetBattlePal_Pokepic:
	push bc
	call LoadPalette_White_Col1_Col2_Black
	pop bc
	pop hl

	; no color variation for trainer pics (assumes temp species == 0 for trainers!)
	ld a, [hl]
	and a
	ret z

	push de
	ld a, 6
.loop
	dec de
	dec a
	jr nz, .loop
	push de

	ld a, [hli]
	ld d, [hl]
	ld e, a

	; hl = DVs
	call _bc_

	ld b, d
	ld c, e

	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	pop hl
	call VaryColorsByDVs
	pop de
	ret

SetBattlePal_PlayerHP:
	ld a, [wPlayerHPPal]
	jr SetBattlePal_HP

SetBattlePal_EnemyHP:
	ld a, [wEnemyHPPal]
	; fallthrough
SetBattlePal_HP:
	add a
	add a
	add LOW(HPBarInteriorPals)
	ld l, a
	adc HIGH(HPBarInteriorPals)
	sub l
	ld h, a
	jmp LoadPalette_White_Col1_Col2_Black

SetBattlePal_ExpGender:
	ld hl, GenderAndExpBarPals
	jmp LoadPalette_White_Col1_Col2_Black

SetBattlePal_Status:
	call LoadPlayerStatusIconPalette
	jmp LoadEnemyStatusIconPalette

SetBattlePal_Text:
	ld hl, DarkGrayPalette
	jmp LoadPalette_White_Col1_Col2_Black

_CGB_BattleColors:
	push bc
	ld de, wBGPals1
	call SetBattlePal_Player
	call SetBattlePal_Enemy
	call SetBattlePal_EnemyHP
	call SetBattlePal_PlayerHP
	call SetBattlePal_ExpGender
	call SetBattlePal_Status
	ld de, wBGPals1 palette PAL_BATTLE_BG_TYPE_CAT
	call SetBattlePal_Player
	call SetBattlePal_Text
	call SetBattlePal_Enemy
	call SetBattlePal_Player

	ld a, CGB_BATTLE_COLORS
	ld [wMemCGBLayout], a
	call ApplyPals
	; fallthrough
_CGB_FinishBattleScreenLayout:
	; don't screw with ability overlay areas
	pop bc
	ld b, 0
	ld a, [wAnimationsDisabled]
	and a
	jr z, .overlay_done

	hlcoord 0, 8, wAttrmap
	bit 3, [hl]
	jr z, .no_player_overlay
	set 0, b
.no_player_overlay
	hlcoord 9, 3, wAttrmap
	bit 3, [hl]
	jr z, .overlay_done
	set 1, b

.overlay_done
	push bc
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, PAL_BATTLE_BG_ENEMY_HP
	rst ByteFill

	hlcoord 0, 4, wAttrmap
	lb bc, 8, 10
	xor a ; PAL_BATTLE_BG_PLAYER
	call FillBoxWithByte

	hlcoord 11, 0, wAttrmap
	lb bc, 7, 9
	ld a, PAL_BATTLE_BG_ENEMY
	call FillBoxWithByte

	hlcoord 0, 0, wAttrmap
	lb bc, 4, 11
	ld a, PAL_BATTLE_BG_ENEMY_HP
	call FillBoxWithByte

	hlcoord 10, 7, wAttrmap
	lb bc, 5, 10
	ld a, PAL_BATTLE_BG_PLAYER_HP
	call FillBoxWithByte

	hlcoord 12, 11, wAttrmap
	lb bc, 1, 7
	ld a, PAL_BATTLE_BG_EXP_GENDER
	call FillBoxWithByte

	ld a, PAL_BATTLE_BG_EXP_GENDER
	ldcoord_a 0, 1, wAttrmap
	ldcoord_a 1, 1, wAttrmap
	ldcoord_a 8, 1, wAttrmap
	ldcoord_a 18, 8, wAttrmap

	hlcoord 12, 8, wAttrmap
	lb bc, 1, 2
	ld a, PAL_BATTLE_BG_STATUS
	call FillBoxWithByte

	hlcoord 2, 1, wAttrmap
	lb bc, 1, 2
	ld a, PAL_BATTLE_BG_STATUS
	call FillBoxWithByte

	hlcoord 1, 9, wAttrmap
	lb bc, 1, 6
	ld a, PAL_BATTLE_BG_TYPE_CAT
	call FillBoxWithByte

	hlcoord 0, 12, wAttrmap
	ld bc, 6 * SCREEN_WIDTH
	ld a, PAL_BATTLE_BG_TEXT
	rst ByteFill

	ld hl, BattleObjectPals
	ld de, wOBPals1 palette PAL_BATTLE_OB_GRAY
	ld c, 6 palettes
	call LoadPalettes
	pop bc

	ld a, b
	and a
	jr z, .apply_attr_map
	bit 0, b
	jr z, .no_player_overlay2
	hlcoord 0, 8, wAttrmap
	push bc
	ld b, PAL_BATTLE_BG_TEXT
	farcall SetAbilityOverlayAttributes
	pop bc
.no_player_overlay2
	bit 1, b
	jr z, .apply_attr_map
	hlcoord 9, 3, wAttrmap
	ld b, PAL_BATTLE_BG_TEXT
	farcall SetAbilityOverlayAttributes

.apply_attr_map
	jmp ApplyAttrMap

HPBarInteriorPals:
INCLUDE "gfx/battle/hp_bar.pal"

GenderAndExpBarPals:
INCLUDE "gfx/battle/exp_bar.pal"

_CGB_FlyMap:
	ld hl, PokegearOBPals
	ld de, wOBPals1
	ld c, 3 palettes
	call LoadPalettes
	; fallthrough

_CGB_PokegearPals:
	ld hl, PokegearPals
	ld de, wBGPals1
	ld c, 8 palettes
	call LoadPalettes

	ld a, [wPlayerGender]
	and a ; PLAYER_MALE
	jr z, .done

	dec a ; PLAYER_FEMALE
	ld hl, FemalePokegearInterfacePalette
	jr z, .got_interface_palette
	; PLAYER_ENBY
	ld hl, EnbyPokegearInterfacePalette
.got_interface_palette
	ld de, wBGPals1 palette 0
	call LoadOnePalette

.done
	call ApplyPals
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

PokegearPals:
INCLUDE "gfx/pokegear/pokegear.pal"

FemalePokegearInterfacePalette:
INCLUDE "gfx/pokegear/pokegear_f.pal"

EnbyPokegearInterfacePalette:
INCLUDE "gfx/pokegear/pokegear_x.pal"

_CGB_StatsScreenHPPals:
	ld de, wBGPals1 palette 1
	ld a, [wCurPartySpecies]
	ld b, a
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	jr z, .done
	ld b, EGG
.done
	ld a, b
	ld bc, wTempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	push de
	call VaryBGPal1ByTempMonDVs
	pop de

	ld hl, ItemIconPalettes
	ld bc, 2 colors
	ld a, [wTempMonItem]
	rst AddNTimes
	ld de, wSummaryScreenPals palette 2
	call LoadPalette_White_Col1_Col2_Black

	ld hl, GenderAndExpBarPals
	ld de, wSummaryScreenPals palette 6
	call LoadPalette_White_Col1_Col2_Black

	farcall SummaryScreen_InitAttrmap

	jmp _CGB_FinishLayout

_CGB_Pokedex:
	call _CGB_Pokedex_PrepareOnly
	jmp _CGB_FinishLayout

_CGB_Pokedex_PrepareOnly:
	ld hl, PokedexPals
	ld de, wBGPals1
	ld c, 2 palettes
	call LoadPalettes
	ld de, wBGPals1 palette 4
	ld c, 2 palettes
	call LoadPalettes
	ld de, wOBPals1 + 2
	ld c, 4 palettes - 2
	jmp LoadPalettes

PokedexPals:
INCLUDE "gfx/pokedex/pokedex.pal"

_CGB_SlotMachine:
	ld hl, SlotMachinePals
	ld de, wBGPals1
	ld c, 16 palettes
	call LoadPalettes

	call WipeAttrMap

	hlcoord 0, 2, wAttrmap
	lb bc, 10, 3
	ld a, $2
	call FillBoxWithByte

	hlcoord 17, 2, wAttrmap
	lb bc, 10, 3
	ld a, $2
	call FillBoxWithByte

	hlcoord 0, 4, wAttrmap
	lb bc, 6, 3
	ld a, $3
	call FillBoxWithByte

	hlcoord 17, 4, wAttrmap
	lb bc, 6, 3
	ld a, $3
	call FillBoxWithByte

	hlcoord 0, 6, wAttrmap
	lb bc, 2, 3
	ld a, $4
	call FillBoxWithByte

	hlcoord 17, 6, wAttrmap
	lb bc, 2, 3
	ld a, $4
	call FillBoxWithByte

	hlcoord 4, 2, wAttrmap
	lb bc, 2, 12
	ld a, $1
	call FillBoxWithByte

	hlcoord 3, 2, wAttrmap
	lb bc, 10, 1
	ld a, $1
	call FillBoxWithByte

	hlcoord 16, 2, wAttrmap
	lb bc, 10, 1
	ld a, $1
	call FillBoxWithByte

	hlcoord 0, 12, wAttrmap
	ld bc, $78
	ld a, $7
	rst ByteFill

	jmp _CGB_FinishLayout

SlotMachinePals:
INCLUDE "gfx/slots/slots.pal"

_CGB_Plain:
	ld b, 8
	ld de, wBGPals1
.loop
	ld hl, Gen1DiplomaPalette
	call LoadOnePalette
	dec b
	jr nz, .loop

	; de == wOBPals1
	ld hl, PokegearOBPals
	ld c, 8 palettes
	call LoadPalettes

	call WipeAttrMap
	jmp ApplyAttrMap

Gen1DiplomaPalette:
INCLUDE "gfx/diploma/plain.pal"

_CGB_NamingScreen:
	ld a, [wNamingScreenType]
	cp $4 ; box?
	ld a, THEME_STANDARD
	jr nz, .got_theme
	farcall GetBoxTheme
.got_theme
	call GetBillsPCThemePalette

	ldh a, [rSVBK]
	push af
	ld a, BANK("GBC Video")
	ldh [rSVBK], a

	push hl
	ld hl, GenderAndExpBarPals
	ld de, wBGPals1 + 2
	ld c, 2 * 2
	call LoadColorBytes
	pop hl
	ld c, 4 * 2
	call LoadColorBytes
	ld hl, WhiteColor
	ld de, wBGPals1 palette 1 + 6
	call LoadOneColor

	ld hl, wBGPals1 palette 1
	ld de, wBGPals1 palette 2
	call LoadOneColor
	ld hl, wBGPals1 + 6
	ld de, wBGPals1 palette 2 + 6
	call LoadOneColor

	pop af
	ldh [rSVBK], a

	ld hl, PokegearOBPals
	ld de, wOBPals1
	ld c, 8 palettes
	call LoadPalettes

	ld a, [wNamingScreenType]
	and a
	jr nz, .not_pokemon
	; mon minis use palette [wCurPartyMon]+2
	ld hl, wOBPals1 palette 2 + 2
	ld bc, 1 palettes
	ld a, [wCurPartyMon]
	rst AddNTimes
	ld d, h
	ld e, l
	ld a, [wMonType]
	cp TEMPMON
	jr nz, .party_mon
	call LoadTempMonPalette
	jr .not_pokemon
.party_mon
	call LoadPartyMonPalette
.not_pokemon

	; message area + Shift/Del/End
	ld a, $1
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
	; input characters
	inc a
	hlcoord 0, 6, wAttrmap
	ld c, SCREEN_WIDTH * 9
	rst ByteFill

	call FillNamingScreenTextBoxes

	; gender icon
	xor a
	ldcoord_a 1, 2, wAttrmap

	jmp ApplyAttrMap

_CGB_Mail:
	ld a, [wCurItem]
	sub FIRST_MAIL
	call LoadMailPalettes

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	ld hl, wBGPals1
	ld de, wBGPals1 palette 1
	call LoadOneColor
	ld hl, wBGPals1
	ld de, wBGPals1 palette 2
	call LoadOneColor
	ld hl, wBGPals1 + 2
	ld de, wBGPals1 palette 2 + 4
	call LoadOneColor
	ld hl, wBGPals1 + 4
	ld de, wBGPals1 palette 1 + 4
	call LoadOneColor
	ld hl, wBGPals1 + 6
	ld de, wBGPals1 palette 1 + 2
	call LoadOneColor
	ld hl, wBGPals1 + 6
	ld de, wBGPals1 palette 2 + 2
	call LoadOneColor
	ld hl, WhiteColor
	ld de, wBGPals1 palette 1 + 6
	call LoadOneColor
	ld hl, WhiteColor
	ld de, wBGPals1 palette 2 + 6
	call LoadOneColor

	ld hl, PokegearOBPals
	ld de, wOBPals1
	ld c, 8 palettes
	call LoadColorBytes

	pop af
	ldh [rSVBK], a

	; message area
	ld a, $1
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * 6
	rst ByteFill
	; input characters
	xor a
	ld c, SCREEN_WIDTH * 9
	rst ByteFill
	; Shift/Del/End
	ld a, $2
	ld c, SCREEN_WIDTH * 3
	rst ByteFill

	call FillNamingScreenTextBoxes

	jmp ApplyAttrMap

FillNamingScreenTextBoxes:
	; Shift/Del/End
	ld a, $7
	hlcoord 1, SCREEN_HEIGHT - 2, wAttrmap
	ld bc, SCREEN_WIDTH - 2
	rst ByteFill
	; message area
	hlcoord 1, 1, wAttrmap
	lb bc, 4, SCREEN_WIDTH - 2
	jmp FillBoxWithByte

_CGB_MapPals:
	call LoadMapPals
	ld a, CGB_MAPPALS
	ld [wMemCGBLayout], a
	ret

_CGB_PartyMenu:
	ld de, wBGPals1
	ld hl, PartyMenuBGPals ; and HPBarPals
	ld c, 4 palettes
	call LoadPalettes

	ld hl, GenderAndExpBarPals
	call LoadPalette_White_Col1_Col2_Black

	ld de, wBGPals1 palette 7
	ld hl, PartyMenuBGPals
	call LoadOnePalette

	call InitPartyMenuOBPals

	hlcoord 10, 2, wAttrmap
	lb bc, 11, 1
	ld a, $4
	call FillBoxWithByte
	jmp ApplyAttrMap

PartyMenuBGPals:
INCLUDE "gfx/stats/party_menu_bg.pal"
; fallthrough
HPBarPals:
INCLUDE "gfx/stats/hp_bars.pal"

_CGB_Evolution:
	ld de, wBGPals1
	ld a, c
	and a
	jr z, .pokemon
	ld hl, DarkGrayPalette
	call LoadOnePalette
	jr .got_palette

.pokemon
	ld hl, wTempMonPersonality
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
	; c = species
	ld a, [wCurPartySpecies]
	ld c, a
	; b = form
	ld a, [wCurForm]
	ld b, a
	; vary colors by DVs
	call CopyDVsToColorVaryDVs
	ld hl, wBGPals1 palette 0 + 2
	call VaryColorsByDVs

	ld hl, BattleObjectPals
	ld de, wOBPals1 palette 2
	ld c, 6 palettes
	call LoadPalettes

.got_palette
	call WipeAttrMap
	jmp _CGB_FinishLayout

_CGB_MoveList:
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $7
	rst ByteFill

	hlcoord 1, 12, wAttrmap
	ld bc, 6
	xor a
	rst ByteFill

	call GetCurMoveFixedCategory
	add a
	add a
	ld hl, CategoryIconPals
	ld c, a
	ld b, 0
	add hl, bc
	ld de, wBGPals1 palette 0 + 2
	ld c, 4
	call LoadPalettes

	ld hl, Moves + MOVE_TYPE
	call GetCurMoveProperty
	ld hl, TypeIconPals
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld de, wBGPals1 palette 0 + 6
	ld c, 2
	call LoadPalettes

	jmp _CGB_FinishLayout

_CGB_BuyMenu:
	ld a, [wMartType]
	cp MARTTYPE_BLUECARD
	ld hl, BlueCardMartMenuPals
	jr z, .ok
	cp MARTTYPE_BP
	ld hl, BTMartMenuPals
	jr z, .ok
	ld hl, MartMenuPals
.ok
	ld de, wBGPals1
	ld c, 3 palettes
	call LoadPalettes

rept 2
	ld hl, CancelPalette
	call LoadPalette_White_Col1_Col2_Black
endr

	call WipeAttrMap

	hlcoord 6, 4, wAttrmap
	lb bc, 7, 1
	ld a, $2
	call FillBoxWithByte

	hlcoord 1, 8, wAttrmap
	lb bc, 3, 3
	ld a, $7
	call FillBoxWithByte

	jmp _CGB_FinishLayout

MartMenuPals:
INCLUDE "gfx/mart/mart.pal"

BlueCardMartMenuPals:
INCLUDE "gfx/mart/blue_card.pal"

BTMartMenuPals:
INCLUDE "gfx/mart/battle_tower.pal"

_CGB_PackPals:
; pack pals
	ld a, [wBattleType]
	ld hl, FemalePackPals
	cp BATTLETYPE_TUTORIAL
	jr z, .got_gender
	ld a, [wPlayerGender]
	ld hl, MalePackPals
	and a ; PLAYER_MALE
	jr z, .got_gender
	ld hl, FemalePackPals
	dec a ; PLAYER_FEMALE
	jr z, .got_gender
	; PLAYER_ENBY
	ld hl, EnbyPackPals
.got_gender
	ld de, wBGPals1
	ld c, 8 palettes
	call LoadPalettes

	call WipeAttrMap

	hlcoord 0, 0, wAttrmap
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
	ldcoord_a 7, 2, wAttrmap
	ldcoord_a 7, 4, wAttrmap
	ldcoord_a 7, 6, wAttrmap
	ldcoord_a 7, 8, wAttrmap
	ldcoord_a 7, 10, wAttrmap
	hlcoord 0, 2, wAttrmap
	lb bc, 5, 5
	call FillBoxWithByte

	hlcoord 1, 8, wAttrmap
	lb bc, 3, 3
	ld a, $7
	call FillBoxWithByte

	jmp _CGB_FinishLayout

MalePackPals:
INCLUDE "gfx/pack/pack.pal"

FemalePackPals:
INCLUDE "gfx/pack/pack_f.pal"

EnbyPackPals:
INCLUDE "gfx/pack/pack_x.pal"

_CGB_TrainerCard:
	call LoadFirstTwoTrainerCardPals

	ld hl, TrainerCardPals + 4 ; skip default
	call LoadPalette_White_Col1_Col2_Black ; bronze star
	call LoadPalette_White_Col1_Col2_Black ; silver star
	call LoadPalette_White_Col1_Col2_Black ; gold star
	call LoadPalette_White_Col1_Col2_Black ; crystal star

	; Trainer stars
	hlcoord 2, 16, wAttrmap
	ld a, $2 ; bronze
	ld [hli], a
	inc a ; silver
	ld [hli], a
	inc a ; gold
	ld [hli], a
	inc a ; crystal
	ld [hl], a

	jmp _CGB_FinishLayout

_CGB_TrainerCard2:
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
	ld de, wOBPals1
	ld c, 8 palettes
	call LoadPalettes

	; Falkner
	hlcoord 3, 10, wAttrmap
	lb bc, 3, 3
	ld a, $2
	call FillBoxWithByte

	; Bugsy
	hlcoord 7, 10, wAttrmap
	lb bc, 3, 3
	ld a, $3
	call FillBoxWithByte

	; Whitney
	hlcoord 11, 10, wAttrmap
	lb bc, 3, 3
	ld a, $4
	call FillBoxWithByte

	; Morty
	hlcoord 15, 10, wAttrmap
	lb bc, 3, 3
	ld a, $5
	call FillBoxWithByte

	; Chuck
	hlcoord 3, 13, wAttrmap
	lb bc, 3, 3
	ld a, $6
	call FillBoxWithByte

	; Jasmine
	hlcoord 7, 13, wAttrmap
	lb bc, 3, 3
	ld a, $6
	call FillBoxWithByte

	; Pryce
	hlcoord 11, 13, wAttrmap
	lb bc, 3, 3
	ld a, $7
	call FillBoxWithByte

	; Clair
	hlcoord 15, 13, wAttrmap
	lb bc, 3, 3
	ld a, $7
	call FillBoxWithByte

	jmp _CGB_FinishLayout

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
	ld de, wOBPals1
	ld c, 8 palettes
	call LoadPalettes

	; Lt.Surge
	hlcoord 3, 10, wAttrmap
	lb bc, 3, 3
	ld a, $4
	call FillBoxWithByte

	; Sabrina
	hlcoord 7, 10, wAttrmap
	lb bc, 3, 3
	ld a, $3
	call FillBoxWithByte

	; Misty
	hlcoord 11, 10, wAttrmap
	lb bc, 3, 3
	ld a, $5
	call FillBoxWithByte

	; Erika
	hlcoord 15, 10, wAttrmap
	lb bc, 3, 3
	ld a, $4
	call FillBoxWithByte

	; Janine
	hlcoord 3, 13, wAttrmap
	lb bc, 3, 3
	ld a, $6
	call FillBoxWithByte

	; Brock
	hlcoord 7, 13, wAttrmap
	lb bc, 3, 3
	ld a, $2
	call FillBoxWithByte

	; Blaine
	hlcoord 11, 13, wAttrmap
	lb bc, 3, 3
	ld a, $3
	call FillBoxWithByte

	; Blue
	hlcoord 15, 13, wAttrmap
	lb bc, 3, 3
	ld a, $7
	call FillBoxWithByte

	jmp _CGB_FinishLayout

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
	ld de, wBGPals1
	call LoadPalette_White_Col1_Col2_Black

	; player sprite
	ld a, [wPlayerGender]
	ld b, CHRIS
	and a ; PLAYER_MALE
	jr z, .got_gender
	assert CHRIS - 1 == KRIS
	dec b
	dec a ; PLAYER_FEMALE
	jr z, .got_gender
	; PLAYER_ENBY
	ld b, CRYS
.got_gender
	ld a, b
	call GetTrainerPalettePointer
	call LoadPalette_White_Col1_Col2_Black

	push de
	; border
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	rst ByteFill

	; player
	hlcoord 14, 1, wAttrmap
	lb bc, 7, 5
	ld a, $1
	call FillBoxWithByte

	pop de
	ret

TrainerCardPals:
INCLUDE "gfx/trainer_card/trainer_card.pal"

JohtoBadgePalettes:
INCLUDE "gfx/trainer_card/johto_badges.pal"

KantoBadgePalettes:
INCLUDE "gfx/trainer_card/kanto_badges.pal"

_CGB_BillsPC:
	farcall GetBoxTheme
BillsPC_PreviewTheme:
	call GetBillsPCThemePalette

	ldh a, [rSVBK]
	push af
	ld a, BANK("GBC Video")
	ldh [rSVBK], a

	push hl
	ld de, wBGPals1 + 2
	ld hl, GenderAndExpBarPals
	ld c, 2 * 2
	call LoadColorBytes
	push de
	ld hl, .PokerusAndShinyPals
	ld de, wBillsPC_PokerusShinyPal
	ld c, 2 * 2
	call LoadColorBytes
	; Prevents flickering shiny+pokerus background
	ld hl, wBGPals1 palette 0
	ld de, wBGPals1 palette 3
	call LoadOneColor
	pop de
	pop hl
	ld c, 4 * 2
	call LoadColorBytes
	ld hl, WhitePalette
	ld de, wBGPals1 palette 1 + 3 * 2
	call LoadOneColor
	ld hl, wBGPals1 palette 1
	ld de, wBGPals1 palette 0
	call LoadOneColor

	pop af
	ldh [rSVBK], a

	ld a, [wBillsPC_ApplyThemePals]
	and a
	jr z, .ob_pals
	farjp BillsPC_SetPals

.ob_pals
	ld de, wOBPals1
	ld hl, PokegearOBPals
	ld c, 8 palettes
	call LoadPalettes
	ld de, wOBPals1 palette 1
	ld hl, .CursorPal
	push hl
	call LoadOnePalette
	pop hl
	call LoadOnePalette
	ld hl, .PackPal
	ld de, wOBPals1 palette 4
	call LoadOnePalette
	ld hl, WhitePalette
	ld de, wOBPals1 palette 6
	jmp LoadOnePalette

.PokerusAndShinyPals:
INCLUDE "gfx/pc/pokerus_shiny.pal"

.CursorPal:
; Coloring is fixed up later.
INCLUDE "gfx/pc/cursor_default.pal"

.PackPal:
INCLUDE "gfx/pc/pack.pal"

GetBillsPCThemePalette:
	; hl = .ThemePals + a * 4 * 2
	assert NUM_BILLS_PC_THEMES <= 64
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, .ThemePals
	add hl, de
	add hl, de
	ret

.ThemePals:
	table_width PAL_COLOR_SIZE * 4
INCLUDE "gfx/pc/themes.pal"
	assert_table_length NUM_BILLS_PC_THEMES

_CGB_UnownPuzzle:
	ld de, wBGPals1
	ld hl, .UnownPuzzlePalette
	call LoadOnePalette

	ld de, wOBPals1
	ld hl, .UnownPuzzlePalette
	call LoadOnePalette

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, wOBPals1
if DEF(NOIR)
	ld a, LOW(palred 9 + palgreen 9 + palblue 9)
	ld [hli], a
	ld [hl], HIGH(palred 9 + palgreen 9 + palblue 9)
elif !DEF(MONOCHROME)
; RGB 31, 00, 00
	ld a, LOW(palred 31 + palgreen 0 + palblue 0)
	ld [hli], a
	ld [hl], HIGH(palred 31 + palgreen 0 + palblue 0)
else
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld [hl], HIGH(PAL_MONOCHROME_WHITE)
endc
	pop af
	ldh [rSVBK], a

	call WipeAttrMap
	jmp ApplyAttrMap

.UnownPuzzlePalette:
INCLUDE "gfx/unown_puzzle/unown_puzzle.pal"

_CGB_GameFreakLogo:
	ld de, wBGPals1
	ld hl, .GameFreakLogoPalette
	call LoadOnePalette

	ld de, wOBPals1
rept 2
	ld hl, .GameFreakDittoPalette
	call LoadOnePalette
endr
	ret

.GameFreakLogoPalette:
INCLUDE "gfx/splash/logo.pal"

.GameFreakDittoPalette:
INCLUDE "gfx/splash/ditto.pal"

_CGB_TradeTube:
	ld de, wBGPals1
	ld hl, .TradeTubeBGPalette
	call LoadOnePalette

	ld hl, .TradeTubeOBPalette
	ld de, wOBPals1
	call LoadOnePalette

	ld de, wOBPals1 palette 7
	ld hl, .TradeTubeBGPalette
	call LoadOnePalette

	jmp WipeAttrMap

.TradeTubeBGPalette:
INCLUDE "gfx/trade/trade_tube_bg.pal"

.TradeTubeOBPalette:
INCLUDE "gfx/trade/trade_tube_ob.pal"

_CGB_IntroPals:
	ld de, wBGPals1
	ld a, [wCurPartySpecies]
	ld bc, wTempMonPersonality
	call GetFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	push de
	call VaryBGPal0ByTempMonDVs
	pop de

	ld hl, IntroGradientPalette
	call LoadOnePalette

	call WipeAttrMap

	hlcoord 0, 0, wAttrmap
	lb bc, 3, 20
	ld a, $1
	call FillBoxWithByte

	call ApplyAttrMap
	jmp ApplyPals

_CGB_IntroGenderPals:
	ld de, wBGPals1
	ld hl, ChrisPalette
	call LoadPalette_White_Col1_Col2_Black
	ld hl, IntroGradientPalette
	call LoadOnePalette
	ld hl, KrisPalette
	call LoadPalette_White_Col1_Col2_Black
	ld hl, CrysPalette
	call LoadPalette_White_Col1_Col2_Black

	call WipeAttrMap

	hlcoord 0, 0, wAttrmap
	lb bc, 3, 20
	ld a, $1
	call FillBoxWithByte

	hlcoord 7, 3, wAttrmap
	lb bc, 8, 5
	ld a, $2
	call FillBoxWithByte

	hlcoord 14, 3, wAttrmap
	lb bc, 8, 5
	ld a, $3
	call FillBoxWithByte

	call ApplyAttrMap
	jmp ApplyPals

IntroGradientPalette:
INCLUDE "gfx/new_game/intro_gradient.pal"

_CGB_NewDiploma:
	ld hl, DiplomaPals
	ld de, wBGPals1
	ld c, 4 palettes
	call LoadPalettes

	call WipeAttrMap

	hlcoord 3, 2, wAttrmap
	lb bc, 2, 14
	ld a, $1
	call FillBoxWithByte

	hlcoord 2, 4, wAttrmap
	ld a, $2
	ldcoord_a 17, 6, wAttrmap
	lb bc, 8, 15
	call FillBoxWithByte

	jmp ApplyAttrMap

DiplomaPals:
INCLUDE "gfx/diploma/diploma.pal"

_CGB_PlayerOrMonFrontpicPals:
	ld de, wBGPals1
	ld a, [wCurPartySpecies]
	ld bc, wTempMonPersonality
	call GetPlayerOrMonPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call VaryBGPal0ByTempMonDVs
	call WipeAttrMap
	call ApplyAttrMap
	jmp ApplyPals

_CGB_TrainerOrMonFrontpicPals:
	ld de, wBGPals1
	ld a, [wCurPartySpecies]
	ld bc, wTempMonPersonality
	call GetFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	call VaryBGPal0ByTempMonDVs
	call WipeAttrMap
	call ApplyAttrMap
	jmp ApplyPals

_CGB_JudgeSystem:
	; gender icon
	ld de, wBGPals1 palette 6
	ld hl, GenderAndExpBarPals
	call LoadPalette_White_Col1_Col2_Black
	; frontpic
	ld a, [wCurPartySpecies]
	ld bc, wTempMonPersonality
	call GetFrontpicPalettePointer
	call LoadPalette_White_Col1_Col2_Black
	ld hl, wBGPals1 palette 7 + 2
	call VaryBGPalByTempMonDVs
	; max stat sparkle and bottle cap
	ld de, wOBPals1 palette 0
	ld hl, .SparkleAndBottleCapPalette
	ld c, 2 palettes
	call LoadPalettes

	call WipeAttrMap

	; up/down arrows
	hlcoord 0, 0, wAttrmap
	ld a, 1 | VRAM_BANK_1
	ld [hli], a
	; top row
	ld bc, 17
	ld a, 1
	rst ByteFill
	; gender icon
	ld a, 6 | VRAM_BANK_1
	ld [hli], a
	; shiny icon and second row
	ld a, 1 | VRAM_BANK_1
	ld bc, 21
	rst ByteFill
	; left/right arrows
	hlcoord 0, 2, wAttrmap
	ld [hl], 0 | VRAM_BANK_1
	; frontpic
	hlcoord 0, 6, wAttrmap
	lb bc, 7, 7
	ld a, 7
	call FillBoxWithByte
	; chart
	hlcoord 9, 4, wAttrmap
	lb bc, 12, 8
	ld a, 5 | VRAM_BANK_1
	call FillBoxWithByte
	hlcoord 8, 6, wAttrmap
	lb bc, 8, 1
	ld a, 5 | VRAM_BANK_1
	call FillBoxWithByte
	hlcoord 17, 6, wAttrmap
	lb bc, 8, 1
	ld a, 5 | VRAM_BANK_1
	call FillBoxWithByte
	; stat values
	ld c, STAT_HP
	hlcoord 12, 3, wAttrmap
	call .FillStat
	ld c, STAT_ATK
	hlcoord 17, 5, wAttrmap
	call .FillStat
	ld c, STAT_DEF
	hlcoord 17, 14, wAttrmap
	call .FillStat
	ld c, STAT_SPE
	hlcoord 12, 16, wAttrmap
	call .FillStat
	ld c, STAT_SDEF
	hlcoord 6, 14, wAttrmap
	call .FillStat
	ld c, STAT_SATK
	hlcoord 6, 5, wAttrmap
	call .FillStat
	; heading
	hlcoord 0, 3, wAttrmap
	ld a, 0 | VRAM_BANK_1
	ld bc, 11
	rst ByteFill

	jr _CGB_FinishLayout

.FillStat:
; Use palette 2 for normal, 3 for lowered, 4 for raised
	ld a, [wTempMonNature]
	push hl
	farcall GetNatureStatMultiplier
	pop hl
	cp 10 ; 10 is normal
	ld a, 4
	jr c, .lowered_stat ; 9 is lowered
	jr nz, .raised_stat ; 11 is raised
	dec a ; 2
.lowered_stat
	dec a ; 3
.raised_stat
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

.SparkleAndBottleCapPalette:
INCLUDE "gfx/stats/judge_ob.pal"

_CGB_FinishLayout:
	call ApplyAttrMap
	call ApplyPals
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret
