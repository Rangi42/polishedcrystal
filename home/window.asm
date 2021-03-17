Script_refreshscreen::
RefreshScreen::
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; aka BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate ; far-ok
	call BGMapAnchorTopLeft
	call LoadFonts_NoOAMUpdate ; far-ok

	pop af
	rst Bankswitch
	ret

RefreshScreenFast::
	; Don't use for bridge updates, just call GenericFinishBridge
	call GetMovementPermissions
	farjp ReanchorBGMap_NoOAMUpdate_NoDelay

CloseText::
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a

	call .CloseText

	pop af
	ldh [hOAMUpdate], a
	ld hl, wVramState
	res 6, [hl]
	ret

.CloseText:
	call ClearWindowData
	xor a
	ldh [hBGMapMode], a
	call LoadMapPart
	call BGMapAnchorTopLeft
	xor a
	ldh [hBGMapMode], a
	call SafeUpdateSprites
	farcall RefreshSprites
	ld a, $90
	ldh [hWY], a
	call UpdatePlayerSprite
	xor a
	ldh [hBGMapMode], a

	farjp InitMapNameSign

Script_opentext::
OpenText::
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; aka BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate ; far-ok
	call SpeechTextbox
	call BGMapAnchorTopLeft
	call LoadFonts_NoOAMUpdate ; far-ok
	pop af
	rst Bankswitch

	ret

BGMapAnchorTopLeft::
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a

	ld b, 0
	call SafeCopyTilemapAtOnce

	pop af
	ldh [hOAMUpdate], a
	ret

SafeUpdateSprites::
	ldh a, [hOAMUpdate]
	push af
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [hOAMUpdate], a
	call UpdateSprites
	xor a
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hBGMapMode], a
	pop af
	ldh [hOAMUpdate], a
	ret
