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

Pokedex:
	ldh a, [hWX]
	ld l, a
	ldh a, [hWY]
	ld h, a
	push hl
	ldh a, [hSCX]
	push af
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a

	xor a
	ldh [hMapAnims], a
	call InitPokedex
	jr .handleLoop

.loop
	call Pokedex_RunJumptable
.handleLoop
	call DelayFrame
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr z, .loop

	ld de, SFX_READ_TEXT_2
	call PlaySFX
	call WaitSFX
	call ClearSprites
	ld a, [wCurDexMode]
	ld [wLastDexMode], a

	pop af
	ldh [hInMenu], a
	pop af
	ld [wVramState], a
	pop af
	ld [wOptions1], a
	pop af
	ldh [hSCX], a
	pop hl
	ld a, l
	ldh [hWX], a
	ld a, h
	ldh [hWY], a
	ret

InitPokedex:
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	call Pokedex_LoadGFX

	xor a
	ld [wJumptableIndex], a
	ld [wPrevDexEntryJumptableIndex], a
	ld [wPrevDexEntryBackup], a
	ld hl, wPokedexDataStart
	ld bc, wPokedexDataEnd - wPokedexDataStart
	rst ByteFill

	ld a, [wStatusFlags]
	and 1 << 1 ; ENGINE_UNOWN_DEX
	rra
	ld [wUnlockedUnownMode], a

	ld a, [wLastDexMode]
	ld [wCurDexMode], a

	call Pokedex_OrderMonsByMode
	call Pokedex_InitCursorPosition
	call GetCurrentLandmark
	ld [wDexCurLocation], a
	call Pokedex_DrawDexEntryScreenRightEdge
Pokedex_ResetBGMapMode:
	xor a
	ldh [hBGMapMode], a
	ret

Pokedex_InitCursorPosition:
	ld hl, wPokedexDataStart
	ld a, [wPrevDexEntry]
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

Pokedex_RunJumptable:
	call StandardStackJumpTable

.Jumptable:
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

Pokedex_Exit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Pokedex_InitMainScreen:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	xor a
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	rst ByteFill
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
	ldh [hSCX], a
	ld a, $47
	ldh [hWX], a
	xor a
	ldh [hWY], a
	call ApplyTilemapInVBlank

	call Pokedex_ResetBGMapMode
	xor a
	ld [wDexMonShiny], a
	dec a ; ld a, -1
	ld [wCurPartySpecies], a
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
Pokedex_IncrementDexPointer:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Pokedex_UpdateMainScreen:
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
	ldh [hBGMapMode], a
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
	ld [wPrevDexEntryJumptableIndex], a
	ret

.select
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_OPTION_SCR
	ld [wJumptableIndex], a
	xor a
	ldh [hSCX], a
	ld a, $a7
	ldh [hWX], a
	jp DelayFrame

.start
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_SEARCH_SCR
	ld [wJumptableIndex], a
	xor a
	ldh [hSCX], a
	ld a, $a7
	ldh [hWX], a
	jp DelayFrame

.b
	ld a, DEXSTATE_EXIT
	ld [wJumptableIndex], a
	ret

Pokedex_InitDexEntryScreen:
	call LowVolume
	xor a
	ld [wPokedexStatus], a
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_LoadCurrentFootprint
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_InitArrowCursor
	call Pokedex_GetSelectedMon
	ld [wPrevDexEntry], a
	farcall DisplayDexEntry
	call Pokedex_DrawFootprint
	call ApplyTilemapInVBlank
	ld a, $a7
	ldh [hWX], a
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	xor a
	ld [wDexMonShiny], a
	ld a, CGB_POKEDEX
	call Pokedex_GetCGBLayout
	ld a, [wCurPartySpecies]
	call PlayCry
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateDexEntryScreen:
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

.return_to_prev_screen
	ld a, [wLastVolume]
	and a
	jr z, .max_volume
	ld a, $77
	ld [wLastVolume], a
.max_volume
	call MaxVolume
	ld a, [wPrevDexEntryJumptableIndex]
	ld [wJumptableIndex], a
	ret

.do_menu_action
	ld a, [wDexArrowCursorPosIndex]
	call StackJumpTable

.DexEntryScreen_MenuActionJumptable:
	dw Pokedex_Page
	dw DexEntryScreen_Area
	dw DexEntryScreen_Cry
	dw DexEntryScreen_Shiny

Pokedex_Page:
	ld a, [wPokedexStatus]
	xor $1
	ld [wPokedexStatus], a
	call Pokedex_GetSelectedMon
	ld [wPrevDexEntry], a
	farcall DisplayDexEntry
	jp ApplyTilemapInVBlank

Pokedex_ReinitDexEntryScreen:
; Reinitialize the Pokédex entry screen after changing the selected mon.
	call Pokedex_BlackOutBG
	xor a
	ld [wPokedexStatus], a
	xor a
	ldh [hBGMapMode], a
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_InitArrowCursor
	call Pokedex_LoadCurrentFootprint
	call Pokedex_GetSelectedMon
	ld [wPrevDexEntry], a
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

DexEntryScreen_ArrowCursorData:
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

DexEntryScreen_Area:
	call Pokedex_BlackOutBG
	xor a
	ldh [hSCX], a
	;call DelayFrame
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call Pokedex_GetSelectedMon
	ld a, [wDexCurLocation]
	ld e, a
	farcall Pokedex_GetArea
	call Pokedex_BlackOutBG
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld a, $90
	ldh [hWY], a
	ld a, $5
	ldh [hSCX], a
	call DelayFrame
	call Pokedex_RedisplayDexEntry
	call Pokedex_LoadSelectedMonTiles
	call ApplyTilemapInVBlank
	call Pokedex_GetSelectedMon
	ld [wCurPartySpecies], a
	ld a, CGB_POKEDEX
	jp Pokedex_GetCGBLayout

DexEntryScreen_Cry:
	ld a, [wCurPartySpecies]
	jp PlayCry

DexEntryScreen_Shiny:
	ld hl, wDexMonShiny
	ld a, [hl]
	xor SHINY_MASK ; alternate 0 and SHINY_MASK
	ld [hl], a
	ld a, CGB_POKEDEX
	jp Pokedex_GetCGBLayout

Pokedex_RedisplayDexEntry:
	call Pokedex_LoadGFX
	call Pokedex_LoadAnyFootprint
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_GetSelectedMon
	farcall DisplayDexEntry
	jp Pokedex_DrawFootprint

Pokedex_InitOptionScreen:
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	call Pokedex_DrawOptionScreenBG
	call Pokedex_InitArrowCursor
	ld a, [wCurDexMode]
	ld [wDexArrowCursorPosIndex], a
	call Pokedex_DisplayModeDescription
	call ApplyTilemapInVBlank
	ld a, CGB_POKEDEX_SEARCH_OPTION
	call Pokedex_GetCGBLayout
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateOptionScreen:
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
	ret z
	ld a, [wDexArrowCursorPosIndex]
	call StackJumpTable

.MenuActionJumptable:
	dw .MenuAction_NewMode
	dw .MenuAction_OldMode
	dw .MenuAction_ABCMode
	dw .MenuAction_UnownMode

.return_to_main_screen
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.NoUnownModeArrowCursorData:
	db D_UP | D_DOWN, 3
	dwcoord 2,  4
	dwcoord 2,  6
	dwcoord 2,  8

.ArrowCursorData:
	db D_UP | D_DOWN, 4
	dwcoord 2,  4
	dwcoord 2,  6
	dwcoord 2,  8
	dwcoord 2, 10

.MenuAction_NewMode:
	ld b, DEXMODE_NEW
	jr .ChangeMode

.MenuAction_OldMode:
	ld b, DEXMODE_OLD
	jr .ChangeMode

.MenuAction_ABCMode:
	ld b, DEXMODE_ABC

.ChangeMode:
	ld a, [wCurDexMode]
	cp b
	jr z, .skip_changing_mode ; Skip if new mode is same as current.

	ld a, b
	ld [wCurDexMode], a
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

.MenuAction_UnownMode:
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_UNOWN_MODE
	ld [wJumptableIndex], a
	ret

Pokedex_InitSearchScreen:
	xor a
	ldh [hBGMapMode], a
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

Pokedex_UpdateSearchScreen:
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
	call StackJumpTable

.MenuActionJumptable:
	dw .MenuAction_MonSearchType
	dw .MenuAction_MonSearchType
	dw .MenuAction_BeginSearch
	dw .MenuAction_Cancel

.cancel
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.ArrowCursorData:
	db D_UP | D_DOWN, 4
	dwcoord 2, 4
	dwcoord 2, 6
	dwcoord 2, 13
	dwcoord 2, 15

.MenuAction_MonSearchType:
	call Pokedex_NextSearchMonType
	jp Pokedex_PlaceSearchScreenTypeStrings

.MenuAction_BeginSearch:
	call Pokedex_SearchForMons
	farcall AnimateDexSearchSlowpoke
	ld a, [wDexSearchResultCount]
	and a
	jr nz, .show_search_results

; No mon with matching types was found.
	call Pokedex_OrderMonsByMode
	call Pokedex_DisplayTypeNotFoundMessage
	xor a
	ldh [hBGMapMode], a
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
	ld a, [wPrevDexEntry]
	ld [wPrevDexEntryBackup], a
	xor a
	ld [wDexListingScrollOffset], a
	ld [wDexListingCursor], a
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_SEARCH_RESULTS_SCR
	ld [wJumptableIndex], a
	ret

.MenuAction_Cancel:
	call Pokedex_BlackOutBG
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

Pokedex_InitSearchResultsScreen:
	xor a
	ldh [hBGMapMode], a
	xor a
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
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
	ldh [hSCX], a
	ld a, $4a
	ldh [hWX], a
	xor a
	ldh [hWY], a
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

Pokedex_UpdateSearchResultsScreen:
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
	ldh [hBGMapMode], a
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
	ld [wPrevDexEntryJumptableIndex], a
	ret

.return_to_search_screen
	ld a, [wDexListingScrollOffsetBackup]
	ld [wDexListingScrollOffset], a
	ld a, [wDexListingCursorBackup]
	ld [wDexListingCursor], a
	ld a, [wPrevDexEntryBackup]
	ld [wPrevDexEntry], a
	call Pokedex_BlackOutBG
	call ClearSprites
	call Pokedex_OrderMonsByMode
	ld a, DEXSTATE_SEARCH_SCR
	ld [wJumptableIndex], a
	xor a
	ldh [hSCX], a
	ld a, $a7
	ldh [hWX], a
	ret

Pokedex_InitUnownMode:
	call Pokedex_LoadUnownFont
	call Pokedex_DrawUnownModeBG
	xor a
	ld [wDexCurUnownIndex], a
	call Pokedex_LoadUnownFrontpicTiles
	call Pokedex_UnownModePlaceCursor
	farcall PrintUnownWord
	call ApplyTilemapInVBlank
	ld a, CGB_POKEDEX_UNOWN_MODE
	call Pokedex_GetCGBLayout
	jp Pokedex_IncrementDexPointer

Pokedex_UpdateUnownMode:
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
	ld de, vTiles2 tile $31
	lb bc, BANK(PokedexLZ), $34
	jp DecompressRequest2bpp

Pokedex_UnownModeHandleDPadInput:
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
	ld hl, wDexCurUnownIndex
	ld a, [hl]
	inc a
	cp e
	ret nc
	ld a, [hl]
	inc [hl]
	jr .update

.left
	ld hl, wDexCurUnownIndex
	ld a, [hl]
	and a
	ret z
	ld a, [hl]
	dec [hl]

.update
	push af
	xor a
	ldh [hBGMapMode], a
	pop af
	call Pokedex_UnownModeEraseCursor
	call Pokedex_LoadUnownFrontpicTiles
	call Pokedex_UnownModePlaceCursor
	farcall PrintUnownWord
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jp DelayFrame

Pokedex_UnownModeEraseCursor:
	ld c, " "
	jr Pokedex_UnownModeUpdateCursorGfx

Pokedex_UnownModePlaceCursor:
	ld a, [wDexCurUnownIndex]
	ld c, "." ; diamond cursor

Pokedex_UnownModeUpdateCursorGfx:
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

Pokedex_NextOrPreviousDexEntry:
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
	jr z, .down

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

Pokedex_ListingHandleDPadInput:
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

Pokedex_ListingMoveCursorUp:
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

Pokedex_ListingMoveCursorDown:
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

Pokedex_ListingMoveUpOnePage:
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

Pokedex_ListingMoveDownOnePage:
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

Pokedex_ListingPosStayedSame:
	and a
	ret

Pokedex_ListingPosChanged:
	scf
	ret

Pokedex_FillColumn:
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

Pokedex_DrawMainScreenBG:
; Draws the left sidebar and the bottom bar on the main screen.
	hlcoord 0, 17
	ld de, String_START_SEARCH
	call Pokedex_PlaceString
	ld a, $32
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
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
PlaceFrontpicTopLeftCorner:
	hlcoord 1, 1
PlaceFrontpicAtHL:
	ld de, SCREEN_WIDTH
	xor a
	ld b, 7
.row
	ld c, 7
	push af
	push hl
.col
	ld [hli], a
	add 7
	dec c
	jr nz, .col
	pop hl
	add hl, de
	pop af
	inc a
	dec b
	jr nz, .row
	ret

String_SEEN:
	rawchar "Seen", $ff
String_OWN:
	rawchar "Own", $ff
String_SELECT_OPTION:
;	db $3b, $48, $49, $4a, $44, $45, $46, $47 ; SELECT > OPTION
	db $3b, $41, $42, $43, $44, $45, $46, $47
String_START_SEARCH:
;	db $3c, $3b, $41, $42, $43, $4b, $4c, $4d, $4e, $3c, $ff ; START > SEARCH
	db $48, $3b, $49, $4a, $4b, $4c, $4d, $4e, $5d, $5e, $ff

Pokedex_DrawDexEntryScreenBG:
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
	rst ByteFill
	hlcoord 1, 17
	ld bc, 18
	ld a, " "
	rst ByteFill
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
	jp PlaceFrontpicTopLeftCorner

.HeightImperial:
	rawchar "Ht  ?′??″", $ff ; HT  ?'??"
.WeightImperial:
	rawchar "Wt   ???lb", $ff ; WT   ???lb
.HeightMetric:
	rawchar "Ht   ???m", $ff ; HT   ???m"
.WeightMetric:
	rawchar "Wt   ???kg", $ff ; WT   ???kg
.MenuItems:
	rawchar $3b, " Page Area Cry     ", $ff
.MenuItemsShinyCharm:
	rawchar $3b, " Page Area Cry Shny", $ff

Pokedex_DrawDexEntryScreenRightEdge:
	ldh a, [hBGMapAddress]
	ld l, a
	ldh a, [hBGMapAddress + 1]
	ld h, a
	push hl
	inc hl
	ld a, l
	ldh [hBGMapAddress], a
	ld a, h
	ldh [hBGMapAddress + 1], a
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
	ldh [hBGMapAddress], a
	ld a, h
	ldh [hBGMapAddress + 1], a
	ret

Pokedex_DrawOptionScreenBG:
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
	rst PlaceString
	ld a, [wUnlockedUnownMode]
	and a
	ret z
	hlcoord 3, 10
	ld de, .UnownMode
	rst PlaceString
	ret

.Title:
	rawchar $3b, " Option ", $3c, $ff

.Modes:
	db   "Johto Mode"
	next "National Mode"
	next "A to Z Mode@"

.UnownMode:
	db "Unown Mode@"

Pokedex_DrawSearchScreenBG:
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
	rst PlaceString
	hlcoord 3, 13
	ld de, .Menu
	rst PlaceString
	ret

.Title:
	rawchar $3b, " Search ", $3c, $ff

.TypeLeftRightArrows:
	db $3d, "        ▷", $ff

.Types:
	db   "Type1"
	next "Type2@"

.Menu:
	db   "Begin Search!"
	next "Cancel@"

Pokedex_DrawSearchResultsScreenBG:
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 0
	lb bc, 7, 7
	call Pokedex_PlaceBorder
	hlcoord 0, 11
	lb bc, 5, 18
	call Pokedex_PlaceBorder
	hlcoord 1, 12
	ld de, .BottomWindowText
	rst PlaceString
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
	jp PlaceFrontpicTopLeftCorner

.BottomWindowText:
	db   "Search Results"
	next "  Type/"
	next "    found!@"

Pokedex_PlaceSearchResultsTypeStrings:
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

Pokedex_DrawUnownModeBG:
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
	call PlaceFrontpicAtHL
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

UnownModeLetterAndCursorCoords:
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

Pokedex_DrawListWindow:
	ld a, $32
	hlcoord 0, 17
	ld bc, 12
	rst ByteFill
	hlcoord 0, 1
	lb bc, 15, 11
	call ClearBox
	ld a, $34
	hlcoord 0, 0
	ld bc, 11
	rst ByteFill
	ld a, $39
	hlcoord 0, 16
	ld bc, 11
	rst ByteFill
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

Pokedex_DrawSearchResultsWindow:
	ld a, $34
	hlcoord 0, 0
	ld bc, 11
	rst ByteFill
	ld a, $39
	hlcoord 0, 10
	ld bc, 11
	rst ByteFill
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
	rst ByteFill
	ld a, $39
	hlcoord 0, 17
	ld bc, 11
	rst ByteFill
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
	rst PlaceString
	ret

.esults_D
; (SEARCH R)
	db   "esults<NEXT>"
; (### FOUN)
	next "d!@"

Pokedex_FillBackgroundColor2:
	hlcoord 0, 0
	ld a, $32
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
	ret

Pokedex_PlaceString:
.loop
	ld a, [de]
	cp -1
	ret z
	inc de
	ld [hli], a
	jr .loop

Pokedex_PlaceBorder:
	push hl
	ld a, $33
	ld [hli], a
	ld d, $34
	call .FillRow
	ld [hl], $35
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
.loop
	push hl
	ld a, $36
	ld [hli], a
	ld d, $7f
	call .FillRow
	ld [hl], $37
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .loop
	ld a, $38
	ld [hli], a
	ld d, $39
	call .FillRow
	ld [hl], $3a
	ret

.FillRow:
	ld e, c
.row_loop
	ld a, e
	and a
	ret z
	ld a, d
	ld [hli], a
	dec e
	jr .row_loop

Pokedex_PrintListing:
; Prints the list of Pokémon on the main Pokédex screen.

; Clear (2 * [wDexListingHeight] + 1) by 11 box starting at 0,1
	hlcoord 0, 1
	ld a, [wDexListingHeight]
	add a
	inc a
	ld b, a
	ld c, 11
	call ClearBox

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

.PrintEntry:
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
	rst PlaceString
	ret

Pokedex_PrintNumberIfOldMode:
	ld a, [wCurDexMode]
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

Pokedex_PlaceCaughtSymbolIfCaught:
	call Pokedex_CheckCaught
	jr nz, .place_caught_symbol
	inc hl
	ret

.place_caught_symbol
	ld a, $4f
	ld [hli], a
	ret

Pokedex_PlaceDefaultStringIfNotSeen:
	call Pokedex_CheckSeen
	ret nz
	inc hl
	ld de, .NameNotSeen
	rst PlaceString
	scf
	ret

.NameNotSeen:
	db "-----@"

Pokedex_DrawFootprint:
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

Pokedex_GetSelectedMon:
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

Pokedex_CheckCaught:
	push de
	push hl
	ld a, [wd265]
	dec a
	call CheckCaughtMon
	pop hl
	pop de
	ret

Pokedex_CheckSeen:
	push de
	push hl
	ld a, [wd265]
	dec a
	call CheckSeenMon
	pop hl
	pop de
	ret

Pokedex_OrderMonsByMode:
	ld hl, wPokedexDataStart
	ld bc, wPokedexMetadata - wPokedexDataStart
	xor a
	rst ByteFill
	ld a, [wCurDexMode]
	call StackJumpTable

.Jumptable:
	dw .NewMode
	dw .OldMode
	dw Pokedex_ABCMode

.NewMode:
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

.OldMode:
	ld hl, wPokedexDataStart
	ld a, $1
	ld c, NUM_POKEMON
.loopold
	ld [hli], a
	inc a
	dec c
	jr nz, .loopold
	; fallthrough

.FindLastSeen:
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

Pokedex_ABCMode:
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

Pokedex_DisplayModeDescription:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld a, [wDexArrowCursorPosIndex]
	ld hl, .Modes
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 1, 14
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret

.Modes:
	dw .NewMode
	dw .OldMode
	dw .ABCMode
	dw .UnownMode

.NewMode:
	db   "<PK><MN> are listed in"
	next "regional order.@"

.OldMode:
	db   "<PK><MN> are listed in"
	next "national order.@"

.ABCMode:
	db   "<PK><MN> are listed"
	next "alphabetically.@"

.UnownMode:
	db   "Unown are listed"
	next "in order caught.@"

Pokedex_DisplayChangingModesMessage:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld de, String_ChangingModesPleaseWait
	hlcoord 1, 14
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 64
	call DelayFrames
	ld de, SFX_CHANGE_DEX_MODE
	call PlaySFX
	ld c, 64
	jp DelayFrames

String_ChangingModesPleaseWait:
	db   "Changing modes."
	next "Please wait.@"

Pokedex_UpdateSearchMonType:
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

Pokedex_PrevSearchMonType:
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

Pokedex_NextSearchMonType:
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

Pokedex_PlaceSearchScreenTypeStrings:
	xor a
	ldh [hBGMapMode], a
	hlcoord 9, 3
	lb bc, 4, 8
	call ClearBox
	ld a, [wDexSearchMonType1]
	hlcoord 9, 4
	call Pokedex_PlaceTypeString
	ld a, [wDexSearchMonType2]
	hlcoord 9, 6
	call Pokedex_PlaceTypeString
	ld a, $1
	ldh [hBGMapMode], a
	ret

Pokedex_PlaceTypeString:
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
	rst PlaceString
	ret

INCLUDE "data/types/search_strings.asm"

Pokedex_SearchForMons:
	ld a, [wDexSearchMonType2]
	and a
	call nz, .Search
	ld a, [wDexSearchMonType1]
	and a
	call nz, .Search
	ret

.Search:
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
	xor a
	ld [wCurForm], a
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

Pokedex_DisplayTypeNotFoundMessage:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld de, .TypeNotFound
	hlcoord 1, 14
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ld c, $80
	jp DelayFrames

.TypeNotFound:
	db   "The specified type"
	next "was not found.@"

Pokedex_UpdateCursorOAM:
	ld hl, .CursorOAM
	call Pokedex_UpdateCursor
	jp Pokedex_PutScrollbarOAM

.CursorOAM:
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
	ld a, [wCurDexMode]
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

Pokedex_LoadCursorOAM:
	ld de, wVirtualOAM
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

Pokedex_PutScrollbarOAM:
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

Pokedex_InitArrowCursor:
	xor a
	ld [wDexArrowCursorPosIndex], a
	ld [wDexArrowCursorDelayCounter], a
	ld [wDexArrowCursorBlinkCounter], a
	ret

Pokedex_MoveArrowCursor:
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

Pokedex_GetArrowCursorPos:
	ld a, [wDexArrowCursorPosIndex]
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Pokedex_BlinkArrowCursor:
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

Pokedex_ArrowCursorDelay:
; Updates the delay counter set when moving the arrow cursor.
; Returns whether the delay is active in carry.
	ld hl, wDexArrowCursorDelayCounter
	ld a, [hl]
	and a
	ret z

	dec [hl]
	scf
	ret

Pokedex_BlackOutBG:
; Make BG palettes black so that the BG becomes all black.
	call _Pokedex_JustBlackOutBG
	jp DelayFrame

_Pokedex_JustBlackOutBG:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, wBGPals1
if !DEF(MONOCHROME)
	ld bc, 8 palettes
	xor a ; RGB 00,00,00
	rst ByteFill
else
	ld b, (8 palettes) / 2
.mono_loop
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc
	pop af
	ldh [rSVBK], a
	ld a, $ff
	call DmgToCgbBGPals
	ld a, $ff
	jp DmgToCgbObjPal0

Pokedex_GetCGBLayout:
	call GetCGBLayout
	ld a, $e4
	call DmgToCgbBGPals
	ld a, $e0
	jp DmgToCgbObjPal0

Pokedex_LoadSelectedMonTiles:
; Loads the tiles of the currently selected Pokémon.
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	jr z, .QuestionMark
	call Pokedex_GetSelectedMon
	cp UNOWN
	jr z, .use_first_unown
	cp MAGIKARP
	jr z, .use_first_magikarp
	ld a, PLAIN_FORM
	jr .continue
.use_first_unown
	ld a, [wFirstUnownSeen]
	jr .continue
.use_first_magikarp
	ld a, [wFirstMagikarpSeen]
.continue
	ld [wCurForm], a
	ld [wDexMonForm], a
	ld a, [wd265]
	ld [wCurPartySpecies], a
	call GetBaseData
	ld de, vTiles2
	predef_jump GetFrontpic

.QuestionMark:
	ld a, BANK(sScratch)
	call GetSRAMBank
	ld hl, QuestionMarkLZ
	ld de, sScratch
	call Decompress
	ld hl, vTiles2
	ld de, sScratch
	ld c, 7 * 7
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	jp CloseSRAM

Pokedex_LoadCurrentFootprint:
	call Pokedex_GetSelectedMon

Pokedex_LoadAnyFootprint:
	ld a, [wd265]
	dec a
	and ($ff ^ $07) ; $f8 ; $1f << 3
	rrca
	rrca
	rrca
	and %00011111
	ld e, 0
	ld d, a
	ld a, [wd265]
	dec a
	and 7
	swap a ; * $10
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld de, Footprints
	add hl, de

	ld e, l
	ld d, h
	ld hl, vTiles2 tile $65
	lb bc, BANK(Footprints), 4
	jp Request1bpp

Pokedex_LoadGFX:
	call DisableLCD
Pokedex_LoadGFX2:
	ld hl, vTiles2
	ld bc, $31 tiles
	xor a
	rst ByteFill
	call LoadStandardFont
	call LoadFontsExtra
	ld hl, PokedexLZ
	ld de, vTiles2 tile $31
	call Decompress
	ld hl, PokedexSlowpokeLZ
	ld de, vTiles0
	call Decompress
	ld a, 6
	call SkipMusic
	jp EnableLCD

Pokedex_LoadUnownFont:
	ld a, [wOptions2]
	ld [wOptionsBuffer], a
	and $ff - FONT_MASK
	or UNOWN_FONT
	ld [wOptions2], a
	jp LoadStandardFont

Pokedex_LoadUnownFrontpicTiles:
	ld a, [wCurForm]
	push af
	ld a, [wDexCurUnownIndex]
	ld e, a
	ld d, 0
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	ld [wCurForm], a
	ld a, UNOWN
	ld [wCurPartySpecies], a
	call GetBaseData
	ld de, vTiles2 tile $00
	predef GetFrontpic
	pop af
	ld [wCurForm], a
	ret

NewPokedexEntry:
	ldh a, [hMapAnims]
	push af
	ld a, [wOTPartyMon1Shiny]
	ld [wDexMonShiny], a
	xor a
	ldh [hMapAnims], a
	call LowVolume
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	call ClearSprites
	ld a, [wPokedexStatus]
	push af
	ldh a, [hSCX]
	add 5
	ldh [hSCX], a
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
	ldh a, [hSCX]
	add -5
	ldh [hSCX], a
	call .ReturnFromDexRegistration
	pop af
	ldh [hMapAnims], a
	ret

.NewPokedexEntry:
	xor a
	ldh [hBGMapMode], a
	call Pokedex_DrawDexEntryScreenRightEdge
	call Pokedex_ResetBGMapMode
	call DisableLCD
	call LoadStandardFont
	call LoadFontsExtra
	call Pokedex_LoadGFX2
	call Pokedex_LoadAnyFootprint
	ld a, [wd265]
	ld [wCurPartySpecies], a
	ld a, [wCurForm]
	ld [wDexMonForm], a
	call Pokedex_DrawDexEntryScreenBG
	call Pokedex_DrawFootprint
	hlcoord 0, 17
	ld [hl], $3b
	inc hl
	ld bc, 19
	ld a, " "
	rst ByteFill
	farcall DisplayDexEntry
	call EnableLCD
	call ApplyTilemapInVBlank
	call GetBaseData
	ld de, vTiles2
	predef GetFrontpic
	ld a, CGB_POKEDEX
	call Pokedex_GetCGBLayout
	ld a, [wCurPartySpecies]
	jp PlayCry

.ReturnFromDexRegistration:
	call ClearTileMap
	call LoadFontsExtra
	call LoadStandardFont
	call PlaceFrontpicTopLeftCorner
	call ApplyAttrAndTilemapInVBlank
	farcall GetEnemyMonDVs
	ld de, wTempMonDVs
	ld bc, 5
	rst CopyBytes
	ld a, CGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetCGBLayout
	jp SetPalettes

Pokedex_SetBGMapMode3:
	ld a, $3
	jr Pokedex_SetBGMapMode

Pokedex_SetBGMapMode4:
	ld a, $4
Pokedex_SetBGMapMode:
	ldh [hBGMapMode], a
	jp Delay2

PokedexLZ:
INCBIN "gfx/pokedex/pokedex.2bpp.lz"

PokedexSlowpokeLZ:
INCBIN "gfx/pokedex/slowpoke.2bpp.lz"

QuestionMarkLZ:
INCBIN "gfx/pokedex/question_mark.2bpp.lz"

Footprints:
INCLUDE "gfx/pokemon/footprints.asm"
