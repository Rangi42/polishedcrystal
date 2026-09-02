_SafeCopyTilemapAtOnce::
	ldh a, [hMapAnims]
	push af
	ldh a, [hVBlank]
	push af
	xor a
	ldh [hMapAnims], a

	ld a, b
	ldh [hTilemapAtomicCopyFlags], a ; Some of these flags must be passed to the VBlank handler.
	and %11
	jr nz, .notZero
	ldh a, [hCGBPalUpdate]
	ld d, a
	ld e, 0
	jr .gotPalUpdate
.notZero
	cp 3
	jr nz, .doNotUseOldValue
	ldh a, [hCGBPalUpdate]
	ld e, a
	ld d, 0
	jr .gotPalUpdate
.doNotUseOldValue
	dec a
	call nz, SetDefaultBGPAndOBP
	lb de, 0, 1
.gotPalUpdate
	xor a
	ldh [hCGBPalUpdate], a
	ldh a, [rLY]
	cp $70
	call nc, DelayFrame ; not enough time to update music, so wait a frame
	ld a, e
	ldh [hCGBPalUpdate], a

.waitLYAndUpdateMusic
	ldh a, [rLY]
	cp $70
	jr nz, .waitLYAndUpdateMusic
	bit 2, b
	jr z, .noForceOAMUpdate
	xor a
	ldh [hOAMUpdate], a
.noForceOAMUpdate

	ld a, 1 << 7 | 7 ; execute actual VBlank7, which leads to `VBlankSafeCopyTilemapAtOnce` below.
	ldh [hVBlank], a
	call UpdateSound
	call DelayFrame

	; Restore all regs.
	ld a, d
	ldh [hCGBPalUpdate], a
	pop af
	ldh [hVBlank], a
	pop af
	ldh [hMapAnims], a
	ret

_CopyTilemapAtOnce::
	ldh a, [hBGMapMode]
	push af
	ldh a, [hMapAnims]
	push af

	xor a
	assert NO_BG_MAP_TRANSFER == 0
	ldh [hBGMapMode], a
	ldh [hMapAnims], a

	di
	hlcoord 0, 0, wAttrmap
	ld a, 1 ; BANK(vStandingFrameTiles)
	call CopyFullTilemapInHBlank
	hlcoord 0, 0
	xor a ; BANK(vObjTiles)
	call CopyFullTilemapInHBlank

	ei ; in case we've passed vblank

	pop af
	ldh [hMapAnims], a
	pop af
	ldh [hBGMapMode], a
	ret

VBlankSafeCopyTilemapAtOnce::
	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a
	ldh a, [hWY]
	ldh [rWY], a
	ldh a, [hWX]
	ldh [rWX], a
	call UpdateCGBPals

	ldh a, [hTilemapAtomicCopyFlags]
	and 1 << 3
	jr z, .copyAttrmapAndTilemap
	; Copy only the tilemap.
	; First, reuse the same code as `UpdateBGMap` to copy the top half during VBlank...
	call UpdateBGMap.DoTiles

	call PushOAM ; This is still the VBlank handler!

	; ...and then, copy the bottom half during HBlank.
	hlcoord 0, SCREEN_HEIGHT / 2 ; HALF_HEIGHT from `video.asm`.
	ld de, TILEMAP_WIDTH * (SCREEN_HEIGHT / 2)
	ld b, SCREEN_HEIGHT / 2
	jr CopyTilemapInHBlank

.copyAttrmapAndTilemap
	; We do not have enough time to copy one half of each map; instead, the strategy is to copy some
	; during VBlank, and then copy the rest during rendering.
	; To avoid tearing, we must stay ahead of the rendering, which requires alternating between updating
	; the tilemap and attrmap. However, it is more efficient to copy in bulk from the same one, since
	; switching between the two carries some overhead.
	; 5 rows turns out to be an appreciable compromise; this means we can split the 18 {tile,attr}map rows
	; into three chunks of 5, leaving a remainder of 3.
	; Those 3 rows are thus what we will copy here during VBlank.  (Whew!)
	inc a ; ld a, 1
	ldh [rVBK], a
	ld hl, wAttrmap
	call CopyTop3MapRows
	; xor a (a == 0 at this point)
	ldh [rVBK], a
	ld hl, wTilemap
	call CopyTop3MapRows

	call PushOAM ; This is still a VBlank handler, after all :)

	; Perform the rest of the copies in HBlank.
FOR row_idx, 3 /* rows already copied during VBlank */, SCREEN_HEIGHT, 5
	hlcoord 0, row_idx, wAttrmap
	ld de, TILEMAP_WIDTH * row_idx
	call Copy5RowsOfTilemapInHBlank_VBK1
	hlcoord 0, row_idx
	ld de, TILEMAP_WIDTH * row_idx
	IF row_idx != SCREEN_HEIGHT - 5 ; Replace the last call with a fallthrough.
	call Copy5RowsOfTilemapInHBlank_VBK0
	ENDC
ENDR

; fallthrough
Copy5RowsOfTilemapInHBlank_VBK0:
	xor a
	ldh [rVBK], a
	jr Copy5RowsOfTilemapInHBlank

CopyFullTilemapInHBlank:
	ldh [rVBK], a
	ld de, 0
	ld b, SCREEN_HEIGHT
	jr CopyTilemapInHBlank

Copy5RowsOfTilemapInHBlank_VBK1:
	ld a, 1
	ldh [rVBK], a

; fallthrough
Copy5RowsOfTilemapInHBlank:
	ld b, 5

; fallthrough
CopyTilemapInHBlank:
; Copy all tiles to vBGMap
	ld [wSPBuffer], sp

	ld sp, hl
	ldh a, [hBGMapAddress + 1]
	ld h, a
	ldh a, [hBGMapAddress]
	ld l, a
	add hl, de

	ld a, b
.loop
	ldh [hNbRowsToCopy], a
; if in v/hblank, wait until not in v/hblank
	pop bc
	pop de
	ldh a, [rLY]
	cp $90
	jr nc, .inVBlank1
.waitnohbl1
	ldh a, [rSTAT]
	and STAT_OAM ; wait until mode 2-3
	jr z, .waitnohbl1
.waithbl1
	ldh a, [rSTAT]
	and STAT_OAM ; wait until mode 0-1
	jr nz, .waithbl1
; load BGMap0
.inVBlank1
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	pop bc
	pop de
	ldh a, [rLY]
	cp $90
	jr nc, .inVBlank2
.waitnohbl2
	ldh a, [rSTAT]
	and STAT_OAM ; wait until mode 2-3
	jr z, .waitnohbl2
.waithbl2
	ldh a, [rSTAT]
	and STAT_OAM ; wait until mode 0-1
	jr nz, .waithbl2
; load BGMap0
.inVBlank2
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	ld a, e
	ld [hli], a
	ld [hl], d

	ld de, TILEMAP_WIDTH - (SCREEN_WIDTH - 1)
	add hl, de

	ldh a, [hNbRowsToCopy]
	dec a
	jr nz, .loop

	ld sp, wSPBuffer
	pop hl
	ld sp, hl
	ret
