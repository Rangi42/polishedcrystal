Script_reanchormap::
ReanchorMap::
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
	ld hl, wStateFlags
	res TEXT_STATE_F, [hl]
	ld hl, wWeatherFlags
	res OW_WEATHER_DISABLED_F, [hl]
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
	ld hl, wWeatherFlags
	set OW_WEATHER_DISABLED_F, [hl]
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; aka BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ClearSpritesUnderTextbox
	call ReanchorBGMap_NoOAMUpdate ; far-ok
	call SpeechTextbox
	call BGMapAnchorTopLeft
	call LoadFonts_NoOAMUpdate ; far-ok
	pop af
	rst Bankswitch

	ret

ClearSpritesUnderTextbox::
	ld de, wShadowOAM
	ld h, d
	ld l, e
	ld c, OAM_COUNT
.loop
	; check if YCoord ≥ (TEXTBOX_Y + 1) * TILE_WIDTH
	ld a, [hl]
	cp (TEXTBOX_Y + 1) * TILE_WIDTH
	jr nc, .clear_sprite
.next
	ld hl, OBJ_SIZE
	add hl, de
	ld e, l
	dec c
	jr nz, .loop
	ldh a, [hOAMUpdate]
	push af
	ld a, TRUE
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hOAMUpdate], a
	ret

.clear_sprite
	ld [hl], OAM_YCOORD_HIDDEN
	jr .next

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
