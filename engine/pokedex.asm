	const_def
	const DEXSTATE_MAIN_SCR
	const DEXSTATE_UPDATE_MAIN_SCR
	const DEXSTATE_DEX_ENTRY_SCR
	const DEXSTATE_UPDATE_DEX_ENTRY_SCR
	const DEXSTATE_REINIT_DEX_ENTRY_SCR
	const DEXSTATE_SEARCH_SCR
	const DEXSTATE_UPDATE_SEARCH_SCR
	const DEXSTATE_OPTION_SCR
	const DEXSTATE_UPDATE_OPTION_SCR
	const DEXSTATE_SEARCH_RESULTS_SCR
	const DEXSTATE_UPDATE_SEARCH_RESULTS_SCR
	const DEXSTATE_UNOWN_MODE
	const DEXSTATE_UPDATE_UNOWN_MODE
	const DEXSTATE_EXIT

Pokedex: ; 40000
	ld a, [hWX]
	ld l, a
	ld a, [hWY]
	ld h, a
	push hl
	ld a, [hSCX]
	push af
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ld a, [hInMenu]
	push af
	ld a, $1
	ld [hInMenu], a

	xor a
	ld [hMapAnims], a
	call InitPokedex
	call DelayFrame

.main
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit
	call Pokedex_RunJumptable
	call DelayFrame
	jr .main

.exit
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	call WaitSFX
	call ClearSprites
	ld a, [wCurrentDexMode]
	ld [wLastDexMode], a

	pop af
	ld [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions1], a
	pop af
	ld [hSCX], a
	pop hl
	ld a, l
	ld [hWX], a
	ld a, h
	ld [hWY], a
	ret

InitPokedex: ; 40063
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	call Pokedex_LoadGFX

	ld hl, wPokedexDataStart
	ld bc, wPokedexDataEnd - wPokedexDataStart
	xor a
	call ByteFill

	xor a
	ld [wJumptableIndex], a
	ld [wDexEntryPrevJumptableIndex], a
	ld [wcf65], a
	ld [wcf66], a

	call Pokedex_CheckUnlockedUnownMode

	ld a, [wLastDexMode]
	ld [wCurrentDexMode], a

	call Pokedex_OrderMonsByMode
	call Pokedex_InitCursorPosition
	call GetCurrentLandmark
	ld [wDexCurrentLocation], a
	call Pokedex_DrawDexEntryScreenRightEdge
	jp Pokedex_ResetBGMapMode

Pokedex_CheckUnlockedUnownMode: ; 400a2
	ld a, [wStatusFlags]
	bit 1, a
	jr nz, .unlocked

	xor a
	ld [wUnlockedUnownMode], a
	ret

.unlocked
	ld a, TRUE
	ld [wUnlockedUnownMode], a
	ret

Pokedex_InitCursorPosition: ; 400b4
	ld hl, wPokedexDataStart
	ld a, [wLastDexEntry]
	and a
	ret z
	cp NUM_POKEMON + 1
	ret nc

	ld b, a
	ld a, [wDexListingEnd]
	cp $8
	jr c, .only_one_page

	sub $7
	ld c, a
.loop1
	ld a, b
	cp [hl]
	ret z
	inc hl
	ld a, [wDexListingScrollOffset]
	inc a
	ld [wDexListingScrollOffset], a
	dec c
	jr nz, .loop1

.only_one_page
	ld c, $7
.loop2
	ld a, b
	cp [hl]
	ret z
	inc hl
	ld a, [wDexListingCursor]
	inc a
	ld [wDexListingCursor], a
	dec c
	jr nz, .loop2
	ret

Pokedex_RunJumptable: ; 4010b
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call Pokedex_LoadPointer
	jp hl


.Jumptable: ; 40115 (10:4115)
	dw Pokedex_InitMainScreen
	dw Pokedex_UpdateMainScreen
	dw Pokedex_InitDexEntryScreen
	dw Pokedex_UpdateDexEntryScreen
	dw Pokedex_ReinitDexEntryScreen
	dw Pokedex_InitSearchScreen
	dw Pokedex_UpdateSearchScreen
	dw Pokedex_InitOptionScreen
	dw Pokedex_UpdateOptionScreen
	dw Pokedex_InitSearchResultsScreen
	dw Pokedex_UpdateSearchResultsScreen
	dw Pokedex_InitUnownMode
	dw Pokedex_UpdateUnownMode
	dw Pokedex_Exit


Pokedex_IncrementDexPointer: ; 40131 (10:4131)
	ld hl, wJumptableIndex
	inc [hl]
	ret

Pokedex_Exit: ; 40136 (10:4136)
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Pokedex_InitMainScreen: ; 4013c (10:413c)
	xor a
	ld [hBGMapMode], a
	call ClearSprites
	xor a
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	call ByteFill
	call Pokedex_DrawListWindow
	hlcoord 0, 17
	ld de, String_START_SEARCH
	call Pokedex_PlaceString
	ld a, 7
	ld [wDexListingHeight], a
	call Pokedex_PrintListing
	call Pokedex_SetBGMapMode3
	call Pokedex_SetBGMapMode4
	call Pokedex_ResetBGMapMode
	call Pokedex_DrawMainScreenBG
	ld a, $5
	ld [hSCX], a
	ld a, $47
	ld [hWX], a
	xor a
	ld [hWY], a
	call ApplyTilemapInVBlank

	call Pokedex_ResetBGMapMode
	ld a, -1
	ld [wCurPartySpecies], a
	xor a
	ld [wDexMonShiny], a
	ld a, CGB_POKEDEX
	call Pokedex_GetCGBLayout
	call Pokedex_UpdateCursorOAM
	call Pokedex_DrawListWindow
	hlcoord 0, 17
	ld de, String_START_SEARCH
	call Pokedex_PlaceString
	ld a, 7
	ld [wDexListingHeight], a
	call Pokedex_PrintListing
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateMainScreen: ; 401ae (10:41ae)
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b
	ld a, [hl]
	and A_BUTTON
	jr nz, .a
	ld a, [hl]
	and SELECT
	jr nz, .select
	ld a, [hl]
	and START
	jr nz, .start
	call Pokedex_ListingHandleDPadInput
	ret nc
	call Pokedex_UpdateCursorOAM
	xor a
	ld [hBGMapMode], a
	call Pokedex_PrintListing
	call Pokedex_SetBGMapMode3
	jp Pokedex_ResetBGMapMode

.a
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	ret z
	ld a, DEXSTATE_DEX_ENTRY_SCR
	ld [wJumptableIndex], a
	ld a, DEXSTATE_MAIN_SCR
	ld [wDexEntryPrevJumptableIndex], a
	ret

.select
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_OPTION_SCR
	ld [wJumptableIndex], a
	xor a
	ld [hSCX], a
	ld a, $a7
	ld [hWX], a
	jp DelayFrame

.start
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_SEARCH_SCR
	ld [wJumptableIndex], a
	xor a
	ld [hSCX], a
	ld a, $a7
	ld [hWX], a
	jp DelayFrame

.b
	ld a, DEXSTATE_EXIT
	ld [wJumptableIndex], a
	ret

Pokedex_InitDexEntryScreen: ; 40217 (10:4217)
	call LowVolume
	xor a
	ld [wPokedexStatus], a
	xor a
	ld [hBGMapMode], a
	call ClearSprites
	call Pokedex_LoadCurrentFootprint
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_InitArrowCursor
	call Pokedex_GetSelectedMon
	ld [wLastDexEntry], a
	farcall DisplayDexEntry
	call Pokedex_DrawFootprint
	call ApplyTilemapInVBlank
	ld a, $a7
	ld [hWX], a
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	xor a
	ld [wDexMonShiny], a
	ld a, CGB_POKEDEX
	call Pokedex_GetCGBLayout
	ld a, [wCurPartySpecies]
	call PlayCry
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateDexEntryScreen: ; 40258 (10:4258)
	ld a, [wCelebiEvent]
	bit 4, a ; ENGINE_HAVE_SHINY_CHARM
	ld de, DexEntryScreen_ArrowCursorData_ShinyCharm
	jr nz, .ok
	ld de, DexEntryScreen_ArrowCursorData
.ok
	call Pokedex_MoveArrowCursor
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .return_to_prev_screen
	ld a, [hl]
	and A_BUTTON
	jr nz, .do_menu_action
	call Pokedex_NextOrPreviousDexEntry
	ret nc
	jp Pokedex_IncrementDexPointer

.do_menu_action
	ld a, [wDexArrowCursorPosIndex]
	ld hl, DexEntryScreen_MenuActionJumptable
	call Pokedex_LoadPointer
	jp hl

.return_to_prev_screen
	ld a, [wLastVolume]
	and a
	jr z, .max_volume
	ld a, $77
	ld [wLastVolume], a

.max_volume
	call MaxVolume
	ld a, [wDexEntryPrevJumptableIndex]
	ld [wJumptableIndex], a
	ret

Pokedex_Page: ; 40292
	ld a, [wPokedexStatus]
	xor $1
	ld [wPokedexStatus], a
	call Pokedex_GetSelectedMon
	ld [wLastDexEntry], a
	farcall DisplayDexEntry
	jp ApplyTilemapInVBlank

Pokedex_ReinitDexEntryScreen: ; 402aa (10:42aa)
; Reinitialize the Pokédex entry screen after changing the selected mon.
	call Pokedex_BlackOutBG
	xor a
	ld [wPokedexStatus], a
	xor a
	ld [hBGMapMode], a
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_InitArrowCursor
	call Pokedex_LoadCurrentFootprint
	call Pokedex_GetSelectedMon
	ld [wLastDexEntry], a
	farcall DisplayDexEntry
	call Pokedex_DrawFootprint
	call Pokedex_LoadSelectedMonTiles
	call ApplyTilemapInVBlank
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	ld a, CGB_POKEDEX
	call Pokedex_GetCGBLayout
	ld a, [wCurPartySpecies]
	call PlayCry
	ld hl, wJumptableIndex
	dec [hl]
	ret

DexEntryScreen_ArrowCursorData: ; 402e8
	db D_RIGHT | D_LEFT, 3
	dwcoord 1, 17
	dwcoord 6, 17
	dwcoord 11, 17

DexEntryScreen_ArrowCursorData_ShinyCharm:
	db D_RIGHT | D_LEFT, 4
	dwcoord 1, 17
	dwcoord 6, 17
	dwcoord 11, 17
	dwcoord 15, 17

DexEntryScreen_MenuActionJumptable: ; 402f2
	dw Pokedex_Page
	dw .Area
	dw .Cry
	dw .Shiny

.Area: ; 402fa
	call Pokedex_BlackOutBG
	xor a
	ld [hSCX], a
	;call DelayFrame
	ld a, $7
	ld [hWX], a
	ld a, $90
	ld [hWY], a
	call Pokedex_GetSelectedMon
	ld a, [wDexCurrentLocation]
	ld e, a
	predef _Area
	call Pokedex_BlackOutBG
	call DelayFrame
	xor a
	ld [hBGMapMode], a
	ld a, $90
	ld [hWY], a
	ld a, $5
	ld [hSCX], a
	call DelayFrame
	call Pokedex_RedisplayDexEntry
	call Pokedex_LoadSelectedMonTiles
	call ApplyTilemapInVBlank
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	ld a, CGB_POKEDEX
	jp Pokedex_GetCGBLayout

.Cry: ; 40340
	ld a, [wCurPartySpecies]
	jp PlayCry

.Shiny:
	ld hl, wDexMonShiny
	ld a, [hl]
	xor SHINY_MASK ; alternate 0 and SHINY_MASK
	ld [hl], a
	ld a, [wCurPartySpecies]
	ld a, CGB_POKEDEX
	jp Pokedex_GetCGBLayout

Pokedex_RedisplayDexEntry: ; 4038d
	call Pokedex_LoadGFX
	call Pokedex_LoadAnyFootprint
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_GetSelectedMon
	farcall DisplayDexEntry
	jp Pokedex_DrawFootprint

Pokedex_InitOptionScreen: ; 4039d (10:439d)
	xor a
	ld [hBGMapMode], a
	call ClearSprites
	call Pokedex_DrawOptionScreenBG
	call Pokedex_InitArrowCursor
	ld a, [wCurrentDexMode]
	ld [wDexArrowCursorPosIndex], a
	call Pokedex_DisplayModeDescription
	call ApplyTilemapInVBlank
	ld a, CGB_POKEDEX_SEARCH_OPTION
	call Pokedex_GetCGBLayout
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateOptionScreen: ; 403be (10:43be)
	ld a, [wUnlockedUnownMode]
	and a
	jr nz, .okay
	ld de, .NoUnownModeArrowCursorData
	jr .okay2
.okay
	ld de, .ArrowCursorData
.okay2
	call Pokedex_MoveArrowCursor
	call c, Pokedex_DisplayModeDescription
	ld hl, hJoyPressed
	ld a, [hl]
	and SELECT | B_BUTTON
	jr nz, .return_to_main_screen
	ld a, [hl]
	and A_BUTTON
	jr nz, .do_menu_action
	ret

.do_menu_action
	ld a, [wDexArrowCursorPosIndex]
	ld hl, .MenuActionJumptable
	call Pokedex_LoadPointer
	jp hl

.return_to_main_screen
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.NoUnownModeArrowCursorData: ; 403f3
	db D_UP | D_DOWN, 3
	dwcoord 2,  4
	dwcoord 2,  6
	dwcoord 2,  8

.ArrowCursorData: ; 403fb
	db D_UP | D_DOWN, 4
	dwcoord 2,  4
	dwcoord 2,  6
	dwcoord 2,  8
	dwcoord 2, 10

.MenuActionJumptable: ; 40405 (10:4405)
	dw .MenuAction_NewMode
	dw .MenuAction_OldMode
	dw .MenuAction_ABCMode
	dw .MenuAction_UnownMode

.MenuAction_NewMode: ; 4040d (10:440d)
	ld b, DEXMODE_NEW
	jr .ChangeMode

.MenuAction_OldMode: ; 40411 (10:4411)
	ld b, DEXMODE_OLD
	jr .ChangeMode

.MenuAction_ABCMode: ; 40415 (10:4415)
	ld b, DEXMODE_ABC

.ChangeMode: ; 40417 (10:4417)
	ld a, [wCurrentDexMode]
	cp b
	jr z, .skip_changing_mode ; Skip if new mode is same as current.

	ld a, b
	ld [wCurrentDexMode], a
	call Pokedex_OrderMonsByMode
	call Pokedex_DisplayChangingModesMessage
	xor a
	ld [wDexListingScrollOffset], a
	ld [wDexListingCursor], a
	call Pokedex_InitCursorPosition

.skip_changing_mode
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.MenuAction_UnownMode: ; 4043a (10:443a)
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_UNOWN_MODE
	ld [wJumptableIndex], a
	ret

Pokedex_InitSearchScreen: ; 40443 (10:4443)
	xor a
	ld [hBGMapMode], a
	call ClearSprites
	call Pokedex_DrawSearchScreenBG
	call Pokedex_InitArrowCursor
	ld a, NORMAL + 1
	ld [wDexSearchMonType1], a
	xor a
	ld [wDexSearchMonType2], a
	call Pokedex_PlaceSearchScreenTypeStrings
	xor a
	ld [wDexSearchSlowpokeFrame], a
	farcall DoDexSearchSlowpokeFrame
	call ApplyTilemapInVBlank
	ld a, CGB_POKEDEX_SEARCH_OPTION
	call Pokedex_GetCGBLayout
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateSearchScreen: ; 40471 (10:4471)
	ld de, .ArrowCursorData
	call Pokedex_MoveArrowCursor
	call Pokedex_UpdateSearchMonType
	call c, Pokedex_PlaceSearchScreenTypeStrings
	ld hl, hJoyPressed
	ld a, [hl]
	and START | B_BUTTON
	jr nz, .cancel
	ld a, [hl]
	and A_BUTTON
	ret z

	ld a, [wDexArrowCursorPosIndex]
	ld hl, .MenuActionJumptable
	call Pokedex_LoadPointer
	jp hl

.cancel
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.ArrowCursorData: ; 4049e
	db D_UP | D_DOWN, 4
	dwcoord 2, 4
	dwcoord 2, 6
	dwcoord 2, 13
	dwcoord 2, 15

.MenuActionJumptable: ; 404a8
	dw .MenuAction_MonSearchType
	dw .MenuAction_MonSearchType
	dw .MenuAction_BeginSearch
	dw .MenuAction_Cancel

.MenuAction_MonSearchType: ; 404b0
	call Pokedex_NextSearchMonType
	jp Pokedex_PlaceSearchScreenTypeStrings

.MenuAction_BeginSearch: ; 404b7
	call Pokedex_SearchForMons
	farcall AnimateDexSearchSlowpoke
	ld a, [wDexSearchResultCount]
	and a
	jr nz, .show_search_results

; No mon with matching types was found.
	call Pokedex_OrderMonsByMode
	call Pokedex_DisplayTypeNotFoundMessage
	xor a
	ld [hBGMapMode], a
	call Pokedex_DrawSearchScreenBG
	call Pokedex_InitArrowCursor
	call Pokedex_PlaceSearchScreenTypeStrings
	jp ApplyTilemapInVBlank

.show_search_results
	ld [wDexListingEnd], a
	ld a, [wDexListingScrollOffset]
	ld [wDexListingScrollOffsetBackup], a
	ld a, [wDexListingCursor]
	ld [wDexListingCursorBackup], a
	ld a, [wLastDexEntry]
	ld [wcf65], a
	xor a
	ld [wDexListingScrollOffset], a
	ld [wDexListingCursor], a
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_SEARCH_RESULTS_SCR
	ld [wJumptableIndex], a
	ret

.MenuAction_Cancel: ; 40501
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

Pokedex_InitSearchResultsScreen: ; 4050a (10:450a)
	xor a
	ld [hBGMapMode], a
	xor a
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	call Pokedex_SetBGMapMode4
	call Pokedex_ResetBGMapMode
	call Pokedex_DrawSearchResultsWindow
	call Pokedex_PlaceSearchResultsTypeStrings
	ld a, 4
	ld [wDexListingHeight], a
	call Pokedex_PrintListing
	call Pokedex_SetBGMapMode3
	call Pokedex_ResetBGMapMode
	call Pokedex_DrawSearchResultsScreenBG
	ld a, $5
	ld [hSCX], a
	ld a, $4a
	ld [hWX], a
	xor a
	ld [hWY], a
	call ApplyTilemapInVBlank
	call Pokedex_ResetBGMapMode
	call Pokedex_DrawSearchResultsWindow
	call Pokedex_PlaceSearchResultsTypeStrings
	call Pokedex_UpdateSearchResultsCursorOAM
	ld a, $ff
	ld [wCurPartySpecies], a
	ld a, CGB_POKEDEX
	call Pokedex_GetCGBLayout
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateSearchResultsScreen: ; 40562 (10:4562)
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .return_to_search_screen
	ld a, [hl]
	and A_BUTTON
	jr nz, .go_to_dex_entry
	call Pokedex_ListingHandleDPadInput
	ret nc
	call Pokedex_UpdateSearchResultsCursorOAM
	xor a
	ld [hBGMapMode], a
	call Pokedex_PrintListing
	call Pokedex_SetBGMapMode3
	jp Pokedex_ResetBGMapMode

.go_to_dex_entry
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	ret z
	ld a, DEXSTATE_DEX_ENTRY_SCR
	ld [wJumptableIndex], a
	ld a, DEXSTATE_SEARCH_RESULTS_SCR
	ld [wDexEntryPrevJumptableIndex], a
	ret

.return_to_search_screen
	ld a, [wDexListingScrollOffsetBackup]
	ld [wDexListingScrollOffset], a
	ld a, [wDexListingCursorBackup]
	ld [wDexListingCursor], a
	ld a, [wcf65]
	ld [wLastDexEntry], a
	call Pokedex_BlackOutBG
	call ClearSprites
	call Pokedex_OrderMonsByMode
	ld a, DEXSTATE_SEARCH_SCR
	ld [wJumptableIndex], a
	xor a
	ld [hSCX], a
	ld a, $a7
	ld [hWX], a
	ret

Pokedex_InitUnownMode: ; 405bd (10:45bd)
	call Pokedex_LoadUnownFont
	call Pokedex_DrawUnownModeBG
	xor a
	ld [wDexCurrentUnownIndex], a
	call Pokedex_LoadUnownFrontpicTiles
	call Pokedex_UnownModePlaceCursor
	farcall PrintUnownWord
	call ApplyTilemapInVBlank
	ld a, CGB_POKEDEX_UNOWN_MODE
	call Pokedex_GetCGBLayout
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateUnownMode: ; 405df (10:45df)
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON | B_BUTTON
	jr z, Pokedex_UnownModeHandleDPadInput
	call Pokedex_BlackOutBG
	ld a, [wOptionsBuffer]
	ld [wOptions2], a
	xor a
	ld [wOptionsBuffer], a
	call LoadStandardFont
	ld a, DEXSTATE_OPTION_SCR
	ld [wJumptableIndex], a
	call DelayFrame
	ld hl, PokedexLZ
	ld de, VTiles2 tile $31
	lb bc, BANK(PokedexLZ), $34
	jp DecompressRequest2bpp

Pokedex_UnownModeHandleDPadInput: ; 40610 (10:4610)
	ld hl, hJoyLast
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ret

.right
	ld a, [wDexUnownCount]
	ld e, a
	ld hl, wDexCurrentUnownIndex
	ld a, [hl]
	inc a
	cp e
	ret nc
	ld a, [hl]
	inc [hl]
	jr .update

.left
	ld hl, wDexCurrentUnownIndex
	ld a, [hl]
	and a
	ret z
	ld a, [hl]
	dec [hl]

.update
	push af
	xor a
	ld [hBGMapMode], a
	pop af
	call Pokedex_UnownModeEraseCursor
	call Pokedex_LoadUnownFrontpicTiles
	call Pokedex_UnownModePlaceCursor
	farcall PrintUnownWord
	ld a, $1
	ld [hBGMapMode], a
	call DelayFrame
	jp DelayFrame

Pokedex_UnownModeEraseCursor: ; 40654 (10:4654)
	ld c, " "
	jr Pokedex_UnownModeUpdateCursorGfx

Pokedex_UnownModePlaceCursor: ; 40658 (10:4658)
	ld a, [wDexCurrentUnownIndex]
	ld c, "." ; diamond cursor

Pokedex_UnownModeUpdateCursorGfx: ; 4065d (10:465d)
	ld e, a
	ld d, 0
	ld hl, UnownModeLetterAndCursorCoords + 2
rept 4
	add hl, de
endr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], c
	ret

Pokedex_NextOrPreviousDexEntry: ; 4066c (10:466c)
	ld a, [wDexListingCursor]
	ld [wBackupDexListingCursor], a
	ld a, [wDexListingScrollOffset]
	ld [wBackupDexListingPage], a
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	and a
	ret

.up
	ld a, [wDexListingHeight]
	ld d, a
	ld a, [wDexListingEnd]
	ld e, a
	call Pokedex_ListingMoveCursorUp
	jr nc, .nope
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	jr nz, .yep
	jr .up

.down
	ld a, [wDexListingHeight]
	ld d, a
	ld a, [wDexListingEnd]
	ld e, a
	call Pokedex_ListingMoveCursorDown
	jr nc, .nope
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	jr nz, .yep
	jr .down

.yep
	scf
	ret

.nope
	ld a, [wBackupDexListingCursor]
	ld [wDexListingCursor], a
	ld a, [wBackupDexListingPage]
	ld [wDexListingScrollOffset], a
	and a
	ret

Pokedex_ListingHandleDPadInput: ; 406c5 (10:46c5)
; Handles D-pad input for a list of Pokémon.
	ld a, [wDexListingHeight]
	ld d, a
	ld a, [wDexListingEnd]
	ld e, a
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, Pokedex_ListingMoveCursorUp
	ld a, [hl]
	and D_DOWN
	jr nz, Pokedex_ListingMoveCursorDown
	ld a, d
	cp e
	jr nc, Pokedex_ListingPosStayedSame
	ld a, [hl]
	and D_LEFT
	jr nz, Pokedex_ListingMoveUpOnePage
	ld a, [hl]
	and D_RIGHT
	jr nz, Pokedex_ListingMoveDownOnePage
	jr Pokedex_ListingPosStayedSame

Pokedex_ListingMoveCursorUp: ; 406ea (10:46ea)
	ld hl, wDexListingCursor
	ld a, [hl]
	and a
	jr z, .try_scrolling
	dec [hl]
	jr Pokedex_ListingPosChanged
.try_scrolling
	ld hl, wDexListingScrollOffset
	ld a, [hl]
	and a
	jr z, Pokedex_ListingPosStayedSame
	dec [hl]
	jr Pokedex_ListingPosChanged

Pokedex_ListingMoveCursorDown: ; 406fe (10:46fe)
	ld hl, wDexListingCursor
	ld a, [hl]
	inc a
	cp e
	jr nc, Pokedex_ListingPosStayedSame
	cp d
	jr nc, .try_scrolling
	inc [hl]
	jr Pokedex_ListingPosChanged
.try_scrolling
	ld hl, wDexListingScrollOffset
	add [hl]
	cp e
	jr nc, Pokedex_ListingPosStayedSame
	inc [hl]
	jr Pokedex_ListingPosChanged

Pokedex_ListingMoveUpOnePage: ; 40716 (10:4716)
	ld hl, wDexListingScrollOffset
	ld a, [hl]
	and a
	jr z, Pokedex_ListingPosStayedSame
	cp d
	jr nc, .not_near_top
; If we're already less than page away from the top, go to the top.
	xor a
	ld [hl], a
	jr Pokedex_ListingPosChanged
.not_near_top
	sub d
	ld [hl], a
	jr Pokedex_ListingPosChanged

Pokedex_ListingMoveDownOnePage: ; 40728 (10:4728)
; When moving down a page, the return value always report a change in position.
	ld hl, wDexListingScrollOffset
	ld a, d
	add a
	add [hl]
	jr c, .near_bottom
	cp e
	jr c, .not_near_bottom
.near_bottom
	ld a, e
	sub d
	ld [hl], a
	jr Pokedex_ListingPosChanged
.not_near_bottom
	ld a, [hl]
	add d
	ld [hl], a
	jr Pokedex_ListingPosChanged

Pokedex_ListingPosStayedSame: ; 4073d (10:473d)
	and a
	ret

Pokedex_ListingPosChanged: ; 4073f (10:473f)
	scf
	ret

Pokedex_FillColumn: ; 40741
; Fills a column starting at HL, going downwards.
; B is the height of the column and A is the tile it's filled with.
	push de
	ld de, SCREEN_WIDTH
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	pop de
	ret

Pokedex_DrawMainScreenBG: ; 4074c (10:474c)
; Draws the left sidebar and the bottom bar on the main screen.
	hlcoord 0, 17
	ld de, String_START_SEARCH
	call Pokedex_PlaceString
	ld a, $32
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	hlcoord 0, 0
	lb bc, 7, 7
	call Pokedex_PlaceBorder
	hlcoord 0, 9
	lb bc, 6, 7
	call Pokedex_PlaceBorder
	hlcoord 1, 11
	ld de, String_SEEN
	call Pokedex_PlaceString
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld de, wd265
	hlcoord 5, 12
	lb bc, 1, 3
	call PrintNum
	hlcoord 1, 14
	ld de, String_OWN
	call Pokedex_PlaceString
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld de, wd265
	hlcoord 5, 15
	lb bc, 1, 3
	call PrintNum
	hlcoord 1, 17
	ld de, String_SELECT_OPTION
	call Pokedex_PlaceString
	hlcoord 8, 1
	ld b, 7
	ld a, $5a
	call Pokedex_FillColumn
	hlcoord 8, 10
	ld b, 6
	ld a, $5a
	call Pokedex_FillColumn
	hlcoord 8, 0
	ld [hl], $59
	hlcoord 8, 8
	ld [hl], $53
	hlcoord 8, 9
	ld [hl], $54
	hlcoord 8, 16
	ld [hl], $5b
	jp Pokedex_PlaceFrontpicTopLeftCorner

String_SEEN: ; 407e1
	db "Seen", $ff
String_OWN: ; 407e6
	db "Own", $ff
String_SELECT_OPTION: ; 407ea
;	db $3b, $48, $49, $4a, $44, $45, $46, $47 ; SELECT > OPTION
	db $3b, $41, $42, $43, $44, $45, $46, $47
String_START_SEARCH: ; 407f2
;	db $3c, $3b, $41, $42, $43, $4b, $4c, $4d, $4e, $3c, $ff ; START > SEARCH
	db $48, $3b, $49, $4a, $4b, $4c, $4d, $4e, $5d, $5e, $ff

Pokedex_DrawDexEntryScreenBG: ; 407fd
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 0
	lb bc, 15, 18
	call Pokedex_PlaceBorder
	hlcoord 19, 0
	ld [hl], $34
	hlcoord 19, 1
	ld a, " "
	ld b, 15
	call Pokedex_FillColumn
	ld [hl], $39
	hlcoord 1, 10
	ld bc, 19
	ld a, $5f ; horizontal divider
	call ByteFill
	hlcoord 1, 17
	ld bc, 18
	ld a, " "
	call ByteFill
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	jr nz, .metric
	hlcoord 9, 7
	ld de, .HeightImperial
	call Pokedex_PlaceString
	hlcoord 9, 9
	ld de, .WeightImperial
	call Pokedex_PlaceString
	jr .done
.metric
	hlcoord 9, 7
	ld de, .HeightMetric
	call Pokedex_PlaceString
	hlcoord 9, 9
	ld de, .WeightMetric
	call Pokedex_PlaceString
.done
	hlcoord 0, 17

	ld a, [wCelebiEvent]
	bit 4, a ; ENGINE_HAVE_SHINY_CHARM
	ld de, .MenuItemsShinyCharm
	jr nz, .ok
	ld de, .MenuItems
.ok
	call Pokedex_PlaceString
	jp Pokedex_PlaceFrontpicTopLeftCorner

.HeightImperial: ; 40852
	rawchar "Ht  ?′??″", $ff ; HT  ?'??"
.WeightImperial: ; 4085c
	rawchar "Wt   ???lb", $ff ; WT   ???lb
.HeightMetric:
	rawchar "Ht   ???m", $ff ; HT   ???m"
.WeightMetric:
	rawchar "Wt   ???kg", $ff ; WT   ???kg
.MenuItems: ; 40867
	rawchar $3b, " Page Area Cry     ", $ff
.MenuItemsShinyCharm:
	rawchar $3b, " Page Area Cry Shny", $ff

Pokedex_DrawDexEntryScreenRightEdge: ; 1de247
	ld a, [hBGMapAddress]
	ld l, a
	ld a, [hBGMapAddress + 1]
	ld h, a
	push hl
	inc hl
	ld a, l
	ld [hBGMapAddress], a
	ld a, h
	ld [hBGMapAddress + 1], a
	hlcoord 19, 0
	ld [hl], $60
	hlcoord 19, 1
	ld a, $61
	ld b, 15
	call Pokedex_FillColumn
	ld [hl], $62
	hlcoord 19, 17
	ld [hl], $3c
	xor a
	ld b, SCREEN_HEIGHT
	hlcoord 19, 0, wAttrMap
	call Pokedex_FillColumn
	call ApplyAttrAndTilemapInVBlank
	pop hl
	ld a, l
	ld [hBGMapAddress], a
	ld a, h
	ld [hBGMapAddress + 1], a
	ret

Pokedex_DrawOptionScreenBG: ; 4087c (10:487c)
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 2
	lb bc, 8, 18
	call Pokedex_PlaceBorder
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	hlcoord 0, 1
	ld de, .Title
	call Pokedex_PlaceString
	hlcoord 3, 4
	ld de, .Modes
	call PlaceString
	ld a, [wUnlockedUnownMode]
	and a
	ret z
	hlcoord 3, 10
	ld de, .UnownMode
	jp PlaceString

.Title: ; 408b2
	rawchar $3b, " Option ", $3c, $ff

.Modes: ; 408bd
	db   "Johto Mode"
	next "National Mode"
	next "A to Z Mode"
	db "@"

.UnownMode: ; 408e5
	db "Unown Mode@"

Pokedex_DrawSearchScreenBG: ; 408f0 (10:48f0)
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 2
	lb bc, 14, 18
	call Pokedex_PlaceBorder
	hlcoord 0, 1
	ld de, .Title
	call Pokedex_PlaceString
	hlcoord 8, 4
	ld de, .TypeLeftRightArrows
	call Pokedex_PlaceString
	hlcoord 8, 6
	ld de, .TypeLeftRightArrows
	call Pokedex_PlaceString
	hlcoord 3, 4
	ld de, .Types
	call PlaceString
	hlcoord 3, 13
	ld de, .Menu
	jp PlaceString

.Title: ; 4092a
	rawchar $3b, " Search ", $3c, $ff

.TypeLeftRightArrows: ; 40935
	db $3d, "        ▷", $ff

.Types: ; 40940
	db   "Type1"
	next "Type2"
	db   "@"

.Menu: ; 4094c
	db   "Begin Search!"
	next "Cancel"
	db   "@"

Pokedex_DrawSearchResultsScreenBG: ; 40962 (10:4962)
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 0
	lb bc, 7, 7
	call Pokedex_PlaceBorder
	hlcoord 0, 11
	lb bc, 5, 18
	call Pokedex_PlaceBorder
	hlcoord 1, 12
	ld de, .BottomWindowText
	call PlaceString
	ld de, wDexSearchResultCount
	hlcoord 1, 16
	lb bc, 1, 3
	call PrintNum
	hlcoord 8, 0
	ld [hl], $59
	hlcoord 8, 1
	ld b, 7
	ld a, $5a
	call Pokedex_FillColumn
	hlcoord 8, 8
	ld [hl], $53
	hlcoord 8, 9
	ld [hl], $63
	hlcoord 8, 10
	ld [hl], $64
	jp Pokedex_PlaceFrontpicTopLeftCorner

.BottomWindowText: ; 409ae
	db   "Search Results"
	next "  Type/"
	next "    found!"
	db   "@"

Pokedex_PlaceSearchResultsTypeStrings: ; 409cf (10:49cf)
	ld a, [wDexSearchMonType1]
	hlcoord 0, 14
	call Pokedex_PlaceTypeString
	ld a, [wDexSearchMonType1]
	ld b, a
	ld a, [wDexSearchMonType2]
	and a
	ret z
	cp b
	ret z
	hlcoord 1, 15
	call Pokedex_PlaceTypeString
	hlcoord 0, 15
	ld [hl], "/"
	ret

Pokedex_DrawUnownModeBG: ; 409f1 (10:49f1)
	call Pokedex_FillBackgroundColor2
	hlcoord 2, 1
	lb bc, 11, 13
	call Pokedex_PlaceBorder
	hlcoord 2, 14
	lb bc, 1, 13
	call Pokedex_PlaceBorder
	hlcoord 2, 15
	ld [hl], $5c
	hlcoord 16, 15
	ld [hl], $3e
	hlcoord 6, 5
	call Pokedex_PlaceFrontpicAtHL
	ld de, 0
	lb bc, 0, NUM_UNOWN
.loop
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	and a
	jr z, .done
	push af
	ld hl, UnownModeLetterAndCursorCoords
rept 4
	add hl, de
endr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	cp 27
	jr z, .exclamation
	cp 28
	jr z, .question
	add "A" - 1
	jr .got_letter
.exclamation
	ld a, "!"
	jr .got_letter
.question
	ld a, "?"
.got_letter
	ld [hl], a
	inc de
	inc b
	dec c
	jr nz, .loop
.done
	ld a, b
	ld [wDexUnownCount], a
	ret

UnownModeLetterAndCursorCoords: ; 40a3e
;           letter, cursor
	dwcoord   4,12,   3,12
	dwcoord   4,11,   3,11
	dwcoord   4,10,   3,10
	dwcoord   4, 9,   3, 9
	dwcoord   4, 8,   3, 8
	dwcoord   4, 7,   3, 7
	dwcoord   4, 6,   3, 6
	dwcoord   4, 5,   3, 5
	dwcoord   4, 4,   3, 4
	dwcoord   4, 3,   3, 2
	dwcoord   5, 3,   5, 2
	dwcoord   6, 3,   6, 2
	dwcoord   7, 3,   7, 2
	dwcoord   8, 3,   8, 2
	dwcoord   9, 3,   9, 2
	dwcoord  10, 3,  10, 2
	dwcoord  11, 3,  11, 2
	dwcoord  12, 3,  12, 2
	dwcoord  13, 3,  13, 2
	dwcoord  14, 3,  15, 2
	dwcoord  14, 4,  15, 4
	dwcoord  14, 5,  15, 5
	dwcoord  14, 6,  15, 6
	dwcoord  14, 7,  15, 7
	dwcoord  14, 8,  15, 8
	dwcoord  14, 9,  15, 9
	dwcoord  14,10,  15,10
	dwcoord  14,11,  15,11

Pokedex_DrawListWindow: ; 1de171 (77:6171)
	ld a, $32
	hlcoord 0, 17
	ld bc, 12
	call ByteFill
	hlcoord 0, 1
	lb bc, 15, 11
	call ClearBox
	ld a, $34
	hlcoord 0, 0
	ld bc, 11
	call ByteFill
	ld a, $39
	hlcoord 0, 16
	ld bc, 11
	call ByteFill
	hlcoord 5, 0
	ld [hl], $3f
	hlcoord 5, 16
	ld [hl], $40
; scroll bar
	hlcoord 11, 0
	ld [hl], $50
	ld a, $51
	hlcoord 11, 1
	ld b, SCREEN_HEIGHT - 3
	call Pokedex_FillColumn
	ld [hl], $52
	ret

Pokedex_DrawSearchResultsWindow: ; 1de1d1 (77:61d1)
	ld a, $34
	hlcoord 0, 0
	ld bc, 11
	call ByteFill
	ld a, $39
	hlcoord 0, 10
	ld bc, 11
	call ByteFill
	hlcoord 5, 0
	ld [hl], $3f
	hlcoord 5, 10
	ld [hl], $40
	hlcoord 11, 0
	ld [hl], $60
	ld a, $61
	hlcoord 11, 1
	ld b, SCREEN_HEIGHT / 2
	call Pokedex_FillColumn
	ld [hl], $62
	ld a, $34
	hlcoord 0, 11
	ld bc, 11
	call ByteFill
	ld a, $39
	hlcoord 0, 17
	ld bc, 11
	call ByteFill
	hlcoord 11, 11
	ld [hl], $60
	ld a, $61
	hlcoord 11, 12
	ld b, 5
	call Pokedex_FillColumn
	ld [hl], $62
	hlcoord 0, 12
	lb bc, 5, 11
	call ClearBox
	ld de, .esults_D
	hlcoord 0, 12
	jp PlaceString

.esults_D ; 1de23c
; (SEARCH R)
	db   "esults<NL>"
; (### FOUN)
	next "d!@"

Pokedex_FillBackgroundColor2: ; 40aa6
	hlcoord 0, 0
	ld a, $32
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	jp ByteFill

Pokedex_PlaceFrontpicTopLeftCorner: ; 40ab2
	hlcoord 1, 1
Pokedex_PlaceFrontpicAtHL: ; 40ab5
	xor a
	ld b, $7
.row
	ld c, $7
	push af
	push hl
.col
	ld [hli], a
	add $7
	dec c
	jr nz, .col
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop af
	inc a
	dec b
	jr nz, .row
	ret

Pokedex_PlaceString: ; 40acd
.loop
	ld a, [de]
	cp -1
	ret z
	inc de
	ld [hli], a
	jr .loop


Pokedex_PlaceBorder: ; 40ad5
	push hl
	ld a, $33
	ld [hli], a
	ld d, $34
	call .FillRow
	ld a, $35
	ld [hl], a
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
.loop
	push hl
	ld a, $36
	ld [hli], a
	ld d, $7f
	call .FillRow
	ld a, $37
	ld [hl], a
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .loop
	ld a, $38
	ld [hli], a
	ld d, $39
	call .FillRow
	ld a, $3a
	ld [hl], a
	ret

.FillRow: ; 40b06
	ld e, c
.row_loop
	ld a, e
	and a
	ret z
	ld a, d
	ld [hli], a
	dec e
	jr .row_loop


Pokedex_PrintListing: ; 40b0f (10:4b0f)
; Prints the list of Pokémon on the main Pokédex screen.

; Clear (2 * [wDexListingHeight] + 1) by 11 box starting at 0,1
	hlcoord 0, 1
	ld a, [wDexListingHeight]
	add a
	inc a
	ld b, a
	ld c, 11
	ld a, " "
	call FillBoxWithByte

; Load de with wPokedexDataStart + [wDexListingScrollOffset]
	ld a, [wDexListingScrollOffset]
	ld e, a
	ld d, $0
	ld hl, wPokedexDataStart
	add hl, de
	ld e, l
	ld d, h
	hlcoord 0, 2
	ld a, [wDexListingHeight]
.loop
	push af
	ld a, [de]
	ld [wd265], a
	push de
	push hl
	call .PrintEntry
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop de
	inc de
	pop af
	dec a
	jr nz, .loop
	jp Pokedex_LoadSelectedMonTiles

.PrintEntry: ; 40b55 (10:4b55)
; Prints one entry in the list of Pokémon on the main Pokédex screen.
	and a
	ret z
	call Pokedex_PrintNumberIfOldMode
	call Pokedex_PlaceDefaultStringIfNotSeen
	ret c
	call Pokedex_PlaceCaughtSymbolIfCaught
	push hl
	call GetPokemonName
	pop hl
	jp PlaceString

Pokedex_PrintNumberIfOldMode: ; 40b6a (10:4b6a)
	ld a, [wCurrentDexMode]
	cp DEXMODE_OLD
	ret nz
	push hl
	ld de, -SCREEN_WIDTH
	add hl, de
	ld de, wd265
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop hl
	ret

Pokedex_PlaceCaughtSymbolIfCaught: ; 40b82 (10:4b82)
	call Pokedex_CheckCaught
	jr nz, .place_caught_symbol
	inc hl
	ret

.place_caught_symbol
	ld a, $4f
	ld [hli], a
	ret

Pokedex_PlaceDefaultStringIfNotSeen: ; 40b8d (10:4b8d)
	call Pokedex_CheckSeen
	ret nz
	inc hl
	ld de, .NameNotSeen
	call PlaceString
	scf
	ret

.NameNotSeen: ; 40b9a
	db "-----@"

Pokedex_DrawFootprint: ; 40ba0
	hlcoord 18, 1
	ld a, $65
	ld [hli], a
	inc a
	ld [hl], a
	hlcoord 18, 2
	ld a, $67
	ld [hli], a
	inc a
	ld [hl], a
	ret


Pokedex_GetSelectedMon: ; 40bb1
; Gets the species of the currently selected Pokémon. This corresponds to the
; position of the cursor in the main listing, but this function can be used
; on all Pokédex screens.
	ld a, [wDexListingCursor]
	ld hl, wDexListingScrollOffset
	add [hl]
	ld e, a
	ld d, $0
	ld hl, wPokedexDataStart
	add hl, de
	ld a, [hl]
	ld [wd265], a
	ret


Pokedex_CheckCaught: ; 40bc4 (10:4bc4)
	push de
	push hl
	ld a, [wd265]
	dec a
	call CheckCaughtMon
	pop hl
	pop de
	ret


Pokedex_CheckSeen: ; 40bd0
	push de
	push hl
	ld a, [wd265]
	dec a
	call CheckSeenMon
	pop hl
	pop de
	ret



Pokedex_OrderMonsByMode: ; 40bdc
	ld hl, wPokedexDataStart
	ld bc, wPokedexMetadata - wPokedexDataStart
	xor a
	call ByteFill
	ld a, [wCurrentDexMode]
	ld hl, .Jumptable
	call Pokedex_LoadPointer
	jp hl


.Jumptable: ; 40bf0 (10:4bf0)
	dw .NewMode
	dw .OldMode
	dw Pokedex_ABCMode


.NewMode: ; 40bf6 (10:4bf6)
	ld de, NewPokedexOrder
	ld hl, wPokedexDataStart
	ld c, NUM_POKEMON
.loopnew
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loopnew
	jr .FindLastSeen

.OldMode: ; 40c08 (10:4c08)
	ld hl, wPokedexDataStart
	ld a, $1
	ld c, NUM_POKEMON
.loopold
	ld [hli], a
	inc a
	dec c
	jr nz, .loopold
	; fallthrough

.FindLastSeen: ; 40c18 (10:4c18)
	ld hl, wPokedexDataStart + NUM_POKEMON - 1
	ld d, NUM_POKEMON
	ld e, d
.loopfindend
	ld a, [hld]
	ld [wd265], a
	call Pokedex_CheckSeen
	jr nz, .foundend
	dec d
	dec e
	jr nz, .loopfindend
.foundend
	ld a, d
	ld [wDexListingEnd], a
	ret

Pokedex_ABCMode: ; 40c30
	xor a
	ld [wDexListingEnd], a
	ld hl, wPokedexDataStart
	ld de, AlphabeticalPokedexOrder
	ld c, NUM_POKEMON
.loop1abc
	push bc
	ld a, [de]
	ld [wd265], a
	call Pokedex_CheckSeen
	jr z, .skipabc
	ld a, [wd265]
	ld [hli], a
	ld a, [wDexListingEnd]
	inc a
	ld [wDexListingEnd], a

.skipabc
	inc de
	pop bc
	dec c
	jr nz, .loop1abc
	ld a, [wDexListingEnd]
	ld c, 0
.loop2abc
	cp NUM_POKEMON
	ret z
	ld [hl], c
	inc hl
	inc a
	jr .loop2abc

INCLUDE "data/pokemon/dex_order_alpha.asm"
INCLUDE "data/pokemon/dex_order_new.asm"

Pokedex_DisplayModeDescription: ; 40e5b
	xor a
	ld [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld a, [wDexArrowCursorPosIndex]
	ld hl, .Modes
	call Pokedex_LoadPointer
	ld e, l
	ld d, h
	hlcoord 1, 14
	call PlaceString
	ld a, $1
	ld [hBGMapMode], a
	ret

.Modes: ; 40e7d
	dw .NewMode
	dw .OldMode
	dw .ABCMode
	dw .UnownMode

.NewMode: ; 40e85
	db   "<PK><MN> are listed in"
	next "regional order.@"

.OldMode: ; 40ea6
	db   "<PK><MN> are listed in"
	next "national order.@"

.ABCMode: ; 40ec6
	db   "<PK><MN> are listed"
	next "alphabetically.@"

.UnownMode: ; 40ee4
	db   "Unown are listed"
	next "in order caught.@"

Pokedex_DisplayChangingModesMessage: ; 40f08 (10:4f08)
	xor a
	ld [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld de, String_ChangingModesPleaseWait
	hlcoord 1, 14
	call PlaceString
	ld a, $1
	ld [hBGMapMode], a
	ld c, 64
	call DelayFrames
	ld de, SFX_CHANGE_DEX_MODE
	call PlaySFX
	ld c, 64
	jp DelayFrames

String_ChangingModesPleaseWait: ; 40f32
	db   "Changing modes."
	next "Please wait.@"

Pokedex_UpdateSearchMonType: ; 40f4f (10:4f4f)
	ld a, [wDexArrowCursorPosIndex]
	cp 2
	jr nc, .no_change
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT
	jr nz, Pokedex_PrevSearchMonType
	ld a, [hl]
	and D_RIGHT
	jr nz, Pokedex_NextSearchMonType
.no_change
	and a
	ret

Pokedex_PrevSearchMonType: ; 40f65
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr nz, .type2

	ld hl, wDexSearchMonType1
	ld a, [hl]
	cp $1
	jr z, .wrap_around
	dec [hl]
	jr .done

.type2
	ld hl, wDexSearchMonType2
	ld a, [hl]
	and a
	jr z, .wrap_around
	dec [hl]
	jr .done

.wrap_around
	ld [hl], UNKNOWN_T

.done
	scf
	ret

Pokedex_NextSearchMonType: ; 40f84
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr nz, .type2

	ld hl, wDexSearchMonType1
	ld a, [hl]
	cp UNKNOWN_T
	jr nc, .type1_wrap_around
	inc [hl]
	jr .done
.type1_wrap_around
	ld [hl], 1
	jr .done

.type2
	ld hl, wDexSearchMonType2
	ld a, [hl]
	cp UNKNOWN_T
	jr nc, .type2_wrap_around
	inc [hl]
	jr .done
.type2_wrap_around
	ld [hl], 0

.done
	scf
	ret

Pokedex_PlaceSearchScreenTypeStrings: ; 40fa8 (10:4fa8)
	xor a
	ld [hBGMapMode], a
	hlcoord 9, 3
	lb bc, 4, 8
	ld a, " "
	call FillBoxWithByte
	ld a, [wDexSearchMonType1]
	hlcoord 9, 4
	call Pokedex_PlaceTypeString
	ld a, [wDexSearchMonType2]
	hlcoord 9, 6
	call Pokedex_PlaceTypeString
	ld a, $1
	ld [hBGMapMode], a
	ret

Pokedex_PlaceTypeString: ; 40fcd (10:4fcd)
	push hl
	ld e, a
	ld d, 0
	ld hl, PokedexTypeSearchStrings
rept 9
	add hl, de
endr
	ld e, l
	ld d, h
	pop hl
	jp PlaceString

INCLUDE "data/types/search_strings.asm"

Pokedex_SearchForMons: ; 41086
	ld a, [wDexSearchMonType2]
	and a
	call nz, .Search
	ld a, [wDexSearchMonType1]
	and a
	call nz, .Search
	ret

.Search: ; 41095
	dec a
	ld e, a
	ld d, 0
	ld hl, PokedexTypeSearchConversionTable
	add hl, de
	ld a, [hl]
	ld [wDexConvertedMonType], a
	ld hl, wPokedexDataStart
	ld de, wPokedexDataStart
	ld c, NUM_POKEMON
	xor a
	ld [wDexSearchResultCount], a
.loop
	push bc
	ld a, [hl]
	and a
	jr z, .next_mon
	ld [wd265], a
	ld [wCurSpecies], a
	call Pokedex_CheckCaught
	jr z, .next_mon
	push hl
	push de
	call GetBaseData
	pop de
	pop hl
	ld a, [wDexConvertedMonType]
	ld b, a
	ld a, [wBaseType1]
	cp b
	jr z, .match_found
	ld a, [wBaseType2]
	cp b
	jr nz, .next_mon

.match_found
	ld a, [wd265]
	ld [de], a
	inc de
	ld a, [wDexSearchResultCount]
	inc a
	ld [wDexSearchResultCount], a

.next_mon
	inc hl
	pop bc
	dec c
	jr nz, .loop

	ld l, e
	ld h, d
	ld a, [wDexSearchResultCount]
	ld c, 0

.zero_remaining_mons
	cp NUM_POKEMON
	ret z
	ld [hl], c
	inc hl
	inc a
	jr .zero_remaining_mons

INCLUDE "data/types/search_types.asm"

Pokedex_DisplayTypeNotFoundMessage: ; 41107
	xor a
	ld [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld de, .TypeNotFound
	hlcoord 1, 14
	call PlaceString
	ld a, $1
	ld [hBGMapMode], a
	ld c, $80
	jp DelayFrames

.TypeNotFound: ; 41126
	db   "The specified type"
	next "was not found.@"

Pokedex_UpdateCursorOAM: ; 41148 (10:5148)
	ld hl, .CursorOAM
	call Pokedex_UpdateCursor
	jp Pokedex_PutScrollbarOAM

.CursorOAM: ; 41230
	; y, x, tile, OAM attributes
	db $10, $47, $31, $7
	db $10, $4f, $32, $7
	db $10, $57, $32, $7
	db $10, $5f, $33, $7
	db $10, $80, $33, $7 | X_FLIP
	db $10, $88, $32, $7 | X_FLIP
	db $10, $90, $32, $7 | X_FLIP
	db $10, $98, $31, $7 | X_FLIP
	db $fe ; tells LoadCursorOAM to set c = 0
	db $18, $47, $30, $7
	db $18, $98, $30, $7 | X_FLIP
	db $20, $47, $30, $7 | Y_FLIP
	db $28, $47, $31, $7 | Y_FLIP
	db $28, $4f, $32, $7 | Y_FLIP
	db $28, $57, $32, $7 | Y_FLIP
	db $28, $5f, $33, $7 | Y_FLIP
	db $28, $80, $33, $7 | X_FLIP | Y_FLIP
	db $28, $88, $32, $7 | X_FLIP | Y_FLIP
	db $28, $90, $32, $7 | X_FLIP | Y_FLIP
	db $28, $98, $31, $7 | X_FLIP | Y_FLIP
	db $20, $98, $30, $7 | X_FLIP | Y_FLIP
	db $ff

Pokedex_UpdateSearchResultsCursorOAM:
	ld hl, .CursorOAM
	jp Pokedex_UpdateCursor

.CursorOAM:
	; y, x, tile, OAM attributes
	db $10, $47, $31, $7
	db $10, $4f, $32, $7
	db $10, $57, $32, $7
	db $10, $5f, $32, $7
	db $10, $67, $33, $7
	db $10, $7e, $33, $7 | X_FLIP
	db $10, $86, $32, $7 | X_FLIP
	db $10, $8e, $32, $7 | X_FLIP
	db $10, $96, $32, $7 | X_FLIP
	db $10, $9e, $31, $7 | X_FLIP
	db $fe ; tells LoadCursorOAM to set c = 0
	db $18, $47, $30, $7
	db $18, $9e, $30, $7 | X_FLIP
	db $20, $47, $30, $7 | Y_FLIP
	db $28, $47, $31, $7 | Y_FLIP
	db $28, $4f, $32, $7 | Y_FLIP
	db $28, $57, $32, $7 | Y_FLIP
	db $28, $5f, $32, $7 | Y_FLIP
	db $28, $67, $33, $7 | Y_FLIP
	db $28, $7e, $33, $7 | X_FLIP | Y_FLIP
	db $28, $86, $32, $7 | X_FLIP | Y_FLIP
	db $28, $8e, $32, $7 | X_FLIP | Y_FLIP
	db $28, $96, $32, $7 | X_FLIP | Y_FLIP
	db $28, $9e, $31, $7 | X_FLIP | Y_FLIP
	db $20, $9e, $30, $7 | X_FLIP | Y_FLIP
	db $ff

Pokedex_UpdateCursor:
	push bc
	lb bc, 3, 0
	ld a, [wCurrentDexMode]
	cp DEXMODE_OLD
	jr nz, .ok
	ld b, c
	ld a, [wDexListingCursor]
	or a
	jr nz, .ok
	ld c, 3
.ok
	call Pokedex_LoadCursorOAM
	pop bc
	ret

Pokedex_LoadCursorOAM: ; 412f1 (10:52f1)
	ld de, wSprites
.loop
	bit 7, [hl]
	jr nz, .special
	ld a, [wDexListingCursor]
	and $7
	swap a
	add [hl]
	add b
	inc hl
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	add c
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	jr .loop
.special
	ld a, [hli]
	cp $ff
	ret z
	ld c, 0
	jr .loop

Pokedex_PutScrollbarOAM: ; 4130e (10:530e)
; Writes the OAM data for the scrollbar in the new mode and ABC mode.
	push de
	ld a, [wDexListingEnd]
	dec a
	ld e, a
	ld a, [wDexListingCursor]
	ld hl, wDexListingScrollOffset
	add [hl]
	cp e
	jr z, .asm_4133f
	ld hl, $0
	ld bc, $79
	rst AddNTimes
	ld e, l
	ld d, h
	ld b, $0
	ld a, d
	or e
	jr z, .asm_41341
	ld a, [wDexListingEnd]
	ld c, a
.asm_41333
	ld a, e
	sub c
	ld e, a
	ld a, d
	sbc $0
	ld d, a
	jr c, .asm_41341
	inc b
	jr .asm_41333
.asm_4133f
	ld b, $79
.asm_41341
	ld a, $14
	add b
	pop hl
	ld [hli], a
	ld a, $a1
	ld [hli], a
	ld a, $f
	ld [hli], a
	ld [hl], $0
	ret

Pokedex_InitArrowCursor: ; 4134f (10:534f)
	xor a
	ld [wDexArrowCursorPosIndex], a
	ld [wDexArrowCursorDelayCounter], a
	ld [wDexArrowCursorBlinkCounter], a
	ret

Pokedex_MoveArrowCursor: ; 4135a (10:535a)
; bc = [de] - 1
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	dec a
	ld c, a
	inc de
	call Pokedex_BlinkArrowCursor

	ld hl, hJoyPressed
	ld a, [hl]
	and D_LEFT | D_UP
	and b
	jr nz, .move_left_or_up
	ld a, [hl]
	and D_RIGHT | D_DOWN
	and b
	jr nz, .move_right_or_down
	ld a, [hl]
	and SELECT
	and b
	jr nz, .select
	call Pokedex_ArrowCursorDelay
	jr c, .no_action
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT | D_UP
	and b
	jr nz, .move_left_or_up
	ld a, [hl]
	and D_RIGHT | D_DOWN
	and b
	jr nz, .move_right_or_down
	jr .no_action

.move_left_or_up
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr z, .no_action
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld hl, wDexArrowCursorPosIndex
	dec [hl]
	jr .update_cursor_pos

.move_right_or_down
	ld a, [wDexArrowCursorPosIndex]
	cp c
	jr nc, .no_action
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld hl, wDexArrowCursorPosIndex
	inc [hl]

.update_cursor_pos
	call Pokedex_GetArrowCursorPos
	ld [hl], "▶"
	ld a, 12
	ld [wDexArrowCursorDelayCounter], a
	xor a
	ld [wDexArrowCursorBlinkCounter], a
	scf
	ret

.no_action
	and a
	ret

.select
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld a, [wDexArrowCursorPosIndex]
	cp c
	jr c, .update
	ld a, -1
.update
	inc a
	ld [wDexArrowCursorPosIndex], a
	jr .update_cursor_pos

Pokedex_GetArrowCursorPos: ; 413d4 (10:53d4)
	ld a, [wDexArrowCursorPosIndex]
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Pokedex_BlinkArrowCursor: ; 413e0 (10:53e0)
	ld hl, wDexArrowCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and $8
	jr z, .blink_on
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ret

.blink_on
	call Pokedex_GetArrowCursorPos
	ld [hl], "▶"
	ret

Pokedex_ArrowCursorDelay: ; 413f5 (10:53f5)
; Updates the delay counter set when moving the arrow cursor.
; Returns whether the delay is active in carry.
	ld hl, wDexArrowCursorDelayCounter
	ld a, [hl]
	and a
	ret z

	dec [hl]
	scf
	ret

Pokedex_BlackOutBG: ; 41401 (10:5401)
; Make BG palettes black so that the BG becomes all black.
	call _Pokedex_JustBlackOutBG
	jp DelayFrame

_Pokedex_JustBlackOutBG:
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld hl, wUnknBGPals
if !DEF(MONOCHROME)
	ld bc, 8 palettes
	xor a
	call ByteFill
else
	ld b, (8 palettes) / 2
.mono_loop
	ld a, PAL_MONOCHROME_BLACK % $100
	ld [hli], a
	ld a, PAL_MONOCHROME_BLACK / $100
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc
	pop af
	ld [rSVBK], a
	ld a, $ff
	call DmgToCgbBGPals
	ld a, $ff
	jp DmgToCgbObjPal0

Pokedex_GetCGBLayout: ; 41423
	ld b, a
	call GetCGBLayout
	ld a, $e4
	call DmgToCgbBGPals
	ld a, $e0
	jp DmgToCgbObjPal0

Pokedex_LoadPointer: ; 41432
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Pokedex_LoadSelectedMonTiles: ; 4143b
; Loads the tiles of the currently selected Pokémon.
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	jr z, .QuestionMark
	call Pokedex_GetSelectedMon
	cp UNOWN
	jr z, .use_first_unown
	cp MAGIKARP
	jr z, .use_first_magikarp
	ld a, 1
	jr .continue
.use_first_unown
	ld a, [wFirstUnownSeen]
	jr .continue
.use_first_magikarp
	ld a, [wFirstMagikarpSeen]
.continue
	ld [wCurForm], a
	ld a, [wd265]
	ld [wCurPartySpecies], a
	call GetBaseData
	ld de, VTiles2
	predef GetFrontpic
	ret

.QuestionMark:
	ld a, BANK(sScratch)
	call GetSRAMBank
	ld hl, QuestionMarkLZ
	ld de, sScratch
	call Decompress
	ld hl, VTiles2
	ld de, sScratch
	ld c, 7 * 7
	ld a, [hROMBank]
	ld b, a
	call Get2bpp
	call CloseSRAM
	ret

Pokedex_LoadCurrentFootprint: ; 41478 (10:5478)
	call Pokedex_GetSelectedMon

Pokedex_LoadAnyFootprint: ; 4147b
	ld a, [wd265]
	dec a
	and ($ff ^ $07) ; $f8 ; $1f << 3
	srl a
	srl a
	srl a
	ld e, 0
	ld d, a
	ld a, [wd265]
	dec a
	and 7
	swap a ; * $10
	add a, a
	ld l, a
	ld h, 0
	add hl, de
	ld de, Footprints
	add hl, de

	ld e, l
	ld d, h
	ld hl, VTiles2 tile $65
	lb bc, BANK(Footprints), 4
	jp Request1bpp

Pokedex_LoadGFX:
	call DisableLCD
Pokedex_LoadGFX2:
	ld hl, VTiles2
	ld bc, $31 tiles
	xor a
	call ByteFill
	call LoadStandardFont
	call LoadFontsExtra
	ld hl, PokedexLZ
	ld de, VTiles2 tile $31
	call Decompress
	ld hl, PokedexSlowpokeLZ
	ld de, VTiles0
	call Decompress
	ld a, 6
	call SkipMusic
	jp EnableLCD

Pokedex_LoadUnownFont: ; 41a2c
	ld a, [wOptions2]
	ld [wOptionsBuffer], a
	and $ff - FONT_MASK
	or UNOWN_FONT
	ld [wOptions2], a
	jp LoadStandardFont

Pokedex_LoadUnownFrontpicTiles: ; 41a58 (10:5a58)
	ld a, [wCurForm]
	push af
	ld a, [wDexCurrentUnownIndex]
	ld e, a
	ld d, 0
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	ld [wCurForm], a
	ld a, UNOWN
	ld [wCurPartySpecies], a
	call GetBaseData
	ld de, VTiles2 tile $00
	predef GetFrontpic
	pop af
	ld [wCurForm], a
	ret

NewPokedexEntry: ; fb877
	ld a, [hMapAnims]
	push af
	ld a, [wOTPartyMon1Shiny]
	ld [wDexMonShiny], a
	xor a
	ld [hMapAnims], a
	call LowVolume
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	call ClearSprites
	ld a, [wPokedexStatus]
	push af
	ld a, [hSCX]
	add 5
	ld [hSCX], a
	xor a
	ld [wPokedexStatus], a
	call .NewPokedexEntry
	call WaitPressAorB_BlinkCursor
	ld a, $1
	ld [wPokedexStatus], a
	farcall DisplayDexEntry
	call WaitPressAorB_BlinkCursor
	pop af
	ld [wPokedexStatus], a
	call MaxVolume
	call ClearBGPalettes
	ld a, [hSCX]
	add -5
	ld [hSCX], a
	call .ReturnFromDexRegistration
	pop af
	ld [hMapAnims], a
	ret

.NewPokedexEntry:
	xor a
	ld [hBGMapMode], a
	farcall Pokedex_DrawDexEntryScreenRightEdge
	call Pokedex_ResetBGMapMode
	call DisableLCD
	call LoadStandardFont
	call LoadFontsExtra
	call Pokedex_LoadGFX2
	call Pokedex_LoadAnyFootprint
	ld a, [wd265]
	ld [wCurPartySpecies], a
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_DrawFootprint
	hlcoord 0, 17
	ld [hl], $3b
	inc hl
	ld bc, 19
	ld a, " "
	call ByteFill
	farcall DisplayDexEntry
	call EnableLCD
	call ApplyTilemapInVBlank
	call GetBaseData
	ld de, VTiles2
	predef GetFrontpic
	ld a, CGB_POKEDEX
	call Pokedex_GetCGBLayout
	ld a, [wCurPartySpecies]
	jp PlayCry

.ReturnFromDexRegistration:
	call ClearTileMap
	call LoadFontsExtra
	call LoadStandardFont
	call Pokedex_PlaceFrontpicTopLeftCorner
	call ApplyAttrAndTilemapInVBlank
	farcall GetEnemyMonDVs
	ld de, wTempMonDVs
	ld bc, 5
	rst CopyBytes
	ld b, CGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetCGBLayout
	jp SetPalettes
; fb8f1

Pokedex_SetBGMapMode3: ; 41ad7 (10:5ad7)
	ld a, $3
	jr Pokedex_SetBGMapMode

Pokedex_SetBGMapMode4: ; 41ae1 (10:5ae1)
	ld a, $4
Pokedex_SetBGMapMode:
	ld [hBGMapMode], a
	jp Delay2

Pokedex_ResetBGMapMode: ; 41af7
	xor a
	ld [hBGMapMode], a
	ret

PokedexLZ: ; 4150e
INCBIN "gfx/pokedex/pokedex.2bpp.lz"

PokedexSlowpokeLZ: ; 416b0
INCBIN "gfx/pokedex/slowpoke.2bpp.lz"

QuestionMarkLZ: ; 1de0e1
INCBIN "gfx/pokedex/question_mark.2bpp.lz"

Footprints: ; f9434
INCLUDE "gfx/footprints.asm"
; fb434
