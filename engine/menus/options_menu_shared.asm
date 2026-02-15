DEF OPTIONS_SHARED_VALUE_OFFSET EQU 9

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
	cp 1
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
	cp 1
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
	ld a, [hl]        ; read the byte at HL
	inc hl            ; HL = resume position (past stop char)
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
