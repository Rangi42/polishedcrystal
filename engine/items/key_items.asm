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
	ld a, b
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
.fix_ycoord
	; We don't want wMenuCursorY to end up with zero. We do want MenuCursorX to
	; be 1, however. We can thus just redo the CursorY insertion if a==0.
	and a
	ld [wMenuCursorY], a
	ld a, $1
	jr z, .fix_ycoord
	ld [wMenuCursorX], a
	jr KeyItems_ShowDescription

KeyItems_Cancel:
	farcall ClearKeyItemIcon
	; fallthrough
KeyItems_JoypadLoop:
	call KeyItems_DisplayPocketItems
	call DoMenuJoypadLoop
	ld b, a
	ld a, [wMenuCursorY]
	ld [wKeyItemsPocketCursor], a
	xor a
	ldh [hBGMapMode], a
	ld a, [w2DMenuFlags2]
	bit 7, a
	jr nz, KeyItems_ScrollPocket
	ld a, b
	ld [wMenuJoypad], a
	bit A_BUTTON_F, a
	jr nz, KeyItems_ChooseKeyItem
	bit B_BUTTON_F, a
	jr nz, KeyItems_ExitPack
	bit D_RIGHT_F, a
	jr nz, KeyItems_ExitPocket
	bit D_LEFT_F, a
	jr nz, KeyItems_ExitPocket
KeyItems_ShowDescription:
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	call KeyItems_GetCurrentKeyItem
	jr c, KeyItems_Cancel
	ld [wNamedObjectIndex], a
	farcall UpdateKeyItemIconAndDescription
	jr KeyItems_JoypadLoop

KeyItems_ChooseKeyItem:
	call KeyItems_PlaySFX_ReadText2
	call KeyItems_GetCursorKeyItem
	jr c, _KeyItems_ExitPack
	; fallthrough
KeyItems_GetCurrentKeyItem:
	call KeyItems_GetCursorKeyItem
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

KeyItems_GetCursorKeyItem:
; Returns key item the cursor is hovering. Returns carry if -1 (Cancel).
	ld a, [wMenuCursorY]
	dec a
	ld l, a
	ld a, [wKeyItemsPocketScrollPosition]
	add l
KeyItems_GetAthKeyItem:
; Get key item for position a
	add LOW(wKeyItems)
	ld l, a
	adc HIGH(wKeyItems)
	sub l
	ld h, a
	ld a, [hl]
	cp 1
	ret

KeyItems_ScrollPocket:
	ld a, b
	bit 7, a
	jr nz, .down

	; Scrolling up
	ld hl, wKeyItemsPocketScrollPosition
	ld a, [hl]
	and a
	jmp z, KeyItems_JoypadLoop
	dec [hl]
	jr .display_and_show

.down
	call KeyItems_GetCursorKeyItem
.joypad_loop
	jmp c, KeyItems_JoypadLoop

	ld hl, wKeyItemsPocketScrollPosition
	inc [hl]
.display_and_show
	call KeyItems_DisplayPocketItems
	jr KeyItems_ShowDescription

KeyItems_DisplayPocketItems:
; Returns amount of displayed rows in b.
	hlcoord 5, 2
	lb bc, 10, 15
	push hl
	call ClearBox
	ld a, [wKeyItemsPocketScrollPosition]
	call KeyItems_GetAthKeyItem
	ld d, h
	ld e, l
	lb bc, 0, 5
	pop hl
	inc hl
.loop
	ld a, [de]
	inc de
	and a
	jr nz, .not_cancel

	; If we've reached Cancel, this is our final iteration.
	ld c, 1
	jr .not_registered
.not_cancel
	; Check item registration status
	push de
	push hl
	push bc
	ld d, a
	ld hl, wRegisteredItems
	ld a, [hli]
	cp d
	ld e, "▲"
	jr z, .registered
	ld a, [hli]
	cp d
	ld e, "◀"
	jr z, .registered
	ld a, [hli]
	cp d
	ld e, "▶"
	jr z, .registered
	ld a, [hli]
	cp d
	ld e, "▼"
	jr z, .registered
	ld a, d
	pop bc
	pop hl
	pop de
	jr .not_registered
.registered
	push de
	farcall CheckRegisteredItem
	pop de
	dec a
	ld a, d
	pop bc
	jr nz, .not_unique
	ld e, "★"
.not_unique
	pop hl
	ld [hl], e
	pop de
.not_registered
	ld [wNamedObjectIndex], a
	push de
	call GetKeyItemName
	push bc
	push hl
	inc hl
	inc hl
	rst PlaceString
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	pop de
	inc b
	dec c
	jr nz, .loop
	ret

KeyItems_PlaySFX_ReadText2:
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret
