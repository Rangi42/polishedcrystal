ReanchorBGMap_NoOAMUpdate::
	ld a, [hOAMUpdate]
	push af

	ld a, $1
	ld [hOAMUpdate], a
	ld a, [hBGMapMode]
	push af

	xor a
	ld [hBGMapMode], a
	ld [hLCDCPointer], a
	ld a, $90
	ld [hWY], a
	call LoadMapPart

	ld a, vBGMap1 / $100
	ld [hBGMapAddress + 1], a
	xor a
	ld [hBGMapAddress], a
	call BGMapAnchorTopLeft
	farcall LoadBlindingFlashPalette
	farcall ApplyPals
	xor a
	ld [hBGMapMode], a
	ld [hWY], a
	ld [hBGMapAddress], a
	ld [wBGMapAnchor], a
	ld [hSCX], a
	ld [hSCY], a
	inc a
	ld [hCGBPalUpdate], a
	ld a, vBGMap0 / $100 ; overworld
	ld [hBGMapAddress + 1], a
	ld [wBGMapAnchor + 1], a
	call ApplyBGMapAnchorToObjects

	pop af
	ld [hBGMapMode], a
	pop af
	ld [hOAMUpdate], a
	ld hl, wVramState
	set 6, [hl]
	ret

LoadFonts_NoOAMUpdate::
	ld a, [hOAMUpdate]
	push af
	ld a, $1
	ld [hOAMUpdate], a

	call LoadFontsExtra
	ld a, $90
	ld [hWY], a
	call SafeUpdateSprites
	call LoadStandardFont

	pop af
	ld [hOAMUpdate], a
	ret

ReanchorBGMap_NoOAMUpdate_NoDelay::
	ld a, [hOAMUpdate]
	push af

	ld a, $1
	ld [hOAMUpdate], a
	ld a, [hBGMapMode]
	push af

	xor a
	ld [hBGMapMode], a
	ld [hLCDCPointer], a
	ld a, $90
	ld [hWY], a
	call LoadMapPart

	ld a, vBGMap1 / $100
	ld [hBGMapAddress + 1], a
	xor a
	ld [hBGMapAddress], a
	call CopyTilemapAtOnce
	xor a
	ld [hWY], a
	ld [hBGMapAddress], a
	ld [wBGMapAnchor], a
	ld [hSCX], a
	ld [hSCY], a
	inc a
	ld [hCGBPalUpdate], a
	ld a, vBGMap0 / $100 ; overworld
	ld [hBGMapAddress + 1], a
	ld [wBGMapAnchor + 1], a
	pop af
	ld [hBGMapMode], a
	pop af
	ld [hOAMUpdate], a
	ld hl, wVramState
	set 6, [hl]
	ld b, 0
	jp SafeCopyTilemapAtOnce
