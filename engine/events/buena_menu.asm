AskRememberPassword:
	lb bc, 14, 7
	ld hl, YesNoMenuDataHeader
	push bc
	call CopyMenuHeader
	pop bc
	ld a, b
	ld [wMenuBorderLeftCoord], a
	add 5
	ld [wMenuBorderRightCoord], a
	ld a, c
	ld [wMenuBorderTopCoord], a
	add 4
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	call VerticalMenu
	push af
	ld c, 15
	call DelayFrames
	call Buena_ExitMenu
	pop af
	jr c, .refused
	ld a, [wMenuCursorY]
	cp $2
	jr z, .refused
	ld a, TRUE
	ldh [hScriptVar], a
	ret

.refused
	ld a, $2
	ld [wMenuCursorY], a
	xor a ; FALSE
	ldh [hScriptVar], a
	ret

Buena_ExitMenu:
	ldh a, [hOAMUpdate]
	push af
	call ExitMenu
	call UpdateSprites
	xor a
	ldh [hOAMUpdate], a
	call DelayFrame
	ld a, $1
	ldh [hOAMUpdate], a
	call ApplyTilemap
	pop af
	ldh [hOAMUpdate], a
	ret
