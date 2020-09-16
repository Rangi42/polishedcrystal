KeyItemsPocket::
	ld a, TRUE
	ldh [hInMenu], a
	call KeyItems_PocketLoop
	ld a, FALSE
	ldh [hInMenu], a
	ret nc
	call PlaceHollowCursor
	ld a, [wCurKeyItem]
	scf
	ret

KeyItems_PocketLoop:
	xor a
	ldh [hBGMapMode], a
	call KeyItems_DisplayPocketItems
	ld a, 2
	ld [w2DMenuCursorInitY], a
	ld a, 7
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 5
	sub d
	inc a
	cp 6
	jr nz, .okay
	dec a
.okay
	ld [w2DMenuNumRows], a
	ld a, $c
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, A_BUTTON | B_BUTTON | D_UP | D_DOWN | D_LEFT | D_RIGHT
	ld [wMenuJoypadFilter], a
	ld a, [wKeyItemsPocketCursor]
	inc a
	ld [wMenuCursorY], a
	ld a, $1
	ld [wMenuCursorX], a
	jr KeyItems_ShowDescription

KeyItems_JoypadLoop:
	call KeyItems_DisplayPocketItems
	call DoMenuJoypadLoop
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [wKeyItemsPocketCursor], a
	xor a
	ldh [hBGMapMode], a
	ld a, [w2DMenuFlags2]
	bit 7, a
	jp nz, KeyItems_ScrollPocket
	ld a, b
	ld [wMenuJoypad], a
	bit A_BUTTON_F, a
	jp nz, KeyItems_ChooseKeyItem
	bit B_BUTTON_F, a
	jp nz, KeyItems_ExitPack
	bit D_RIGHT_F, a
	jp nz, KeyItems_ExitPocket
	bit D_LEFT_F, a
	jp nz, KeyItems_ExitPocket
KeyItems_ShowDescription:
	call KeyItems_GetCurrentKeyItem
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wCurKeyItem]
	cp NUM_KEY_ITEMS + 1
	jr nc, .Cancel
	ld [wd265], a
	farcall UpdateKeyItemIconAndDescription
	jp KeyItems_JoypadLoop

.Cancel:
	farcall ClearKeyItemIcon
	jp KeyItems_JoypadLoop

KeyItems_ChooseKeyItem:
	call KeyItems_PlaySFX_ReadText2
	call CountKeyItems ; This stores the count to wd265.
	ld a, [wMenuCursorY]
	dec a
	ld b, a
	ld a, [wKeyItemsPocketScrollPosition]
	add b
	ld b, a
	ld a, [wd265]
	cp b
	jr z, _KeyItems_ExitPack ; our cursor was hovering over CANCEL

KeyItems_GetCurrentKeyItem:
	call KeyItems_GetCurrentPocketPosition
	ld a, [wMenuCursorY]
	ld b, a
.loop
	inc c
	ld a, c
	cp NUM_KEY_ITEMS + 1
	jr nc, .okay
	call InnerCheckKeyItems
	jr z, .loop
	dec b
	jr nz, .loop
	ld a, c
.okay
	ld [wCurKeyItem], a
	ret

KeyItems_ExitPack:
	call KeyItems_PlaySFX_ReadText2
_KeyItems_ExitPack:
	ld a, $2
	ld [wMenuJoypad], a
KeyItems_ExitPocket:
	and a
	ret

KeyItems_ScrollPocket:
	ld a, b
	bit 7, a
	jr nz, .skip
	ld hl, wKeyItemsPocketScrollPosition
	ld a, [hl]
	and a
	jp z, KeyItems_JoypadLoop
	dec [hl]
	call KeyItems_DisplayPocketItems
	jp KeyItems_ShowDescription

.skip
	call KeyItems_GetCurrentPocketPosition
	ld b, 5
.loop
	inc c
	ld a, c
	cp NUM_KEY_ITEMS + 1
	jp nc, KeyItems_JoypadLoop
	call InnerCheckKeyItems
	jr z, .loop
	dec b
	jr nz, .loop
	ld hl, wKeyItemsPocketScrollPosition
	inc [hl]
	call KeyItems_DisplayPocketItems
	jp KeyItems_ShowDescription

KeyItems_DisplayPocketItems:
	hlcoord 5, 2
	lb bc, 10, 15
	call ClearBox
	call KeyItems_GetCurrentPocketPosition
	ld d, $5
.loop2
	inc c
	ld a, c
	cp NUM_KEY_ITEMS + 1
	jr nc, .NotKeyItems
	call InnerCheckKeyItems
	jr z, .loop2
	ld b, a
	ld a, c
	ld [wd265], a
	push hl
	push de
	push bc
	call KeyItemsPocket_GetCurrentLineCoord
	push hl

    push hl
    pop de
    push hl
	ld a, [wd265]
    and a
	jr z, .not_registered
	ld b, a
	ld hl, wRegisteredItems
	ld a, [hli]
	cp b
	ld c, "▲"
	jr z, .registered
	ld a, [hli]
	cp b
	ld c, "◀"
	jr z, .registered
	ld a, [hli]
	cp b
	ld c, "▶"
	jr z, .registered
	ld a, [hli]
	cp b
	ld c, "▼"
	jr nz, .not_registered
.registered
	push bc
	farcall CheckRegisteredItem
	pop bc
	dec a
	jr nz, .not_unique
	ld c, "★"
.not_unique
	pop de
	push de
    inc de
	ld a, c
	ld [de], a
.not_registered
    pop hl

	ld a, [wd265]
	call GetKeyItemName
	pop hl
	ld bc, 3
	add hl, bc
	push hl
	rst PlaceString
	pop hl
	pop bc
	pop de
	pop hl
	dec d
	jr nz, .loop2
	ret

.NotKeyItems:
	call KeyItemsPocket_GetCurrentLineCoord
	inc hl
	inc hl
	inc hl
	push de
	ld de, KeyItems_String_Cancel
	rst PlaceString
	pop de
	ret

KeyItemsPocket_GetCurrentLineCoord:
	hlcoord 5, 0
	ld bc, 2 * SCREEN_WIDTH
	ld a, 6
	sub d
	ld e, a
	; AddNTimes
.loop
	add hl, bc
	dec e
	jr nz, .loop
	ret

KeyItems_String_Cancel:
	db "Cancel@"

KeyItems_GetCurrentPocketPosition:
	ld a, [wKeyItemsPocketScrollPosition]
	ld b, a
	inc b
	ld c, -1
.loop
	inc c
	ld a, c
	call InnerCheckKeyItems
	jr z, .loop
	dec b
	jr nz, .loop
	dec c
	ret

KeyItems_PlaySFX_ReadText2:
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret

CountKeyItems:
	ld hl, wKeyItems
	ld b, wKeyItemsEnd - wKeyItems
	jp CountSetBits

InnerCheckKeyItems:
	and a
	ret z
	push bc
	push de
	dec a
	ld e, a
	ld d, 0
	ld b, CHECK_FLAG
	ld hl, wKeyItems
	call FlagAction
	ld a, c
	pop de
	pop bc
	and a
	ret
