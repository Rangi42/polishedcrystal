_SafeCopyTilemapAtOnce::
	ldh a, [hBGMapMode]
	push af
	ldh a, [hMapAnims]
	push af
	ldh a, [hVBlank]
	push af
	xor a
	ldh [hBGMapMode], a
	ldh [hMapAnims], a

	ld a, b
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
	call nz, SetPalettes
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
	xor a
	ldh [hBGMapHalf], a
	bit 2, b
	jr z, .noForceOAMUpdate
	xor a
	ldh [hOAMUpdate], a
.noForceOAMUpdate
	bit 3, b
	ld a, 3
	jr z, .gotTileCount
	ld a, 9
.gotTileCount
	ldh [hTilesPerCycle], a
	ld a, b
	and %1000
	swap a
	or 5
	ldh [hBGMapMode], a ; bit 7 = skip attr map
	ld a, 1 << 7 | 7 ; execute actual VBlank7
	ldh [hVBlank], a
	call UpdateSound
	call DelayFrame
	ld a, d
	ldh [hCGBPalUpdate], a
	pop af
	ldh [hVBlank], a
	pop af
	ldh [hMapAnims], a
	pop af
	ldh [hBGMapMode], a
	ret

_CopyTilemapAtOnce::
	ldh a, [hBGMapMode]
	push af
	ldh a, [hMapAnims]
	push af

	xor a
	ldh [hBGMapMode], a
	ldh [hMapAnims], a

	di
	hlcoord 0, 0, wAttrMap
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
; values for the bg map update part should already be loaded
	call UpdateBGMap
; specify the values for attr map update
	ldh a, [hBGMapMode]
	bit 7, a
	jr nz, .skipAttr
	ld a, 6
	ldh [hBGMapMode], a
	call UpdateBGMap
.skipAttr
	call PushOAM
	ldh a, [hBGMapMode]
	bit 7, a
	jr z, .attrAndBGCopy
; if we only need to update tiles, copy the remaining half in hblank
	hlcoord 0, 9
	ld de, BG_MAP_WIDTH * 9
	ld b, 9
	jr CopyTilemapInHBlank
.attrAndBGCopy
; now copy both tile and attr map, of alternating groups of 5/5/4
	hlcoord 0, 3, wAttrMap
	ld de, BG_MAP_WIDTH * 3
	call Copy5RowsOfTilemapInHBlank_VBK1
	hlcoord 0, 3
	ld de, BG_MAP_WIDTH * 3
	call Copy5RowsOfTilemapInHBlank_VBK0
	hlcoord 0, 8, wAttrMap
	ld de, BG_MAP_WIDTH * 8
	call Copy5RowsOfTilemapInHBlank_VBK1
	hlcoord 0, 8
	ld de, BG_MAP_WIDTH * 8
	call Copy5RowsOfTilemapInHBlank_VBK0
	hlcoord 0, 13, wAttrMap
	ld de, BG_MAP_WIDTH * 13
	call Copy5RowsOfTilemapInHBlank_VBK1
	hlcoord 0, 13
	ld de, BG_MAP_WIDTH * 13

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
	ld [hSPBuffer], sp

	ld sp, hl
	ldh a, [hBGMapAddress + 1]
	ld h, a
	ldh a, [hBGMapAddress]
	ld l, a
	add hl, de

	ld a, b
.loop
	ldh [hTilesPerCycle], a
; if in v/hblank, wait until not in v/hblank
	pop bc
	pop de
	ldh a, [rLY]
	cp $90
	jr nc, .inVBlank1
.waitnohbl1
	ldh a, [rSTAT]
	and %10
	jr z, .waitnohbl1
.waithbl1
	ldh a, [rSTAT]
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
	ldh a, [rLY]
	cp $90
	jr nc, .inVBlank2
.waitnohbl2
	ldh a, [rSTAT]
	and %10
	jr z, .waitnohbl2
.waithbl2
	ldh a, [rSTAT]
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

	ld de, BG_MAP_WIDTH - (SCREEN_WIDTH - 1)
	add hl, de

	ldh a, [hTilesPerCycle]
	dec a
	jr nz, .loop

	ld sp, hSPBuffer
	pop hl
	ld sp, hl
	ret
