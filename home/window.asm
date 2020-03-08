RefreshScreen::
	call ClearWindowData
	ld a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate
	call BGMapAnchorTopLeft
	call LoadFonts_NoOAMUpdate

	pop af
	rst Bankswitch
	ret

RefreshScreenFast::
	; Don't use for bridge updates, just call GenericFinishBridge
	call GetMovementPermissions
	farjp ReanchorBGMap_NoOAMUpdate_NoDelay

CloseText::
	ld a, [hOAMUpdate]
	push af
	ld a, $1
	ld [hOAMUpdate], a

	call .CloseText

	pop af
	ld [hOAMUpdate], a
	ld hl, wVramState
	res 6, [hl]
	ret

.CloseText:
	call ClearWindowData
	xor a
	ld [hBGMapMode], a
	call LoadMapPart
	call BGMapAnchorTopLeft
	xor a
	ld [hBGMapMode], a
	call SafeUpdateSprites
	farcall ReloadVisibleSprites
	ld a, $90
	ld [hWY], a
	call ReplaceKrisSprite
	xor a
	ld [hBGMapMode], a

	farjp ReturnFromMapSetupScript

OpenText::
	call ClearWindowData
	ld a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; and BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate
	call SpeechTextBox
	call BGMapAnchorTopLeft
	call LoadFonts_NoOAMUpdate
	pop af
	rst Bankswitch

	ret

BGMapAnchorTopLeft::
	ld a, [hOAMUpdate]
	push af
	ld a, $1
	ld [hOAMUpdate], a

	ld b, 0
	call SafeCopyTilemapAtOnce

	pop af
	ld [hOAMUpdate], a
	ret

SafeUpdateSprites::
	ld a, [hOAMUpdate]
	push af
	ld a, [hBGMapMode]
	push af
	xor a
	ld [hBGMapMode], a
	ld a, $1
	ld [hOAMUpdate], a
	call UpdateSprites
	xor a
	ld [hOAMUpdate], a
	call DelayFrame
	pop af
	ld [hBGMapMode], a
	pop af
	ld [hOAMUpdate], a
	ret
