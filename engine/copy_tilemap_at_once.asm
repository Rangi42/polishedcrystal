_SafeCopyTilemapAtOnce::
	ld a, [hBGMapMode]
	push af
	ld a, [hMapAnims]
	push af
	ld a, [hVBlank]
	push af
	xor a
	ld [hBGMapMode], a
	ld [hMapAnims], a

	ld a, b
	and %11
	jr nz, .notZero
	ld a, [hCGBPalUpdate]
	ld d, a
	ld e, 0
	jr .gotPalUpdate
.notZero
	cp 3
	jr nz, .doNotUseOldValue
	ld a, [hCGBPalUpdate]
	ld e, a
	ld d, 0
	jr .gotPalUpdate
.doNotUseOldValue
	dec a
	call nz, SetPalettes
	lb de, 0, 1
.gotPalUpdate
	xor a
	ld [hCGBPalUpdate], a
	ld a, [rLY]
	cp $70
	call nc, DelayFrame ; not enough time to update music, so wait a frame
	ld a, e
	ld [hCGBPalUpdate], a
.waitLYAndUpdateMusic
	ld a, [rLY]
	cp $70
	jr nz, .waitLYAndUpdateMusic
	xor a
	ld [hBGMapHalf], a
	inc a
	call SkipMusic
	bit 2, b
	jr z, .noForceOAMUpdate
	xor a
	ld [hOAMUpdate], a
.noForceOAMUpdate
	bit 3, b
	ld a, 3
	jr z, .gotTileCount
	ld a, 9
.gotTileCount
	ld [hTilesPerCycle], a
	ld a, b
	and %1000
	swap a
	or 5
	ld [hBGMapMode], a ; bit 7 = skip attr map
	ld a, 1 << 7 | 7 ; execute actual vblank 7
	ld [hVBlank], a
	call DelayFrame
	ld a, d
	ld [hCGBPalUpdate], a
	pop af
	ld [hVBlank], a
	pop af
	ld [hMapAnims], a
	pop af
	ld [hBGMapMode], a
	ret

_CopyTilemapAtOnce::
	ld a, [hBGMapMode]
	push af
	ld a, [hMapAnims]
	push af

	xor a
	ld [hBGMapMode], a
	ld [hMapAnims], a

	di
	coord hl, 0, 0, wAttrMap
	ld a, 1 ; BANK(vStandingFrameTiles)
	call CopyFullTilemapInHBlank
	coord hl, 0, 0
	xor a ; BANK(vObjTiles)
	call CopyFullTilemapInHBlank

	ei ; in case we've passed vblank

	pop af
	ld [hMapAnims], a
	pop af
	ld [hBGMapMode], a
	ret

VBlankSafeCopyTilemapAtOnce::
	ld a, [hSCX]
	ld [rSCX], a
	ld a, [hSCY]
	ld [rSCY], a
	ld a, [hWY]
	ld [rWY], a
	ld a, [hWX]
	ld [rWX], a
	call UpdateCGBPals
; values for the bg map update part should already be loaded
	call UpdateBGMap
; specify the values for attr map update
	ld a, [hBGMapMode]
	bit 7, a
	jr nz, .skipAttr
	ld a, 6
	ld [hBGMapMode], a
	call UpdateBGMap
.skipAttr
	call PushOAM
	ld a, [hBGMapMode]
	bit 7, a
	jr z, .attrAndBGCopy
; if we only need to update tiles, copy the remaining half in hblank
	coord hl, 0, 9
	ld de, BG_MAP_WIDTH * 9
	ld b, 9
	jr CopyTilemapInHBlank
.attrAndBGCopy
; now copy both tile and attr map, of alternating groups of 5/5/4
	coord hl, 0, 3, wAttrMap
	ld de, BG_MAP_WIDTH * 3
	call Copy5RowsOfTilemapInHBlank_VBK1
	coord hl, 0, 3
	ld de, BG_MAP_WIDTH * 3
	call Copy5RowsOfTilemapInHBlank_VBK0
	coord hl, 0, 8, wAttrMap
	ld de, BG_MAP_WIDTH * 8
	call Copy5RowsOfTilemapInHBlank_VBK1
	coord hl, 0, 8
	ld de, BG_MAP_WIDTH * 8
	call Copy5RowsOfTilemapInHBlank_VBK0
	coord hl, 0, 13, wAttrMap
	ld de, BG_MAP_WIDTH * 13
	call Copy5RowsOfTilemapInHBlank_VBK1
	coord hl, 0, 13
	ld de, BG_MAP_WIDTH * 13

; fallthrough
Copy5RowsOfTilemapInHBlank_VBK0:
	xor a
	ld [rVBK], a
	jr Copy5RowsOfTilemapInHBlank

CopyFullTilemapInHBlank:
	ld [rVBK], a
	ld de, 0
	ld b, SCREEN_HEIGHT
	jr CopyTilemapInHBlank

Copy5RowsOfTilemapInHBlank_VBK1:
	ld a, 1
	ld [rVBK], a

; fallthrough
Copy5RowsOfTilemapInHBlank:
	ld b, 5

; fallthrough
CopyTilemapInHBlank:
; Copy all tiles to VBGMap
	ld [hSPBuffer], sp

	ld sp, hl
	ld a, [hBGMapAddress + 1]
	ld h, a
	ld a, [hBGMapAddress]
	ld l, a
	add hl, de

	ld a, b
.loop
	ld [hTilesPerCycle], a
; if in v/hblank, wait until not in v/hblank
	pop bc
	pop de
	ld a, [rLY]
	cp $90
	jr nc, .inVBlank1
.waitnohbl1
	ld a, [rSTAT]
	and %10
	jr z, .waitnohbl1
.waithbl1
	ld a, [rSTAT]
	and %10
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
	ld [hl], d
	inc hl

	pop bc
	pop de
	ld a, [rLY]
	cp $90
	jr nc, .inVBlank2
.waitnohbl2
	ld a, [rSTAT]
	and %10
	jr z, .waitnohbl2
.waithbl2
	ld a, [rSTAT]
	and %10
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

	ld a, BG_MAP_WIDTH - (SCREEN_WIDTH - 1)
	add l
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [hTilesPerCycle]
	dec a
	jr nz, .loop

	ld sp, hSPBuffer
	pop hl
	ld sp, hl
	ret
