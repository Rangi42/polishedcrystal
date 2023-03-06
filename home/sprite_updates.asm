FadeToMenu::
	xor a
	ldh [hBGMapMode], a
	call LoadStandardMenuHeader
	farcall FadeOutPalettes
	call ClearSprites
	; fallthrough
DisableSpriteUpdates::
	xor a
	ldh [hMapAnims], a
	ld [wSpriteUpdatesEnabled], a
	ld a, [wVramState]
	res 0, a
	ld [wVramState], a
	ret

CloseSubmenu::
	farcall ClearSavedObjPals
	farcall DisableDynPalUpdates
	call ClearBGPalettes
	call ReloadTilesetAndPalettes
	call UpdateSprites
	call ExitMenu
	jr FinishExitMenu

ExitAllMenus::
	farcall ClearSavedObjPals
	farcall DisableDynPalUpdates
	call ClearBGPalettes
	call ExitMenu
	call ReloadTilesetAndPalettes
	call UpdateSprites
FinishExitMenu::
	ld a, CGB_MAPPALS
	call GetCGBLayout
	farcall LoadBlindingFlashPalette
	call ApplyAttrAndTilemapInVBlank
	farcall FadeInPalettes
	farcall EnableDynPalUpdates
	; fallthrough
EnableSpriteUpdates::
	ld a, $1
	ld [wSpriteUpdatesEnabled], a
	ldh [hMapAnims], a
	ld a, [wVramState]
	set 0, a
	ld [wVramState], a
	ret
