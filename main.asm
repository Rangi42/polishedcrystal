INCLUDE "constants.asm"


SECTION "Code 1", ROMX

LoadPushOAM:: ; 4031
	lb bc, (PushOAMEnd - PushOAM), (hPushOAM - $ff00)
	ld hl, PushOAM
.loop
	ld a, [hli]
	ld [$ff00+c], a
	inc c
	dec b
	jr nz, .loop
	ret

PushOAM: ; 403f
	ld a, Sprites / $100
	ld [rDMA], a
	ld a, 40
.loop
	dec a
	jr nz, .loop
	ret
PushOAMEnd

ReanchorBGMap_NoOAMUpdate:: ; 6454
	call DelayFrame

	ld a, [hOAMUpdate]
	push af

	ld a, $1
	ld [hOAMUpdate], a
	ld a, [hBGMapMode]
	push af

	xor a
	ld [hBGMapMode], a
	ld [hLCDCPointer], a
	ld a, $90
	ld [hWY], a
	call OverworldTextModeSwitch

	ld a, VBGMap1 / $100
	ld [hBGMapAddress + 1], a
	xor a
	ld [hBGMapAddress], a
	farcall OpenAndCloseMenu_HDMATransferTileMapAndAttrMap

	farcall LoadBlindingFlashPalette
	farcall ApplyPals

	xor a
	ld [hBGMapMode], a
	ld [hWY], a
	inc a
	ld [hCGBPalUpdate], a
	call HDMATransfer_FillBGMap0WithBlackTile

	ld a, VBGMap0 / $100
	ld [hBGMapAddress + 1], a
	ld [wBGMapAnchor + 1], a
	xor a
	ld [hBGMapAddress], a
	ld [wBGMapAnchor], a
	ld [hSCX], a
	ld [hSCY], a
	call ApplyBGMapAnchorToObjects

	pop af
	ld [hBGMapMode], a
	pop af
	ld [hOAMUpdate], a
	ld hl, VramState
	set 6, [hl]
	ret

LoadFonts_NoOAMUpdate:: ; 64bf
	ld a, [hOAMUpdate]
	push af
	ld a, $1
	ld [hOAMUpdate], a

	call LoadFontsExtra
	ld a, $90
	ld [hWY], a
	call SafeUpdateSprites
	call LoadStandardFont

	pop af
	ld [hOAMUpdate], a
	ret

HDMATransfer_FillBGMap0WithBlackTile: ; 64db
	ld a, [rSVBK]
	push af
	ld a, $6
	ld [rSVBK], a

	ld a, "<BLACK>"
	ld hl, wScratchTileMap
	ld bc, BG_MAP_WIDTH * BG_MAP_HEIGHT
	call ByteFill
	ld a, wScratchTileMap / $100
	ld [rHDMA1], a
	ld a, wScratchTileMap % $100
	ld [rHDMA2], a
	ld a, (VBGMap0 % $8000) / $100
	ld [rHDMA3], a
	ld a, (VBGMap0 % $8000) % $100
	ld [rHDMA4], a
	ld a, $3f
	ld [hDMATransfer], a
	call DelayFrame

	pop af
	ld [rSVBK], a
	ret

ReanchorBGMap_NoOAMUpdate_NoDelay::
	ld a, [hOAMUpdate]
	push af
	ld a, $1
	ld [hOAMUpdate], a

	ld a, [hBGMapMode]
	push af
	xor a
	ld [hBGMapMode], a

	ld [hLCDCPointer], a
	ld a, $90
	ld [hWY], a
	call OverworldTextModeSwitch

	ld a, VBGMap1 / $100
	ld [hBGMapAddress + 1], a
	xor a
	ld [hBGMapAddress], a
	farcall BridgeTransition_HDMATransferTileMapAndAttrMap

	ld a, VBGMap0 / $100
	ld [hBGMapAddress + 1], a
	ld [wBGMapAnchor + 1], a
	xor a
	ld [hBGMapAddress], a
	ld [wBGMapAnchor], a
	ld [hSCX], a
	ld [hSCY], a
	ld [hWY], a
	inc a
	ld [hCGBPalUpdate], a
	farcall BridgeTransition_HDMATransferTileMapAndAttrMap

	pop af
	ld [hBGMapMode], a

	pop af
	ld [hOAMUpdate], a
	ret

INCLUDE "engine/map_objects.asm"
INCLUDE "engine/intro_menu.asm"
INCLUDE "engine/init_options.asm"
INCLUDE "engine/learn.asm"
INCLUDE "engine/math.asm"
INCLUDE "engine/npc_movement.asm"
INCLUDE "engine/events/happiness_egg.asm"
INCLUDE "engine/events/specials_2.asm"
INCLUDE "data/items/attributes.asm"


SECTION "Code 2", ROMX

INCLUDE "engine/player_object.asm"
INCLUDE "engine/sine.asm"
INCLUDE "data/predef_pointers.asm"
INCLUDE "engine/color.asm"
INCLUDE "engine/trainer_scripts.asm"


SECTION "Code 3", ROMX

INCLUDE "engine/events/specials.asm"
INCLUDE "engine/printnum.asm"
INCLUDE "engine/health.asm"
INCLUDE "engine/events/overworld.asm"
INCLUDE "engine/items.asm"
INCLUDE "engine/player_step.asm"
INCLUDE "engine/anim_hp_bar.asm"
INCLUDE "engine/move_mon.asm"
INCLUDE "engine/billspctop.asm"
INCLUDE "engine/item_effects.asm"

CheckTime:: ; c000
	ld a, [TimeOfDay]
	ld hl, TimeOfDayTable
	ld de, 2
	call IsInArray
	inc hl
	ld c, [hl]
	ret c

	xor a
	ld c, a
	ret

TimeOfDayTable: ; c012
	db MORN, 1 << MORN
	db DAY,  1 << DAY
	db NITE, 1 << NITE
	db NITE, 1 << NITE
	db -1

GetBreedMon1LevelGrowth: ; e698
	ld hl, wBreedMon1Stats
	ld de, TempMon
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	farcall CalcLevel
	ld a, [wBreedMon1Level]
	ld b, a
	ld a, d
	ld e, a
	sub b
	ld d, a
	ret

GetBreedMon2LevelGrowth: ; e6b3
	ld hl, wBreedMon2Stats
	ld de, TempMon
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	farcall CalcLevel
	ld a, [wBreedMon2Level]
	ld b, a
	ld a, d
	ld e, a
	sub b
	ld d, a
	ret

BugContest_SetCaughtContestMon: ; e6ce
	ld a, [wContestMon]
	and a
	jr z, .firstcatch
	ld [wd265], a
	call DisplayAlreadyCaughtText
	call DisplayCaughtContestMonStats
	call YesNoBox
	ret c

.firstcatch
	call .generatestats
	ld a, [TempEnemyMonSpecies]
	ld [wd265], a
	call GetPokemonName
	ld hl, .caughttext
	jp PrintText

.generatestats ; e6fd
	ld a, [TempEnemyMonSpecies]
	ld [CurSpecies], a
	ld [CurPartySpecies], a
	call GetBaseData
	xor a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wContestMon
	call ByteFill
	xor a
	ld [MonType], a
	ld hl, wContestMon
	jp GeneratePartyMonStats

.caughttext ; 0xe71d
	; Caught @ !
	text_jump UnknownText_0x1c10c0
	db "@"

DisplayAlreadyCaughtText: ; cc0c7
	call GetPokemonName
	ld hl, .AlreadyCaughtText
	jp PrintText

.AlreadyCaughtText: ; 0xcc0d0
	; You already caught a @ .
	text_jump UnknownText_0x1c10dd
	db "@"

DisplayCaughtContestMonStats: ; cc000
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call LoadFontsBattleExtra

	ld hl, Options1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]

	hlcoord 0, 0
	lb bc, 4, 13
	call TextBox

	hlcoord 0, 6
	lb bc, 4, 13
	call TextBox

	hlcoord 2, 0
	ld de, .Stock
	call PlaceString

	hlcoord 2, 6
	ld de, .This
	call PlaceString

	hlcoord 5, 4
	ld de, .Health
	call PlaceString

	hlcoord 5, 10
	ld de, .Health
	call PlaceString

	ld a, [wContestMon]
	ld [wd265], a
	call GetPokemonName
	ld de, StringBuffer1
	hlcoord 1, 2
	call PlaceString

	ld h, b
	ld l, c
	ld a, [wContestMonLevel]
	ld [TempMonLevel], a
	call PrintLevel

	ld de, EnemyMonNick
	hlcoord 1, 8
	call PlaceString

	ld h, b
	ld l, c
	ld a, [EnemyMonLevel]
	ld [TempMonLevel], a
	call PrintLevel

	hlcoord 11, 4
	ld de, wContestMonMaxHP
	lb bc, 2, 3
	call PrintNum

	hlcoord 11, 10
	ld de, EnemyMonMaxHP
	call PrintNum

	ld hl, SwitchMonText
	call PrintText

	pop af
	ld [Options1], a

	call WaitBGMap
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	jp SetPalettes

.Health:
	db "Health@"
.Stock:
	db " Stock <PK><MN> @"
.This:
	db " This <PK><MN>  @"

SwitchMonText: ; cc0c2
	; Switch #MON?
	text_jump UnknownText_0x1c10cf
	db "@"


SECTION "Code 4", ROMX

INCLUDE "engine/pack.asm"
INCLUDE "engine/time.asm"
INCLUDE "engine/tmhm.asm"
INCLUDE "engine/naming_screen.asm"
INCLUDE "engine/events/itemball.asm"
INCLUDE "engine/events/heal_machine_anim.asm"
INCLUDE "engine/events/whiteout.asm"
INCLUDE "engine/events/forced_movement.asm"
INCLUDE "engine/events/itemfinder.asm"
INCLUDE "engine/startmenu.asm"
INCLUDE "engine/selectmenu.asm"
INCLUDE "engine/events/elevator.asm"
INCLUDE "engine/events/bug_contest.asm"
INCLUDE "engine/events/safari_game.asm"
INCLUDE "engine/events/std_tiles.asm"


SECTION "Roofs", ROMX

INCLUDE "engine/mapgroup_roofs.asm"


SECTION "Code 5", ROMX

INCLUDE "engine/rtc.asm"
INCLUDE "engine/overworld.asm"
INCLUDE "engine/tile_events.asm"
INCLUDE "engine/save.asm"
INCLUDE "engine/spawn_points.asm"
INCLUDE "engine/map_setup.asm"
INCLUDE "engine/pokecenter_pc.asm"
INCLUDE "engine/mart.asm"
INCLUDE "engine/money.asm"
INCLUDE "data/items/marts.asm"
INCLUDE "engine/events/mom.asm"
INCLUDE "engine/events/daycare.asm"
INCLUDE "engine/breeding.asm"


SECTION "Code 6", ROMX

INCLUDE "engine/clock_reset.asm"
INCLUDE "engine/events/move_reminder.asm"


SECTION "Code 7", ROMX

INCLUDE "engine/events/pokepic.asm"
INCLUDE "engine/scrolling_menu.asm"
INCLUDE "engine/switch_items.asm"
INCLUDE "engine/menu.asm"
INCLUDE "engine/mon_menu.asm"
INCLUDE "engine/battle/menu.asm"
INCLUDE "engine/buy_sell_toss.asm"
INCLUDE "engine/trainer_card.asm"
INCLUDE "engine/events/prof_oaks_pc.asm"
INCLUDE "engine/decorations.asm"
INCLUDE "data/trainers/dvs.asm"

UpdateItemDescriptionAndBagQuantity:
	hlcoord 1, 1
	lb bc, 1, 8
	call ClearBox
	ld a, [MenuSelection]
	cp -1
	jr z, UpdateItemDescription
	hlcoord 1, 1
	ld de, BagXString
	call PlaceString
	ld a, [MenuSelection]
	call GetQuantityInBag
	hlcoord 6, 1
	ld de, Buffer1
	lb bc, 2, 3
	call PrintNum
UpdateItemDescription: ; 0x244c3
	ld a, [MenuSelection]
	ld [CurSpecies], a
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call TextBox
	ld a, [MenuSelection]
	cp -1
	ret z
	decoord 1, 14
	farjp PrintItemDescription

BagXString:
	db "Bag ×@"

UpdateTMHMDescriptionAndOwnership:
	hlcoord 1, 1
	lb bc, 1, 8
	call ClearBox
	ld a, [MenuSelection]
	cp -1
	jr z, UpdateTMHMDescription
	ld a, [CurTMHM]
	call CheckTMHM
	ld de, OwnedTMString
	jr c, .GotString
	ld de, UnownedTMString
.GotString
	hlcoord 1, 1
	call PlaceString
UpdateTMHMDescription:
	ld a, [MenuSelection]
	ld [CurSpecies], a
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call TextBox
	ld a, [MenuSelection]
	cp -1
	ret z
	decoord 1, 14
	farjp PrintTMHMDescription

OwnedTMString:
	db "Owned@"
UnownedTMString:
	db "Unowned@"

GetQuantityInBag:
	ld a, [CurItem]
	push af
	ld a, [MenuSelection]
	ld [CurItem], a
	call CountItem
	pop af
	ret

PlaceMenuItemName: ; 0x24ab4
	push de
	ld a, [MenuSelection]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	pop hl
	jp PlaceString

PlaceMenuTMHMName:
	push de
	ld a, [MenuSelection]
	ld [wNamedObjectIndexBuffer], a
	call GetTMHMName
	pop hl
	jp PlaceString

PlaceMenuApricornQuantity:
	ld a, [MenuSelection]
	ld [CurItem], a
	and a
	ret nz
	ld l, e
	ld h, d
	jr _PlaceMenuQuantity

PlaceMenuItemQuantity: ; 0x24ac3
	push de
	ld a, [MenuSelection]
	ld [CurItem], a
	farcall _CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	pop hl
	and a
	ret nz
_PlaceMenuQuantity:
	ld de, $15
	add hl, de
	ld [hl], "×"
	inc hl
	ld de, MenuSelectionQuantity
	lb bc, 1, 2
	jp PrintNum

PlaceMoneyTopRight: ; 24ae8
	ld hl, MenuDataHeader_0x24b15
	call CopyMenuDataHeader
	jr PlaceMoneyDataHeader

PlaceMoneyBottomLeft: ; 24af0
	ld hl, MenuDataHeader_0x24b1d
	call CopyMenuDataHeader
	jr PlaceMoneyDataHeader

PlaceMoneyAtTopLeftOfTextbox: ; 24af8
	ld hl, MenuDataHeader_0x24b15
	lb de, 0, 11
	call OffsetMenuDataHeader

PlaceMoneyDataHeader: ; 24b01
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld de, Money
	lb bc, PRINTNUM_MONEY | 3, 7
	jp PrintNum

MenuDataHeader_0x24b15: ; 0x24b15
	db $40 ; flags
	db 00, 10 ; start coords
	db 02, 19 ; end coords
	dw NULL
	db 1 ; default option

MenuDataHeader_0x24b1d: ; 0x24b1d
	db $40 ; flags
	db 11, 00 ; start coords
	db 13, 09 ; end coords
	dw NULL
	db 1 ; default option

PlaceBlueCardPointsTopRight:
	hlcoord 11, 0
	lb bc, 1, 7
	call TextBox
	hlcoord 12, 1
	ld de, wBlueCardBalance
	lb bc, 1, 3
	call PrintNum
	ld de, .PointsString
	jp PlaceString

.PointsString:
	db " Pts@"

PlaceBattlePointsTopRight:
	hlcoord 12, 0
	lb bc, 1, 6
	call TextBox
	hlcoord 13, 1
	ld de, BattlePoints
	lb bc, 1, 3
	call PrintNum
	ld de, .BPString
	jp PlaceString

.BPString:
	db " BP@"

Special_DisplayCoinCaseBalance: ; 24b25
	; Place a text box of size 1x7 at 11, 0.
	hlcoord 11, 0
	lb bc, 1, 7
	call TextBox
	hlcoord 12, 0
	ld de, CoinString
	call PlaceString
	ld de, Coins
	lb bc, 2, 5
	hlcoord 13, 1
	jp PrintNum

Special_DisplayMoneyAndCoinBalance: ; 24b4e
	hlcoord 5, 0
	lb bc, 3, 13
	call TextBox
	hlcoord 6, 1
	ld de, MoneyString
	call PlaceString
	hlcoord 11, 1
	ld de, Money
	lb bc, PRINTNUM_MONEY | 3, 7
	call PrintNum
	hlcoord 6, 3
	ld de, CoinString
	call PlaceString
	hlcoord 14, 3
	ld de, Coins
	lb bc, 2, 5
	jp PrintNum

MoneyString: ; 24b83
	db "Money@"
CoinString: ; 24b89
	db "Coin@"

StartMenu_DrawBugContestStatusBox: ; 24bdc
	hlcoord 0, 0
	lb bc, 5, 17
	jp TextBox

StartMenu_PrintBugContestStatus: ; 24be7
	ld hl, Options1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call StartMenu_DrawBugContestStatusBox
	hlcoord 1, 5
	ld de, .Balls
	call PlaceString
	hlcoord 8, 5
	ld de, wParkBallsRemaining
	lb bc, PRINTNUM_RIGHTALIGN | 1, 2
	call PrintNum
	hlcoord 1, 1
	ld de, .Caught
	call PlaceString
	ld a, [wContestMon]
	and a
	ld de, .None
	jr z, .no_contest_mon
	ld [wd265], a
	call GetPokemonName

.no_contest_mon
	hlcoord 8, 1
	call PlaceString
	ld a, [wContestMon]
	and a
	jr z, .skip_level
	hlcoord 1, 3
	ld de, .Level
	call PlaceString
	ld a, [wContestMonLevel]
	ld h, b
	ld l, c
	inc hl
	ld c, 3
	call Print8BitNumRightAlign

.skip_level
	pop af
	ld [Options1], a
	ret

.Caught: ; 24c4b
	db "Caught@"
.Balls: ; 24c52
	db "Balls:@"
.None: ; 24c59
	db "None@"
.Level: ; 24c5e
	db "Level@"

PadCoords_de: ; 27092
	ld a, d
	add 4
	ld d, a
	ld a, e
	add 4
	ld e, a
	jp GetBlockLocation

LevelUpHappinessMod: ; 2709e
	ld a, [CurPartyMon]
	ld hl, PartyMon1CaughtLocation
	call GetPartyLocation
	ld a, [hl]
	and $7f
	ld d, a
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
	ld c, a
	call GetWorldMapLocation
	cp d
	ld c, HAPPINESS_GAINLEVEL
	jr nz, .ok
	ld c, HAPPINESS_GAINLEVELATHOME

.ok
	farjp ChangeHappiness

_ReturnToBattle_UseBall: ; 2715c
	call ClearBGPalettes
	call ClearTileMap
	ld a, [BattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .gettutorialbackpic
	farcall GetMonBackpic
	jr .continue

.gettutorialbackpic
	farcall GetTrainerBackpic
.continue
	farcall GetMonFrontpic
	farcall _LoadBattleFontsHPBar
	call GetMemCGBLayout
	call CloseWindow
	call LoadStandardMenuDataHeader
	call WaitBGMap
	call SetPalettes
	farcall LoadPlayerStatusIcon
	farcall LoadEnemyStatusIcon
	farjp InstantReloadPaletteHack

INCLUDE "data/moves/effects_pointers.asm"

INCLUDE "data/moves/effects.asm"


SECTION "Code 8", ROMX

INCLUDE "engine/link.asm"


SECTION "Code 9", ROMX

INCLUDE "data/battle/music.asm"
INCLUDE "engine/battle/trainer_huds.asm"
INCLUDE "engine/battle/ai/redundant.asm"
INCLUDE "engine/events/move_deleter.asm"
INCLUDE "engine/tmhm2.asm"
INCLUDE "engine/events/pokerus.asm"
INCLUDE "data/trainers/class_names.asm"
INCLUDE "data/moves/descriptions.asm"

ShowLinkBattleParticipants: ; 2ee18
; If we're not in a communications room,
; we don't need to be here.
	ld a, [wLinkMode]
	and a
	ret z

	farcall _ShowLinkBattleParticipants
	ld c, 150
	call DelayFrames
	call ClearTileMap
	jp ClearSprites

FindFirstAliveMonAndStartBattle: ; 2ee2f
	xor a
	ld [hMapAnims], a
	call DelayFrame
	ld b, 6
	ld hl, PartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH - 1

.loop
	ld a, [hli]
	or [hl]
	jr nz, .okay
	add hl, de
	dec b
	jr nz, .loop

.okay
	ld de, MON_LEVEL - MON_HP
	add hl, de
	ld a, [hl]
	ld [BattleMonLevel], a
	predef Predef_StartBattle
	farcall _LoadBattleFontsHPBar
	ld a, 1
	ld [hBGMapMode], a
	call ClearSprites
	call ClearTileMap
	xor a
	ld [hBGMapMode], a
	ld [hWY], a
	ld [rWY], a
	ld [hMapAnims], a
	ret

ClearBattleRAM: ; 2ef18
	xor a
	ld [wPlayerAction], a
	ld [wBattleResult], a

	ld hl, wPartyMenuCursor
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld [wMenuScrollPosition], a
	ld [CriticalHit], a
	ld [BattleMonSpecies], a
	ld [wBattleParticipantsNotFainted], a
	ld [CurBattleMon], a
	ld [wForcedSwitch], a
	ld [TimeOfDayPal], a
	ld [PlayerTurnsTaken], a
	ld [EnemyTurnsTaken], a
	ld [EvolvableFlags], a

	ld hl, PlayerHPPal
	ld [hli], a
	ld [hl], a

	ld hl, BattleMonDVs
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld hl, BattleMonPersonality
	ld [hli], a
	ld [hl], a

	ld hl, EnemyMonDVs
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld hl, EnemyMonPersonality
	ld [hli], a
	ld [hl], a

	; Clear the entire BattleMons area
	ld hl, wBattle
	ld bc, wBattleEnd - wBattle
	xor a
	call ByteFill

	; Clear UsedItems
	ld hl, PartyUsedItems
	ld bc, 6
	xor a
	call ByteFill
	ld hl, OTPartyUsedItems
	ld bc, 6
	xor a
	call ByteFill

	farcall ResetEnemyStatLevels

	call ClearWindowData

	ld hl, hBGMapAddress
	xor a
	ld [hli], a
	ld [hl], VBGMap0 / $100
	ret

PlaceGraphic: ; 2ef6e
; Fill wBoxAlignment-aligned box width b height c
; with iterating tile starting from hGraphicStartTile at hl.
; Predef $13

	ld de, SCREEN_WIDTH

	ld a, [wBoxAlignment]
	and a
	jr nz, .right

	ld a, [hGraphicStartTile]
.x1
	push bc
	push hl

.y1
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .y1

	pop hl
	inc hl
	pop bc
	dec b
	jr nz, .x1
	ret

.right
; Right-aligned.
	push bc
	ld b, 0
	dec c
	add hl, bc
	pop bc

	ld a, [hGraphicStartTile]
.x2
	push bc
	push hl

.y2
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .y2

	pop hl
	dec hl
	pop bc
	dec b
	jr nz, .x2
	ret


SECTION "Code 10", ROMX

INCLUDE "engine/mail.asm"
INCLUDE "engine/events/fruit_trees.asm"
INCLUDE "engine/events/hidden_grottoes.asm"
INCLUDE "engine/battle/ai/move.asm"

AnimateDexSearchSlowpoke: ; 441cf
	ld hl, .FrameIDs
	ld b, 25
.loop
	ld a, [hli]

	; Wrap around
	cp $fe
	jr nz, .ok
	ld hl, .FrameIDs
	ld a, [hli]
.ok

	ld [wDexSearchSlowpokeFrame], a
	ld a, [hli]
	ld c, a
	push bc
	push hl
	call DoDexSearchSlowpokeFrame
	pop hl
	pop bc
	call DelayFrames
	dec b
	jr nz, .loop
	xor a
	ld [wDexSearchSlowpokeFrame], a
	call DoDexSearchSlowpokeFrame
	ld c, 32
	jp DelayFrames

.FrameIDs: ; 441fc
	; frame ID, duration
	db 0, 7
	db 1, 7
	db 2, 7
	db 3, 7
	db 4, 7
	db -2

DoDexSearchSlowpokeFrame: ; 44207
	ld a, [wDexSearchSlowpokeFrame]
	ld hl, .SpriteData
	ld de, Sprites
.loop
	ld a, [hli]
	cp -1
	ret z
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [wDexSearchSlowpokeFrame]
	ld b, a
	add a
	add b
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	jr .loop

.SpriteData: ; 44228
	dsprite 11, 0,  9, 0, $00, $0
	dsprite 11, 0, 10, 0, $01, $0
	dsprite 11, 0, 11, 0, $02, $0
	dsprite 12, 0,  9, 0, $10, $0
	dsprite 12, 0, 10, 0, $11, $0
	dsprite 12, 0, 11, 0, $12, $0
	dsprite 13, 0,  9, 0, $20, $0
	dsprite 13, 0, 10, 0, $21, $0
	dsprite 13, 0, 11, 0, $22, $0
	db -1

DisplayDexEntry: ; 4424d
	call GetPokemonName
	hlcoord 9, 3
	call PlaceString ; mon species
	ld a, [wd265]
	ld b, a
	call GetDexEntryPointer
	ld a, b
	push af
	hlcoord 9, 5
	call FarString ; dex species
	ld h, b
	ld l, c
	push de
; Print dex number
	hlcoord 2, 8
	ld a, "№"
	ld [hli], a
	ld a, "."
	ld [hli], a
	ld de, wd265
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
; Check to see if we caught it.  Get out of here if we haven't.
	ld a, [wd265]
	dec a
	call CheckCaughtMon
	pop hl
	pop bc
	ret z
; Get the height of the Pokemon.
	ld a, [CurPartySpecies]
	ld [CurSpecies], a
	inc hl
	ld a, b
	push af
	push hl
	call GetFarHalfword
	ld d, l
	ld e, h
	pop hl
	inc hl
	inc hl
	ld a, d
	or e
	jr z, .skip_height
	ld a, [Options2]
	bit POKEDEX_UNITS, a
	jr z, .imperial_height

	push hl
	ld l, d
	ld h, e
	ld bc, -100
	ld e, 0
.inchloop
	ld a, h
	and a
	jr nz, .inchloop2
	ld a, l
	cp 100
	jr c, .inchdone
.inchloop2
	add hl, bc
	inc e
	jr .inchloop
.inchdone
	ld a, e
	ld e, l
	ld d, 0
	ld hl, 0
	ld bc, 12
	call AddNTimes
	add hl, de
	ld b, h
	ld c, l
	ld de, 16646 ; 0.254 << 16
	call Mul16
	ld de, hTmpd
	hlcoord 11, 7
	lb bc, 2, PRINTNUM_RIGHTALIGN | 5
	call PrintNum
	pop hl
	jr .skip_height

.imperial_height
	push hl
	push de
	ld hl, sp+$0
	ld d, h
	ld e, l
	hlcoord 12, 7
	lb bc, 2, PRINTNUM_MONEY | 4
	call PrintNum
	hlcoord 14, 7
	ld [hl], "′"
	pop af
	pop hl

.skip_height
	pop af
	push af
	inc hl
	push hl
	dec hl
	call GetFarHalfword
	ld d, l
	ld e, h
	ld a, e
	or d
	jr z, .skip_weight
	ld a, [Options2]
	bit POKEDEX_UNITS, a
	jr z, .imperial_weight

	ld c, d
	ld b, e
	ld de, 29726 ; 0.45359237 << 16
	call Mul16
	ld de, hTmpd
	hlcoord 11, 9
	lb bc, 2, PRINTNUM_RIGHTALIGN | 5
	call PrintNum
	jr .skip_weight

.imperial_weight
	push de
	ld hl, sp+$0
	ld d, h
	ld e, l
	hlcoord 11, 9
	lb bc, 2, PRINTNUM_RIGHTALIGN | 5
	call PrintNum
	pop de

.skip_weight
; Page 1
	lb bc, 5, SCREEN_WIDTH - 2
	hlcoord 2, 11
	call ClearBox
	hlcoord 1, 10
	ld bc, SCREEN_WIDTH - 1
	ld a, $5f ; horizontal divider
	call ByteFill
	; page number
	hlcoord 1, 9
	ld [hl], $55
	inc hl
	ld [hl], $55
	hlcoord 1, 10
	ld [hl], $56 ; P.
	inc hl
	ld [hl], $57 ; 1
	pop de
	inc de
	pop af
	hlcoord 2, 11
	push af
	call FarString
	pop bc
	ld a, [wPokedexStatus]
	or a
	ret z

; Page 2
	push bc
	push de
	lb bc, 5, SCREEN_WIDTH - 2
	hlcoord 2, 11
	call ClearBox
	hlcoord 1, 10
	ld bc, SCREEN_WIDTH - 1
	ld a, $5f ; horizontal divider
	call ByteFill
	; page number
	hlcoord 1, 9
	ld [hl], $55
	inc hl
	ld [hl], $55
	hlcoord 1, 10
	ld [hl], $56 ; P.
	inc hl
	ld [hl], $58 ; 2
	pop de
	inc de
	pop af
	hlcoord 2, 11
	jp FarString

; Metric conversion code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/main.asm
Mul16:
	;[hTmpd][hTmpe]hl = bc * de
	xor a
	ld [hTmpd], a
	ld [hTmpe], a
	ld hl, 0
	ld a, 16
	ld [hProduct], a
.loop
	sla l
	rl h
	ld a, [hTmpe]
	rla
	ld [hTmpe], a
	ld a, [hTmpd]
	rla
	ld [hTmpd], a
	sla e
	rl d
	jr nc, .noadd
	add hl, bc
	ld a, [hTmpe]
	adc 0
	ld [hTmpe], a
	ld a, [hTmpd]
	adc 0
	ld [hTmpd], a
.noadd
	ld a, [hProduct]
	dec a
	ld [hProduct], a
	jr nz, .loop
	ret

GetDexEntryPointer: ; 44333
; return dex entry pointer b:de
	push hl
	ld hl, PokedexDataPointerTable
	ld a, b
	dec a
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	push de
	rlca
	rlca
	and $3
	ld hl, .PokedexEntryBanks
	ld d, 0
	ld e, a
	add hl, de
	ld b, [hl]
	pop de
	pop hl
	ret

.PokedexEntryBanks: ; 44351

GLOBAL PokedexEntries1
GLOBAL PokedexEntries2
GLOBAL PokedexEntries3
GLOBAL PokedexEntries4

	db BANK(PokedexEntries1)
	db BANK(PokedexEntries2)
	db BANK(PokedexEntries3)
	db BANK(PokedexEntries4)

	call GetDexEntryPointer ; b:de
	push hl
	ld h, d
	ld l, e
; skip species name
.loop1
	ld a, b
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .loop1
; skip height and weight
rept 4
	inc hl
endr
; if c != 1: skip entry
	dec c
	jr z, .done
; skip entry
.loop2
	ld a, b
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .loop2

.done
	ld d, h
	ld e, l
	pop hl
	ret

PokedexDataPointerTable: ; 0x44378
INCLUDE "data/pokemon/dex_entry_pointers.asm"


SECTION "Code 11", ROMX

INCLUDE "engine/main_menu.asm"
INCLUDE "engine/search.asm"
INCLUDE "engine/events/celebi.asm"
INCLUDE "engine/tileset_palettes.asm"

Special_MoveTutor: ; 4925b
	call FadeToMenu
	call ClearBGPalettes
	call ClearScreen
	call DelayFrame
	ld b, CGB_PACKPALS
	call GetCGBLayout
	xor a
	ld [wItemAttributeParamBuffer], a
	ld a, [ScriptVar]
	ld [wd265], a
	ld [wPutativeTMHMMove], a
	call GetMoveName
	call CopyName1
	farcall ChooseMonToLearnTMHM
	jr c, .cancel
	jr .enter_loop

.loop
	farcall ChooseMonToLearnTMHM_NoRefresh
	jr c, .cancel
.enter_loop
	call CheckCanLearnMoveTutorMove
	jr nc, .loop
	xor a
	jr .quit

.cancel
	ld a, -1
.quit
	ld [ScriptVar], a
	jp CloseSubmenu

CheckCanLearnMoveTutorMove: ; 492b9
	ld hl, .MenuDataHeader
	call LoadMenuDataHeader

	predef CanLearnTMHMMove

	push bc
	ld a, [CurPartyMon]
	ld hl, PartyMonNicknames
	call GetNick
	pop bc

	ld a, c
	and a
	jr nz, .can_learn
	push de
	ld de, SFX_WRONG
	call PlaySFX
	pop de
	ld a, BANK(Text_TMHMNotCompatible)
	ld hl, Text_TMHMNotCompatible
	call FarPrintText
	jr .didnt_learn

.can_learn
	farcall KnowsMove
	jr c, .didnt_learn

	predef LearnMove
	ld a, b
	and a
	jr z, .didnt_learn

	ld c, HAPPINESS_LEARNMOVE
	farcall ChangeHappiness
	jr .learned

.didnt_learn
	call ExitMenu
	and a
	ret

.learned
	call ExitMenu
	scf
	ret

.MenuDataHeader: ; 0x4930a
	db $40 ; flags
	db 12, 00 ; start coords
	db 17, 19 ; end coords

AskRememberPassword: ; 4ae12
	call .DoMenu
	ld a, 0 ; not xor a; preserve carry flag
	jr c, .okay
	ld a, $1

.okay
	ld [ScriptVar], a
	ret

.DoMenu: ; 4ae1f
	lb bc, 14, 7
	push bc
	ld hl, YesNoMenuDataHeader
	call CopyMenuDataHeader
	pop bc
	ld a, b
	ld [wMenuBorderLeftCoord], a
	add $5
	ld [wMenuBorderRightCoord], a
	ld a, c
	ld [wMenuBorderTopCoord], a
	add $4
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	call VerticalMenu
	push af
	ld c, 15
	call DelayFrames
	call Buena_ExitMenu
	pop af
	jr c, .refused
	ld a, [wMenuCursorY]
	cp $2
	jr z, .refused
	and a
	ret

.refused
	ld a, $2
	ld [wMenuCursorY], a
	scf
	ret

Buena_ExitMenu: ; 4ae5e
	ld a, [hOAMUpdate]
	push af
	call ExitMenu
	call UpdateSprites
	xor a
	ld [hOAMUpdate], a
	call DelayFrame
	ld a, $1
	ld [hOAMUpdate], a
	call ApplyTilemap
	pop af
	ld [hOAMUpdate], a
	ret

PackGFX:
INCBIN "gfx/pack/pack.w40.2bpp"
PackFGFX: ; 48e9b
INCBIN "gfx/pack/pack_f.w40.2bpp"


SECTION "Code 12", ROMX

EmptyAllSRAMBanks: ; 4cf1f
	xor a
	call .EmptyBank
	ld a, $1
	call .EmptyBank
	ld a, $2
	call .EmptyBank
	ld a, $3
	; fallthrough

.EmptyBank: ; 4cf34
	call GetSRAMBank
	ld hl, SRAM_Begin
	ld bc, SRAM_End - SRAM_Begin
	xor a
	call ByteFill
	jp CloseSRAM

SaveMenu_LoadEDTile: ; 4cf45 (13:4f45)
; The following is a modified version of Function3246.
	ld a, [hBGMapMode]
	push af
	xor a
	ld [hBGMapMode], a
	ld a, [hMapAnims]
	push af
	xor a
	ld [hMapAnims], a
.WaitLY:
	ld a, [rLY]
	cp $60
	jr c, .WaitLY

	di
	ld a, BANK(VBGMap2)
	ld [rVBK], a
	hlcoord 0, 0, AttrMap
	call .LoadEDTile
	xor a ; ld a, BANK(VBGMap0)
	ld [rVBK], a
	hlcoord 0, 0
	call .LoadEDTile
.WaitLY2:
	ld a, [rLY]
	cp $60
	jr c, .WaitLY2
	ei

	pop af
	ld [hMapAnims], a
	pop af
	ld [hBGMapMode], a
	ret

.LoadEDTile: ; 4cf80 (13:4f80)
	ld [hSPBuffer], sp ; $ffd9
	ld sp, hl
	ld a, [hBGMapAddress + 1]
	ld h, a
	ld l, 0
	ld a, SCREEN_HEIGHT
	ld [hTilesPerCycle], a
	lb bc, (1 << 1), (rSTAT % $100)

.loop
rept SCREEN_WIDTH / 2
	pop de
.loop\@
	ld a, [$ff00+c]
	and b
	jr nz, .loop\@
	ld [hl], e
	inc l
	ld [hl], d
	inc l
endr

	ld de, $20 - SCREEN_WIDTH
	add hl, de
	ld a, [hTilesPerCycle]
	dec a
	ld [hTilesPerCycle], a
	jr nz, .loop

	ld a, [hSPBuffer]
	ld l, a
	ld a, [hSPBuffer + 1]
	ld h, a
	ld sp, hl
	ret

CheckSave:: ; 4cffe
	ld a, BANK(sCheckValue1)
	call GetSRAMBank
	ld a, [sCheckValue1]
	ld b, a
	ld a, [sCheckValue2]
	ld c, a
	call CloseSRAM
	ld a, b
	cp SAVE_CHECK_VALUE_1
	jr nz, .ok
	ld a, c
	cp SAVE_CHECK_VALUE_2
	jr nz, .ok
	ld c, $1
	ret

.ok
	ld c, $0
	ret

INCLUDE "data/maps/scenes.asm"

_LoadMapPart:: ; 4d15b
	ld hl, wMisc
	ld a, [wMetatileStandingY]
	and a
	jr z, .top_row
	ld bc, WMISC_WIDTH * 2
	add hl, bc

.top_row
	ld a, [wMetatileStandingX]
	and a
	jr z, .left_column
	inc hl
	inc hl

.left_column
	decoord 0, 0
	ld b, SCREEN_HEIGHT
.loop
	ld c, SCREEN_WIDTH
.loop2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop2
	ld a, l
	add 4
	ld l, a
	jr nc, .carry
	inc h

.carry
	dec b
	jr nz, .loop
	ret

PhoneRing_LoadEDTile: ; 4d188
	ld a, [wSpriteUpdatesEnabled]
	cp $0
	jp z, WaitBGMap

; What follows is a modified version of LoadEDTile.
	ld a, [hBGMapMode]
	push af
	xor a
	ld [hBGMapMode], a
	ld a, [hMapAnims]
	push af
	xor a
	ld [hMapAnims], a
.wait
	ld a, [rLY]
	cp $8f
	jr c, .wait

	di
	ld a, BANK(VBGMap2)
	ld [rVBK], a
	hlcoord 0, 0, AttrMap
	call .StackPointerMagic
	xor a ; ld a, BANK(VBGMap0)
	ld [rVBK], a
	hlcoord 0, 0
	call .StackPointerMagic
.wait2
	ld a, [rLY]
	cp $8f
	jr c, .wait2
	ei

	pop af
	ld [hMapAnims], a
	pop af
	ld [hBGMapMode], a
	ret

.StackPointerMagic: ; 4d1cb
; Copy all tiles to VBGMap
	ld [hSPBuffer], sp
	ld sp, hl
	ld a, [hBGMapAddress + 1]
	ld h, a
	ld l, 0
	ld a, SCREEN_HEIGHT
	ld [hTilesPerCycle], a
	lb bc, (1 << 1), (rSTAT % $100) ; b: not in v/hblank

.loop
rept SCREEN_WIDTH / 2
	pop de
; if in v/hblank, wait until not in v/hblank
.loop\@
	ld a, [$ff00+c]
	and b
	jr nz, .loop\@
; load BGMap0
	ld [hl], e
	inc l
	ld [hl], d
	inc l
endr

	ld de, $20 - SCREEN_WIDTH
	add hl, de
	ld a, [hTilesPerCycle]
	dec a
	ld [hTilesPerCycle], a
	jr nz, .loop

	ld a, [hSPBuffer]
	ld l, a
	ld a, [hSPBuffer + 1]
	ld h, a
	ld sp, hl
	ret

Shrink1Pic: ; 4d249
INCBIN "gfx/new_game/shrink1.2bpp.lz"

Shrink2Pic: ; 4d2d9
INCBIN "gfx/new_game/shrink2.2bpp.lz"

_ResetClock: ; 4d3b1
	farcall BlankScreen
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .text_askreset
	call PrintText
	ld hl, .NoYes_MenuDataHeader
	call CopyMenuDataHeader
	call VerticalMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	ret z
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	ld a, $80
	ld [sRTCStatusFlags], a
	call CloseSRAM
	ld hl, .text_okay
	jp PrintText

.text_okay ; 0x4d3fe
	; Select CONTINUE & reset settings.
	text_jump UnknownText_0x1c55db
	db "@"

.text_askreset ; 0x4d408
	; Reset the clock?
	text_jump UnknownText_0x1c561c
	db "@"

.NoYes_MenuDataHeader: ; 0x4d40d
	db $00 ; flags
	db 07, 14 ; start coords
	db 11, 19 ; end coords
	dw .NoYes_MenuData2
	db 1 ; default option

.NoYes_MenuData2: ; 0x4d415
	db $c0 ; flags
	db 2 ; items
	db "No@"
	db "Yes@"

_DeleteSaveData: ; 4d54c
	farcall BlankScreen
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .Text_ClearAllSaveData
	call PrintText
	ld hl, TitleScreenNoYesMenuDataHeader
	call CopyMenuDataHeader
	call VerticalMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	ret z
	farjp EmptyAllSRAMBanks

.Text_ClearAllSaveData: ; 0x4d580
	; Clear all save data?
	text_jump UnknownText_0x1c564a
	db "@"

_ResetInitialOptions:
	farcall BlankScreen
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .Text_ResetInitialOptions
	call PrintText
	ld hl, TitleScreenNoYesMenuDataHeader
	call CopyMenuDataHeader
	call VerticalMenu
	ret c
	ld a, [wMenuCursorY]
	cp $1
	ret z
	ld a, [InitialOptions]
	set RESET_INIT_OPTS, a
	ld [InitialOptions], a
	ld a, BANK(sOptions)
	call GetSRAMBank
	ld a, [InitialOptions]
	ld [sOptions + 6], a ; sInitialOptions
	jp CloseSRAM

.Text_ResetInitialOptions: ; 0x4d580
	; Reset the initial game options?
	text_jump ResetInitialOptionsText
	db "@"

TitleScreenNoYesMenuDataHeader: ; 0x4d585
	db $00 ; flags
	db 07, 14 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2: ; 0x4d58d
	db $c0 ; flags
	db 2 ; items
	db "No@"
	db "Yes@"

INCLUDE "data/tilesets.asm"

FlagPredef: ; 4d7c1
; Perform action b on flag c in flag array hl.
; If checking a flag, check flag array d:hl unless d is 0.

; For longer flag arrays, see FlagAction.

	push hl
	push bc

; Divide by 8 to get the byte we want.
	push bc
	srl c
	srl c
	srl c
	ld b, 0
	add hl, bc
	pop bc

; Which bit we want from the byte
	ld a, c
	and 7
	ld c, a

; Shift left until we can mask the bit
	ld a, 1
	jr z, .shifted
.shift
	add a
	dec c
	jr nz, .shift
.shifted
	ld c, a

; What are we doing to this flag?
	dec b
	jr z, .set ; 1
	dec b
	jr z, .check ; 2

.reset
	ld a, c
	cpl
	and [hl]
	ld [hl], a
	jr .done

.set
	ld a, [hl]
	or c
	ld [hl], a
	jr .done

.check
	ld a, d
	cp 0
	jr nz, .farcheck

	ld a, [hl]
	and c
	jr .done

.farcheck
	call GetFarByte
	and c

.done
	pop bc
	pop hl
	ld c, a
	ret

GetTrademonFrontpic: ; 4d7fd
	ld a, [wOTTrademonSpecies]
	ld hl, wOTTrademonForm
	ld de, VTiles2
	push de
	push af
	predef GetVariant
	pop af
	ld [CurPartySpecies], a
	ld [CurSpecies], a
	call GetBaseData
	pop de
	predef FrontpicPredef
	ret

AnimateTrademonFrontpic: ; 4d81e
	ld a, [wOTTrademonSpecies]
	call IsAPokemon
	ret c
	farcall ShowOTTrademonStats
	ld a, [wOTTrademonSpecies]
	ld [CurPartySpecies], a
	ld a, [wOTTrademonPersonality]
	ld [TempMonPersonality], a
	ld a, [wOTTrademonPersonality + 1]
	ld [TempMonPersonality + 1], a
	ld b, CGB_PLAYER_OR_MON_FRONTPIC_PALS
	call GetCGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	farcall TradeAnim_ShowGetmonFrontpic
	ld a, [wOTTrademonSpecies]
	ld [CurPartySpecies], a
	hlcoord 7, 2
	lb de, $0, ANIM_MON_TRADE
	predef AnimateFrontpic
	ret

CheckPokerus: ; 4d860
; Return carry if a monster in your party has Pokerus

; Get number of monsters to iterate over
	ld a, [PartyCount]
	and a
	jr z, .NoPokerus
	ld b, a
; Check each monster in the party for Pokerus
	ld hl, PartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH
.Check:
	ld a, [hl]
	and $0f ; only the bottom nybble is used
	jr nz, .HasPokerus
; Next PartyMon
	add hl, de
	dec b
	jr nz, .Check
.NoPokerus:
	and a
	ret
.HasPokerus:
	scf
	ret

Special_CheckForLuckyNumberWinners: ; 4d87a
	xor a
	ld [ScriptVar], a
	ld [wFoundMatchingIDInParty], a
	ld a, [PartyCount]
	and a
	ret z
	ld d, a
	ld hl, PartyMon1ID
	ld bc, PartySpecies
.PartyLoop:
	ld a, [bc]
	inc bc
	cp EGG
	call nz, .CompareLuckyNumberToMonID
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec d
	jr nz, .PartyLoop
	ld a, BANK(sBox)
	call GetSRAMBank
	ld a, [sBoxCount]
	and a
	jr z, .SkipOpenBox
	ld d, a
	ld hl, sBoxMon1ID
	ld bc, sBoxSpecies
.OpenBoxLoop:
	ld a, [bc]
	inc bc
	cp EGG
	jr z, .SkipOpenBoxMon
	call .CompareLuckyNumberToMonID
	jr nc, .SkipOpenBoxMon
	ld a, 1
	ld [wFoundMatchingIDInParty], a

.SkipOpenBoxMon:
	push bc
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec d
	jr nz, .OpenBoxLoop

.SkipOpenBox:
	call CloseSRAM
	ld c, $0
.BoxesLoop:
	ld a, [wCurBox]
	and $f
	cp c
	jr z, .SkipBox
	ld hl, .BoxBankAddresses
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	call GetSRAMBank
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl now contains the address of the loaded box in SRAM
	ld a, [hl]
	and a
	jr z, .SkipBox ; no mons in this box
	push bc
	ld b, h
	ld c, l
	inc bc
	ld de, sBoxMon1ID - sBox
	add hl, de
	ld d, a
.BoxNLoop:
	ld a, [bc]
	inc bc
	cp EGG
	jr z, .SkipBoxMon

	call .CompareLuckyNumberToMonID ; sets ScriptVar and CurPartySpecies appropriately
	jr nc, .SkipBoxMon
	ld a, 1
	ld [wFoundMatchingIDInParty], a

.SkipBoxMon:
	push bc
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec d
	jr nz, .BoxNLoop
	pop bc

.SkipBox:
	inc c
	ld a, c
	cp NUM_BOXES
	jr c, .BoxesLoop

	call CloseSRAM
	ld a, [ScriptVar]
	and a
	ret z ; found nothing
	ld a, [wFoundMatchingIDInParty]
	and a
	push af
	ld a, [CurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, .FoundPartymonText
	pop af
	jr z, .print
	ld hl, .FoundBoxmonText

.print
	jp PrintText

.CompareLuckyNumberToMonID: ; 4d939
	push bc
	push de
	push hl
	ld d, h
	ld e, l
	ld hl, Buffer1
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld hl, LuckyNumberDigitsBuffer
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	lb bc, 5, 0
	ld hl, LuckyNumberDigitsBuffer + 4
	ld de, Buffer1 + 4
.loop
	ld a, [de]
	cp [hl]
	jr nz, .done
	dec de
	dec hl
	inc c
	dec b
	jr nz, .loop

.done
	pop hl
	push hl
	ld de, -6
	add hl, de
	ld a, [hl]
	pop hl
	pop de
	push af
	ld a, c
	ld b, 1
	cp 5
	jr z, .okay
	ld b, 2
	cp 4
	jr z, .okay
	ld b, 3
	cp 3
	jr nc, .okay
	ld b, 4
	cp 2
	jr nz, .nomatch

.okay
	inc b
	ld a, [ScriptVar]
	and a
	jr z, .bettermatch
	cp b
	jr c, .nomatch

.bettermatch
	dec b
	ld a, b
	ld [ScriptVar], a
	pop bc
	ld a, b
	ld [CurPartySpecies], a
	pop bc
	scf
	ret

.nomatch
	pop bc
	pop bc
	and a
	ret

.BoxBankAddresses: ; 4d99f
	dba sBox1
	dba sBox2
	dba sBox3
	dba sBox4
	dba sBox5
	dba sBox6
	dba sBox7
	dba sBox8
	dba sBox9
	dba sBox10
	dba sBox11
	dba sBox12
	dba sBox13
	dba sBox14

.FoundPartymonText: ; 0x4d9c9
	; Congratulations! We have a match with the ID number of @  in your party.
	text_jump UnknownText_0x1c1261
	db "@"

.FoundBoxmonText: ; 0x4d9ce
	; Congratulations! We have a match with the ID number of @  in your PC BOX.
	text_jump UnknownText_0x1c12ae
	db "@"

Special_PrintTodaysLuckyNumber: ; 4d9d3
	ld hl, StringBuffer3
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld a, "@"
	ld [StringBuffer3 + 5], a
	ret

CheckPartyFullAfterContest: ; 4d9e5
	ld a, [wContestMon]
	and a
	jp z, .DidntCatchAnything
	ld [CurPartySpecies], a
	ld [CurSpecies], a
	call GetBaseData
	ld hl, PartyCount
	ld a, [hl]
	cp 6
	jp nc, .TryAddToBox
	inc a
	ld [hl], a
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [wContestMon]
	ld [hli], a
	ld [CurSpecies], a
	ld a, $ff
	ld [hl], a
	ld hl, PartyMon1Species
	ld a, [PartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wContestMon
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [PartyCount]
	dec a
	ld hl, PartyMonOT
	call SkipNames
	ld d, h
	ld e, l
	ld hl, PlayerName
	call CopyBytes
	ld a, [CurPartySpecies]
	ld [wd265], a
	call GetPokemonName
	ld hl, StringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes
	call GiveANickname_YesNo
	jr c, .Party_SkipNickname
	ld a, [PartyCount]
	dec a
	ld [CurPartyMon], a
	xor a
	ld [MonType], a
	ld de, wMonOrItemNameBuffer
	farcall InitNickname

.Party_SkipNickname:
	ld a, [PartyCount]
	dec a
	ld hl, PartyMonNicknames
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wMonOrItemNameBuffer
	call CopyBytes
	ld a, [PartyCount]
	dec a
	ld hl, PartyMon1Level
	call GetPartyLocation
	ld a, [hl]
	ld [CurPartyLevel], a
	ld a, PARK_BALL
	ld [CurItem], a
	call SetCaughtData
	ld a, [PartyCount]
	dec a
	ld hl, PartyMon1CaughtLocation
	call GetPartyLocation
	ld a, NATIONAL_PARK
	ld [hl], a
	xor a
	ld [wContestMon], a
	and a
	ld [ScriptVar], a
	ret

.TryAddToBox: ; 4daa3
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld hl, sBoxCount
	ld a, [hl]
	cp MONS_PER_BOX
	call CloseSRAM
	jr nc, .BoxFull
	xor a
	ld [CurPartyMon], a
	ld hl, wContestMon
	ld de, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	ld hl, PlayerName
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH
	call CopyBytes
	farcall InsertPokemonIntoBox
	ld a, [CurPartySpecies]
	ld [wd265], a
	call GetPokemonName
	call GiveANickname_YesNo
	ld hl, StringBuffer1
	jr c, .Box_SkipNickname
	ld a, BOXMON
	ld [MonType], a
	ld de, wMonOrItemNameBuffer
	farcall InitNickname
	ld hl, wMonOrItemNameBuffer

.Box_SkipNickname:
	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank
	ld de, sBoxMonNicknames
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes
	call CloseSRAM

.BoxFull:
	ld a, BANK(sBoxMon1Level)
	call GetSRAMBank
	ld a, [sBoxMon1Level]
	ld [CurPartyLevel], a
	call CloseSRAM
	call SetBoxMonCaughtData
	ld a, BANK(sBoxMon1CaughtLocation)
	call GetSRAMBank
	ld hl, sBoxMon1CaughtLocation
	ld a, [hl]
	and $80
	ld b, $13
	or b
	ld [hl], a
	call CloseSRAM
	xor a
	ld [wContestMon], a
	ld a, $1
	ld [ScriptVar], a
	ret

.DidntCatchAnything: ; 4db35
	ld a, $2
	ld [ScriptVar], a
	ret

GiveANickname_YesNo: ; 4db3b
	ld a, [InitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .AlwaysNickname
	ld hl, TextJump_GiveANickname
	call PrintText
	jp YesNoBox

.AlwaysNickname:
	ld a, 1
	and a
	ret

TextJump_GiveANickname: ; 0x4db44
	; Give a nickname to the @  you received?
	text_jump UnknownText_0x1c12fc
	db "@"

SetCaughtData: ; 4db49
	ld a, [PartyCount]
	dec a
	ld hl, PartyMon1CaughtData
	call GetPartyLocation
SetBoxmonOrEggmonCaughtData: ; 4db53
	; CaughtGender
	ld a, [PlayerGender]
	and a
	jr z, .male
	ld a, FEMALE
	jr .ok
.male
	ld a, MALE
.ok
	ld b, a
	; CaughtTime
	ld a, [TimeOfDay]
	inc a
	rrca
	rrca
	rrca
	or b
	ld b, a
	; CaughtBall
	ld a, [CurItem]
	and CAUGHTBALL_MASK
	or b
	ld [hli], a
	; CaughtLevel
	ld a, [CurPartyLevel]
	ld [hli], a
	; CaughtLocation
	call GetCurrentLandmark
	ld [hl], a
	ret

SetBoxMonCaughtData: ; 4db83
	ld a, BANK(sBoxMon1CaughtData)
	call GetSRAMBank
	ld hl, sBoxMon1CaughtData
	call SetBoxmonOrEggmonCaughtData
	jp CloseSRAM

SetGiftBoxMonCaughtData: ; 4db92
	push bc
	ld a, BANK(sBoxMon1CaughtData)
	call GetSRAMBank
	ld hl, sBoxMon1CaughtData
	pop bc
	call SetGiftMonCaughtData
	jp CloseSRAM

SetGiftPartyMonCaughtData: ; 4dba3
	ld a, [PartyCount]
	dec a
	ld hl, PartyMon1CaughtData
	call GetPartyLocation
SetGiftMonCaughtData: ; 4dbaf
	; CaughtGender
	; b contains it
	; CaughtTime
	ld a, [TimeOfDay]
	inc a
	rrca
	rrca
	rrca
	or b
	ld b, a
	; CaughtBall
	; c contains it
	ld a, c
	and CAUGHTBALL_MASK
	or b
	ld [hli], a
	; CaughtLevel
	; Met in a trade
	xor a
	ld [hli], a
	; CaughtLocation
	; Unknown location
	ld [hl], a
	ret

SetEggMonCaughtData: ; 4dbb8 (13:5bb8)
	ld a, [CurPartyMon]
	ld hl, PartyMon1CaughtData
	call GetPartyLocation
	ld a, [CurPartyLevel]
	push af
	ld a, EGG_LEVEL
	ld [CurPartyLevel], a
	ld a, POKE_BALL
	ld [CurItem], a
	call SetBoxmonOrEggmonCaughtData
	pop af
	ld [CurPartyLevel], a
	ret

_FindGreaterThanThatLevel: ; 4dbd2
	ld hl, PartyMon1Level
	jp FindGreaterThanThatLevel

_FindAtLeastThatHappy: ; 4dbd9
	ld hl, PartyMon1Happiness
	jp FindAtLeastThatHappy

_FindThatSpecies: ; 4dbe0
	ld hl, PartyMon1Species
	jp FindThatSpecies

_FindThatSpeciesYourTrainerID: ; 4dbe6
	ld hl, PartyMon1Species
	call FindThatSpecies
	ret z
	ld a, c
	ld hl, PartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [PlayerID]
	cp [hl]
	jr nz, .nope
	inc hl
	ld a, [PlayerID + 1]
	cp [hl]
	jr nz, .nope
	ld a, $1
	and a
	ret

.nope
	xor a
	ret

FindAtLeastThatHappy: ; 4dc0a
; Sets the bits for the Pokemon that have a happiness greater than or equal to b.
; The lowest bits are used.  Sets z if no Pokemon in your party is at least that happy.
	ld c, $0
	ld a, [PartyCount]
	ld d, a
.loop
	ld a, d
	dec a
	push hl
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop bc
	ld a, b
	cp [hl]
	pop hl
	jr z, .greater_equal
	jr nc, .lower

.greater_equal
	ld a, c
	or $1
	ld c, a

.lower
	sla c
	dec d
	jr nz, .loop
	call RetroactivelyIgnoreEggs
	ld a, c
	and a
	ret

FindGreaterThanThatLevel: ; 4dc31
	ld c, $0
	ld a, [PartyCount]
	ld d, a
.loop
	ld a, d
	dec a
	push hl
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop bc
	ld a, b
	cp [hl]
	pop hl
	jr c, .greater
	ld a, c
	or $1
	ld c, a

.greater
	sla c
	dec d
	jr nz, .loop
	call RetroactivelyIgnoreEggs
	ld a, c
	and a
	ret

FindThatSpecies: ; 4dc56
; Find species b in your party.
; If you have no Pokemon, returns c = -1 and z.
; If that species is in your party, returns its location in c, and nz.
; Otherwise, returns z.
	ld c, -1
	ld hl, PartySpecies
.loop
	ld a, [hli]
	cp -1
	ret z
	inc c
	cp b
	jr nz, .loop
	ld a, $1
	and a
	ret

RetroactivelyIgnoreEggs: ; 4dc67
	ld e, -2
	ld hl, PartySpecies
.loop
	ld a, [hli]
	cp -1
	ret z
	cp EGG
	jr nz, .skip_notegg
	ld a, c
	and e
	ld c, a

.skip_notegg
	rlc e
	jr .loop

INCLUDE "engine/stats_screen.asm"

CatchTutorial:: ; 4e554
	ld a, [BattleType]
	dec a
	ld c, a
	ld hl, .dw
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.dw ; 4e564 (13:6564)
	dw .DudeTutorial
	dw .DudeTutorial
	dw .DudeTutorial

.DudeTutorial: ; 4e56a (13:656a)
; Back up your name
	ld hl, PlayerName
	ld de, BackupName
	ld bc, NAME_LENGTH
	call CopyBytes
; Copy Dude's name to your name
	ld hl, .Dude
	ld de, PlayerName
	ld bc, NAME_LENGTH
	call CopyBytes

	call .LoadDudeData

	xor a
	ld [hJoyDown], a
	ld [hJoyPressed], a

	ld hl, .AutoInput
	ld a, BANK(.AutoInput)
	call StartAutoInput
	farcall StartBattle
	call StopAutoInput

	ld hl, BackupName
	ld de, PlayerName
	ld bc, NAME_LENGTH
	jp CopyBytes

.LoadDudeData: ; 4e5b7 (13:65b7)
	ld hl, wDudeNumItems
	ld [hl], 1
	inc hl
	ld [hl], REPEL
	inc hl
	ld [hl], 1
	inc hl
	ld [hl], -1
	ld hl, wDudeNumMedicine
	ld [hl], 1
	inc hl
	ld [hl], POTION
	inc hl
	ld [hl], 1
	inc hl
	ld [hl], -1
	ld hl, wDudeNumBalls
	ld [hl], 1
	inc hl
	ld [hl], POKE_BALL
	inc hl
	ld [hl], 10
	inc hl
	ld [hl], -1
	ret

.Dude: ; 4e5da
	db "Lyra@"

.AutoInput: ; 4e5df
	db NO_INPUT, $ff ; end

INCLUDE "engine/evolution_animation.asm"

InitDisplayForHallOfFame: ; 4e881
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	call LoadStandardFont
	call LoadFontsBattleExtra
	hlbgcoord 0, 0
	ld bc, VBGMap1 - VBGMap0
	ld a, " "
	call ByteFill
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	xor a
	ld [hSCY], a
	ld [hSCX], a
	call EnableLCD
	ld hl, .SavingRecordDontTurnOff
	call PrintText
	call WaitBGMap2
	jp SetPalettes

.SavingRecordDontTurnOff: ; 0x4e8bd
	; SAVING RECORD… DON'T TURN OFF!
	text_jump UnknownText_0x1bd39e
	db "@"

InitDisplayForLeafCredits: ; 4e8c2
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	call LoadStandardFont
	call LoadFontsBattleExtra
	hlbgcoord 0, 0
	ld bc, VBGMap1 - VBGMap0
	ld a, " "
	call ByteFill
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	ld hl, UnknBGPals
	ld c, 4 tiles
.load_white_palettes
if !DEF(MONOCHROME)
	ld a, (palred 31 + palgreen 31 + palblue 31) % $100
	ld [hli], a
	ld a, (palred 31 + palgreen 31 + palblue 31) / $100
	ld [hli], a
else
	ld a, PAL_MONOCHROME_WHITE % $100
	ld [hli], a
	ld a, PAL_MONOCHROME_WHITE / $100
	ld [hli], a
endc
	dec c
	jr nz, .load_white_palettes
	xor a
	ld [hSCY], a
	ld [hSCX], a
	call EnableLCD
	call WaitBGMap2
	jp SetPalettes

ResetDisplayBetweenHallOfFameMons: ; 4e906
	ld a, [rSVBK]
	push af
	ld a, $6
	ld [rSVBK], a
	ld hl, wScratchTileMap
	ld bc, BG_MAP_WIDTH * BG_MAP_HEIGHT
	ld a, " "
	call ByteFill
	hlbgcoord 0, 0
	ld de, wScratchTileMap
	lb bc, $0, $40
	call Request2bpp
	pop af
	ld [rSVBK], a
	ret

INCLUDE "engine/battle/sliding_intro.asm"

CheckBattleEffects: ; 4ea44
; Return carry if battle scene is turned off.
	ld a, [Options1]
	bit BATTLE_EFFECTS, a
	jr z, .off
	and a
	ret
.off
	scf
	ret

INCLUDE "engine/bsod.asm"

INCLUDE "engine/events/stats_judge.asm"

INCLUDE "engine/events/poisonstep.asm"
INCLUDE "engine/events/squirtbottle.asm"
INCLUDE "engine/events/card_key.asm"
INCLUDE "engine/events/basement_key.asm"
INCLUDE "engine/events/sacred_ash.asm"


SECTION "Code 13", ROMX

INCLUDE "engine/party_menu.asm"

CopyPkmnToTempMon: ; 5084a
; gets the BaseData of a Pkmn
; and copys the PkmnStructure to TempMon

	ld a, [CurPartyMon]
	ld e, a
	call GetPkmnSpecies
	ld a, [CurPartySpecies]
	ld [CurSpecies], a
	call GetBaseData

	ld a, [MonType]
	ld hl, PartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	and a
	jr z, .copywholestruct
	ld hl, OTPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	cp OTPARTYMON
	jr z, .copywholestruct
	ld bc, BOXMON_STRUCT_LENGTH
	farjp CopyBoxmonToTempMon

.copywholestruct
	ld a, [CurPartyMon]
	call AddNTimes
	ld de, TempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	jp CopyBytes

CalcwBufferMonStats: ; 5088b
	ld bc, wBufferMon
	jr _TempMonStatsCalculation

CalcTempmonStats: ; 50890
	ld bc, TempMon
_TempMonStatsCalculation: ; 50893
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [CurPartyLevel], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_EVS - 1
	add hl, bc
	push bc
	ld b, TRUE
	predef CalcPkmnStats
	pop bc
	ld hl, MON_HP
	add hl, bc
	ld d, h
	ld e, l
	ld a, [CurPartySpecies]
	cp EGG
	jr nz, .not_egg
	xor a
	ld [de], a
	inc de
	ld [de], a
	jr .zero_status

.not_egg
	push bc
	ld hl, MON_MAXHP
	add hl, bc
	ld bc, 2
	call CopyBytes
	pop bc

.zero_status
	ld hl, MON_STATUS
	add hl, bc
	xor a
	ld [hli], a
	ld [hl], a
	ret

GetPkmnSpecies: ; 508d5
; [MonType] has the type of the Pkmn
; e = Nr. of Pkmn (i.e. [CurPartyMon])

	ld a, [MonType]
	and a ; PARTYMON
	jr z, .partymon
	cp OTPARTYMON
	jr z, .otpartymon
	cp BOXMON
	jr z, .boxmon
	cp BREEDMON
	jr z, .breedmon
	; WILDMON

.partymon
	ld hl, PartySpecies
	jr .done

.otpartymon
	ld hl, OTPartySpecies
	jr .done

.boxmon
	ld a, BANK(sBoxSpecies)
	call GetSRAMBank
	ld hl, sBoxSpecies
	call .done
	jp CloseSRAM

.breedmon
	ld a, [wBreedMon1Species]
	jr .done2

.done
	ld d, 0
	add hl, de
	ld a, [hl]

.done2
	ld [CurPartySpecies], a
	ret

INCLUDE "data/types/names.asm"

PrintNature:
; Print nature b at hl.
	ld a, b
	push hl
	ld hl, NatureNames
	jr _PrintNatureProperty

PrintNatureIndicators:
; Print indicators for nature b at hl.
	ld a, b
	push hl
	ld hl, NatureIndicators
_PrintNatureProperty:
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/natures.asm"

DrawPlayerHP: ; 50b0a
	ld a, $1
	ld [wWhichHPBar], a
	push hl
	push bc
	ld a, [MonType]
	cp BOXMON
	jr z, .at_least_1_hp

	ld a, [TempMonHP]
	ld b, a
	ld a, [TempMonHP + 1]
	ld c, a

; Any HP?
	or b
	jr nz, .at_least_1_hp

	xor a
	ld c, a
	ld e, a
	ld a, 6
	ld d, a
	jp .fainted

.at_least_1_hp
	ld a, [TempMonMaxHP]
	ld d, a
	ld a, [TempMonMaxHP + 1]
	ld e, a
	ld a, [MonType]
	cp BOXMON
	jr nz, .not_boxmon

	ld b, d
	ld c, e

.not_boxmon
	predef ComputeHPBarPixels
	ld a, 6
	ld d, a
	ld c, a

.fainted
	ld a, c
	pop bc
	ld c, a
	pop hl
	push de
	push hl
	push hl
	call DrawBattleHPBar
	pop hl

; Print HP
	ld bc, $15 ; move (1,1)
	add hl, bc
	ld de, TempMonHP
	ld a, [MonType]
	cp BOXMON
	jr nz, .not_boxmon_2
	ld de, TempMonMaxHP
.not_boxmon_2
	lb bc, 2, 3
	call PrintNum

	ld a, "/"
	ld [hli], a

; Print max HP
	ld de, TempMonMaxHP
	lb bc, 2, 3
	call PrintNum
	pop hl
	pop de
	ret

PrintTempMonStats: ; 50b7b
; Print TempMon's stats at hl, with spacing bc.
	push bc
	push hl
	ld de, .StatNames
	call PlaceString
	pop hl
	pop bc

	push bc
	push hl
	push hl
	ld a, [TempMonNature]
	ld b, a
	farcall GetNature
	pop hl
rept 8
	inc hl
endr
	predef PrintNatureIndicators
	pop hl
	pop bc

	add hl, bc
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, TempMonAttack
	lb bc, 2, 3
	call .PrintStat
	ld de, TempMonDefense
	call .PrintStat
	ld de, TempMonSpclAtk
	call .PrintStat
	ld de, TempMonSpclDef
	call .PrintStat
	ld de, TempMonSpeed
	jp PrintNum

.PrintStat: ; 50bab
	push hl
	call PrintNum
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ret

.StatNames: ; 50bb5
	db   "Attack"
	next "Defense"
	next "Spcl.Atk"
	next "Spcl.Def"
	next "Speed"
	next "@"

GetGender: ; 50bdd
; Return the gender of a given monster (CurPartyMon/CurOTMon/CurWildMon).
; When calling this function, a should be set to an appropriate MonType value.

; return values:
; a = 1: f = nc|nz; male
; a = 0: f = nc|z;  female
;        f = c:  genderless

; This is determined by checking the Personality gender value,
; which was already determined by the species' gender ratio.

; Figure out what type of monster struct we're looking at.

; 0: PartyMon
	ld hl, PartyMon1Gender
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [MonType]
	and a
	jr z, .PartyMon

; 1: OTPartyMon
	ld hl, OTPartyMon1Gender
	dec a
	jr z, .PartyMon

; 2: sBoxMon
	ld hl, sBoxMon1Gender
	ld bc, BOXMON_STRUCT_LENGTH
	dec a
	jr z, .sBoxMon

; 3: Other (used for breeding, possibly elsewhere)
	ld hl, TempMonGender
	dec a
	jr z, .Gender

; else: WildMon
	ld hl, EnemyMonGender
	jr .Gender

; Get our place in the party/box.

.PartyMon:
.sBoxMon
	ld a, [CurPartyMon]
	call AddNTimes

.Gender:

; sBoxMon data is read directly from SRAM.
	ld a, [MonType]
	cp BOXMON
	ld a, 1
	call z, GetSRAMBank

; Gender
	ld a, [hl]
	and GENDER_MASK
	ld b, a

; Close SRAM if we were dealing with a sBoxMon.
	ld a, [MonType]
	cp BOXMON
	call z, CloseSRAM

; We need the gender ratio to do anything with this.
	push bc
	ld a, [CurPartySpecies]
	dec a
	ld hl, BASEMON_GENDER
	ld bc, BASEMON_STRUCT_LENGTH
	call AddNTimes
	pop bc

	ld a, BANK(BaseData)
	call GetFarByte
	swap a
	and $f

; Fixed values ignore the Personality gender value.
	cp GENDERLESS
	jr z, .Genderless
	and a ; cp ALL_MALE
	jr z, .Male
	cp ALL_FEMALE
	jr z, .Female

; Otherwise, use the Personality gender value directly.
	ld a, b
	and a ; cp MALE
	jr z, .Male

.Female:
	xor a
	ret

.Male:
	ld a, 1
	and a
	ret

.Genderless:
	scf
	ret

ListMovePP: ; 50c50
	ld a, [wNumMoves]
	inc a
	ld c, a
	ld a, NUM_MOVES
	sub c
	ld b, a
	push hl
	ld a, [Buffer1]
	ld e, a
	ld d, $0
	ld a, "<BOLDP>"
	call .load_loop
	ld a, b
	and a
	jr z, .skip
	ld c, a
	ld a, "-"
	call .load_loop

.skip
	pop hl
	inc hl
	inc hl
	inc hl
	ld d, h
	ld e, l
	ld hl, TempMonMoves
	ld b, 0
.loop
	ld a, [hli]
	and a
	ret z
	push bc
	push hl
	push de
	ld hl, wMenuCursorY
	ld a, [hl]
	push af
	ld [hl], b
	push hl
	farcall GetMaxPPOfMove
	pop hl
	pop af
	ld [hl], a
	pop de
	pop hl
	push hl
	ld bc, TempMonPP - (TempMonMoves + 1)
	add hl, bc
	ld a, [hl]
	and $3f
	ld [StringBuffer1 + 4], a
	ld h, d
	ld l, e
	push hl
	ld de, StringBuffer1 + 4
	lb bc, 1, 2
	call PrintNum
	ld a, "/"
	ld [hli], a
	ld de, wd265
	lb bc, 1, 2
	call PrintNum
	pop hl
	ld a, [Buffer1]
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	pop hl
	pop bc
	inc b
	ld a, b
	cp NUM_MOVES
	jr nz, .loop
	ret

.load_loop ; 50cc9
	ld [hli], a
	ld [hld], a
	add hl, de
	dec c
	jr nz, .load_loop
	ret

GetStatusConditionIndex:
; de points to status, e.g. from a party_struct or battle_struct
; return the status condition index in a
	push de
	inc de
	inc de
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	or b
	pop de
	jr z, .fnt
	ld a, [de]
	ld b, a
	and SLP
	ld a, 0
	jr nz, .slp
	xor a
	bit TOX, b
	jr nz, .tox
	bit PSN, b
	jr nz, .psn
	bit PAR, b
	jr nz, .par
	bit BRN, b
	jr nz, .brn
	bit FRZ, b
	jr nz, .frz
	jr .done
.tox
	inc a
.fnt
	inc a
.frz
	inc a
.brn
	inc a
.slp
	inc a
.par
	inc a
.psn
	inc a
.done
	ret

PlaceStatusString: ; 50d0a
	xor a
	call GetStatusConditionIndex
	and a
	ret z
	push de

	ld d, 0
	ld e, a
	push hl
	ld hl, StatusStringPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	pop hl

	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a

	pop de
	ld a, $1
	and a
	ret

StatusStringPointers:
	dw OKString
	dw PsnString
	dw ParString
	dw SlpString
	dw BrnString
	dw FrzString
	dw FntString

OKString:  db "OK @"
PsnString: db "Psn@"
ParString: db "Par@"
SlpString: db "Slp@"
BrnString: db "Brn@"
FrzString: db "Frz@"
FntString: db "Fnt@"

ListMoves: ; 50d6f
; List moves at hl, spaced every [Buffer1] tiles.
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $0
.moves_loop
	ld a, [de]
	inc de
	and a
	jr z, .no_more_moves
	push de
	push hl
	push hl
	ld [CurSpecies], a
	ld a, MOVE_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, StringBuffer1
	pop hl
	push bc
	call PlaceString
	pop bc
	ld a, b
	ld [wNumMoves], a
	inc b
	pop hl
	push bc
	ld a, [Buffer1]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	pop de
	ld a, b
	cp NUM_MOVES
	ret z
	jr .moves_loop

.no_more_moves
	ld a, b
.nonmove_loop
	push af
	ld [hl], "-"
	ld a, [Buffer1]
	ld c, a
	ld b, 0
	add hl, bc
	pop af
	inc a
	cp NUM_MOVES
	jr nz, .nonmove_loop
	ret

CalcLevel: ; 50e1b
	ld a, [TempMonSpecies]
	ld [CurSpecies], a
	call GetBaseData
	ld d, 1
.next_level
	inc d
	ld a, d
	cp (MAX_LEVEL + 1) % $100
	jr z, .got_level
	call CalcExpAtLevel
	push hl
	ld hl, TempMonExp + 2
	ld a, [hProduct + 3]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [hProduct + 2]
	ld c, a
	ld a, [hld]
	sbc c
	ld a, [hProduct + 1]
	ld c, a
	ld a, [hl]
	sbc c
	pop hl
	jr nc, .next_level

.got_level
	dec d
	ret

CalcExpAtLevel: ; 50e47
; (a/b)*n**3 + c*n**2 + d*n - e
	ld a, d
	cp 1
	jr nz, .UseExpFormula
; Pokémon have 0 experience at level 1
	xor a
	ld [hProduct], a
	ld [hProduct + 1], a
	ld [hProduct + 2], a
	ld [hProduct + 3], a
	ret
.UseExpFormula
	ld a, [BaseGrowthRate]
	add a
	add a
	ld c, a
	ld b, 0
	ld hl, GrowthRates
	add hl, bc
; Cube the level
	call .LevelSquared
	ld a, d
	ld [hMultiplier], a
	call Multiply

; Multiply by a
	ld a, [hl]
	and $f0
	swap a
	ld [hMultiplier], a
	call Multiply
; Divide by b
	ld a, [hli]
	and $f
	ld [hDivisor], a
	ld b, 4
	call Divide
; Push the cubic term to the stack
	ld a, [hQuotient + 0]
	push af
	ld a, [hQuotient + 1]
	push af
	ld a, [hQuotient + 2]
	push af
; Square the level and multiply by the lower 7 bits of c
	call .LevelSquared
	ld a, [hl]
	and $7f
	ld [hMultiplier], a
	call Multiply
; Push the absolute value of the quadratic term to the stack
	ld a, [hProduct + 1]
	push af
	ld a, [hProduct + 2]
	push af
	ld a, [hProduct + 3]
	push af
	ld a, [hli]
	push af
; Multiply the level by d
	xor a
	ld [hMultiplicand + 0], a
	ld [hMultiplicand + 1], a
	ld a, d
	ld [hMultiplicand + 2], a
	ld a, [hli]
	ld [hMultiplier], a
	call Multiply
; Subtract e
	ld b, [hl]
	ld a, [hProduct + 3]
	sub b
	ld [hMultiplicand + 2], a
	ld b, $0
	ld a, [hProduct + 2]
	sbc b
	ld [hMultiplicand + 1], a
	ld a, [hProduct + 1]
	sbc b
	ld [hMultiplicand], a
; If bit 7 of c is set, c is negative; otherwise, it's positive
	pop af
	and $80
	jr nz, .subtract
; Add c*n**2 to (d*n - e)
	pop bc
	ld a, [hProduct + 3]
	add b
	ld [hMultiplicand + 2], a
	pop bc
	ld a, [hProduct + 2]
	adc b
	ld [hMultiplicand + 1], a
	pop bc
	ld a, [hProduct + 1]
	adc b
	ld [hMultiplicand], a
	jr .done_quadratic

.subtract
; Subtract c*n**2 from (d*n - e)
	pop bc
	ld a, [hProduct + 3]
	sub b
	ld [hMultiplicand + 2], a
	pop bc
	ld a, [hProduct + 2]
	sbc b
	ld [hMultiplicand + 1], a
	pop bc
	ld a, [hProduct + 1]
	sbc b
	ld [hMultiplicand], a

.done_quadratic
; Add (a/b)*n**3 to (d*n - e +/- c*n**2)
	pop bc
	ld a, [hProduct + 3]
	add b
	ld [hMultiplicand + 2], a
	pop bc
	ld a, [hProduct + 2]
	adc b
	ld [hMultiplicand + 1], a
	pop bc
	ld a, [hProduct + 1]
	adc b
	ld [hMultiplicand], a
	ret

.LevelSquared: ; 50eed
	xor a
	ld [hMultiplicand + 0], a
	ld [hMultiplicand + 1], a
	ld a, d
	ld [hMultiplicand + 2], a
	ld [hMultiplier], a
	jp Multiply

INCLUDE "data/growth_rates.asm"

_SwitchPartyMons:
	ld a, [wSwitchMon]
	dec a
	ld [Buffer3], a
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [Buffer2], a
	cp b
	ret z
	call .SwapMonAndMail
	ld a, [Buffer3]
	call .ClearSprite
	ld a, [Buffer2]
	; fallthrough

.ClearSprite: ; 50f34 (14:4f34)
	push af
	hlcoord 0, 1
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld bc, 2 * SCREEN_WIDTH
	ld a, " "
	call ByteFill
	pop af
	ld hl, Sprites
	ld bc, $10
	call AddNTimes
	ld de, $4
	ld c, $4
.gfx_loop
	ld [hl], $a0
	add hl, de
	dec c
	jr nz, .gfx_loop
	ld de, SFX_SWITCH_POKEMON
	jp WaitPlaySFX

.SwapMonAndMail: ; 50f62 (14:4f62)
	push hl
	push de
	push bc
	ld bc, PartySpecies
	ld a, [Buffer2]
	ld l, a
	ld h, $0
	add hl, bc
	ld d, h
	ld e, l
	ld a, [Buffer3]
	ld l, a
	ld h, $0
	add hl, bc
	ld a, [hl]
	push af
	ld a, [de]
	ld [hl], a
	pop af
	ld [de], a
	ld a, [Buffer2]
	ld hl, PartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	push hl
	ld de, wd002
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [Buffer3]
	ld hl, PartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop de
	push hl
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	pop de
	ld hl, wd002
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [Buffer2]
	ld hl, PartyMonOT
	call SkipNames
	push hl
	call .CopyNameTowd002
	ld a, [Buffer3]
	ld hl, PartyMonOT
	call SkipNames
	pop de
	push hl
	call .CopyName
	pop de
	ld hl, wd002
	call .CopyName
	ld hl, PartyMonNicknames
	ld a, [Buffer2]
	call SkipNames
	push hl
	call .CopyNameTowd002
	ld hl, PartyMonNicknames
	ld a, [Buffer3]
	call SkipNames
	pop de
	push hl
	call .CopyName
	pop de
	ld hl, wd002
	call .CopyName
	ld hl, sPartyMail
	ld a, [Buffer2]
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	push hl
	ld de, wd002
	ld bc, MAIL_STRUCT_LENGTH
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	call CopyBytes
	ld hl, sPartyMail
	ld a, [Buffer3]
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	pop de
	push hl
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes
	pop de
	ld hl, wd002
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes
	call CloseSRAM
	pop bc
	pop de
	pop hl
	ret

.CopyNameTowd002: ; 51036 (14:5036)
	ld de, wd002

.CopyName: ; 51039 (14:5039)
	ld bc, NAME_LENGTH
	jp CopyBytes

INCLUDE "gfx/load_pics.asm"

InsertPokemonIntoBox: ; 51322
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld hl, sBoxCount
	call InsertSpeciesIntoBoxOrParty
	ld a, [sBoxCount]
	dec a
	ld [wd265], a
	ld hl, sBoxMonNicknames
	ld bc, PKMN_NAME_LENGTH
	ld de, wBufferMonNick
	call InsertDataIntoBoxOrParty
	ld a, [sBoxCount]
	dec a
	ld [wd265], a
	ld hl, sBoxMonOT
	ld bc, NAME_LENGTH
	ld de, wBufferMonOT
	call InsertDataIntoBoxOrParty
	ld a, [sBoxCount]
	dec a
	ld [wd265], a
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	ld de, wBufferMon
	call InsertDataIntoBoxOrParty
	ld hl, wBufferMonMoves
	ld de, TempMonMoves
	ld bc, NUM_MOVES
	call CopyBytes
	ld hl, wBufferMonPP
	ld de, TempMonPP
	ld bc, NUM_MOVES
	call CopyBytes
	ld a, [CurPartyMon]
	ld b, a
	farcall RestorePPofDepositedPokemon
	jp CloseSRAM

InsertPokemonIntoParty: ; 5138b
	ld hl, PartyCount
	call InsertSpeciesIntoBoxOrParty
	ld a, [PartyCount]
	dec a
	ld [wd265], a
	ld hl, PartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	ld de, wBufferMonNick
	call InsertDataIntoBoxOrParty
	ld a, [PartyCount]
	dec a
	ld [wd265], a
	ld hl, PartyMonOT
	ld bc, NAME_LENGTH
	ld de, wBufferMonOT
	call InsertDataIntoBoxOrParty
	ld a, [PartyCount]
	dec a
	ld [wd265], a
	ld hl, PartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, wBufferMon
	jp InsertDataIntoBoxOrParty

InsertSpeciesIntoBoxOrParty: ; 513cb
	inc [hl]
	inc hl
	ld a, [CurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [CurPartySpecies]
	ld c, a
.loop
	ld a, [hl]
	ld [hl], c
	inc hl
	inc c
	ld c, a
	jr nz, .loop
	ret

InsertDataIntoBoxOrParty: ; 513e0
	push de
	push hl
	push bc
	ld a, [wd265]
	dec a
	call AddNTimes
	push hl
	add hl, bc
	ld d, h
	ld e, l
	pop hl
.loop
	push bc
	ld a, [wd265]
	ld b, a
	ld a, [CurPartyMon]
	cp b
	pop bc
	jr z, .insert
	push hl
	push de
	push bc
	call CopyBytes
	pop bc
	pop de
	pop hl
	push hl
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	pop de
	ld a, [wd265]
	dec a
	ld [wd265], a
	jr .loop

.insert
	pop bc
	pop hl
	ld a, [CurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	jp CopyBytes

INCLUDE "data/pokemon/base_stats.asm"
INCLUDE "data/pokemon/names.asm"


SECTION "Code 14", ROMX

INCLUDE "engine/battle/abilities.asm"
INCLUDE "data/trainers/final_text.asm"
INCLUDE "engine/player_movement.asm"
INCLUDE "engine/engine_flags.asm"
INCLUDE "engine/variables.asm"
INCLUDE "data/text/battle.asm"


SECTION "Code 15", ROMX

INCLUDE "gfx/battle_anims.asm"
INCLUDE "engine/events/halloffame.asm"

PrintAbility:
; Print ability b at hl.
	ld l, b
	ld h, 0
	ld bc, AbilityNames
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 3, 13
	jp PlaceString

BufferAbility:
; Buffer name for b into StringBuffer1
	ld l, b
	ld h, 0
	ld bc, AbilityNames
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, StringBuffer1
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp "@"
	ret z
	jr .loop

PrintAbilityDescription:
; Print ability description for b
; we can't use PlaceString, because it would linebreak with an empty line inbetween
	ld l, b
	ld h, 0
	ld bc, AbilityDescriptions
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	decoord 1, 15
	push de
.loop
	ld a, [hli]
	cp "@"
	jr z, .done
	cp $4e
	jr z, .line
	ld [de], a
	inc de
	jr .loop

.line
	pop de
	push hl
	ld hl, $0014
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push de
	jr .loop

.done
	pop de
	ret

INCLUDE "data/abilities.asm"


SECTION "Code 16", ROMX

INCLUDE "engine/player_gfx.asm"
INCLUDE "engine/events/kurt.asm"
INCLUDE "engine/events/unown.asm"
INCLUDE "engine/events/buena.asm"
INCLUDE "engine/events/movesets.asm"
INCLUDE "engine/events/battle_tower/battle_tower.asm"
INCLUDE "engine/events/battle_tower/trainer_text.asm"
INCLUDE "engine/events/item_maniacs.asm"


SECTION "Code 17", ROMX

INCLUDE "engine/timeofdaypals.asm"
INCLUDE "engine/battle_start.asm"
INCLUDE "engine/sprites.asm"
INCLUDE "engine/mon_icons.asm"
INCLUDE "engine/events/field_moves.asm"
INCLUDE "engine/events/magnet_train.asm"
INCLUDE "data/pokemon/menu_icon_pointers.asm"
INCLUDE "data/pokemon/menu_icons.asm"


SECTION "Code 18", ROMX

INCLUDE "engine/phone.asm"
INCLUDE "engine/timeset.asm"
INCLUDE "engine/pokegear.asm"
INCLUDE "engine/events/fish.asm"
INCLUDE "engine/slot_machine.asm"


SECTION "Code 19", ROMX

INCLUDE "engine/events_2.asm"
INCLUDE "engine/radio.asm"
INCLUDE "gfx/mail.asm"


SECTION "Code 20", ROMX

INCLUDE "engine/events/std_scripts.asm"
INCLUDE "engine/phone_scripts.asm"


SECTION "Code 21", ROMX

INCLUDE "engine/battle_anims/bg_effects.asm"
INCLUDE "data/moves/animations.asm"


SECTION "Code 22", ROMX

INCLUDE "engine/card_flip.asm"
INCLUDE "engine/unown_puzzle.asm"
;INCLUDE "engine/dummy_game.asm"
INCLUDE "engine/billspc.asm"


SECTION "Code 23", ROMX

INCLUDE "engine/battle/hidden_power.asm"
INCLUDE "engine/battle/misc.asm"
INCLUDE "engine/unowndex.asm"
INCLUDE "engine/events/magikarp.asm"
INCLUDE "engine/events/name_rater.asm"
INCLUDE "audio/distorted_cries.asm"


SECTION "Code 24", ROMX

INCLUDE "engine/tileset_anims.asm"
INCLUDE "engine/events/npc_trade.asm"
INCLUDE "engine/events/wonder_trade.asm"
INCLUDE "engine/events/mom_phone.asm"


SECTION "Code 25", ROMX

INCLUDE "engine/misc_gfx.asm"
INCLUDE "engine/warp_connection.asm"
INCLUDE "engine/battle/used_move_text.asm"
INCLUDE "gfx/items.asm"


SECTION "Introduction", ROMX

INCLUDE "engine/options_menu.asm"
INCLUDE "engine/crystal_intro.asm"

CopyrightGFX:: ; e4000
INCBIN "gfx/splash/copyright.2bpp"


SECTION "Title Screen", ROMX

INCLUDE "engine/title.asm"


SECTION "Diploma", ROMX

INCLUDE "engine/diploma.asm"


SECTION "Palette Maps", ROMX

INCLUDE "engine/map_palettes.asm"


SECTION "Typefaces", ROMX

INCLUDE "gfx/font.asm"


SECTION "Battle Core", ROMX

INCLUDE "engine/battle/core.asm"


SECTION "Effect Commands", ROMX

INCLUDE "engine/battle/effect_commands.asm"


SECTION "Effect Command Pointers", ROMX

INCLUDE "data/battle/effect_command_pointers.asm"


SECTION "Battle Animations", ROMX

INCLUDE "engine/battle_anims/anim_commands.asm"
INCLUDE "engine/battle_anims/core.asm"
INCLUDE "data/battle_anims/objects.asm"
INCLUDE "engine/battle_anims/functions.asm"
INCLUDE "engine/battle_anims/helpers.asm"
INCLUDE "data/battle_anims/framesets.asm"
INCLUDE "data/battle_anims/oam.asm"
INCLUDE "data/battle_anims/object_gfx.asm"


SECTION "Battle Graphics", ROMX

SubstituteFrontpic: INCBIN "gfx/battle/substitute-front.2bpp.lz"
SubstituteBackpic:  INCBIN "gfx/battle/substitute-back.2bpp.lz"

GhostFrontpic:      INCBIN "gfx/battle/ghost.2bpp.lz"


SECTION "Moves", ROMX

INCLUDE "data/moves/moves.asm"


SECTION "Enemy Trainers", ROMX

INCLUDE "engine/battle/ai/items.asm"

AIScoring: ; 38591
INCLUDE "engine/battle/ai/scoring.asm"

GetTrainerClassName: ; 3952d
	ld a, c
	ld [CurSpecies], a
	ld a, TRAINER_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, StringBuffer1
	ret

GetOTName: ; 39550
	ld hl, OTPlayerName
	ld a, [wLinkMode]
	and a
	jr nz, .ok

	ld a, c
	ld [CurSpecies], a
	ld a, TRAINER_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld hl, StringBuffer1

.ok
	ld bc, TRAINER_CLASS_NAME_LENGTH
	ld de, OTClassName
	push de
	call CopyBytes
	pop de
	ret

GetTrainerAttributes: ; 3957b
	ld a, [TrainerClass]
	ld c, a
	call GetOTName
	ld a, [TrainerClass]
	dec a
	ld hl, TrainerClassAttributes + TRNATTR_ITEM1
	ld bc, NUM_TRAINER_ATTRIBUTES
	call AddNTimes
	ld de, wEnemyTrainerItem1
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	ld [wEnemyTrainerBaseReward], a
	ret

ComputeTrainerReward: ; 3991b (e:591b)
	ld hl, hProduct
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld a, [wEnemyTrainerBaseReward]
	ld [hli], a
	ld a, [CurPartyLevel]
	ld [hl], a
	call Multiply
	ld hl, wBattleReward
	xor a
	ld [hli], a
	ld a, [hProduct + 2]
	ld [hli], a
	ld a, [hProduct + 3]
	ld [hl], a
	ret

INCLUDE "data/trainers/attributes.asm"


SECTION "Enemy Trainer Pointers", ROMX

INCLUDE "engine/read_party.asm"
INCLUDE "data/trainers/party_pointers.asm"
INCLUDE "data/trainers/parties.asm"


SECTION "Wild Data", ROMX

INCLUDE "engine/wildmons.asm"


SECTION "Pokedex", ROMX

INCLUDE "engine/pokedex.asm"


SECTION "Evolution", ROMX

INCLUDE "engine/evolve.asm"


SECTION "Pic Animations", ROMX

INCLUDE "engine/pic_animation.asm"

; Pic animations are assembled in 3 parts:

; Top-level animations:
; 	frame #, duration: Frame 0 is the original pic (no change)
;	setrepeat #:       Sets the number of times to repeat
; 	dorepeat #:        Repeats from command # (starting from 0)
; 	end

; Bitmasks:
;	Layered over the pic to designate affected tiles

; Frame definitions:
;	first byte is the bitmask used for this frame
;	following bytes are tile ids mapped to each bit in the mask

; Main animations (played everywhere)
INCLUDE "gfx/pokemon/anim_pointers.asm"
INCLUDE "gfx/pokemon/anims.asm"

; Extra animations, appended to the main animation
; Used in the status screen (blinking, tail wags etc.)
INCLUDE "gfx/pokemon/extra_pointers.asm"
INCLUDE "gfx/pokemon/extras.asm"

; Variants have their own animation data despite having entries in the main tables
INCLUDE "gfx/pokemon/variant_anim_pointers.asm"
INCLUDE "gfx/pokemon/variant_anims.asm"
INCLUDE "gfx/pokemon/variant_extra_pointers.asm"
INCLUDE "gfx/pokemon/variant_extras.asm"


SECTION "Pic Animations Frames 1", ROMX

INCLUDE "gfx/pokemon/frame_pointers.asm"
INCLUDE "gfx/pokemon/kanto_frames.asm"


SECTION "Pic Animations Frames 2", ROMX

INCLUDE "gfx/pokemon/johto_frames.asm"
INCLUDE "gfx/pokemon/variant_frame_pointers.asm"
INCLUDE "gfx/pokemon/variant_frames.asm"


SECTION "Pic Animations Bitmasks", ROMX

; Bitmasks
INCLUDE "gfx/pokemon/bitmask_pointers.asm"
INCLUDE "gfx/pokemon/bitmasks.asm"
INCLUDE "gfx/pokemon/variant_bitmask_pointers.asm"
INCLUDE "gfx/pokemon/variant_bitmasks.asm"


SECTION "Standard Text", ROMX

INCLUDE "data/text/std_text.asm"


SECTION "Phone Scripts", ROMX

INCLUDE "engine/more_phone_scripts.asm"
INCLUDE "engine/buena_phone_scripts.asm"


SECTION "Phone Text 1", ROMX

INCLUDE "data/phone/text/anthony_overworld.asm"
INCLUDE "data/phone/text/todd_overworld.asm"
INCLUDE "data/phone/text/gina_overworld.asm"
INCLUDE "data/phone/text/irwin_overworld.asm"
INCLUDE "data/phone/text/arnie_overworld.asm"
INCLUDE "data/phone/text/alan_overworld.asm"
INCLUDE "data/phone/text/dana_overworld.asm"
INCLUDE "data/phone/text/chad_overworld.asm"
INCLUDE "data/phone/text/derek_overworld.asm"
INCLUDE "data/phone/text/tully_overworld.asm"
INCLUDE "data/phone/text/brent_overworld.asm"
INCLUDE "data/phone/text/tiffany_overworld.asm"
INCLUDE "data/phone/text/vance_overworld.asm"
INCLUDE "data/phone/text/wilton_overworld.asm"
INCLUDE "data/phone/text/kenji_overworld.asm"
INCLUDE "data/phone/text/parry_overworld.asm"
INCLUDE "data/phone/text/erin_overworld.asm"


SECTION "Phone Text 2", ROMX

INCLUDE "data/phone/text/jack_overworld.asm"
INCLUDE "data/phone/text/beverly_overworld.asm"
INCLUDE "data/phone/text/huey_overworld.asm"
INCLUDE "data/phone/text/gaven_overworld.asm"
INCLUDE "data/phone/text/beth_overworld.asm"
INCLUDE "data/phone/text/jose_overworld.asm"
INCLUDE "data/phone/text/reena_overworld.asm"
INCLUDE "data/phone/text/joey_overworld.asm"
INCLUDE "data/phone/text/wade_overworld.asm"
INCLUDE "data/phone/text/ralph_overworld.asm"


SECTION "Phone Text 3", ROMX

INCLUDE "data/phone/text/mom.asm"
INCLUDE "data/phone/text/bill.asm"
INCLUDE "data/phone/text/elm.asm"
INCLUDE "data/phone/text/trainers1.asm"
INCLUDE "data/phone/text/liz_overworld.asm"


SECTION "Phone Text 4", ROMX

INCLUDE "data/phone/text/extra.asm"
INCLUDE "data/phone/text/lyra.asm"


SECTION "Phone Text 5", ROMX

INCLUDE "data/phone/text/extra2.asm"


SECTION "Item Text", ROMX

INCLUDE "data/items/names.asm"

PrintItemDescription: ; 0x1c8955
; Print the description for item [CurSpecies] at de.

	ld hl, ItemDescriptions
	ld a, [CurSpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	jp PlaceString
; 0x1c8987

PrintTMHMDescription:
; Print the description for TM/HM [CurSpecies] at de.

	ld a, [CurSpecies]
	inc a
	ld [CurTMHM], a
	ld [wCurTMHM], a
	push de
	predef GetTMHMMove
	pop hl
	ld a, [wd265]
	ld [CurSpecies], a
	predef PrintMoveDesc
	ret

INCLUDE "data/items/descriptions.asm"
INCLUDE "data/items/apricorn_names.asm"


SECTION "Move and Landmark Text", ROMX

INCLUDE "data/moves/names.asm"

INCLUDE "engine/landmarks.asm"


SECTION "Battle Tower Text", ROMX

INCLUDE "data/battle_tower/trainer_text.asm"


SECTION "Crystal Data", ROMX

INCLUDE "engine/events/battle_tower/load_trainer.asm"
INCLUDE "data/events/odd_eggs.asm"
