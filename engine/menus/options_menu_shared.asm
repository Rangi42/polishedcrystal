DEF OPTIONS_SHARED_VALUE_OFFSET EQU 9

; Edge tile graphics shared by both menus
OptionsShared_LoadEdgeTiles:
	ld hl, .BGTiles
	ld de, vTiles2 tile $00
	lb bc, BANK(.BGTiles), 3
	jmp DecompressRequest2bpp

.BGTiles:
	INCBIN "gfx/options/edge.2bpp.lzp"

; Draw left/right edge tiles and set palette attributes
OptionsShared_DrawEdges:
	hlcoord 0, 0
	ld a, $01 ; left edge tile
	ld bc, SCREEN_WIDTH - 2
	ld d, TEXTBOX_Y
.edge_loop
	ld [hli], a
	inc a ; $02 = right edge tile
	add hl, bc
	ld [hli], a
	dec a ; $01 = left edge tile
	dec d
	jr nz, .edge_loop
	ret

; Shared main loop for both options menus.
; Caller must set wOptionsMenuIsInitial and call CopyMenuHeader before calling this.
OptionsShared_RunLoop:
	ld a, $ff
	ld [wOptionsMenuLastSelection], a

	call OptionsShared_DrawEdges

	ld a, 1
	ld [wMenuCursorY], a

.loop
	ld hl, wMenuCursorBuffer
	ld a, [wMenuCursorY]
	ld [hli], a
	xor a
	ld [hl], a

	call ScrollingMenu
	ld a, TRUE
	ldh [hInMenu], a

	ld a, [wMenuJoypad]
	cp PAD_B
	jr z, .exit
	cp PAD_START
	jr z, .exit
	cp PAD_LEFT
	jr z, .apply_left
	cp PAD_RIGHT
	jr z, .apply_right
	cp PAD_A
	jr nz, .loop

.advance_description
	call .DispatchAdvanceDesc
	call OptionsShared_DrawEdges
	call ApplyAttrAndTilemapInVBlank
	jr .loop

.apply_left
	ldh a, [hJoyPressed]
	and PAD_LEFT
	jr z, .loop
	ld a, PAD_LEFT
	jr .apply_left_right

.apply_right
	ldh a, [hJoyPressed]
	and PAD_RIGHT
	jr z, .loop
	ld a, PAD_RIGHT
	; fallthrough
.apply_left_right
	push af ; save direction (PAD_LEFT or PAD_RIGHT)
	call OptionsShared_SetValueCoordFromCursor
	call OptionsShared_SetSelectionFromCursor
	ld a, [wMenuSelection]
	and a ; 0?
	jr z, .skip_left_right
	inc a ; -1?
	jr z, .skip_left_right
	pop bc ; restore direction into B
	ldh a, [hJoyPressed]
	push af
	ld a, b
	ldh [hJoyPressed], a
	call OptionsShared_DispatchCallRoutine
	call ApplyTilemapInVBlank
	pop af
	ldh [hJoyPressed], a
	xor a
	ldh [hJoyPressed], a
	call OptionsShared_WaitDPadRelease
	jr .loop

.skip_left_right
	pop af ; discard saved direction
	jr .loop

.exit
	ld a, [wOptionsMenuIsInitial]
	and a
	jr z, .common_exit
	ld hl, wInitialOptions2
	res RESET_INIT_OPTS, [hl]
.common_exit
	ld de, SFX_TRANSACTION
	call PlaySFX
	jmp WaitSFX

.DispatchAdvanceDesc:
	ld a, [wOptionsMenuIsInitial]
	and a
	jmp z, OptionsMenu_AdvanceSelectionDescription
	jmp OptionsShared_SimpleAdvanceDescription

OptionsShared_DispatchCallRoutine:
	ld a, [wOptionsMenuIsInitial]
	and a
	jmp z, OptionsMenu_CallOptionRoutine
	jmp InitialOptions_CallOptionRoutine

; Dispatch to the correct description table based on menu type
OptionsShared_DispatchLookupDescription:
	ld a, [wOptionsMenuIsInitial]
	and a
	ld hl, InitialOptionDescriptions - 2 * 2
	ld de, InitialOptionsDoneDescription
	jr nz, .lookup
	ld hl, OptionsDescriptions - 2 * 2
	ld de, OptionsDoneDescription
.lookup
	call OptionsShared_LookupString
	ld h, d
	ld l, e
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	ld de, wDecompressScratch
	call DecompressStringToRAM
	pop af
	ldh [rWBK], a
	ld hl, wDecompressScratch
	ld a, l
	ld [wOptionsMenuDescriptionAddr], a
	ld a, h
	ld [wOptionsMenuDescriptionAddr + 1], a
	xor a ; OPTDESCSTATE_PAGE
	ld [wOptionsMenuDescriptionState], a
	ret

; Shared PlaceOptionName callback for ScrollingMenu.
; Dispatches on wOptionsMenuIsInitial to select the correct name table.
OptionsShared_PlaceOptionName:
	push de
	ld a, [wOptionsMenuIsInitial]
	and a
	ld hl, InitialOptionNames - 2 * 2
	jr nz, .lookup
	ld hl, OptionNames - 2 * 2
.lookup
	ld de, .Done
	call OptionsShared_LookupString
	pop hl
	rst PlaceString
	ret

.Done:
	db "Done@"

; Shared routine to look up the 1-indexed [wMenuSelection] from a `- 2 * 2`
; offset pointer table in HL.
; Returns the lookup result in DE, with DE initialized to the -1 "done" value.
OptionsShared_LookupString:
	ld a, [wMenuSelection]
	inc a ; -1?
	ret z
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret

; Shared PlaceOptionValue callback for ScrollingMenu.
; Dispatches on wOptionsMenuIsInitial to call the correct option routine.
OptionsShared_PlaceOptionValue:
	ld a, [wMenuSelection]
	inc a ; -1?
	ret z
	ld hl, SCREEN_WIDTH
	add hl, de
	call OptionsShared_StartValue
	ldh a, [hJoyPressed]
	push af
	xor a
	ldh [hJoyPressed], a
	call OptionsShared_DispatchCallRoutine
	pop af
	ldh [hJoyPressed], a
	ret

; Shared ResetSelectionDescription callback for ScrollingMenu.
; Called by function 3 on every ScrollingMenu init.
; Skip if selection hasn't changed (avoids resetting description on A press).
OptionsShared_ResetSelectionDescription:
	ld a, [wMenuSelection]
	ld hl, wOptionsMenuLastSelection
	cp [hl]
	ret z
	ld [hl], a

	call OptionsShared_DispatchLookupDescription
	call SetUpTextbox
	ld a, [wOptionsMenuIsInitial]
	and a
	jmp nz, OptionsShared_PlaceDescriptionTextInstantly
	call OptionsMenu_GetTextSpeedFlag
	jmp OptionsShared_PlaceDescriptionText

; Simple advance description (for InitialOptions, and non-TextSpeed options)
OptionsShared_SimpleAdvanceDescription:
	ld a, [wOptionsMenuDescriptionState]
	cp OPTDESCSTATE_DONE
	call z, OptionsShared_DispatchLookupDescription
	jmp OptionsShared_PlaceDescriptionTextInstantly

OptionsShared_SetSelectionFromCursor:
	ld a, [wMenuCursorY]
	dec a
	ld b, a
	ld a, [wMenuScrollPosition]
	add b
	ld [wMenuSelection], a
	ld c, a
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMenuData_ItemsPointerBank]
	ld b, a
	call GetFarByte
	ld d, a
	ld a, c
	cp d
	jr c, .valid_index
	ld a, -1
	ld [wMenuSelection], a
	ret

.valid_index
	inc hl ; skip count byte
	ld a, [wMenuData_ScrollingMenuSpacing]
	cp SCROLLINGMENU_ITEMS_QUANTITY
	ld a, 1
	jr nz, .got_stride
	inc a ; 2
.got_stride
	push bc
	ld b, 0
	ld c, a
	ld a, [wMenuSelection]
	rst AddNTimes
	pop af ; a = bank
	call GetFarByte
	ld [wMenuSelection], a
	ret

OptionsShared_SetValueCoordFromCursor:
	call MenuBoxCoord2Tile
	ld a, [wMenuFlags]
	bit 7, a
	ld bc, SCREEN_WIDTH + 1
	jr z, .gotOffset
	ld c, 1
.gotOffset
	add hl, bc
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wMenuCursorY]
	dec a
	rst AddNTimes
	ld bc, SCREEN_WIDTH + OPTIONS_SHARED_VALUE_OFFSET
	add hl, bc
	; fallthrough
OptionsShared_StartValue:
	ld a, l
	ld [wOptionsMenuValueCoord], a
	ld a, h
	ld [wOptionsMenuValueCoord + 1], a
	; Place ":" prefix immediately before the value.
	dec hl
	ld a, ':'
	ld [hli], a
	ret

OptionsShared_WaitDPadRelease:
.loop
	call JoyTextDelay
	ldh a, [hJoyDown]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .loop
	ret

OptionsShared_GetValueCoord:
	ld hl, wOptionsMenuValueCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

OptionsShared_PlaceStringAtValueCoord:
	call OptionsShared_GetValueCoord
	rst PlaceString
	and a
	ret

OptionsShared_PlaceDescriptionTextInstantly:
	ld c, FALSE
OptionsShared_PlaceDescriptionText:
; Display the current description page non-blockingly.
; Text from wOptionsMenuDescriptionAddr is in wDecompressScratch (uncompressed).
; Input: C = 0 for instant text, C != 0 to use configured text speed
	push bc

	ld a, [wOptions1]
	push af
	ld a, [wTextboxFlags]
	push af

	ld hl, wTextboxFlags
	set NO_TEXT_PAUSE_F, [hl]

	ld a, c
	and a
	jr nz, .useConfiguredSpeed
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
	jr .placeText

.useConfiguredSpeed
	ld hl, wTextboxFlags
	set FAST_TEXT_DELAY_F, [hl]

.placeText
	call UnloadBlinkingCursor

	; If continuing from <CONT>, scroll existing line 2 up to line 1.
	ld a, [wOptionsMenuDescriptionState]
	assert OPTDESCSTATE_SCROLL == 1
	dec a
	jr nz, .noScroll
	call Text_WaitBGMap
	call TextScroll
	call TextScroll
.noScroll

	ld hl, wOptionsMenuDescriptionAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOptionsMenuDescriptionState]
	ld b, a

	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a

	ld a, b
	assert OPTDESCSTATE_SCROLL == 1
	dec a
	jr nz, .wholeBox
	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	call PlaceWholeStringInBoxAtOnce
	jr .placed

.wholeBox
	call PrintTextNoBox

.placed
	ld a, [hli]
	ld b, a ; b = stop char
	ld d, h ; de = resume position
	ld e, l

	pop af
	ldh [rWBK], a

	ld a, b
	cp '<PARA>'
	jr z, .morePara
	cp '<CONT>'
	jr z, .moreCont

	ld a, OPTDESCSTATE_DONE
	ld [wOptionsMenuDescriptionState], a
	jr .restore

.morePara
	ld a, e
	ld [wOptionsMenuDescriptionAddr], a
	ld a, d
	ld [wOptionsMenuDescriptionAddr + 1], a
	xor a ; OPTDESCSTATE_PAGE
	ld [wOptionsMenuDescriptionState], a
	jr .showCursor

.moreCont
	ld a, e
	ld [wOptionsMenuDescriptionAddr], a
	ld a, d
	ld [wOptionsMenuDescriptionAddr + 1], a
	ld a, OPTDESCSTATE_SCROLL
	ld [wOptionsMenuDescriptionState], a
.showCursor
	call LoadBlinkingCursor
.restore
	pop af
	ld [wTextboxFlags], a
	pop af
	ld [wOptions1], a
	pop bc
	jmp ApplyTilemap
