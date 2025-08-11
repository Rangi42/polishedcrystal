PokegearPhone_Init:
	ld hl, wJumptableIndex
	inc [hl]
	xor a
	ld [wPokegearPhoneScrollPosition], a
	ld [wPokegearPhoneCursorPosition], a
	ld [wPokegearPhoneSelectedPerson], a

	ld a, CGB_POKEGEAR_PALS
	call GetCGBLayout
	call SetDefaultBGPAndOBP

	call InitPokegearTilemap
	call ExitPokegearRadio_HandleMusic
	ld hl, PokegearText_WhomToCall
	jmp PrintText

PokegearPhone_Joypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and PAD_B
	jr nz, .b
	ld a, [hl]
	and PAD_A
	jr nz, .a
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_LEFT
	jr nz, .left
	ld a, [hl]
	and PAD_RIGHT
	jr nz, .right
	jmp PokegearPhone_GetDPad

.left
	ld a, [wPokegearFlags]
	bit POKEGEAR_MAP_CARD_F, a
	jr z, .no_map
	lb bc, POKEGEARCARD_MAP, POKEGEARSTATE_MAPCHECKREGION
	jr .switch_page

.no_map
	lb bc, POKEGEARCARD_CLOCK, POKEGEARSTATE_CLOCKINIT
	jr .switch_page

.right
	ld a, [wPokegearFlags]
	bit POKEGEAR_RADIO_CARD_F, a
	ret z
	lb bc, POKEGEARCARD_RADIO, POKEGEARSTATE_RADIOINIT
.switch_page
	jmp Pokegear_SwitchPage

.b
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.a
	call PokegearPhone_GetCellNumber
	ld a, c
	and a
	ret z
	ld [wPokegearPhoneSelectedPerson], a
	hlcoord 1, 4
	ld a, [wPokegearPhoneCursorPosition]
	ld bc, 20 * 2
	rst AddNTimes
	ld [hl], "▷"
	call PokegearPhoneContactSubmenu
	jr c, .quit_submenu
	ld hl, wJumptableIndex
	inc [hl]
	ret

.quit_submenu
	ld a, POKEGEARSTATE_PHONEJOYPAD
	ld [wJumptableIndex], a
	ret

PokegearPhone_MakePhoneCall:
	call GetMapPhoneService
	and a
	jr nz, .no_service
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	xor a
	ldh [hInMenu], a
	ld de, SFX_CALL
	call PlaySFX
	ld hl, .dotdotdot
	call PrintText
	call WaitSFX
	ld de, SFX_CALL
	call PlaySFX
	ld hl, .dotdotdot
	call PrintText
	call WaitSFX
	ld a, [wPokegearPhoneSelectedPerson]
	ld b, a
	call MakePhoneCallFromPokegear
	ld c, 10
	call DelayFrames
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
	ld a, $1
	ldh [hInMenu], a
	call PokegearPhone_UpdateCursor
	ld hl, wJumptableIndex
	inc [hl]
	ret

.no_service
	call Phone_NoSignal
	ld hl, .OutOfServiceArea
	call PrintText
	ld a, POKEGEARSTATE_PHONEJOYPAD
	ld [wJumptableIndex], a
	ld hl, PokegearText_WhomToCall
	jmp PrintText

.dotdotdot
	;
	text_far _GearEllipseText
	text_end

.OutOfServiceArea:
	; You're out of the service area.
	text_far _GearOutOfServiceText
	text_end

PokegearPhone_FinishPhoneCall:
	ldh a, [hJoyPressed]
	and PAD_A | PAD_B
	ret z
	call HangUp
	ld a, POKEGEARSTATE_PHONEJOYPAD
	ld [wJumptableIndex], a
	ld hl, PokegearText_WhomToCall
	jmp PrintText

PokegearPhone_GetDPad:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, .up
	ld a, [hl]
	and PAD_DOWN
	jr nz, .down
	ret

.up
	ld hl, wPokegearPhoneCursorPosition
	ld a, [hl]
	and a
	jr z, .scroll_page_up
	dec [hl]
	jr .done_joypad_same_page

.scroll_page_up
	ld hl, wPokegearPhoneScrollPosition
	ld a, [hl]
	and a
	ret z
	dec [hl]
	jr .done_joypad_update_page

.down
	ld hl, wPokegearPhoneCursorPosition
	ld a, [hl]
	cp $3
	jr nc, .scroll_page_down
	inc [hl]
	jr .done_joypad_same_page

.scroll_page_down
	ld hl, wPokegearPhoneScrollPosition
	ld a, [wNumSetBits]
	sub 4
	ret c
	cp [hl]
	ret z
	inc [hl]
	jr .done_joypad_update_page

.done_joypad_same_page
	xor a
	ldh [hBGMapMode], a
	call PokegearPhone_UpdateCursor
	jmp ApplyTilemapInVBlank

.done_joypad_update_page
	xor a
	ldh [hBGMapMode], a
	call PokegearPhone_UpdateDisplayList
	jmp ApplyTilemapInVBlank

PokegearPhone_UpdateDisplayList:
	hlcoord 1, 3
	ld b, 9
	ld a, " "
.row
	ld c, 18
.col
	ld [hli], a
	dec c
	jr nz, .col
	inc hl
	inc hl
	dec b
	jr nz, .row
	ld a, [wPokegearPhoneScrollPosition]
	ld e, a
	xor a
	ld [wPokegearPhoneLoadNameBuffer], a
.loop
	push de
	call PokegearPhone_GetCellNumberFromE
	ld d, c
	hlcoord 2, 4
	ld a, [wPokegearPhoneLoadNameBuffer]
	ld bc, 2 * SCREEN_WIDTH
	rst AddNTimes
	ld b, d
	ld d, h
	ld e, l
	call GetCallerClassAndName
	pop de
	inc e
	ld hl, wPokegearPhoneLoadNameBuffer
	inc [hl]
	ld a, [hl]
	cp 4 ; 4 entries fit on the screen
	jr c, .loop
	; fallthrough
PokegearPhone_UpdateCursor:
	ld a, " "
	hlcoord 1, 4
	ld [hl], a
	hlcoord 1, 6
	ld [hl], a
	hlcoord 1, 8
	ld [hl], a
	hlcoord 1, 10
	ld [hl], a
	hlcoord 1, 4
	ld a, [wPokegearPhoneCursorPosition]
	ld bc, 2 * SCREEN_WIDTH
	rst AddNTimes
	ld [hl], "▶"
	ret

PokegearPhone_DeletePhoneNumber:
	call PokegearPhone_GetCellNumber
	call DelCellNum
; Check if scroll position should be decremented as a result
	ld hl, wNumSetBits
	dec [hl]
	ld a, [wPokegearPhoneScrollPosition]
	and a
	ret z
	add 3 ; assume cursor position is at the bottom for this calculation
	cp [hl]
	ret c
	sub 4
	ld [wPokegearPhoneScrollPosition], a
	ret

PokegearPhone_GetCellNumber:
; Returns nth contact from wPhoneList in c, c=0 for invalid contact
; Input: wPokegearPhoneCursorPosition + wPokegearPhoneCursorPosition
	ld a, [wPokegearPhoneScrollPosition]
	ld e, a
	ld a, [wPokegearPhoneCursorPosition]
	add e
	ld e, a
	;fallthrough
PokegearPhone_GetCellNumberFromE:
; Returns e-th contact from wPhoneList in c, c=0 for invalid contact
; Input: e
	inc e
	call PokegearPhone_CountSetBits
	cp e ; result is returned in a
	ld c, 0
	ret c
.loop
	inc c
	call CheckCellNum
	jr z, .loop
	dec e
	jr nz, .loop
	ret

PokegearPhone_CountSetBits:
; Returns result in wNumSetBits
	ld hl, wPhoneList
	ld b, wPhoneListEnd - wPhoneList
	jmp CountSetBits

PokegearPhoneContactSubmenu:
	call PokegearPhone_GetCellNumber
	call CheckCanDeletePhoneNumber
	ld a, c
	and a
	jr z, .cant_delete
	ld hl, .CallDeleteCancelJumptable
	ld de, .CallDeleteCancelStrings
	jr .got_menu_data

.cant_delete
	ld hl, .CallCancelJumptable
	ld de, .CallCancelStrings
.got_menu_data
	xor a
	ldh [hBGMapMode], a
	push hl
	push de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	inc de
	push hl
	bccoord -1, -2, 0
	add hl, bc
	ld a, [de]
	inc de
	add a
	ld b, a
	ld c, 8
	push de
	call Textbox
	pop de
	pop hl
	inc hl
	rst PlaceString
	pop de
	xor a
	ld [wPokegearPhoneSubmenuCursor], a
	call .UpdateCursor
	call ApplyTilemapInVBlank
.loop
	push de
	call JoyTextDelay
	pop de
	ld hl, hJoyPressed
	ld a, [hl]
	and PAD_UP
	jr nz, .d_up
	ld a, [hl]
	and PAD_DOWN
	jr nz, .d_down
	ld a, [hl]
	and PAD_A | PAD_B
	jr nz, .a_b
	call DelayFrame
	jr .loop

.d_up
	ld hl, wPokegearPhoneSubmenuCursor
	ld a, [hl]
	and a
	jr z, .loop
	dec [hl]
	call .UpdateCursor
	jr .loop

.d_down
	ld hl, 2
	add hl, de
	ld a, [wPokegearPhoneSubmenuCursor]
	inc a
	cp [hl]
	jr nc, .loop
	ld [wPokegearPhoneSubmenuCursor], a
	call .UpdateCursor
	jr .loop

.a_b
	xor a
	ldh [hBGMapMode], a
	call PokegearPhone_UpdateDisplayList
	ld a, $1
	ldh [hBGMapMode], a
	pop hl
	ldh a, [hJoyPressed]
	and PAD_B
	jr nz, .Cancel
	ld a, [wPokegearPhoneSubmenuCursor]
	jmp JumpTable

.Cancel:
	ld hl, PokegearText_WhomToCall
	call PrintText
	scf
	ret

.Delete:
	ld hl, PokegearText_DeleteStoredNumber
	call MenuTextbox
	call YesNoBox
	call ExitMenu
	jr c, .CancelDelete
	call PokegearPhone_DeletePhoneNumber
	xor a
	ldh [hBGMapMode], a
	call PokegearPhone_UpdateDisplayList
	ld hl, PokegearText_WhomToCall
	call PrintText
	call ApplyTilemapInVBlank
.CancelDelete:
	scf
	ret

.Call:
	and a
	ret

.UpdateCursor:
	push de
	ld a, [de]
	inc de
	ld l, a
	ld a, [de]
	inc de
	ld h, a
	ld a, [de]
	ld c, a
	push hl
	ld a, " "
	ld de, SCREEN_WIDTH * 2
.clear_column
	ld [hl], a
	add hl, de
	dec c
	jr nz, .clear_column
	pop hl
	ld a, [wPokegearPhoneSubmenuCursor]
	ld bc, SCREEN_WIDTH  * 2
	rst AddNTimes
	ld [hl], "▶"
	pop de
	ret

.CallDeleteCancelStrings:
	dwcoord 10, 6
	db 3
	text "Call"
	next "Delete"
	next "Cancel"
	done

.CallDeleteCancelJumptable:
	dw .Call
	dw .Delete
	dw .Cancel

.CallCancelStrings:
	dwcoord 10, 8
	db 2
	text "Call"
	next "Cancel"
	done

.CallCancelJumptable:
	dw .Call
	dw .Cancel
