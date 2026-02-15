DEF OPTIONS_SHARED_VALUE_OFFSET EQU 9

; Edge tile graphics shared by both menus
OptionsShared_LoadEdgeTiles:
	ld hl, .BGTiles
	ld de, vTiles2 tile $00
	lb bc, BANK(.BGTiles), 15
	jmp DecompressRequest2bpp

.BGTiles:
	INCBIN "gfx/new_game/init_bg.2bpp.lzp"

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

	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH - 2
	ld d, TEXTBOX_Y
	xor a
.edge_attr_loop
	ld [hli], a
	inc a
	add hl, bc
	xor a
	ld [hli], a
	dec d
	jr nz, .edge_attr_loop
	ret

; Shared main loop for both options menus.
; Caller must set wOptionsMenuType, wOptionsMenuCursor, wOptionsMenuScrollPosition,
; wOptionsMenuLastSelection, and call CopyMenuHeader before calling this.
OptionsShared_RunLoop:
.loop
	ld hl, wMenuScrollPosition
	ld a, [wOptionsMenuScrollPosition]
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld hl, wMenuCursorBuffer
	ld a, [wOptionsMenuCursor]
	ld [hli], a
	xor a
	ld [hl], a

	call ScrollingMenu
	ld a, TRUE
	ldh [hInMenu], a

	ld a, [wMenuScrollPosition]
	ld [wOptionsMenuScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wOptionsMenuCursor], a

	ld a, [wMenuJoypad]
	cp PAD_B
	jmp z, .exit
	cp PAD_START
	jmp z, .exit
	cp PAD_LEFT
	jmp z, .apply_left
	cp PAD_RIGHT
	jmp z, .apply_right
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
	jmp z, .loop
	ld a, PAD_LEFT
	jr .apply_left_right

.apply_right
	ldh a, [hJoyPressed]
	and PAD_RIGHT
	jmp z, .loop
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
	jmp .loop

.skip_left_right
	pop af ; discard saved direction
	jmp .loop

.exit
	; Menu-specific exit hook
	ld a, [wOptionsMenuType]
	and a
	jr z, .common_exit
	; Initial Options: clear the reset flag
	ld hl, wInitialOptions2
	res RESET_INIT_OPTS, [hl]
.common_exit
	ld de, SFX_TRANSACTION
	call PlaySFX
	jmp WaitSFX

.DispatchAdvanceDesc:
	ld a, [wOptionsMenuType]
	and a
	jmp z, OptionsMenu_AdvanceSelectionDescription
	jmp OptionsShared_SimpleAdvanceDescription

OptionsShared_DispatchCallRoutine:
	ld a, [wOptionsMenuType]
	and a
	jmp z, OptionsMenu_CallOptionRoutine
	jmp InitialOptions_CallOptionRoutine

; Dispatch to the correct description table based on menu type
OptionsShared_DispatchLookupDescription:
	ld a, [wOptionsMenuType]
	and a
	jr nz, .initial
	ld hl, OptionsDescriptions
	ld de, OptionsDescriptions.Done
	jr OptionsShared_LookupDescription
.initial
	ld hl, InitialOptionDescriptions
	ld de, InitialOptionDescriptions.Done
	; fallthrough

; Decompress description text to wDecompressScratch.
; HL = descriptions table, DE = .Done label
OptionsShared_LookupDescription:
	ld a, [wMenuSelection]
	inc a ; -1? (Done)
	jr z, .done_item
	dec a
	dec a ; 0-indexed (items are 1-based)
	add a ; * 2 for pointer table
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr .decompress

.done_item
	ld h, d
	ld l, e

.decompress
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
	ret

; Shared PlaceOptionName callback for ScrollingMenu.
; Dispatches on wOptionsMenuType to select the correct name table.
OptionsShared_PlaceOptionName:
	push de
	ld a, [wOptionsMenuType]
	and a
	jr nz, .initial
	ld de, OptionNames.Done
	ld hl, OptionNames - 2 * 2
	jr .lookup
.initial
	ld de, InitialOptionNames.Done
	ld hl, InitialOptionNames - 2 * 2
.lookup
	ld a, [wMenuSelection]
	inc a ; -1?
	jr z, .got_name
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
.got_name
	pop hl
	rst PlaceString
	ret

; Shared PlaceOptionValue callback for ScrollingMenu.
; Dispatches on wOptionsMenuType to call the correct option routine.
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
	xor a
	ld [wOptionsMenuDescriptionState], a
	call SetUpTextbox
	; Get text speed flag based on menu type
	ld a, [wOptionsMenuType]
	and a
	jr nz, .instant
	; OptionsMenu: check if Text Speed option
	call OptionsMenu_GetTextSpeedFlag
	jmp OptionsShared_PlaceDescriptionText
.instant
	ld c, 0 ; instant text
	jmp OptionsShared_PlaceDescriptionText

; Simple advance description (for InitialOptions, and non-TextSpeed options)
OptionsShared_SimpleAdvanceDescription:
	ld a, [wOptionsMenuDescriptionState]
	cp 2 ; ended?
	jr z, .wrap
	; More text - advance (state is 0=para or 1=cont)
	ld c, 0 ; instant text
	jmp OptionsShared_PlaceDescriptionText

.wrap
	; Description ended - loop back to first page
	call OptionsShared_DispatchLookupDescription
	xor a
	ld [wOptionsMenuDescriptionState], a
	ld c, 0 ; instant text
	jmp OptionsShared_PlaceDescriptionText

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

OptionsShared_PlaceDescriptionText:
; Display the current description page non-blockingly.
; Text from wOptionsMenuDescriptionAddr is in wDecompressScratch (uncompressed).
; Input: C = 0 for instant text, C != 0 to use configured text speed
; Uses wOptionsMenuDescriptionState: 0=para, 1=cont, 2=ended.
	push bc ; save text speed flag

	; Save wOptions1 and wTextboxFlags
	ld a, [wOptions1]
	push af
	ld a, [wTextboxFlags]
	push af

	; Set NO_TEXT_PAUSE_F
	ld hl, wTextboxFlags
	set NO_TEXT_PAUSE_F, [hl]

	; If C = 0, set NO_TEXT_SCROLL for instant text
	; If C != 0, set bit 0 so PrintLetterDelay uses configured speed
	;   and syncs tiles to VRAM per-character.
	ld a, c
	and a
	jr nz, .useConfiguredSpeed
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
	jr .placeText

.useConfiguredSpeed
	ld hl, wTextboxFlags
	set 0, [hl]

.placeText
	; Remove any previous blinking cursor
	call UnloadBlinkingCursor

	; If continuing from <CONT>, scroll existing line 2 up to line 1.
	ld a, [wOptionsMenuDescriptionState]
	dec a
	jr nz, .loadPointer
	call Text_WaitBGMap
	call TextScroll
	call TextScroll

.loadPointer
	; Cache state for render path selection.
	ld a, [wOptionsMenuDescriptionState]
	ld b, a

	; Load description pointer BEFORE switching bank
	; (wOptionsMenuDescriptionAddr is in WRAMX bank 1)
	ld hl, wOptionsMenuDescriptionAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Switch to WRAM bank 6 for wDecompressScratch access
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a

	; Place text from bank 6 buffer.
	; - state 1 (<CONT>): keep box contents, print starting on line 2
	; - otherwise: clear box and print from line 1
	ld a, b
	dec a
	jr nz, .placeFresh
	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	call PlaceWholeStringInBoxAtOnce
	jr .placed

.placeFresh
	call PrintTextNoBox

.placed

	; After a <CONT>/<PARA> stop: HL = AT the stop char
	; After terminal <PROMPT>/@: HL = past the terminator
	; Check [hl] while bank 6 is still active
	ld a, [hli]       ; read byte at HL, HL = resume position (past stop char)
	ld d, h           ; save resume position in DE
	ld e, l
	ld b, a           ; save stop char in B

	; Restore WRAM bank (back to bank 1 for wOptionsMenuDescriptionAddr writes)
	pop af
	ldh [rWBK], a

	; Check the stop char (saved in B)
	ld a, b
	cp CHARVAL("<PARA>")
	jr z, .morePara
	cp CHARVAL("<CONT>")
	jr z, .moreCont

	; Description ended
	ld a, 2
	ld [wOptionsMenuDescriptionState], a
	jr .restore

.morePara
	; Save resume position, set state = 0
	ld a, e
	ld [wOptionsMenuDescriptionAddr], a
	ld a, d
	ld [wOptionsMenuDescriptionAddr + 1], a
	xor a ; state 0
	ld [wOptionsMenuDescriptionState], a
	jr .showCursor

.moreCont
	; Save resume position, set state = 1
	ld a, e
	ld [wOptionsMenuDescriptionAddr], a
	ld a, d
	ld [wOptionsMenuDescriptionAddr + 1], a
	ld a, 1
	ld [wOptionsMenuDescriptionState], a

.showCursor
	call LoadBlinkingCursor

.restore
	; Restore wTextboxFlags
	pop af
	ld [wTextboxFlags], a
	; Restore wOptions1
	pop af
	ld [wOptions1], a

	pop bc ; restore text speed flag

	; Flush tilemap to VRAM
	jmp ApplyTilemap
