Pokedex_Copy1bpp:
; Copies c tiles from b:hl to de. Avoids running Copy1bpp during HBlank.
	ldh a, [rLY]
	sub $3c
	jr c, .ok
.loop
	cp $4
	jr c, Pokedex_Copy1bpp
	sub $18
	jr nc, .loop
.ok
	call SwapHLDE
	di
	call Copy1bpp
	reti

Pokedex_SetTilemap:
; Copies between wDexTilemap+wDexAttrmap (32x32) and wTilemap/wAttrmap (20x18).
; b controls the following:
; If bit 0 is set, copy from wDex*map instead of to it.
	ld a, BANK(wDexTilemap)
	call StackCallInWRAMBankA
.Function:
	ld hl, wDexTilemap
	ld de, wTileMap
	call .Copy
	; fallthrough
.Copy:
	ld c, SCREEN_HEIGHT
.loop
	push bc
	bit DEXTILE_FROM_DEXMAP_F, b
	push af
	call z, SwapHLDE
	lb bc, 0, SCREEN_WIDTH
	rst CopyBytes
	pop af
	call z, SwapHLDE
	ld c, BG_MAP_WIDTH - SCREEN_WIDTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	push bc
	ld bc, BG_MAP_WIDTH
	add hl, bc
	pop bc
	ret

Pokedex_RefreshScreen:
; Refreshes the screen. Prefer ScheduleScreenUpdate to reduce on needless
; screen updates, which defers the refresh until Pokedex_GetInput.
	; Copy the normal tilemap to the larger dex tilemap.
	ld b, 0
	call Pokedex_SetTilemap

	ld a, BANK(wDexTilemap)
	call StackCallInWRAMBankA
.Function:
	; This will be overwritten, so back it up.
	ld hl, wVirtualOAMSprite12
	ld de, wDexVirtualOAMCopy
	ld bc, wDexVirtualOAMCopyEnd - wDexVirtualOAMCopy
	push bc
	push de
	push hl
	rst CopyBytes

	; Reload dex number display, should only be visible for main and description pages.
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_DESC
	jr z, .got_y
	and a
	jr z, .got_y
	xor a
	ld [wPokedexOAM_DexNoY], a
.got_y
	ld a, [wPokedexOAM_DexNoX]
	ld e, a
	ld bc, 2
	ld hl, wDexVirtualOAMDexNoCopy
	ld d, 6
	ld a, [wPokedexOAM_IsCaught]
	and a
	jr z, .dexno_y_loop
	ld a, [wPokedexOAM_DexNoY]
.dexno_y_loop
	ld [hli], a
	ld a, e
	ld [hli], a
	add 8
	ld e, a
	ld a, [wPokedexOAM_DexNoY]
	add hl, bc
	dec d
	jr nz, .dexno_y_loop
	ld c, 4
	ld hl, wDexVirtualOAMDexNoCopy + 14
	ld de, wPokedexOAM_DexNoStr
	ld a, 3
.dexno_str_loop
	push af
	ld a, [de]
	inc de
	ld [hl], a
	add hl, bc
	pop af
	dec a
	jr nz, .dexno_str_loop

	; Scrollbar should only be visible in the main dex display mode.
	ld a, [wPokedex_DisplayMode]
	and a ; cp DEXDISP_MAIN
	ld a, 0
	jr nz, .got_scrollbar_offset

	; Figure out scrollbar position.
	ld hl, hMultiplicand
	ld [hli], a
	ld [hli], a
	ld a, [wPokedex_Offset]
	ld [hli], a
	ld a, 55
	ldh [hMultiplier], a
	call Multiply
	ld b, 4
	ld a, [wPokedex_Rows]
	sub 3
	ldh [hDivisor], a
	ld a, 0
	jr c, .got_scrollbar_offset
	call Divide
	ldh a, [hQuotient + 2]
	add 85

.got_scrollbar_offset
	ld [wDexVirtualOAMScrollbarCopy], a
	farcall PlaySpriteAnimations
	ld a, [wPokedex_DisplayMode]
	sub DEXDISP_SEARCH
	jr c, .copy_back

	push af
	ld e, a
	add a
	add a
	add e
	add LOW(DexDisplayOAMData)
	ld e, a
	add HIGH(DexDisplayOAMData)
	sub e
	ld d, a
	ld hl, wVirtualOAMSprite00
	pop af
	jr z, .indicator_oam ; cp DEXDISP_SEARCH

	ld a, 152
	ld b, a
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ld a, $17
	ld c, a
	ld [hli], a
	ld a, 1
	ld [hli], a
	ld a, [wPokedexOAM_IsCaught]
	and a
	jr z, .indicator_oam
	push de
	ld de, DexBotMenuXPositions
	ld a, [de]
.botmenu_oam_loop
	ld [hl], b
	inc hl
	ld [hli], a
	inc c
	ld a, c
	ld [hli], a
	xor a
	ld [hli], a
	inc de
	ld a, [de]
	and a
	jr nz, .botmenu_oam_loop
	pop de

.indicator_oam
	inc de
	ld a, [de] ; indicator y pos
	and a
	jr z, .copy_back
	push hl
	ld h, d
	ld l, e
	ld b, a
	inc hl
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld e, [hl]
	pop hl
.indicator_oam_loop
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	add 8
	ld c, a
	ld a, d
	ld [hli], a
	inc d
	ld a, 1
	ld [hli], a
	dec e
	jr nz, .indicator_oam_loop

	; Copy it back.
.copy_back
	pop de
	pop hl
	pop bc
	rst CopyBytes

	call SetPalettes
	ld hl, wPokedex_GFXFlags
	set DEXGFX_TILEMAP, [hl]
.tilemap_delay
	call DelayFrame
	bit DEXGFX_TILEMAP, [hl]
	jr nz, .tilemap_delay
	ret

Pokedex_SetHBlankFunctionToRow1:
	ld a, $3f
	ld de, PHB_Row1
	; fallthrough
Pokedex_SetHBlankFunction:
	ldh [rLYC], a
	ld a, e
	ld [wPokedex_HBlankFunction], a
	ld a, d
	ld [wPokedex_HBlankFunction + 1], a
	ret

; Pokédex HBlank/VBlank functions.

; All PHB functions are timing-critical down to single cycles. Do not optimize
; for space unless you align the cycles exactly the same (Don't optimize for
; speed either, there's no point since everything here is busylooping).
; An interrupt can trigger with between 0 and 5 cycles of imprecision.
; Thus, we assume worst-case mode0 access. Mode2 is always 40 cycles in
; doublespeed while worst-case mode0 is 37 after factoring in interrupt latency.
PHB_WRAMCode:
	push af
	ldh a, [hROMBank]
	ldh [hROMBankBackup], a
	ld a, BANK(PHB_WRAMCode)
	rst Bankswitch
	call DoNothing ; replaced with the actual function
	ldh a, [hROMBankBackup]
	rst Bankswitch
	pop af
	reti
PHB_WRAMCodeEnd:

PHB_DescSwitchSCY:
	push hl
	push de
	push bc
.busyloop
	ldh a, [rSTAT]
	and %11
	jr nz, .busyloop
	ld a, 8
	ldh [rSCY], a
	jmp PopBCDEHL

PHB_BioStatsSwitchSCY:
	push hl
	push de
	push bc
.busyloop
	ld a, [rSTAT]
	and %11
	jr nz, .busyloop
	ld a, 3
	ldh [rSCY], a
	ld a, $87
	ld de, _PHB_BioStatsSwitchSCY
	call Pokedex_SetHBlankFunction
	jmp PopBCDEHL

_PHB_BioStatsSwitchSCY:
	push hl
	push de
	push bc
.busyloop
	ld a, [rSTAT]
	and %11
	jr nz, .busyloop
	ld a, 8
	ldh [rSCY], a
	ld a, $84
	ld de, PHB_BioStatsSwitchSCY
	call Pokedex_SetHBlankFunction
	jmp PopBCDEHL

PHB_Row1:
	push hl
	push de
	push bc
	ld hl, wPokedex_Row1
	ld d, 80
	call PHB_LoadRow

	ld a, $57
	ld de, PHB_Row2
	call Pokedex_SetHBlankFunction
	jmp PopBCDEHL

PHB_Row2:
	push hl
	push de
	push bc
	ld hl, wPokedex_Row2
	ld d, 104
	call PHB_LoadRow

	ld a, $6f
	ld de, PHB_Row3
	call Pokedex_SetHBlankFunction
	jmp PopBCDEHL

PHB_Row3:
	push hl
	push de
	push bc
	ld hl, wPokedex_Row3
	ld d, 128
	call PHB_LoadRow

	call Pokedex_SetHBlankFunctionToRow1
	jmp PopBCDEHL

PHB_LoadRow:
; Loads hblank-tied vram data for a dex row. d is Y offset, [hl] is row data.
	ld e, [hl]
	push de
	push hl
	ld a, 2
.loop
	push af
	call .GetCaptureOffset
	ld b, a
	call .GetCaptureOffset
	ld c, a
	pop af
	push bc
	dec a
	jr nz, .loop

	; Redundant for row2 and row3, but this is a fitting location for row1.
	ldh [rSCX], a
	ld a, 8
	ldh [rSCY], a
	call .GetCaptureOffset
	pop de

	; This places the OAM writes within the worst-case mode0 margin.
	; Delay for exactly 2 + (1 + 3) * 34 + 1 + 2 = 141 cycles.
	ld b, 35
.fixtiming1
	dec b
	jr nz, .fixtiming1

	; Write poké ball presence info
	ld hl, oamSprite12YCoord + 16
	ld bc, -4
	ld [hl], a
	add hl, bc
	ld [hl], e
	add hl, bc
	ld [hl], d
	add hl, bc
	pop de
	ld [hl], e
	add hl, bc
	ld [hl], d

	; Pal col 1 (BG2).
	pop hl
	inc hl
	ld a, $80 | $12
	ld c, LOW(rBGPD)
	ldh [rBGPI], a
rept 6
	ld a, [hli]
	ldh [c], a
endr
	ld a, $80 | $12
	ldh [rOBPI], a
	pop de
	push de

	; Sprite tiles and pal col 2-3
	ld a, e
	or $80
	ld de, oamSprite17TileID
	ld b, 33
	call .WriteMiniTiles
	ld de, oamSprite23TileID
	ld b, 36
	call .WriteMiniTiles

	pop de
	push de

	ld a, d
	ld de, oamSprite17YCoord
	lb bc, 29, rOBPD
	call .WriteMiniY
	ld de, oamSprite19YCoord
	lb bc, 35, rBGPD
	call .WriteMiniY
	pop de
	ret

.WriteMiniTiles:
	push hl
	ld h, d
	ld l, e
	ld e, a
	ld c, 4
.fixtiming2
	dec b
	jr nz, .fixtiming2
rept 5
	ld [hl], e
	inc e
	add hl, bc
endr
	ld [hl], e
	inc e

	; Pal col 2 (OBJ2) on first iteration, col 3 (OBJ3) on the second.
	pop hl
	ld c, LOW(rOBPD)
rept 6
	ld a, [hli]
	ldh [c], a
endr
	; advance to the next pal quickly
	ldh [c], a ; no-optimize useless loads (rOBPD)
	ldh [c], a

	; Prepare this for later.
	ld a, $80 | $1a
	ldh [rBGPI], a
	ld a, e
	ret

.WriteMiniY:
	push hl
	push bc
	ld h, d
	ld l, e
	ld de, 12
	ld c, 4
.fixtiming3
	dec b
	jr nz, .fixtiming3
	add 8
rept 3
	ld [hl], a
	add hl, bc
	ld [hl], a
	add hl, de
endr
	ld d, a

	; Pal col 4 (OBJ4) on first iteration, col 5 (BG3) on the second.
	pop bc
	pop hl
rept 6
	ld a, [hli]
	ldh [c], a
endr
	ld a, d
	ret

.GetCaptureOffset:
	push bc
	ld bc, 6
	add hl, bc
	pop bc
	ld a, [hl]
	cp 1
	ld a, d
	jr c, .end ; `ret c` desyncs the timing
	xor a
.end
	ret ; no-optimize stub function

PVB_UpdateDexMap::
; Reloads dex gfx data depending on wPokedex_GFXFlags.
	ld hl, wPokedex_GFXFlags
	ld a, [hl]
	and a
	ret z
	ldh a, [rSVBK]
	push af
	ldh a, [rVBK]
	push af
	ld a, BANK(wDexTilemap)
	ldh [rSVBK], a
	ld a, [hl]
	res DEXGFX_DEFERRED, a
	cp 1 << DEXGFX_TILEMAP
	jr nz, .no_tilemap

	xor a
	ldh [rVBK], a
	ld de, wDexTilemap
	ld bc, vBGMap0
	ld a, ((BG_MAP_WIDTH * (SCREEN_HEIGHT + 1)) >> 4) - 1
	call GDMACopy
	ld a, 1
	ldh [rVBK], a
	ld a, ((BG_MAP_WIDTH * (SCREEN_HEIGHT + 1)) >> 4) - 1
	call ContinueGDMACopy
	ld [hl], 0
	call ForcePushOAM
	call ForceUpdateCGBPals
	ld hl, wDexPalCopy
	ld de, wPokedex_Pals
	ld bc, wPokedex_PalsEnd - wPokedex_Pals
	rst CopyBytes
	jr .done

.no_tilemap
	bit DEXGFX_FRONTPIC, [hl]
	res DEXGFX_FRONTPIC, [hl]
	jr z, .frontpic_done

	ld a, [wPokedex_MonInfoBank]
	ldh [rVBK], a
	ld de, sScratch + 1 tiles
	ld bc, vTiles2 tile $40
	ld a, BANK(sScratch)
	call GetSRAMBank
	ld a, 48
	call GDMACopy
	call CloseSRAM

.frontpic_done
	bit DEXGFX_POKEINFO, [hl]
	res DEXGFX_POKEINFO, [hl]
	jr z, .pokeinfo_done
	ld a, [wPokedex_MonInfoBank]
	ldh [rVBK], a
	ld de, wDexMonType1Tiles
	ld bc, vTiles2 tile $71
	ld a, 11
	call GDMACopy

.pokeinfo_done
	bit DEXGFX_ROWTILES, [hl]
	res DEXGFX_ROWTILES, [hl]
	jr z, .done

	ld a, 1
	ldh [rVBK], a
	push hl
	ld hl, wDexRowTilesDest
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld de, wDexVWFTiles
	ld a, 17
	call GDMACopy
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld de, wDexIconTiles
	ld a, 19
	call GDMACopy
	pop hl

.done
	pop af
	ldh [rVBK], a
	pop af
	ldh [rSVBK], a
	ret

DexBotMenuXPositions:
	db 66, 74, 91, 99, 105, 0

DexDisplayOAMData:
; bottom menu cursor x pos, indicator y pos, indicator x pos, indicator start tile, indicator length
	db  0,   0,   0, $0b, 6 ; DEXDISP_SEARCH
	db 32,  93,  31, $05, 6 ; DEXDISP_DESC
	db  0,   0,   0,   0, 0 ; DEXDISP_AREA
	db 62,  52, 132, $12, 4 ; DEXDISP_BIO
	db 87,   0              ; DEXDISP_STATS (can be < 6 bytes since it's the highest index)

DexOAM:
INCBIN "gfx/pokedex/oam.2bpp.lz"
