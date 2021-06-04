	const_def
	const DEXTILE_FROM_DEXMAP_F

DEXTILE_FROM_DEXMAP EQU 1 << DEXTILE_FROM_DEXMAP_F

	const_def
	const DEXSTATE_MAIN_SCR
	const DEXSTATE_UPDATE_MAIN_SCR
	const DEXSTATE_DEX_ENTRY_SCR
	const DEXSTATE_UPDATE_DEX_ENTRY_SCR
	const DEXSTATE_REINIT_DEX_ENTRY_SCR
	const DEXSTATE_SEARCH_SCR
	const DEXSTATE_UPDATE_SEARCH_SCR
	const DEXSTATE_OPTION_SCR
	const DEXSTATE_UPDATE_OPTION_SCR
	const DEXSTATE_SEARCH_RESULTS_SCR
	const DEXSTATE_UPDATE_SEARCH_RESULTS_SCR
	const DEXSTATE_UNOWN_MODE
	const DEXSTATE_UPDATE_UNOWN_MODE
	const DEXSTATE_EXIT

	const_def
	const DEXDISP_MAIN
	const DEXDISP_DESC

	const_def
	const DEXPOS_MONS
	const DEXPOS_DEXNO
	const DEXPOS_ICON_TILES
	const DEXPOS_VWF_TILES
	const DEXPOS_ICON_VTILES
	const DEXPOS_VWF_VTILES
	const DEXPOS_ICONTILE_OFFSET
	const DEXPOS_VWFTILE_OFFSET
	const DEXPOS_TILEMAP
	const DEXPOS_ATTRMAP
	const DEXPOS_PALCOPY

Pokedex:
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

	call ClearScreen
	call ClearPalettes
	farcall WipeAttrMap
	call ClearSprites
	call ClearSpriteAnims
	ld a, [wVramState]
	res 0, a
	ld [wVramState], a

	xor a
	ldh [hBGMapMode], a

	; Set up tile graphics
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDex2bpp)
	ldh [rSVBK], a

	; TODO: compress dex tiles.
	; The reason we copy like this is because we want to copy some of the tiles
	; to a template to write out VWF dex numbers later.
	ld hl, PokedexLZ
	ld de, wDex2bpp
	ld a, BANK(PokedexLZ)
	call FarDecompressToDE

	ld de, wDex2bpp
	ld hl, vTiles2
	lb bc, BANK(PokedexLZ), $40
	call Get2bpp

	ld a, 1
	ldh [rVBK], a
	ld de, wDex2bpp tile $40
	ld hl, vTiles5 tile $18
	lb bc, BANK(PokedexLZ), $20
	call Get2bpp
	xor a
	ldh [rVBK], a

	ld de, DexOAM
	ld hl, vTiles0
	lb bc, BANK(DexOAM), 5
	call Get2bpp

	call .SetupVWFPreset

	pop af
	ldh [rSVBK], a

	; Prepare OAM
	call .PrepareOAM

	call Pokedex_InitData

	; Reset palettes for minis
	xor a
	dec a
	ld hl, wPokedex_Pals
	ld bc, wPokedex_PalsEnd - wPokedex_Pals
	rst ByteFill

	; Prepare H-blank code.
	ld hl, PHB_WRAMCode
	ld de, wPokedex_HBlankCode
	ld bc, PHB_WRAMCodeEnd - PHB_WRAMCode
	rst CopyBytes
	assert (PHB_WRAMCodeEnd - PHB_WRAMCode) == (wPokedex_HBlankCodeEnd - wPokedex_HBlankCode)
	ld a, LOW(wPokedex_HBlankCode)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(wPokedex_HBlankCode)
	ldh [hFunctionTargetHi], a

	ld a, CGB_POKEDEX
	call Pokedex_GetCGBLayout

	ld a, 4
	ldh [hSCX], a
	ldh [hSCY], a

	call Pokedex_GetCursorMonInVBK1
	call Pokedex_Main

	ld a, 1 << 6
	ldh [rSTAT], a
	ld hl, rIF
	res LCD_STAT, [hl]
	ld hl, rIE
	set LCD_STAT, [hl]

	xor a
	ld [wPokedex_CursorPos], a
	ld [wPokedex_MonInfoBank], a

	call Pokedex_MainLoop

	ld hl, rIE
	res LCD_STAT, [hl]
	ld a, 1 << 3
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
	ret

.PrepareOAM:
	; Poké balls
	ld hl, wVirtualOAMSprite12
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
	ld a, VRAM_BANK_1 | 5
	sub c
	ld [hli], a
	dec d
	jr nz, .mini_oam_loop
	ld a, b
	add 30
	ld b, a
	dec c
	jr nz, .mini_oam_outer_loop

	; Scrollbar
	ld a, 85
	ld [hli], a
	ld a, 160
	ld [hli], a
	ld a, 4
	ld [hli], a
	ld a, 1
	ld [hli], a

	; Dex number
	xor a
	ld bc, 24
	rst ByteFill

	ld a, "№"
	ld [wVirtualOAMSprite31TileID], a
	ld a, "."
	ld [wVirtualOAMSprite32TileID], a
	ret

.SetupVWFPreset:
; Sets up wDexVWFPreset appropriately.
	; First, copy the regular top line to the entire preset.
	ld hl, wDex2bpp
	ld de, wDexVWFPreset
	ld bc, 1 tiles
	push de
	rst CopyBytes
	pop hl
	; This will make 17 copies of the first tile.
	ld bc, 17 tiles
	rst CopyBytes

	; Then deal with the vertical dividers.
	ld hl, wDexVWFPreset tile $03
	ld b, 4
	call .VWFCopyTile
	ld b, 1
	; fallthrough

.VWFCopyTile:
	ld de, -1 tiles
	add hl, de
	ld de, wDex2bpp tile $02
.vwfloop1
	call .DoVWFCopy
	push bc
	ld bc, 3 tiles
	add hl, bc
	pop bc
	dec b
	ret z
	ld a, b
	dec a
	jr nz, .vwfloop1
	ld de, wDex2bpp tile $01
	jr .vwfloop1

.DoVWFCopy:
	ld c, 1 tiles
.vwfloop2
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .vwfloop2
	ret

Pokedex_LoadTilemapWithPokepic:
	ld a, BANK(wDexTilemap)
	call StackCallInWRAMBankA
.Function:
	ld de, wDexTilemap
	ld a, BANK(DexTilemaps)
	call FarDecompressToDE

	ld b, DEXTILE_FROM_DEXMAP
	call Pokedex_SetTilemap

	hlcoord 1, 1
	ld a, $40
	jmp _PlaceFrontpicAtHL

Pokedex_GetCursorSpecies:
; Returns species in c, form+ext in b that cursor is hovering.
	ld a, BANK(wDexMons)
	call StackCallInWRAMBankA
.Function:
	ld a, [wPokedex_CursorPos]
	push af
	swap a
	and $f
	ld hl, wPokedex_Offset
	add [hl]
	ld c, a
	ld b, 0
	ld a, 10
	ld hl, wDexMons
	rst AddNTimes
	pop af
	and $f
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, [hl]
	ld c, a
	ret

Pokedex_MainLoop:
.loop
	call Pokedex_GetInput
	rrca
	jr c, .pressed_a
	rrca
	ret c ; pressed b
	rrca
	jr c, .pressed_select
	rrca
	jr c, .pressed_start
	rrca
	jr c, .pressed_right
	rrca
	jr c, .pressed_left
	rrca
	jr c, .pressed_up
	rrca
	jr c, .pressed_down
	jr .loop

.pressed_a
	; Do nothing if we haven't seen what the cursor is hovering.
	call Pokedex_GetCursorSpecies
	ld a, c
	and a
	call nz, Pokedex_Description
	jr .loop
.pressed_start
	; TODO: search
	jr .loop
.pressed_select
	; TODO: mode switch
	jr .loop
.pressed_right
	ld a, 1
	jr .fixcursor
.pressed_left
	ld a, -1
	jr .fixcursor
.pressed_up
	ld a, -$10
	jr .fixcursor
.pressed_down
	ld a, $10
	; fallthrough
.fixcursor
	ld hl, wPokedex_CursorPos
.fixcursor_loop
	push af
	add [hl]
	ld [hl], a
	call .CursorPosValid
	pop bc
	ld a, b
	jr nc, .fixcursor_loop
	call Pokedex_GetCursorMon
	jr .loop

.CursorPosValid:
	; If we can't go further up or down, don't do anything.
	ld a, [hl]
	cp $f0
	jr c, .not_going_upwards
	add $10
	ld [hl], a
	push hl
	ld b, 0
	call .SwitchRow ; Returns a=0 c|z upon failure.
	pop hl
	jr nc, .not_going_downwards
	ld [hl], 0
	ret

.not_going_upwards
	cp $30
	jr c, .not_going_downwards
	sub $10
	ld [hl], a
	push hl
	ld b, 2
	call .SwitchRow
	pop hl
	jr nc, .not_going_downwards
	ld [hl], $24
	ret

.not_going_downwards
	ld a, [hl]
	and $f
	cp $5
	sbc a
	inc a
	ret

.ShiftRowData:
; Copies c bytes data between hl and de. b determines direction.
	push bc
	ld a, b
	ld b, 0
	and a
	jr nz, .shift_upwards
	add hl, bc
	call SwapHLDE
	add hl, bc
	dec hl
.reverse_copy_loop
	ld a, [hld]
	dec de
	ld [de], a
	dec c
	jr nz, .reverse_copy_loop
	pop bc
	ret

.shift_upwards
	rst CopyBytes
	pop bc
	ret

.SwitchRow:
	ld a, BANK(wDexPalCopy)
	call StackCallInWRAMBankA
.SwitchRow_Function:
	ld hl, wPokedex_Offset

	ld a, b
	and a
	jr z, .upwards

	; Don't move downwards past row offset (total - 3).
	ld a, [wPokedex_Rows]
	sub [hl]
	cp 4
	ret c
	inc [hl]

	; Minor optimization: +2-1 is shorter than jumping past descending.
	inc [hl]

.upwards
	; Don't move upwards past row offset 0.
	or [hl]
	scf
	ret z
	dec [hl]

	; Shift current row information around.
	ld de, wDexRow1Tile
	ld hl, wDexRow2Tile
	ld c, wDexRow3Tile - wDexRow1Tile
	call .ShiftRowData
	decoord 1, 9
	hlcoord 1, 12
	ld c, SCREEN_WIDTH * 6 - 2
	call .ShiftRowData
	decoord 1, 9, wAttrMap
	hlcoord 1, 12, wAttrMap
	ld c, SCREEN_WIDTH * 6 - 2
	call .ShiftRowData
	hlcoord 19, 9
	ld [hl], $0c
	hlcoord 19, 12
	ld [hl], $1c
	ld c, b
	call Pokedex_UpdateRow
	xor a
	ret

Pokedex_UpdateRow:
; Populate tiles used for the given row in c with dex numbers and icon.
	ld a, BANK(wDexMons)
	call StackCallInWRAMBankA
.Function:
	; Set sprite offset.
	ld a, DEXPOS_ICONTILE_OFFSET
	ld b, 1 ; the first column is part of BG, not OAM.
	call .GetPosData
	ld e, l
	dec b
	ld a, DEXPOS_PALCOPY
	call .GetPosData
	dec hl
	ld [hl], e
	ld a, e
	add $7c
	push bc
	push af

	; Set up the VWF tilemap row with the proper tiles+attributes.
	ld a, DEXPOS_TILEMAP
	call .GetPosData
	push hl
	ld a, DEXPOS_VWFTILE_OFFSET
	call .GetPosData
	ld a, l
	pop hl
	ld d, 18
.loop
	ld [hli], a
	inc a
	dec d
	jr nz, .loop
	ld bc, wAttrMap - (wTileMap + 18)
	add hl, bc
	ld a, VRAM_BANK_1 | 4
	ld d, 18
.loop2
	ld [hli], a
	dec d
	jr nz, .loop2
	pop af

	; Now set up the mini BG tiles properly.
	ld bc, (wTileMap - wAttrMap) + 2
	add hl, bc
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld bc, SCREEN_WIDTH - 2
	add hl, bc
	ld [hli], a
	inc a
	ld [hli], a
	add 13
	ld bc, -7
	add hl, bc
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld bc, SCREEN_WIDTH - 2
	add hl, bc
	ld [hli], a
	inc a
	ld [hli], a

	; If we haven't yet written the previous row tiles, wait for it.
	ld hl, wPokedex_GFXFlags
	bit DEXGFX_ROWTILES, [hl]
	call nz, DelayFrame

	; Prepare VWF tiles.
	ld hl, wDexVWFPreset
	ld de, wDexVWFTiles
	ld bc, 18 tiles
	rst CopyBytes
	pop bc

	; The rest are to be iterated by column.
.loop3
	; Get mini palette and check species for this position.
	ld a, DEXPOS_PALCOPY
	call .GetPosData
	push hl
	ld a, DEXPOS_MONS
	call .GetPosData
	ld a, [hli]
	and a
	jr nz, .got_species

	; Blank the palette and do nothing else.
	pop hl
	xor a
	dec a
	ld d, 6
.blank_pal
	ld [hli], a
	dec d
	jr nz, .blank_pal
	jr .species_done

.got_species
	; Palette.
	ld d, [hl]
	bit MON_CAUGHT_F, d
	jr z, .mon_not_caught
	push af

	; If the mon is caught, we don't want slight transparency on the VWF dexno.
	ld a, DEXPOS_ATTRMAP
	call .GetPosData

	; VWF tilemap actually uses slightly less than 4 tiles, so fix that up here.
	ld a, b
	cp 3
	jr c, .not_far_right
	dec hl
.not_far_right
	ld a, VRAM_BANK_1 | 5
	ld [hli], a
	ld [hli], a
	ld [hli], a
	pop af

.mon_not_caught
	pop hl
	push bc
	ld c, a
	ld b, d

	push bc
	ld a, b
	and CAUGHT_MASK
	push af
	push hl
	xor a
	farcall GetMenuMonIconTruePalette
	pop hl
	pop af
	push af
	jr nz, .species_caught

	; Apply transparency
	push hl
	; Remove least significant bit from each pal color.
	ld hl, palred 30 + palgreen 30 + palblue 30
	ld a, c
	and l
	ld c, a
	ld a, b
	and h
	ld b, a
	ld a, e
	and l
	ld e, a
	ld a, d
	and h
	ld d, a

	; Halve all palette colors
	srl b
	rr c
	srl d
	rr e

	; Add 16 to each palette color.
	ld hl, palred 16 + palgreen 16 + palblue 16
	push hl
	add hl, de
	ld d, h
	ld e, l
	pop hl
	add hl, bc
	ld b, h
	ld c, l
	pop hl

.species_caught
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop af
	ld bc, palred 0 + palgreen 0 + palblue 0
	jr nz, .got_outline_pal
	ld bc, palred 16 + palgreen 16 + palblue 16
.got_outline_pal
	ld a, c
	ld [hli], a
	ld [hl], b

	; Icon
	pop bc
	farcall _LoadOverworldMonIcon
	ld a, b
	pop bc
	push af
	ld a, DEXPOS_ICON_TILES
	call .GetPosData
	pop af
	call SwapHLDE
	push bc
	call FarDecompressToDE
	pop bc
.species_done
	call .GetDexNo
	ld de, wDexNumberString
	push bc
	call FastPrintNum
	pop bc
	ld a, DEXPOS_VWF_TILES
	call .GetPosData
	ld a, 14
	sub b
	sub b
	push bc
	ld c, a
	ld b, VWF_OPAQUE
	ld de, wDexNumberString
	call PlaceVWFString
	pop bc
	inc b
	ld a, b
	cp 5
	jmp nz, .loop3
	ld b, 0
	ld a, DEXPOS_VWF_VTILES
	call .GetPosData
	ld de, wDexRowTilesDest
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	ld a, DEXPOS_ICON_VTILES
	call .GetPosData
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ld hl, wPokedex_GFXFlags
	set DEXGFX_ROWTILES, [hl]
	ret

.GetDexNo:
; TODO: When we have search modes, we want to check based on wDexMons.
	ld a, DEXPOS_DEXNO
	; fallthrough
.GetPosData:
; Sets hl to a pointer offset, or value, depending on position data type in a.
; Takes row in c and column in b as input (0-indexed).
	push bc
	call .do_pos_data
	pop bc
	ret

.do_pos_data
	cp DEXPOS_TILEMAP
	jr nc, .got_row

	ld hl, wPokedex_Offset
	push af
	ld a, c
	add [hl]
	ld c, a
	pop af
	cp DEXPOS_ICON_TILES
	jr c, .got_row
	push af
	ld a, c
	and %11
	ld c, a
	pop af

.got_row
	ld hl, .PosTable
	push bc
	ld bc, 6
	rst AddNTimes
	pop bc
	push de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, c
	call .AddWordNTimesToDE
	ld a, b
	call .AddWordNTimesToDE
	ld h, d
	ld l, e
	pop de
	ret

.AddWordNTimesToDE:
	; Add [hl16]*a to de.
	push bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	call SwapHLDE
	rst AddNTimes
	call SwapHLDE
	pop bc
	ret

.PosTable:
	; absolute row
	dw wDexMons, 10, 2
	dw 1, 5, 1

	; mod-based
	dw wDexIconTiles, 0, 4 tiles
	dw wDexVWFTiles - 1 tiles, 0, 4 tiles
	dw vTiles4, 20 tiles, 4 tiles
	dw vTiles4 tile $50, 18 tiles, 4 tiles
	dw 0, 20, 4
	dw $d0, 18, 4

	; offset-based
	dw wTileMap + 9 * SCREEN_WIDTH + 1, SCREEN_WIDTH * 3, 4
	dw wAttrMap + 9 * SCREEN_WIDTH + 1, SCREEN_WIDTH * 3, 4
	dw wDexPalCopy + 1, 6 * 5 + 1, 6

PokedexStr_Feet:
; Feet uses its own pelicular display format, so replace the ?s too.
	db "′??″@"

Pokedex_Description:
	; Since we're reusing 0:$40-$7c, ensure that we have the frontpic loaded in
	; 1:$40-$7c.
	call Pokedex_GetCursorMonInVBK1

	; Move the dex number display.
	ld a, 17
	ld [wPokedexOAM_DexNoX], a
	ld a, 80
	ld [wPokedexOAM_DexNoY], a

	; Load the description tilemap.
	ld hl, DexTilemap_Description
	call Pokedex_LoadTilemapWithPokepic

	ld a, DEXDISP_DESC
	ld [wPokedex_DisplayMode], a
	ld de, wStringBuffer1
	hlcoord 9, 1
	call PlaceString

	; Possibly adjust units of display.
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	jr nz, .units_ok

	hlcoord 15, 7
	ld de, PokedexStr_Feet
	call PlaceString
	hlcoord 18, 9
	ld a, "l"
	ld [hli], a
	ld [hl], "b"

.units_ok
	; Check if we've captured the mon. If not, return "?????" as mon type.
	call Pokedex_GetCursorSpecies
	bit MON_CAUGHT_F, b
	jr nz, .mon_caught
	hlcoord 9, 5
	ld a, "?"
	ld bc, 5
	rst ByteFill

	; This isn't used (it's for pagination for dex entries we have caught), but
	; this balances the stack.
	push af
	push af
	push af
	jmp .info_done

.mon_caught
	; Get a pointer to the dex information.
	call GetSpeciesAndFormIndex
	ld hl, PokedexDataPointerTable
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, BANK(PokedexDataPointerTable)
	ld b, a
	call GetFarByte
	inc hl
	ld c, a
	ld a, b
	call GetFarWord
	ld a, c

	; Height
	push hl
	push af
	call GetFarByte
	ldh [hMultiplier], a
	ld e, a
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	jr nz, .metric_height

	; Multiply by 16513008 >> 22
	ld a, 16513008 >> 16
	ldh [hMultiplicand + 0], a
	ld a, (16513008 >> 8) & $ff
	ldh [hMultiplicand + 1], a
	ld a, 16513008 & $ff
	ldh [hMultiplicand + 2], a
	call Multiply
	ld hl, hProduct + 1
	ld a, [hld]
	ld l, [hl]
	ld h, 0
	add a
	rl l
	rl h
	add a
	rl l
	rl h
	add a
	jr nc, .no_ht_overflow
	inc hl
.no_ht_overflow
	ld a, -1
	ld bc, -12
	push hl
.ht_loop
	pop de
	inc a
	push hl
	add hl, bc
	jr c, .ht_loop
	ld bc, 12
	ld e, a
	hlcoord 13, 7
	lb bc, 2, 2
	push bc
	call PrintNumFromReg
	pop bc
	pop de
	hlcoord 16, 7
	lb bc, 2, 2
	call PrintNumFromReg
	jr .height_done

.metric_height
	ld d, 0
	hlcoord 12, 7
	ln bc, 0, 2, 4, 5
	call PrintNumFromReg

.height_done
	pop af
	pop hl
	inc hl

	; Weight
	push hl
	push af
	call GetFarWord
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	jr nz, .metric_weight

	; Approximate as follows: lbs = ((kg * 43 * 35 * 192) + (kg * 4)) >> 17.
	push hl
	add hl, hl
	add hl, hl
	pop de
	push hl
	ld hl, hMultiplicand
	xor a
	ld [hli], a
	ld a, d
	ld [hli], a
	ld [hl], e

	ld a, 43
	ldh [hMultiplier], a
	call Multiply
	ld a, 35
	ldh [hMultiplier], a
	call Multiply
	ld a, 192
	ldh [hMultiplier], a
	call Multiply
	ld hl, hProduct
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld l, [hl]
	ld h, a
	pop bc
	add hl, bc
	jr nc, .no_wt_overflow
	inc de
.no_wt_overflow
	; Shift by 17, but ensure we round up.
	inc de
	srl d
	rr e
	hlcoord 12, 9
	ln bc, 0, 2, 4, 5
	call PrintNumFromReg
	jr .weight_done

.metric_weight
	ld d, h
	ld e, l
	hlcoord 12, 9
	ln bc, 0, 2, 4, 5
	call PrintNumFromReg

.weight_done
	; Category
	pop af
	pop de
	inc de
	inc de
	inc de
	hlcoord 9, 5
	push af
	call FarString
	inc de
	pop af
	push de
	push af
	hlcoord 1, 12
	call FarString
	inc de
	pop af
	push de
	push af
	; At this point, we have pointers to the dex pages stored on the stack along
	; with the bank. This is used if we want to switch page.

.info_done
	pop af
	pop hl
	pop hl
	call Pokedex_RefreshScreen
	ld a, $57
	ld de, PHB_DescSwitchSCY
	call Pokedex_SetHBlankFunction
	ld c, 240
	call DelayFrames

	; fallthrough
Pokedex_Main:
	; Move the dex number display.
	ld a, 77
	ld [wPokedexOAM_DexNoX], a
	ld a, 16
	ld [wPokedexOAM_DexNoY], a

	ld hl, DexTilemap_Main
	call Pokedex_LoadTilemapWithPokepic
	ld de, wStringBuffer1
	hlcoord 9, 2
	call PlaceString

	xor a
	ld [wPokedex_DisplayMode], a

	lb de, $50, $09
	ld a, SPRITE_ANIM_INDEX_DEX_CURSOR
	call InitSpriteAnimStruct

	hlcoord 10, 7
	lb bc, 2, 3
	ld de, wPokedex_NumSeen
	call PrintNum
	hlcoord 17, 7
	lb bc, 2, 3
	ld de, wPokedex_NumOwned
	call PrintNum

	ld c, 0
	call Pokedex_UpdateRow
	ld c, 1
	call Pokedex_UpdateRow
	ld c, 2
	call Pokedex_UpdateRow

	call Pokedex_RefreshScreen
	jmp Pokedex_SetHBlankFunctionToRow1

Mul16AndPrint:
	push de
	ld d, h
	ld e, l
	call Mul16
	pop hl
	ld de, hTmpd
	ln bc, 0, 2, 4, 5
	jmp PrintNum

; Metric conversion code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/main.asm
Mul16:
; [hTmpd][hTmpe]hl = bc * de
	xor a
	ldh [hTmpd], a
	ldh [hTmpe], a
	ld hl, 0
	ld a, 16
	ldh [hProduct], a
.loop
	add hl, hl
	ldh a, [hTmpe]
	rla
	ldh [hTmpe], a
	ldh a, [hTmpd]
	rla
	ldh [hTmpd], a
	sla e
	rl d
	jr nc, .noadd
	add hl, bc
	ldh a, [hTmpe]
	adc 0
	ldh [hTmpe], a
	ldh a, [hTmpd]
	adc 0
	ldh [hTmpd], a
.noadd
	ldh a, [hProduct]
	dec a
	ldh [hProduct], a
	jr nz, .loop
	ret

Pokedex_InitData:
; Initializes the list of Pokémon seen and owned.
	; Reset cursor positioning.
	xor a
	ld [wPokedex_CursorPos], a
	ld [wPokedex_Offset], a

	; First, wipe the current wDexMons data.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexMons)
	ldh [rSVBK], a
	xor a
	ld hl, wDexMons
	ld bc, wDexMonsEnd - wDexMons
	rst ByteFill
	pop af
	ldh [rSVBK], a

	; Then populate the list with seen/captured Pokémon. Do seen first, because
	; a captured altform takes predecence over a seen regular form.
	ld hl, wPokedexSeen
	ld de, wPokedex_NumSeen
	ld b, 0
	call .GetCaptureData
	ld a, [wPokedex_FinalEntry]
	ld b, a
	ld a, [wPokedex_FinalEntry + 1]
	ld c, a
	push bc
	ld hl, wPokedexCaught
	ld de, wPokedex_NumOwned
	ld b, CAUGHT_MASK
	call .GetCaptureData
	pop bc

	; Set up LastCol and Rows
	ld hl, hDividend
	ld a, b
	ld [hli], a
	ld [hl], c
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hRemainder]
	ld [wPokedex_LastCol], a
	ldh a, [hQuotient + 2]
	inc a
	ld [wPokedex_Rows], a
	ret

.GetCaptureData:
	push hl
	push bc
	push de
	call _Pokedex_GetCaptureStats
	pop hl
	ld a, b
	ld [hli], a
	ld [hl], c
	pop bc
	pop hl
	ld de, 0
.loop
	push de
	push bc ; popped to af later, so c is clobbered.
	call .GetSpecies

	; Check for any entry.
	push hl
	ld hl, wTempDexFoundSpecies
	call .CheckOwnership
	pop hl
	jr z, .next

	; Check if we have the main entry, or if we should look at variant lists.
	call .CheckOwnership
	jr nz, .found

.variant_loop
	inc b
	call .CheckOwnership
	jr z, .variant_loop
.found
	pop af
	push af
	or b
	ld b, a
	ld a, d
	ld [wPokedex_FinalEntry], a
	ld a, e
	ld [wPokedex_FinalEntry + 1], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexMons)
	ldh [rSVBK], a
	push hl
	ld hl, wDexMons
	add hl, de
	add hl, de
	ld a, c
	ld [hli], a
	ld [hl], b
	pop hl
	pop af
	ldh [rSVBK], a
.next
	pop bc
	pop de
	inc de
	ld a, e
	sub LOW(REAL_NUM_POKEMON)
	ld a, d
	sbc HIGH(REAL_NUM_POKEMON)
	jr c, .loop
	ret

.GetSpecies:
; Returns the species data for the given dex no+1.
; TODO: account for dex mode.
	jr .national_mode

.regional_mode
	push hl
	ld hl, NewPokedexOrder
	add hl, de
	add hl, de
	ld a, [hli]
	ld c, a
	ld b, [hl]
	pop hl
	ret

.national_mode
	ld b, d
	ld a, e
	push de
	inc d
.natloop
	add 2
	jr nc, .natok
	inc b
	inc d
.natok
	dec d
	jr nz, .natloop
	dec a
	ld c, a
	swap b
	sla b
	pop de
	ret

.CheckOwnership:
	push hl
	push de
	push bc
	ld a, CHECK_FLAG
	call PokedexFlagAction
	jmp PopBCDEHL

Pokedex_GetCaptureStats:
; Sets de to the amount caught, bc to the amount seen, and writes a detailed
; list of the seen/caught list (compressing formes into one entry) into
; wTempDexFound (unionized with string buffers 1-5)
	ld hl, wPokedexCaught
	call _Pokedex_GetCaptureStats
	push bc
	ld hl, wPokedexSeen
	call _Pokedex_GetCaptureStats
	pop de
	ret

_Pokedex_GetCaptureStats:
	; Copies caught/seen array from hl to wTempDex.
	ld de, wTempDexFound
	ld bc, wTempDexEnd - wTempDexFound
	rst CopyBytes

	; Iterate the flags past the main species flags for base data-affecting
	; formes. If we find entries there, unset the flag and set the corresponding
	; main species flag.
	ld bc, VariantSpeciesAndFormTable
	ld de, NUM_SPECIES
.loop
	; Have we seen/caught this forme?
	call .CheckFlag
	jr z, .next

	; Reset the form flag.
	call .ResetFlag

	; Set the corresponding regular flag.
	push de
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	call ConvertFormToExtendedSpecies
	dec bc
	ld d, a
	dec de ; Flags are 0-indexed.
	call .SetFlag
	pop de

.next
	inc bc
	inc bc
	inc de
	ld a, e
	sub LOW(NUM_EXT_POKEMON)
	ld a, d
	sbc HIGH(NUM_EXT_POKEMON)
	jr c, .loop

	; Now we have a list of dex entries seen/captured. Figure out how many
	; we've seen/captured and return that in bc.
	ld hl, wTempDexFoundSpecies
	ld bc, wTempDexSpeciesEnd - wTempDexFoundSpecies
	jp CountSetBits16

.SetFlag:
	push bc
	ld b, SET_FLAG
	jr .SafeFlagAction
.ResetFlag:
	push bc
	ld b, RESET_FLAG
	jr .SafeFlagAction
.CheckFlag:
	push bc
	ld b, CHECK_FLAG
	; fallthrough
.SafeFlagAction:
	ld hl, wTempDexFound
	push de
	call FlagAction
	pop de
	pop bc
	ret

Pokedex_GetInput:
; Returns button input in a, and potentially handles screen refreshing.
	ld a, TRUE
	ldh [hVBlankOccurred], a
	ld hl, wPokedex_GFXFlags
	bit DEXGFX_DEFERRED, [hl]
	res DEXGFX_DEFERRED, [hl]
	call nz, Pokedex_RefreshScreen
	call MaybeDelayFrame
	call JoyTextDelay_AllowRepeat

	; Only allow keyrepeat of the D-pad.
	ldh a, [hJoyPressed]
	and a
	ret nz

	ldh a, [hJoyLast]
	and D_PAD
	ret

Pokedex_GetCursorMonInVBK1:
	ld a, 1
	ld [wPokedex_MonInfoBank], a
	jr _Pokedex_GetCursorMon
Pokedex_GetCursorMon:
; Displays information about the mon the cursor is currently hovering.
	; Switch which bank to store tile data in. Tiles are loaded as follows:
	; 0: vTiles2 tile $40
	; 1: vTiles5 tile $40
	; 2: vTiles1 tile $40 (unused)
	; 3: vTiles4 tile $40
	ld a, [wPokedex_DisplayMode]
	and a
	ld b, 1
	jr z, .got_vbkswitch
	ld b, 3
.got_vbkswitch
	ld hl, wPokedex_MonInfoBank
	ld a, [hl]
	xor b
	ld [hl], a

_Pokedex_GetCursorMon:
	; Set up proper palettes and switch between vbk0 and vbk1 usage.
	swap a
	rrca

	; Frontpic pal
	hlcoord 1, 1, wAttrMap
	lb bc, 7, 7
	add $6 ; BG6, potentially with VRAM_BANK_1
	call FillBoxWithByte

	hlcoord 18, 3, wAttrMap
	lb bc, 2, 2
	call FillBoxWithByte

	; Mon infobox pal
	inc a ; BG7, potentially with VRAM_BANK_1
	hlcoord 9, 4, wAttrMap
	ld bc, 8
	rst ByteFill

	; Clear existing data.
	ld a, "@"
	ld [wStringBuffer1], a
	hlcoord 9, 2
	ld a, $7f
	ld c, 10
	rst ByteFill
	xor a
	ld [wPokedexOAM_IsCaught], a
	ld [wPokedexOAM_DexNoY], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexMonFootprintTiles)
	ldh [rSVBK], a
	ld hl, wDexMonFootprintTiles
	xor a
	ld bc, 4 tiles
	rst ByteFill
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld a, -1
	ld hl, wBGPals1 palette 7 + 2
	ld c, 6
	rst ByteFill
	pop af
	ldh [rSVBK], a

	; Attributes are done. Now we can deal with the main data.
	call Pokedex_GetCursorSpecies

	; If species is zero, there's nothing there. Just reload the screen.
	ld a, c
	and a
	jr nz, .got_species

	; Display a questionmark in place of the frontpic.
	ld hl, wPokedex_GFXFlags
	bit DEXGFX_ROWTILES, [hl]
	call nz, DelayFrame
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexMonFrontpicTiles)
	ldh [rSVBK], a
	ld hl, QuestionMarkLZ
	ld de, wDexMonFrontpicTiles
	ld a, BANK(QuestionMarkLZ)
	call FarDecompressToDE
	pop af
	ldh [rSVBK], a
	ld hl, wPokedex_GFXFlags
	set DEXGFX_FRONTPIC, [hl]
	set DEXGFX_POKEINFO, [hl]

	ld hl, Pokedex_QuestionMarkPal
	ld de, wBGPals1 palette 6 + 2
	ld a, BANK(Pokedex_QuestionMarkPal)
	ld bc, 4
	call FarCopyBytesToColorWRAM

	; Introduce a deliberate delay. The reason for this is so that we get a more
	; consistent delay for each slot if keyrepeat applies.
	ld c, 3
	call DelayFrames
	jmp .done

.got_species
	; Species name.
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld [wNamedObjectIndex], a
	bit MON_CAUGHT_F, b
	ld a, $10
	ld [wPokedexOAM_DexNoY], a
	ld a, b
	ld [wCurForm], a
	ld [wNamedObjectIndex+1], a
	ld [wPokedex_Form], a
	push af
	push bc
	call GetPokemonName
	ld de, wStringBuffer1
	hlcoord 9, 2
	call PlaceString
	pop bc

	; Get dex number.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexNumber)
	ldh [rSVBK], a
	call GetPokedexNumber
	ld de, wDexNumberString
	ld h, b
	ld l, c
	call FastPrintNum
	pop af
	ldh [rSVBK], a

	; Frontpic
	call GetBaseData
	farcall DexPrepareFrontpic
	ld hl, wPokedex_GFXFlags
	set DEXGFX_FRONTPIC, [hl]

	; Frontpic pal
	ld bc, wPokedex_Personality
	xor a
	ld [bc], a ; Not shiny.
	ld a, [wCurPartySpecies]
	farcall GetMonNormalOrShinyPalettePointer
	ld de, wBGPals1 palette 6 + 2
	ld a, BANK(PokemonPalettes)
	ld bc, 4
	call FarCopyBytesToColorWRAM

	; If we haven't caught the mon, we're done here.
	pop af
	jmp z, .done

	ld a, 1
	ld [wPokedexOAM_IsCaught], a

	; Otherwise, also include footprint and type icons.
	; Type icons.
	ld hl, TypeIconGFX
	ld a, [wBaseType1]
	ld c, a
	ld a, [wBaseType2]
	cp c
	ld b, -1
	jr z, .got_types
	ld b, a
.got_types
	push bc
	ld b, 0
	ld a, 4 * LEN_1BPP_TILE
	rst AddNTimes
	ld de, wBGPals1 palette 7 + 2
	call Pokedex_CopyTypeIconPals
	pop bc
	ld de, wDexMonType1Tiles
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexMonType1Tiles)
	ldh [rSVBK], a
	push bc
	lb bc, BANK(TypeIconGFX), 4
	call Pokedex_Copy1bpp
	pop bc
	inc b
	jr z, .types_done
	dec b
	ld c, b
	ld b, 0
	ld a, 4 * LEN_1BPP_TILE
	ld hl, TypeIconGFX
	rst AddNTimes
	ld de, wBGPals1 palette 7 + 4
	call Pokedex_CopyTypeIconPals
	ld de, wDexMonType2Tiles
	lb bc, BANK(TypeIconGFX), 4
	call Pokedex_Copy1bpp

.types_done
	; Footprint
	call Pokedex_GetCursorSpecies
	call GetSpeciesAndFormIndex
	ld hl, Footprints
	ld a, 4 * LEN_1BPP_TILE
	rst AddNTimes
	ld de, wDexMonFootprintTiles
	lb bc, BANK(Footprints), 4
	call Pokedex_Copy1bpp

	; Make the type icons use color 1 and 2 of the pal instead of 3.
	ld hl, wDexMonType1Tiles + 1
	xor a
	ld c, 2
.outer_copy_loop
	ld b, $20
.inner_copy_loop
	ld [hli], a
	inc hl
	dec b
	jr nz, .inner_copy_loop
	dec hl
	dec c
	jr nz, .outer_copy_loop

	pop af
	ldh [rSVBK], a

.done
	ld hl, wPokedex_GFXFlags
	set DEXGFX_POKEINFO, [hl]
	; fallthrough
Pokedex_ScheduleScreenUpdate:
; Schedules a screen refresh for the next Pokedex_GetInput.
	ld hl, wPokedex_GFXFlags
	set DEXGFX_DEFERRED, [hl]
	ret

Pokedex_CopyTypeIconPals:
	push hl
	ld hl, TypeIconPals
	ld a, 2
	rst AddNTimes
	ld a, BANK(TypeIconPals)
	ld bc, 2
	call FarCopyBytesToColorWRAM
	pop hl
	ret

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

	; Reload dex number display.
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
	ld de, wDexNumberString
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

	; Copy it back.
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
	ld b, 28
.fixtiming1
	dec b
	jp nz, .fixtiming1

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
	ld [c], a
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
	ld [c], a
endr
	; advance to the next pal quickly
	ld [c], a ; no-optimize useless loads (rOBPD)
	ld [c], a

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
	ld [c], a
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

DexOAM:
	dw `00000000
	dw `00033000
	dw `00322300
	dw `03222230
	dw `03000030
	dw `00300300
	dw `00033000
	dw `00000000

	dw `11111111
	dw `11111111
	dw `11000000
	dw `11000000
	dw `11000000
	dw `11000000
	dw `11000000
	dw `11000000

	dw `11111111
	dw `11111111
	dw `00000000
	dw `00000000
	dw `00000000
	dw `00000000
	dw `00000000
	dw `00000000

	dw `11000000
	dw `11000000
	dw `11000000
	dw `11000000
	dw `11000000
	dw `11000000
	dw `11000000
	dw `11000000

	dw `33333333
	dw `32222223
	dw `32222223
	dw `32222223
	dw `32222223
	dw `32222223
	dw `32222223
	dw `33333333








































































































Pokedex_ResetBGMapMode:
Pokedex_FillColumn:
PlaceFrontpicTopLeftCorner:
PlaceFrontpicAtHL:
	xor a
_PlaceFrontpicAtHL:
	ld de, SCREEN_WIDTH
	ld b, 7
.row
	ld c, 7
	push af
	push hl
.col
	ld [hli], a
	add 7
	dec c
	jr nz, .col
	pop hl
	add hl, de
	pop af
	inc a
	dec b
	jr nz, .row
	ret

String_SEEN:
	rawchar "Seen", $ff
String_OWN:
	rawchar "Own", $ff
String_SELECT_OPTION:
;	db $3b, $48, $49, $4a, $44, $45, $46, $47 ; SELECT > OPTION
	db $3b, $41, $42, $43, $44, $45, $46, $47
String_START_SEARCH:
;	db $3c, $3b, $41, $42, $43, $4b, $4c, $4d, $4e, $3c, $ff ; START > SEARCH
	db $48, $3b, $49, $4a, $4b, $4c, $4d, $4e, $5d, $5e, $ff

Pokedex_DrawDexEntryScreenBG:

Pokedex_DrawDexEntryScreenRightEdge:
Pokedex_DrawSearchScreenBG:
	call Pokedex_FillBackgroundColor2
	hlcoord 0, 2
	lb bc, 14, 18
	call Pokedex_PlaceBorder
	hlcoord 0, 1
	ld de, .Title
	call Pokedex_PlaceString
	hlcoord 8, 4
	ld de, .TypeLeftRightArrows
	call Pokedex_PlaceString
	hlcoord 8, 6
	ld de, .TypeLeftRightArrows
	call Pokedex_PlaceString
	hlcoord 3, 4
	ld de, .Types
	rst PlaceString
	hlcoord 3, 13
	ld de, .Menu
	rst PlaceString
	ret

.Title:
	rawchar $3b, " Search ", $3c, $ff

.TypeLeftRightArrows:
	db $3d, "        ▷", $ff

.Types:
	db   "Type1"
	next "Type2@"

.Menu:
	db   "Begin Search!"
	next "Cancel@"

Pokedex_DrawSearchResultsScreenBG:
.BottomWindowText:
	db   "Search Results"
	next "  Type/"
	next "    found!@"

Pokedex_PlaceSearchResultsTypeStrings:
	ld a, [wDexSearchMonType1]
	hlcoord 0, 14
	call Pokedex_PlaceTypeString
	ld a, [wDexSearchMonType1]
	ld b, a
	ld a, [wDexSearchMonType2]
	and a
	ret z
	cp b
	ret z
	hlcoord 1, 15
	call Pokedex_PlaceTypeString
	hlcoord 0, 15
	ld [hl], "/"
	ret

Pokedex_DrawUnownModeBG:
	call Pokedex_FillBackgroundColor2
	hlcoord 2, 1
	lb bc, 11, 13
	call Pokedex_PlaceBorder
	hlcoord 2, 14
	lb bc, 1, 13
	call Pokedex_PlaceBorder
	hlcoord 2, 15
	ld [hl], $5c
	hlcoord 16, 15
	ld [hl], $3e
	hlcoord 6, 5
	call PlaceFrontpicAtHL
	ld de, 0
	lb bc, 0, NUM_UNOWN
.loop
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	and a
	jr z, .done
	push af
	ld hl, UnownModeLetterAndCursorCoords
rept 4
	add hl, de
endr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	cp 27
	jr z, .exclamation
	cp 28
	jr z, .question
	add "A" - 1
	jr .got_letter
.exclamation
	ld a, "!"
	jr .got_letter
.question
	ld a, "?"
.got_letter
	ld [hl], a
	inc de
	inc b
	dec c
	jr nz, .loop
.done
	ld a, b
	ld [wDexUnownCount], a
	ret

UnownModeLetterAndCursorCoords:
;           letter, cursor
	dwcoord   4,12,   3,12
	dwcoord   4,11,   3,11
	dwcoord   4,10,   3,10
	dwcoord   4, 9,   3, 9
	dwcoord   4, 8,   3, 8
	dwcoord   4, 7,   3, 7
	dwcoord   4, 6,   3, 6
	dwcoord   4, 5,   3, 5
	dwcoord   4, 4,   3, 4
	dwcoord   4, 3,   3, 2
	dwcoord   5, 3,   5, 2
	dwcoord   6, 3,   6, 2
	dwcoord   7, 3,   7, 2
	dwcoord   8, 3,   8, 2
	dwcoord   9, 3,   9, 2
	dwcoord  10, 3,  10, 2
	dwcoord  11, 3,  11, 2
	dwcoord  12, 3,  12, 2
	dwcoord  13, 3,  13, 2
	dwcoord  14, 3,  15, 2
	dwcoord  14, 4,  15, 4
	dwcoord  14, 5,  15, 5
	dwcoord  14, 6,  15, 6
	dwcoord  14, 7,  15, 7
	dwcoord  14, 8,  15, 8
	dwcoord  14, 9,  15, 9
	dwcoord  14,10,  15,10
	dwcoord  14,11,  15,11

Pokedex_FillBackgroundColor2:
	hlcoord 0, 0
	ld a, $32
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
	ret

Pokedex_PlaceString:
Pokedex_PlaceBorder:
Pokedex_DrawFootprint:
	hlcoord 18, 1
	ld a, $65
	ld [hli], a
	inc a
	ld [hl], a
	hlcoord 18, 2
	ld a, $67
	ld [hli], a
	inc a
	ld [hl], a
	ret

Pokedex_GetSelectedMon:
; Gets the species of the currently selected Pokémon. This corresponds to the
; position of the cursor in the main listing, but this function can be used
; on all Pokédex screens.
	ld a, [wDexListingCursor]
	ld hl, wDexListingScrollOffset
	add [hl]
	ld e, a
	ld d, $0
	ld hl, wPokedexDataStart
	add hl, de
	ld a, [hli]
	ld [wTempSpecies], a
	ret

Pokedex_CheckCaught:
	push de
	push hl
	ld hl, wTempSpecies
	ld a, [hli]
	ld c, a
	dec c
	ld b, [hl]
	call CheckCaughtMon
	pop hl
	pop de
	ret

Pokedex_CheckSeen:
	push de
	push hl
	ld hl, wTempSpecies
	ld a, [hli]
	ld c, a
	dec c
	ld b, [hl]
	call CheckSeenMon
	pop hl
	pop de
	ret

Pokedex_OrderMonsByMode:
	ld hl, wPokedexOrder
	ld bc, wPokedexOrderEnd - wPokedexOrder
	xor a
	rst ByteFill
	ld a, [wCurDexMode]
	call StackJumpTable

.Jumptable:
	dw .NewMode
	dw .OldMode
	dw Pokedex_ABCMode

.NewMode:
	ld de, NewPokedexOrder
	ld hl, wPokedexOrder
	ld bc, NUM_POKEMON
.loopnew
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loopnew
	dec b
	jr nz, .loopnew
	jr .FindLastSeen

.OldMode:
	ld hl, wPokedexDataStart
	ld a, $1
	ld c, NUM_POKEMON
.loopold
	ld [hli], a
	inc a
	dec c
	jr nz, .loopold
	; fallthrough

.FindLastSeen:
	ld hl, wPokedexDataStart + NUM_POKEMON - 1
	ld d, NUM_POKEMON
	ld e, d
.loopfindend
	ld a, [hld]
	ld [wTempSpecies], a
	call Pokedex_CheckSeen
	jr nz, .foundend
	dec d
	dec e
	jr nz, .loopfindend
.foundend
	ld a, d
	ld [wDexListingEnd], a
	ret

Pokedex_ABCMode:
	xor a
	ld [wDexListingEnd], a
	ld hl, wPokedexDataStart
	ld de, AlphabeticalPokedexOrder
	ld c, NUM_POKEMON
.loop1abc
	push bc
	ld a, [de]
	ld [wTempSpecies], a
	call Pokedex_CheckSeen
	jr z, .skipabc
	ld a, [wTempSpecies]
	ld [hli], a
	ld a, [wDexListingEnd]
	inc a
	ld [wDexListingEnd], a

.skipabc
	inc de
	pop bc
	dec c
	jr nz, .loop1abc
	ld a, [wDexListingEnd]
	ld c, 0
.loop2abc
	cp NUM_POKEMON
	ret z
	ld [hl], c
	inc hl
	inc a
	jr .loop2abc

INCLUDE "data/pokemon/dex_order_alpha.asm"
INCLUDE "data/pokemon/dex_order_new.asm"

Pokedex_DisplayModeDescription:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld a, [wDexArrowCursorPosIndex]
	ld hl, .Modes
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 1, 14
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret

.Modes:
	dw .NewMode
	dw .OldMode
	dw .ABCMode
	dw .UnownMode

.NewMode:
	db   "<PK><MN> are listed in"
	next "regional order.@"

.OldMode:
	db   "<PK><MN> are listed in"
	next "national order.@"

.ABCMode:
	db   "<PK><MN> are listed"
	next "alphabetically.@"

.UnownMode:
	db   "Unown are listed"
	next "in order caught.@"

Pokedex_DisplayChangingModesMessage:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld de, String_ChangingModesPleaseWait
	hlcoord 1, 14
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 64
	call DelayFrames
	ld de, SFX_CHANGE_DEX_MODE
	call PlaySFX
	ld c, 64
	jmp DelayFrames

String_ChangingModesPleaseWait:
	db   "Changing modes."
	next "Please wait.@"

Pokedex_UpdateSearchMonType:
	ld a, [wDexArrowCursorPosIndex]
	cp 2
	jr nc, .no_change
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT
	jr nz, Pokedex_PrevSearchMonType
	ld a, [hl]
	and D_RIGHT
	jr nz, Pokedex_NextSearchMonType
.no_change
	and a
	ret

Pokedex_PrevSearchMonType:
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr nz, .type2

	ld hl, wDexSearchMonType1
	ld a, [hl]
	cp $1
	jr z, .wrap_around
	dec [hl]
	jr .done

.type2
	ld hl, wDexSearchMonType2
	ld a, [hl]
	and a
	jr z, .wrap_around
	dec [hl]
	jr .done

.wrap_around
	ld [hl], UNKNOWN_T

.done
	scf
	ret

Pokedex_NextSearchMonType:
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr nz, .type2

	ld hl, wDexSearchMonType1
	ld a, [hl]
	cp UNKNOWN_T
	jr nc, .type1_wrap_around
	inc [hl]
	jr .done
.type1_wrap_around
	ld [hl], 1
	jr .done

.type2
	ld hl, wDexSearchMonType2
	ld a, [hl]
	cp UNKNOWN_T
	jr nc, .type2_wrap_around
	inc [hl]
	jr .done
.type2_wrap_around
	ld [hl], 0

.done
	scf
	ret

Pokedex_PlaceSearchScreenTypeStrings:
	xor a
	ldh [hBGMapMode], a
	hlcoord 9, 3
	lb bc, 4, 8
	call ClearBox
	ld a, [wDexSearchMonType1]
	hlcoord 9, 4
	call Pokedex_PlaceTypeString
	ld a, [wDexSearchMonType2]
	hlcoord 9, 6
	call Pokedex_PlaceTypeString
	ld a, $1
	ldh [hBGMapMode], a
	ret

Pokedex_PlaceTypeString:
	push hl
	ld e, a
	ld d, 0
	ld hl, PokedexTypeSearchStrings
rept POKEDEX_TYPE_STRING_LENGTH
	add hl, de
endr
	ld e, l
	ld d, h
	pop hl
	rst PlaceString
	ret

INCLUDE "data/types/search_strings.asm"

Pokedex_SearchForMons:
	ld a, [wDexSearchMonType2]
	and a
	call nz, .Search
	ld a, [wDexSearchMonType1]
	and a
	call nz, .Search
	ret

.Search:
	dec a
	ld e, a
	ld d, 0
	ld hl, PokedexTypeSearchConversionTable
	add hl, de
	ld a, [hl]
	ld [wDexConvertedMonType], a
	ld hl, wPokedexDataStart
	ld de, wPokedexDataStart
	ld c, NUM_POKEMON
	xor a
	ld [wDexSearchResultCount], a
.loop
	push bc
	ld a, [hl]
	and a
	jr z, .next_mon
	ld [wTempSpecies], a
	ld [wCurSpecies], a
	xor a
	ld [wCurForm], a
	call Pokedex_CheckCaught
	jr z, .next_mon
	push hl
	push de
	call GetBaseData
	pop de
	pop hl
	ld a, [wDexConvertedMonType]
	ld b, a
	ld a, [wBaseType1]
	cp b
	jr z, .match_found
	ld a, [wBaseType2]
	cp b
	jr nz, .next_mon

.match_found
	ld a, [wTempSpecies]
	ld [de], a
	inc de
	ld a, [wDexSearchResultCount]
	inc a
	ld [wDexSearchResultCount], a

.next_mon
	inc hl
	pop bc
	dec c
	jr nz, .loop

	ld l, e
	ld h, d
	ld a, [wDexSearchResultCount]
	ld c, 0

.zero_remaining_mons
	cp NUM_POKEMON
	ret z
	ld [hl], c
	inc hl
	inc a
	jr .zero_remaining_mons

INCLUDE "data/types/search_types.asm"

Pokedex_DisplayTypeNotFoundMessage:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 12
	lb bc, 4, 18
	call Pokedex_PlaceBorder
	ld de, .TypeNotFound
	hlcoord 1, 14
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ld c, $80
	jmp DelayFrames

.TypeNotFound:
	db   "The specified type"
	next "was not found.@"

Pokedex_CursorOAM:
	; y, x, tile, OAM attributes
	db $10, $47, $31, $7
	db $10, $4f, $32, $7
	db $10, $57, $32, $7
	db $10, $5f, $33, $7
	db $10, $80, $33, $7 | X_FLIP
	db $10, $88, $32, $7 | X_FLIP
	db $10, $90, $32, $7 | X_FLIP
	db $10, $98, $31, $7 | X_FLIP
	db $fe ; tells LoadCursorOAM to set c = 0
	db $18, $47, $30, $7
	db $18, $98, $30, $7 | X_FLIP
	db $20, $47, $30, $7 | Y_FLIP
	db $28, $47, $31, $7 | Y_FLIP
	db $28, $4f, $32, $7 | Y_FLIP
	db $28, $57, $32, $7 | Y_FLIP
	db $28, $5f, $33, $7 | Y_FLIP
	db $28, $80, $33, $7 | X_FLIP | Y_FLIP
	db $28, $88, $32, $7 | X_FLIP | Y_FLIP
	db $28, $90, $32, $7 | X_FLIP | Y_FLIP
	db $28, $98, $31, $7 | X_FLIP | Y_FLIP
	db $20, $98, $30, $7 | X_FLIP | Y_FLIP
	db $ff

Pokedex_SearchResultsCursorOAM:
	; y, x, tile, OAM attributes
	db $10, $47, $31, $7
	db $10, $4f, $32, $7
	db $10, $57, $32, $7
	db $10, $5f, $32, $7
	db $10, $67, $33, $7
	db $10, $7e, $33, $7 | X_FLIP
	db $10, $86, $32, $7 | X_FLIP
	db $10, $8e, $32, $7 | X_FLIP
	db $10, $96, $32, $7 | X_FLIP
	db $10, $9e, $31, $7 | X_FLIP
	db $fe ; tells LoadCursorOAM to set c = 0
	db $18, $47, $30, $7
	db $18, $9e, $30, $7 | X_FLIP
	db $20, $47, $30, $7 | Y_FLIP
	db $28, $47, $31, $7 | Y_FLIP
	db $28, $4f, $32, $7 | Y_FLIP
	db $28, $57, $32, $7 | Y_FLIP
	db $28, $5f, $32, $7 | Y_FLIP
	db $28, $67, $33, $7 | Y_FLIP
	db $28, $7e, $33, $7 | X_FLIP | Y_FLIP
	db $28, $86, $32, $7 | X_FLIP | Y_FLIP
	db $28, $8e, $32, $7 | X_FLIP | Y_FLIP
	db $28, $96, $32, $7 | X_FLIP | Y_FLIP
	db $28, $9e, $31, $7 | X_FLIP | Y_FLIP
	db $20, $9e, $30, $7 | X_FLIP | Y_FLIP
	db $ff

Pokedex_UpdateSearchResultsCursorOAM:
	ld hl, Pokedex_SearchResultsCursorOAM
	; fallthrough

Pokedex_UpdateCursor:
	push bc
	lb bc, 3, 0
	ld a, [wCurDexMode]
	cp DEXMODE_OLD
	jr nz, .ok
	ld b, c
	ld a, [wDexListingCursor]
	or a
	jr nz, .ok
	ld c, 3
.ok
	call Pokedex_LoadCursorOAM
	pop bc
	ret

Pokedex_LoadCursorOAM:
	ld de, wVirtualOAM
.loop
	bit 7, [hl]
	jr nz, .special
	ld a, [wDexListingCursor]
	and $7
	swap a
	add [hl]
	add b
	inc hl
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	add c
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	jr .loop
.special
	ld a, [hli]
	cp $ff
	ret z
	ld c, 0
	jr .loop

Pokedex_UpdateCursorOAM:
	ld hl, Pokedex_CursorOAM
	call Pokedex_UpdateCursor
	; fallthrough

Pokedex_PutScrollbarOAM:
; Writes the OAM data for the scrollbar in the new mode and ABC mode.
	push de
	ld a, [wDexListingEnd]
	dec a
	ld e, a
	ld a, [wDexListingCursor]
	ld hl, wDexListingScrollOffset
	add [hl]
	cp e
	jr z, .asm_4133f
	ld hl, $0
	ld bc, $79
	rst AddNTimes
	ld e, l
	ld d, h
	ld b, $0
	ld a, d
	or e
	jr z, .asm_41341
	ld a, [wDexListingEnd]
	ld c, a
.asm_41333
	ld a, e
	sub c
	ld e, a ; no-optimize a = X +/- carry
	ld a, d ; no-optimize b|c|d|e|h|l -= carry
	sbc 0
	ld d, a
	jr c, .asm_41341
	inc b
	jr .asm_41333
.asm_4133f
	ld b, $79
.asm_41341
	ld a, $14
	add b
	pop hl
	ld [hli], a
	ld a, $a1
	ld [hli], a
	ld a, $f
	ld [hli], a
	ld [hl], $0
	ret

Pokedex_InitArrowCursor:
	xor a
	ld [wDexArrowCursorPosIndex], a
	ld [wDexArrowCursorDelayCounter], a
	ld [wDexArrowCursorBlinkCounter], a
	ret

Pokedex_MoveArrowCursor:
; bc = [de] - 1
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	dec a
	ld c, a
	inc de
	call Pokedex_BlinkArrowCursor

	ld hl, hJoyPressed
	ld a, [hl]
	and D_LEFT | D_UP
	and b
	jr nz, .move_left_or_up
	ld a, [hl]
	and D_RIGHT | D_DOWN
	and b
	jr nz, .move_right_or_down
	ld a, [hl]
	and SELECT
	and b
	jr nz, .select
	call Pokedex_ArrowCursorDelay
	jr c, .no_action
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT | D_UP
	and b
	jr nz, .move_left_or_up
	ld a, [hl]
	and D_RIGHT | D_DOWN
	and b
	jr nz, .move_right_or_down
	jr .no_action

.move_left_or_up
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr z, .no_action
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld hl, wDexArrowCursorPosIndex
	dec [hl]
	jr .update_cursor_pos

.move_right_or_down
	ld a, [wDexArrowCursorPosIndex]
	cp c
	jr nc, .no_action
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld hl, wDexArrowCursorPosIndex
	inc [hl]

.update_cursor_pos
	call Pokedex_GetArrowCursorPos
	ld [hl], "▶"
	ld a, 12
	ld [wDexArrowCursorDelayCounter], a
	xor a
	ld [wDexArrowCursorBlinkCounter], a
	scf
	ret

.no_action
	and a
	ret

.select
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ld a, [wDexArrowCursorPosIndex]
	cp c
	jr c, .update
	ld a, -1
.update
	inc a
	ld [wDexArrowCursorPosIndex], a
	jr .update_cursor_pos

Pokedex_GetArrowCursorPos:
	ld a, [wDexArrowCursorPosIndex]
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

Pokedex_BlinkArrowCursor:
	ld hl, wDexArrowCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and $8
	jr z, .blink_on
	call Pokedex_GetArrowCursorPos
	ld [hl], " "
	ret

.blink_on
	call Pokedex_GetArrowCursorPos
	ld [hl], "▶"
	ret

Pokedex_ArrowCursorDelay:
; Updates the delay counter set when moving the arrow cursor.
; Returns whether the delay is active in carry.
	ld hl, wDexArrowCursorDelayCounter
	ld a, [hl]
	and a
	ret z

	dec [hl]
	scf
	ret

Pokedex_BlackOutBG:
; Make BG palettes black so that the BG becomes all black.
	call _Pokedex_JustBlackOutBG
	jmp DelayFrame

_Pokedex_JustBlackOutBG:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, wBGPals1
if !DEF(MONOCHROME)
	ld bc, 8 palettes
	xor a ; RGB 00,00,00
	rst ByteFill
else
	ld b, (8 palettes) / 2
.mono_loop
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc
	pop af
	ldh [rSVBK], a
	ld a, $ff
	call DmgToCgbBGPals
	ld a, $ff
	jmp DmgToCgbObjPal0

Pokedex_GetCGBLayout:
	call GetCGBLayout
	ld a, $e4
	call DmgToCgbBGPals
	ld a, $e0
	jmp DmgToCgbObjPal0

Pokedex_LoadSelectedMonTiles:
; Loads the tiles of the currently selected Pokémon.
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	jr z, .QuestionMark
	call Pokedex_GetSelectedMon
	cp UNOWN
	jr z, .use_first_unown
	cp MAGIKARP
	jr z, .use_first_magikarp
	ld a, PLAIN_FORM
	jr .continue
.use_first_unown
	ld a, [wFirstUnownSeen]
	jr .continue
.use_first_magikarp
	ld a, [wFirstMagikarpSeen]
.continue
	ld [wCurForm], a
	ld [wDexMonForm], a
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	call GetBaseData
	ld de, vTiles2
	predef_jump GetFrontpic

.QuestionMark:
	ld a, BANK(sScratch)
	call GetSRAMBank
	ld hl, QuestionMarkLZ
	ld de, sScratch
	call Decompress
	ld hl, vTiles2
	ld de, sScratch
	ld c, 7 * 7
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	jmp CloseSRAM

Pokedex_LoadAnyFootprint:
	ld a, [wTempSpecies]
	dec a
	and ($ff ^ $07) ; $f8 ; $1f << 3
	rrca
	rrca
	rrca
	and %00011111
	ld e, 0
	ld d, a
	ld a, [wTempSpecies]
	dec a
	and 7
	swap a ; * $10
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld de, Footprints
	add hl, de

	ld e, l
	ld d, h
	ld hl, vTiles2 tile $65
	lb bc, BANK(Footprints), 4
	jmp Request1bpp

Pokedex_LoadGFX:
	call DisableLCD
Pokedex_LoadGFX2:
	ld hl, vTiles2
	ld bc, $31 tiles
	xor a
	rst ByteFill
	call LoadStandardFont
	call LoadFontsExtra
	ld hl, PokedexLZ
	ld de, vTiles2 tile $31
	call Decompress
	ld hl, PokedexSlowpokeLZ
	ld de, vTiles0
	call Decompress
	ld a, 6
	call SkipMusic
	jmp EnableLCD

Pokedex_LoadUnownFont:
	ld a, [wOptions2]
	ld [wOptionsBuffer], a
	and $ff - FONT_MASK
	or UNOWN_FONT
	ld [wOptions2], a
	jmp LoadStandardFont

Pokedex_LoadUnownFrontpicTiles:
	ld a, [wCurForm]
	push af
	ld a, [wDexCurUnownIndex]
	ld e, a
	ld d, 0
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	ld [wCurForm], a
	ld a, UNOWN
	ld [wCurPartySpecies], a
	call GetBaseData
	ld de, vTiles2 tile $00
	predef GetFrontpic
	pop af
	ld [wCurForm], a
	ret

NewPokedexEntry:
	; TODO
	ret

Pokedex_SetBGMapMode3:
	ld a, $3
	jr Pokedex_SetBGMapMode

Pokedex_SetBGMapMode4:
	ld a, $4
Pokedex_SetBGMapMode:
	ldh [hBGMapMode], a
	jmp Delay2

DexTilemaps:
DexTilemap_Main:
INCBIN "gfx/pokedex/main.bin.lz"

DexTilemap_Description:
INCBIN "gfx/pokedex/description.bin.lz"

PokedexLZ:
INCBIN "gfx/pokedex/pokedex.2bpp.lz"

PokedexSlowpokeLZ:
INCBIN "gfx/pokedex/slowpoke.2bpp.lz"

QuestionMarkLZ:
INCBIN "gfx/pokedex/question_mark.2bpp.lz"
