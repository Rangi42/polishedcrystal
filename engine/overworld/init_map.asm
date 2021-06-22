ReanchorBGMap_NoOAMUpdate::
	ldh a, [hOAMUpdate]
	push af

	ld a, $1
	ldh [hOAMUpdate], a
	ldh a, [hBGMapMode]
	push af

	xor a
	ldh [hBGMapMode], a
	ldh [hLCDCPointer], a
	ld a, $90
	ldh [hWY], a
	call LoadMapPart

	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	xor a
	ldh [hBGMapAddress], a
	call BGMapAnchorTopLeft
	farcall LoadBlindingFlashPalette
	farcall ApplyPals
	xor a
	ldh [hBGMapMode], a
	ldh [hWY], a
	ldh [hBGMapAddress], a
	ld [wBGMapAnchor], a
	ldh [hSCX], a
	ldh [hSCY], a
	inc a
	ldh [hCGBPalUpdate], a
	ld a, HIGH(vBGMap0) ; overworld
	ldh [hBGMapAddress + 1], a
	ld [wBGMapAnchor + 1], a
	call ApplyBGMapAnchorToObjects

	pop af
	ldh [hBGMapMode], a
	pop af
	ldh [hOAMUpdate], a
	ld hl, wVramState
	set 6, [hl]
	ret

LoadFonts_NoOAMUpdate::
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a

	call LoadFontsExtra
	ld a, $90
	ldh [hWY], a
	call SafeUpdateSprites
	call LoadStandardFont

	pop af
	ldh [hOAMUpdate], a
	ret

ReanchorBGMap_NoOAMUpdate_NoDelay::
	ldh a, [hOAMUpdate]
	push af

	ld a, $1
	ldh [hOAMUpdate], a
	ldh a, [hBGMapMode]
	push af

	xor a
	ldh [hBGMapMode], a
	ldh [hLCDCPointer], a
	ld a, $90
	ldh [hWY], a
	call LoadMapPart

	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	xor a
	ldh [hBGMapAddress], a
	call CopyTilemapAtOnce
	xor a
	ldh [hWY], a
	ldh [hBGMapAddress], a
	ld [wBGMapAnchor], a
	ldh [hSCX], a
	ldh [hSCY], a
	inc a
	ldh [hCGBPalUpdate], a
	ld a, HIGH(vBGMap0) ; overworld
	ldh [hBGMapAddress + 1], a
	ld [wBGMapAnchor + 1], a
	pop af
	ldh [hBGMapMode], a
	pop af
	ldh [hOAMUpdate], a
	ld hl, wVramState
	set 6, [hl]
	ld b, 0
	jmp SafeCopyTilemapAtOnce
