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
	ld a, [wStateFlags]
	res SPRITE_UPDATES_DISABLED_F, a
	ld [wStateFlags], a
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
	call RestoreSprites
	call EnableSpriteUpdates
	call UpdateSprites
	call DisableSpriteUpdates
FinishExitMenu::
	ld a, CGB_MAPPALS
	call GetCGBLayout
	farcall LoadBlindingFlashPalette
	call ApplyAttrAndTilemapInVBlank
	farcall LoadWeatherPalNoApply
	farcall LoadWeatherGraphics
	farcall FadeInPalettes_EnableDynNoApply
	; fallthrough
EnableSpriteUpdates::
	ld a, TRUE
	ld [wSpriteUpdatesEnabled], a
	ldh [hMapAnims], a
	ld a, [wStateFlags]
	set SPRITE_UPDATES_DISABLED_F, a
	ld [wStateFlags], a
	ret
