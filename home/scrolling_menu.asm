ScrollingMenu::
	call CopyMenuData2
	ldh a, [hROMBank]
	push af

	ld a, BANK(_ScrollingMenu) ; aka BANK(_InitScrollingMenu)
	rst Bankswitch

	call _InitScrollingMenu ; far-ok
	call .UpdatePalettes
	call _ScrollingMenu ; far-ok

	pop af
	rst Bankswitch

	ld a, [wMenuJoypad]
	ret

.UpdatePalettes:
	ld hl, wVramState
	bit 0, [hl]
	jmp nz, UpdateTimePals
	; fallthrough

SetPalettes::
	push de
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	pop de
	ret

InitScrollingMenu::
	ld a, [wMenuBorderTopCoord]
	dec a
	ld b, a
	ld a, [wMenuBorderBottomCoord]
	sub b
	ld d, a
	ld a, [wMenuBorderLeftCoord]
	dec a
	ld c, a
	ld a, [wMenuBorderRightCoord]
	sub c
	ld e, a
	push de
	call Coord2Tile
	pop bc
	jmp Textbox

JoyTextDelay_ForcehJoyDown::
	call DelayFrame

	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	call JoyTextDelay
	pop af
	ldh [hInMenu], a

	ldh a, [hJoyLast]
	and D_RIGHT + D_LEFT + D_UP + D_DOWN
	ld c, a
	ldh a, [hJoyPressed]
	and A_BUTTON + B_BUTTON + SELECT + START
	or c
	ld c, a
	ret
