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
