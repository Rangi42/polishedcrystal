Pokedex_Copy1bpp:
; Copies c tiles from b:hl to de. Avoids running Copy1bpp during HBlank.
	push bc
.loop
	ldh a, [rLY]
	ld b, a
	ldh a, [rLYC]
	sub b
	cp c
	jr c, .loop
	pop bc
	call SwapHLDE
	di
	call Copy1bpp
	reti

Pokedex_Get2bpp:
; Copies c tiles from b:hl to de. Avoids running Copy2bpp during HBlank.
	push bc
.loop
	ldh a, [rLY]
	cp $84
	jr nc, .loop
	ld b, a
	ldh a, [rLYC]
	sub b
	cp $10
	jr c, .loop
	pop bc
	call SwapHLDE
	di
	call Get2bpp
	reti

Pokedex_SetTilemap:
; Copies between wDexTilemap+wDexAttrmap (32x21) and wTilemap/wAttrmap (20x18).
; b controls the following:
; If bit 0 is set, copy from wDex*map instead of to it.
	ld a, BANK(wDexTilemap)
	call StackCallInWRAMBankA
.Function:
	ld hl, wDexTilemap
	ld de, wTilemap
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
	; Reload dex number ball display
	; Don't display a ball if mon isn't caught.
	ld a, [wPokedexOAM_IsCaught]
	and a
	ld a, $7f
	ld [wDexNoStrBall], a
	jr z, .dexno_ball_done

	; Never display it in Bio/Stats/Area pages.
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_BIO
	jr nc, .dexno_ball_done

	; Otherwise, display a ball.
	xor a ; the ball occupies tile ID 0.
	ld [wDexNoStrBall], a

.dexno_ball_done
	call Pokedex_RefreshOAM

	call SetDefaultBGPAndOBP
	ld hl, wPokedex_GFXFlags
	set DEXGFX_TILEMAP, [hl]
.tilemap_delay
	call DelayFrame
	bit DEXGFX_TILEMAP, [hl]
	jr nz, .tilemap_delay
	ret

Pokedex_WriteOAMFromHL:
; Writes d sprites starting from OAM sprite e.
; Input: bc = xy, d = length, e = starting OAM, [hl] = tiles, a = attributes
	push de
	ld d, a
	ld a, [hli]
	push hl
	ld l, a
	ld h, d
	ld d, 1
	call Pokedex_WriteOAM
	ld a, h
	pop hl
	pop de
	inc e
	dec d
	jr nz, Pokedex_WriteOAMFromHL
	ret

StackDexGraphics:
	pop de
	ldh a, [hBGMapMode]
	ld b, a
	ldh a, [hVBlank]
	ld hl, wOptions1
	ld c, [hl]
	push hl
	push bc
	push af
	ld a, 4
	ldh [hVBlank], a
	set NO_TEXT_SCROLL, [hl]

	push de
	call ClearScreen
	call ClearPalettes
	farcall WipeAttrMap
	call ClearSprites
	call ClearSpriteAnims
	ld a, [wStateFlags]
	res SPRITE_UPDATES_DISABLED_F , a
	ld [wStateFlags], a

	xor a
	ldh [hBGMapMode], a
	ld [wPokedex_PendingLYC], a

	; Set up tile graphics
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDex2bpp)
	ldh [rSVBK], a

	; The reason we copy like this is because we want to copy some of the tiles
	; to a template to write out VWF dex numbers later.
	ld hl, PokedexTileLZ
	ld de, wDex2bpp
	ld a, BANK(PokedexTileLZ)
	call FarDecompressToDE

	; pokedex0
	ld de, wDex2bpp
	push de
	ld hl, vTiles2 tile $00
	ld c, $3d
	call Get2bpp

	; grid lines and scrollbar tiles
	ld de, wDex2bpp tile $38
	ld hl, vTiles0 tile $70
	ld c, $8
	call Get2bpp

	; pokedex1
	ld a, 1
	ldh [rVBK], a
	ld de, wDex2bpp tile $40
	ld hl, vTiles5 tile $00
	ld c, $3a
	call Get2bpp

	; area
	ld de, wDex2bpp tile $80
	ld hl, vTiles3 tile $00
	ld c, $40
	call Get2bpp

	; (partial) unown font
	ld de, FontUnown
	ld hl, vTiles4
	lb bc, BANK(FontUnown), $20
	call Get1bpp

	; slowpoke oam
	ld hl, PokedexSlowpokeLZ
	ld de, vTiles3 tile $40
	lb bc, BANK(PokedexSlowpokeLZ), $2d
	call DecompressRequest2bpp
	xor a
	ldh [rVBK], a

	; fill out the "No." part in the "*No.123" string.
	ld hl, wDexNoStrNo
	ld a, "№"
	ld [hli], a
	ld [hl], "."

	; ensure that vTiles0 $7f is whitespace (for the benefit of area display)
	pop hl
	push hl
	ld bc, 1 tiles
	xor a
	rst ByteFill
	pop de
	ld hl, vTiles0 tile $7f
	lb bc, BANK(PokedexTileLZ), 1
	call Get2bpp

	ld hl, PokedexObjLZ
	ld de, vTiles0
	lb bc, BANK(PokedexObjLZ), 31
	call DecompressRequest2bpp

	; Gender symbols
	ld hl, BattleExtrasGFX
	ld de, vTiles2 tile $7d
	lb bc, BANK(BattleExtrasGFX), 2
	call DecompressRequest2bpp

	; Set up a conversion table for Johto dex numbers.
	ld a, BANK(wDexConversionTable)
	ldh [rSVBK], a
	ld de, 0
	ld bc, NUM_POKEMON + $100 ; "+ $100" simplifies loop iteration
.conversion_loop
	push bc
	ld hl, NewPokedexOrder
	add hl, de
	add hl, de
	ld a, [hli]
	ld b, [hl]
	ld c, a
	inc de
	call GetNationalDexNumber
	ld hl, wDexConversionTable - 2
	add hl, bc
	add hl, bc
	ld a, d
	ld [hli], a
	ld [hl], e
	pop bc
	dec c
	jr nz, .conversion_loop
	dec b
	jr nz, .conversion_loop
	pop af
	ldh [rSVBK], a

	call Pokedex_InitData

	; Reset shininess and palettes for minis
	xor a
	ld [wPokedex_Personality], a
	dec a
	ld hl, wPokedex_Pals
	ld bc, wPokedex_PalsEnd - wPokedex_Pals
	rst ByteFill

	; Prepare H-blank code.
	ld hl, PHB_LCDCode
	ld de, wLCDPokedex
	ld bc, PHB_LCDCode.End - PHB_LCDCode
	rst CopyBytes
	ld a, LOW(wLCDPokedex)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(wLCDPokedex)
	ldh [hFunctionTargetHi], a

	ld a, CGB_POKEDEX
	call GetCGBLayout

	ld a, 4
	ldh [hSCX], a
	ldh [hSCY], a

	pop de
	call _de_

	call ClearPalettes
	call ClearSprites
	call ClearSpriteAnims
	ld hl, wPokedex_GFXFlags
	set DEXGFX_TILEMAP, [hl]
.loop
	bit DEXGFX_TILEMAP, [hl]
	jr z, .done_update
	call DelayFrame
	jr .loop
.done_update
	ld hl, rIE
	res LCD_STAT, [hl]
	ld a, 1 << rSTAT_INT_DEFAULT
	ldh [rSTAT], a
	ld a, LOW(LCDGeneric)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDGeneric)
	ldh [hFunctionTargetHi], a

	pop af
	pop bc
	pop hl
	ldh [hVBlank], a
	ld [hl], c
	ld a, b
	ldh [hBGMapMode], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	farcall _DecompressMetatiles

	; If we're in "new dex description" mode, do a couple of more things.
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_NEWDESC
	ret nz

	call ClearTileMap
	hlcoord 7, 2
	ld a, $40
	call _PlaceFrontpicAtHL
	farcall GetEnemyMonDVs
	ld de, wTempMonDVs
	ld bc, 5
	rst CopyBytes
	ld a, CGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetCGBLayout
	ld b, 2
	jmp SafeCopyTilemapAtOnce

Pokedex_RefreshOAM:
; Reloads OAM data.
	; We really only use sprite anims for the list cursor, but calling this
	; unconditionally also wipes the sprite table. Convenient!
	farcall PlaySpriteAnimations

	; Add "*No.123" back.
	ld a, [wPokedexOAM_DexNoX]
	ld b, a
	ld a, [wPokedexOAM_DexNoY]
	ld c, a
	ld hl, wDexNoStr
	lb de, 6, 34 ; length, OAM index
	xor a ; attributes
	call Pokedex_WriteOAMFromHL

	ld a, [wPokedex_DisplayMode]
	sub DEXDISP_SEARCH
	jr c, .indicator_done

	; Handle bottom bar
	push af
	ld l, a
	add a
	add a
	add l
	add LOW(DexDisplayOAMData)
	ld l, a
	adc HIGH(DexDisplayOAMData)
	sub l
	ld h, a

	; Should we draw it in the first place?
	ld a, [hli]
	and a
	jr z, .indicator_oam ; cp DEXDISP_SEARCH

	; Draw bottom bar cursor
	ld c, 152 ; y
	ld b, a ; x
	push hl
	lb de, 1, 0 ; length, oam number
	lb hl, 0, $17 ; attributes, tile id
	call Pokedex_WriteOAM

	; Don't draw the middle menu options if mon isn't caught§
	ld a, [wPokedexOAM_IsCaught]
	and a
	jr z, .pop_hl_indicator_oam

	; Bio
	ld b, $42
	ld d, 2
	call Pokedex_WriteOAM

	; Stats
	ld b, $5b
	ld d, 3
	call Pokedex_WriteOAM

.pop_hl_indicator_oam
	pop hl
.indicator_oam
	pop af

	; In description mode, only display indicator if we have seen forms.
	; This is specifically in regular description mode, we don't want to
	; display it in the "new dex entry".
	assert DEXDISP_SEARCH + 1 == DEXDISP_DESC
	dec a ; cp DEXDISP_DESC - DEXDISP_SEARCH
	jr z, .fix_indicator
	sub DEXDISP_NEWDESC - DEXDISP_DESC
	jr nz, .indicator_ok
	jr .indicator_done
.fix_indicator
	ld a, [wPokedex_OtherForm]
	rra
	jr nc, .indicator_done

.indicator_ok
	; If y=0, skip this.
	ld a, [hli]
	and a
	jr z, .indicator_done
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld d, [hl]
	ld l, a
	ld h, 1
	ld e, 9
	call Pokedex_WriteOAM

.indicator_done
	; These need additional sprite handling, handled seperately.
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_STATS
	jr nz, .not_stats

	; Ability display
	lb bc, 76, 100
	lb de, 1, 15
	lb hl, 0, $1d

	ldh a, [hPokedexStatsCurAbil]
	cp 2 ; 0/1/2 -> 1/2/H
	jr z, .got_ability
	add "1"
	ld l, a
.got_ability
	call Pokedex_WriteOAM

	; (A) button for ability display
	ld b, 92
	ld d, 2
	lb hl, VRAM_BANK_1 | 1, $3d
	jr Pokedex_WriteOAM

.not_stats
	cp DEXDISP_SEARCH
	jr z, .search
	cp DEXDISP_AREA
	jmp z, Pokedex_GetAreaOAM
	and a ; cp DEXDISP_MAIN
	jr z, Pokedex_GetMainOAM
	ret

.search
	ld a, [wPokedex_SearchInProgress]
	and a
	ret nz

	; Write (static) slowpoke frame.
	ld c, 120
	ld e, 15
	lb hl, VRAM_BANK_1, $40
	ld a, 3
.search_loop
	ld b, 120
	ld d, 3
	push af
	call Pokedex_WriteOAM
	ld a, l
	add 12
	ld l, a
	ld a, c
	add 8
	ld c, a
	pop af
	dec a
	jr nz, .search_loop
	ret

Pokedex_WriteOAMSingleTile:
; Writes a line of sprites, all with the same tile ID.
	ld a, d
.loop
	push af
	ld d, 1
	call Pokedex_WriteOAM
	dec l
	pop af
	dec a
	jr nz, .loop
	ret

Pokedex_WriteOAM:
; Writes d sprites starting from OAM sprite e.
; Input: bc = xy, d = length, e = starting OAM, h = attributes, l = tile ID
	push de
	push hl
	ld l, e
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, wShadowOAM
	add hl, de
	pop de
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	add 8
	ld b, a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld h, d
	ld l, e
	pop de
	inc l ; next tile
	inc e ; next OAM
	dec d
	jr nz, Pokedex_WriteOAM
	ret

Pokedex_GetMainOAM:
	; Poké balls
	ld hl, wShadowOAMSprite12
	lb bc, 12, 5
	xor a
.ball_oam_loop
	ld [hli], a
	ld a, b
	ld [hli], a
	add 30
	ld b, a
	xor a
	ld [hli], a
	ld [hli], a
	dec c
	jr nz, .ball_oam_loop

	; Minis
	lb bc, 46, 3
.mini_oam_outer_loop
	lb de, 4, 8
.mini_oam_loop
	xor a
	ld [hli], a
	ld a, b
	ld [hli], a
	add e
	ld b, a
	ld a, e
	cpl
	inc a
	ld e, a
	xor a
	ld [hli], a
	; VRAM_BANK_1 + 8 - 1/2/3 == VRAM_BANK_1 | 7/6/5
	ld a, VRAM_BANK_1 + 8
	sub c
	ld [hli], a
	dec d
	jr nz, .mini_oam_loop
	ld a, b
	add 30
	ld b, a
	dec c
	jr nz, .mini_oam_outer_loop

	; Figure out scrollbar position.
	xor a
	push hl
	ld hl, hMultiplicand
	ld [hli], a
	ld [hli], a
	ld a, [wPokedex_Offset]
	ld [hli], a
	ld a, 55
	ldh [hMultiplier], a
	farcall Multiply
	ld b, 4
	ld a, [wPokedex_Rows]
	sub 3
	ldh [hDivisor], a
	ld a, 0 ; no-optimize a = 0
	jr c, .got_scrollbar_offset
	jr z, .got_scrollbar_offset
	farcall Divide
	ldh a, [hQuotient + 2]
	add 85

.got_scrollbar_offset
	pop hl
	ld [hli], a
	ld a, 160
	ld [hli], a
	ld a, 4
	ld [hli], a
	ld a, 1
	ld [hli], a
	ret

Pokedex_UnsafeSetHBlankFunction:
; Can be used by H-blank functions for sequential triggers, since those use
; consistent timings and don't require the error-checking.
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
PHB_LCDCode:
LOAD UNION "Misc 404", WRAM0
wLCDPokedex::
	ldh a, [hROMBank]
	ldh [hROMBankBackup], a
	ld a, BANK(PHB_LCDCode)
	rst Bankswitch
	db $cd ; call
wPokedex_HBlankFunction::
	dw DoNothing ; replaced with the actual function
	ldh a, [hROMBankBackup]
	rst Bankswitch
	pop af
	reti
wLCDPokedexEnd::
ENDL
.End:

PHB_WaitUntilLY_Mode0:
; Don't use this for more timing-critical h-blank setups.
; Wait until mode0 for LY in b.
.busyloop
	ldh a, [rLY]
	cp b
	jr nz, .busyloop
.busyloop2
	ldh a, [rSTAT]
	and rSTAT_MODE_MASK ; wait until mode 0
	jr nz, .busyloop2
	ret

PHB_ModeSwitchSCY:
	push hl
	push de
	ld de, PHB_ModeSwitchSCY2
	lb hl, 7, $60
	jr PHB_DoSwitchSCY

PHB_ModeSwitchSCY2:
	push hl
	push de
	ld de, PHB_ModeSwitchSCY3
	lb hl, 9, $7e
	jr PHB_DoSwitchSCY

PHB_ModeSwitchSCY3:
	push hl
	push de
	ld de, PHB_ModeSwitchSCY4

	; reuse the spacing between the 2 description lines
	lb hl, -4, $83
	jr PHB_DoSwitchSCY

PHB_ModeSwitchSCY4:
	push hl
	push de
	ld de, PHB_ModeSwitchSCY
	lb hl, 8, $57
	; fallthrough
PHB_DoSwitchSCY:
; Switch SCY to h, then set next hblank event to de with LYC=l
	push bc
.loop
	ldh a, [rSTAT]
	and rSTAT_MODE_MASK
	jr nz, .loop
	ld a, h
	ldh [rSCY], a
	ld a, l
	call Pokedex_UnsafeSetHBlankFunction
	jmp PopBCDEHL

PHB_DescSwitchSCY:
	push hl
	push de
	push bc
.busyloop
	ldh a, [rSTAT]
	and rSTAT_MODE_MASK ; wait until mode 0
	jr nz, .busyloop
	ld a, 8
	ldh [rSCY], a
	jmp PopBCDEHL

PHB_BioStatsSwitchSCY:
	push hl
	push de
	ld de, PHB_BioStatsSwitchSCY2
	lb hl, 3, $87
	jr PHB_DoSwitchSCY

PHB_BioStatsSwitchSCY2:
	push hl
	push de
	ld de, PHB_BioStatsSwitchSCY
	lb hl, 8, $84
	jr PHB_DoSwitchSCY

PHB_SearchSwitchSCY:
	push hl
	push de
	ld de, PHB_SearchSetOAM
	lb hl, 8, $40
	jr PHB_DoSwitchSCY

PHB_SearchSetOAM:
; needed to handle slowpoke animation when enabled
	push hl
	push de
	push bc
	ld a, [wPokedex_SearchInProgress]
	and a
	jr z, .oam_done
	call Pokedex_RefreshOAM
	call ForcePushOAM
.oam_done
	ld a, $88
	ld de, PHB_SearchSwitchSCY2
	call Pokedex_UnsafeSetHBlankFunction
	jmp PopBCDEHL

PHB_SearchSwitchSCY2:
	push hl
	push de
	ld de, PHB_SearchSwitchSCY3
	; -117 is the top of the window above "Order".
	lb hl, -117, $8b
	jr PHB_DoSwitchSCY

PHB_SearchSwitchSCY3:
	push hl
	push de
	ld de, PHB_SearchSwitchSCY
	lb hl, 4, $f
	jr PHB_DoSwitchSCY

PHB_Row1:
	push hl
	push de
	push bc
	ld hl, wPokedex_Row1
	ld d, 80
	call PHB_LoadRow

	ld a, $57
	ld de, PHB_Row2
	call Pokedex_UnsafeSetHBlankFunction
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
	call Pokedex_UnsafeSetHBlankFunction
	jmp PopBCDEHL

PHB_Row3:
	push hl
	push de
	push bc
	ld hl, wPokedex_Row3
	ld d, 128
	call PHB_LoadRow

	ld a, $87
	ld de, PHB_MainResetLCDC
	call Pokedex_UnsafeSetHBlankFunction
	jmp PopBCDEHL

PHB_MainResetLCDC:
	push hl
	push de
	push bc
	ld a, $3f
	ld de, PHB_Row1
	call Pokedex_UnsafeSetHBlankFunction
.loop
	ldh a, [rSTAT]
	and rSTAT_MODE_MASK ; wait until mode 0
	jr nz, .loop
	ld hl, rLCDC
	res rLCDC_TILE_DATA, [hl]
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
	ldh a, [rLCDC]
	set rLCDC_TILE_DATA, a
	ldh [rLCDC], a

	call .GetCaptureOffset
	pop de

	ld c, 33
	call PHB_BusyLoop

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
	ld a, (1 << rBGPI_AUTO_INCREMENT) | (0 palette 2 color 2)
	ld c, LOW(rBGPD)
	ldh [rBGPI], a
rept 6
	ld a, [hli]
	ldh [c], a
endr
	ld a, (1 << rOBPI_AUTO_INCREMENT) | (0 palette 5 color 2)
	ldh [rOBPI], a
	pop de
	push de

	; Sprite tiles and pal col 2-3
	ld a, e
	xor $80
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

	; Pal col 2 (OBJ5) on first iteration, col 3 (OBJ6) on the second.
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
	ld a, (1 << rBGPI_AUTO_INCREMENT) | (0 palette 3 color 2)
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

	; Pal col 4 (OBJ7) on first iteration, col 5 (BG3) on the second.
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
	; a = carry (iff a == 0) ? d : 0
	cp 1 ; no-optimize a == 1 (dec a can't set carry)
	sbc a
	and d
	ret

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

	; Update the tilemap last if several kinds are pending.
	; The reason this is checked here instead of later is because
	; this just barely makes it in time before leaving VBlank, so.
	; checking it last in a sequence causes us to run out of time.
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

	; done with time-critical activities

	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_AREA
	jr nz, .no_area

	ld a, [wDexAreaMonOffset]
	xor $80
	ld [wDexAreaMonOffset], a

	; wDexAreaModeCopy is used by h-blank
	ldh a, [hPokedexAreaMode]
	ld [wDexAreaModeCopy], a

	ld hl, wShadowOAM
	ld de, wDexAreaShadowOAM
	ld bc, wShadowOAMEnd - wShadowOAM
	rst CopyBytes
	jr .done_copy

.no_area
	and a ; cp DEXDISP_MAIN
	jr nz, .done_copy
	ld hl, wDexPalCopy
	ld de, wPokedex_Pals
	ld bc, wPokedex_PalsEnd - wPokedex_Pals
	rst CopyBytes

.done_copy
	; update HBlank trigger if applicable
	ld a, [wPokedex_PendingLYC]
	and a
	jmp z, .done
	ldh [rLYC], a
	xor a
	ld [wPokedex_PendingLYC], a
	ld hl, wPokedex_PendingHBlankFunction
	ld de, wPokedex_HBlankFunction
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	jmp .done

.no_tilemap
	bit DEXGFX_FRONTPIC, [hl]
	res DEXGFX_FRONTPIC, [hl]
	jr z, .frontpic_done

	ld a, [wPokedex_MonInfoBank]
	ldh [rVBK], a
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	call GetPaddedFrontpicAddress
	ld bc, vTiles2 tile $40
	ld a, 7 * 7 - 1
	call GDMACopy
	ld a, BANK(wDex2bpp)
	ldh [rSVBK], a

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
	ld a, 1
	ldh [rVBK], a
	bit DEXGFX_ICONSHAPE, [hl]
	res DEXGFX_ICONSHAPE, [hl]
	jr z, .iconshape_done

	ld a, [wPokedex_MonInfoBank]
	swap a
	rrca
	ld c, a
	ld a, [wPokedex_FirstIconTile]
	add c
	swap a
	ld c, a
	and $f
	add HIGH(vTiles4)
	ld b, a
	ld a, c
	and $f0
	ld c, a ; ld bc, vTiles4 tile (wPokedex_FirstIconTile + wPokedex_MonInfoBank * 8)
	ld de, wDexMonIconTiles
	ld a, 7
	call GDMACopy

.iconshape_done
	bit DEXGFX_ROWTILES, [hl]
	res DEXGFX_ROWTILES, [hl]
	jr z, .done

	push hl
	xor a
	ldh [rVBK], a
	ld hl, wDexRowTilesDest
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld de, wDexVWFTiles
	ld a, 17
	call GDMACopy
	ld a, 1
	ldh [rVBK], a
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

DexDisplayOAMData:
; botmenu cursor x, indicator y, indicator x, indicator offset, indicator length
	db   0, 145, 100, $0b, 6 ; DEXDISP_SEARCH
	db  32,  93,  31, $05, 6 ; DEXDISP_DESC
	db  62,  52, 132, $12, 4 ; DEXDISP_BIO
	db  87,   0,   0,   0, 0 ; DEXDISP_STATS
	db 122,   0              ; DEXDISP_AREA (last index can be < 6 bytes)
