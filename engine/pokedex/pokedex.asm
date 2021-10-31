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
	const DEXDISP_MODE
	const DEXDISP_SEARCH
	const DEXDISP_DESC
	const DEXDISP_AREA
	const DEXDISP_BIO
	const DEXDISP_STATS

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
	ld [wPokedex_PendingLYC], a

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
	lb bc, BANK(PokedexLZ), $22
	call Get2bpp
	xor a
	ldh [rVBK], a

	ld hl, DexOAM
	ld de, vTiles0
	lb bc, BANK(DexOAM), 29
	call DecompressRequest2bpp

	; Gender symbols
	ld hl, BattleExtrasGFX
	ld de, vTiles2 tile $7d
	lb bc, BANK(BattleExtrasGFX), 2
	call DecompressRequest2bpp

	pop af
	ldh [rSVBK], a

	; Prepare OAM
	call .PrepareOAM

	call Pokedex_InitData

	; Reset shininess and palettes for minis
	xor a
	ld [wPokedex_Personality], a
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

	; Needs to be set up immediately during init.
	call Pokedex_RefreshScreen

	ld a, 1 << 6
	ldh [rSTAT], a
	ld hl, rIF
	res LCD_STAT, [hl]
	ld hl, rIE
	set LCD_STAT, [hl]

	xor a
	ld [wPokedex_CursorPos], a

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

Pokedex_LoadTilemap:
	ld a, BANK(wDexTilemap)
	call StackCallInWRAMBankA
.Function
	ld de, wDexTilemap
	ld a, BANK(DexTilemaps)
	call FarDecompressToDE

	ld b, DEXTILE_FROM_DEXMAP
	jmp Pokedex_SetTilemap

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
	call _PlaceFrontpicAtHL

	; Correct the pokepic vram bank if applicable.
	ld a, [wPokedex_MonInfoBank]
	and a
	ret nz

	hlcoord 1, 1, wAttrMap
	ld b, 7
.outer_loop
	ld c, 7
.inner_loop
	ld a, [hl]
	xor VRAM_BANK_1
	ld [hli], a
	dec c
	jr nz, .inner_loop
	ld de, SCREEN_WIDTH - 7
	add hl, de
	dec b
	jr nz, .outer_loop
	ret

Pokedex_LoadTilemapWithIconAndForm:
	ld a, BANK(wDexTilemap)
	call StackCallInWRAMBankA
.Function:
	ld de, wDexTilemap
	ld a, BANK(DexTilemaps)
	call FarDecompressToDE

	ld b, DEXTILE_FROM_DEXMAP
	call Pokedex_SetTilemap

	ld a, [wPokedex_MonInfoBank]
	rlca
	rlca
	rlca
	ld b, a
	ld a, [wPokedex_FirstIconTile]
	add b ; wPokedex_FirstIconTile + wPokedex_MonInfoBank * 8
	xor $80

	hlcoord 1, 1
	ld [hli], a
	inc a
	ld [hl], a
	inc a
	hlcoord 1, 2
	ld [hli], a
	inc a
	ld [hl], a

	ld b, a
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_STATS ; stats page shouldn't display shape
	ret nc

	ld a, b
	inc a
	hlcoord 18, 2
	ld [hli], a
	inc a
	ld [hl], a
	inc a
	hlcoord 18, 3
	ld [hli], a
	inc a
	ld [hl], a
	ret

Pokedex_ChangeForm:
; Input: a = 0 (check seen), 1 (check caught)
	call Pokedex_CheckForOtherForms
	ret c
	ld a, BANK(wDexMons)
	call StackCallInWRAMBankA
.Function:
	ld [hl], b
	jmp Pokedex_ScheduleScreenUpdate

Pokedex_CheckForOtherForms:
; Input: a = 0 (check caught), 1 (check seen)
; Output: b = form, c = species, hl = pointer to mon form
; carry flag set if no other eligible form found
	ld e, a
	call Pokedex_GetCursorSpecies
	res MON_CAUGHT_F, b
	ld d, 0
	push hl
	ld hl, VariantSpeciesAndFormTable
	call .FindVariant
	pop hl
	ret

.FindVariant:
.variant_loop
	ld a, [hli]
	and a
	jr z, .cont
	cp c
	ld a, [hli]
	jr nz, .variant_loop
	xor b
	cp FORM_MASK + 1
	jr nc, .variant_loop
	and FORM_MASK ; ensure listed form isn't the same as current form
	jr z, .variant_loop
	dec hl
	push bc
	push de
	push hl
	ld b, [hl]
	ld a, e
	rra
	call nc, CheckCaughtMon
	call c, CheckSeenMon ; CheckCaughtMon (when called) always returns with carry flag cleared
	pop hl
	pop de
	pop bc
	ld a, [hli]
	jr z, .variant_loop
	cp b
	jr nc, .got_form
	dec d
	inc d
	jr nz, .variant_loop
	ld d, a ; possible form to switch to, but we should check if others are viable (including base form)
	jr .variant_loop

.cont
	ld a, d
	and a
	jr nz, .test_base
	ld a, b
	and FORM_MASK
	cp ALOLAN_FORM
	ret c
.test_base
	ld a, b
	and EXTSPECIES_MASK
	ld b, a
	push de
	push bc
	ld a, e
	rra
	call nc, CheckCaughtMon
	call c, CheckSeenMon
	pop bc
	pop de
	ld a, b
	jr nz, .got_form
	ld a, d
	and a
	scf
	ret z ; non-zero form hasn't changed and base form wasn't seen yet
.got_form
	ld b, a
	push bc
	call CheckCaughtMon ; FlagAction always clears carry flag
	pop bc
	ret z
	set MON_CAUGHT_F, b
	ret

Pokedex_SwitchNormalOrShinyPalette:
	ld a, SHINY_CHARM
	ld [wCurKeyItem], a
	call CheckKeyItem
	ret nc
	ld bc, wPokedex_Shiny
	ld a, [bc]
	xor SHINY_MASK
	ld [bc], a
	ld a, [wCurPartySpecies]
	farcall GetMonNormalOrShinyPalettePointer
	ld de, wBGPals1 palette 6 + 2
	ld a, BANK(PokemonPalettes)
	ld bc, 4
	call FarCopyBytesToColorWRAM
Pokedex_GetMonIconPalette:
	ld a, BANK(wBGPals1)
	call StackCallInWRAMBankA
.Function:
	ld a, [wCurIconSpecies]
	ld c, a
	ld a, [wCurIconForm]
	ld b, a
	ld a, [wPokedex_Shiny]
	farcall GetMenuMonIconTruePalette
	ld hl, wBGPals1 palette 2 + 5
	ld a, d
	ld [hld], a
	ld a, e
	ld [hld], a
	ld a, b
	ld [hld], a
	ld [hl], c
	jmp Pokedex_ScheduleScreenUpdate

Pokedex_PrevPageMon:
	ld a, -1
	jr Pokedex_ScrollPageMon

Pokedex_NextPageMon:
	ld a, 1
	; fallthrough
Pokedex_ScrollPageMon:
; Scroll the cursor until we find a species (caught-only for certain pages), or
; until we reach the end.
	; Back up current position and offset, in case we are at the beginning/end.
	ld hl, wPokedex_Offset
	ld c, [hl]
	dec hl
	ld b, [hl]
	ld e, b

	; Scroll the dex cursor
.loop
	push af
	push bc
	ld d, 1
	push de
	call Pokedex_SetCursorMon
	pop de

	; Check if the cursor changed
	ld a, [wPokedex_CursorPos]
	cp e
	jr z, .scroll_failed
	ld e, a

	; Check if we found a valid species
	call Pokedex_GetCursorSpecies
	bit MON_CAUGHT_F, b
	jr nz, .found_species
	and a
	jr z, .next
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_BIO
	jr nc, .next

.found_species
	pop bc
	pop af
	xor a
	ret

.next
	pop bc
	pop af
	jr .loop

.scroll_failed
	pop bc
	ld hl, wPokedex_Offset
	ld a, c
	ld [hld], a
	ld [hl], b
	pop af
	or 1
	ret

Pokedex_GetCursorSpecies:
; Returns species in c and a, form+ext in b that cursor is hovering.
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
	call Pokedex_SearchInit
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
	ld d, 0
	call Pokedex_SetCursorMon
	jr .loop

Pokedex_SetCursorMon:
; Changes the cursor location based on a. If d==1, skip display updates.
	ld hl, wPokedex_Offset
	ld c, [hl]
	assert wPokedex_Offset - 1 == wPokedex_CursorPos
	dec hl
	ld b, [hl]
	push bc
.fixcursor_loop
	push af
	add [hl]
	ld [hl], a
	call .CursorPosValid
	pop bc
	ld a, b
	jr nc, .fixcursor_loop
	pop bc
	ld a, d
	and a
	ret nz
	ld a, [hli]
	cp b
	jr nz, .changed
	ld a, [hl]
	cp c
.changed
	call nz, Pokedex_GetCursorMon
	ret

.CursorPosValid:
	; If we can't go further up or down, don't do anything.
	ld a, [hl]
	cp $f0
	jr c, .not_going_upwards
	add $10
	ld [hl], a
	push hl
	ld b, 0
	call .SwitchRow ; Returns c upon failure.
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

	xor a
	bit 0, d
	ret nz

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
	ld d, a
	ret

Pokedex_UpdateRow:
; Populate tiles used for the given row in c with dex numbers and icon.
	ld a, BANK(wDexMons)
	call StackCallInWRAMBankA
.Function:
	; Set sprite offset.
	ld a, DEXPOS_ICONTILE_OFFSET
	ld b, 1 ; the first column is part of BG, not OAM.
	call Pokedex_GetPosData
	ld e, l
	dec b
	ld a, DEXPOS_PALCOPY
	call Pokedex_GetPosData
	dec hl
	ld [hl], e
	ld a, e
	add $7c
	push bc
	push af

	; Set up the VWF tilemap row with the proper tiles+attributes.
	ld a, DEXPOS_TILEMAP
	call Pokedex_GetPosData
	push hl
	ld a, DEXPOS_VWFTILE_OFFSET
	call Pokedex_GetPosData
	ld a, l
	pop hl
	ld d, 18
.loop
	ld [hli], a
	inc a
	dec d
	jr nz, .loop
	pop af

	; Now set up the mini BG tiles properly.
	inc hl
	inc hl
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
	ld hl, wDexVWFTiles
	ld bc, 18 tiles
	xor a
	rst ByteFill
	pop bc

	; The rest are to be iterated by column.
.loop3
	; Get mini palette and check species for this position.
	ld a, DEXPOS_PALCOPY
	call Pokedex_GetPosData
	push hl
	ld a, DEXPOS_MONS
	call Pokedex_GetPosData
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
	push af
	jr .species_done

.got_species
	; Palette.
	ld d, [hl]
	pop hl
	push bc
	ld c, a
	ld b, d

	push bc
	ld a, b
	and CAUGHT_MASK ; z = is not caught
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
	push af
	farcall _LoadOverworldMonIcon
	pop af
	ld a, b
	pop bc
	push af
	ld a, DEXPOS_ICON_TILES
	call Pokedex_GetPosData
	call SwapHLDE
	pop af
	push af
	push bc
	call FarDecompressToDE
	pop bc
.species_done
	call .GetDexNo
	ld de, wDexNumberString
	push bc
	call FastPrintNum
	pop bc
	inc de
	ld a, "@"
	ld [de], a
	ld a, DEXPOS_VWF_TILES
	call Pokedex_GetPosData
	pop af
	ld d, 0
	jr nz, .got_vwf_transparency
	ld d, VWF_OPAQUE
.got_vwf_transparency
	ld a, 14
	sub b
	sub b
	push bc
	ld c, a
	ld b, d
	ld de, wDexNumberString
	call PlaceVWFString
	pop bc
	inc b
	ld a, b
	cp 5
	jmp nz, .loop3
	ld b, 0
	ld a, DEXPOS_VWF_VTILES
	call Pokedex_GetPosData
	ld de, wDexRowTilesDest
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	ld a, DEXPOS_ICON_VTILES
	call Pokedex_GetPosData
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ld hl, wDexVWFTiles
	lb bc, -1, 18
	ld de, 1 tiles
.vwfhlines_loop
	ld [hl], b
	add hl, de
	dec c
	jr nz, .vwfhlines_loop
	ld a, 1
	ld hl, wDexVWFTiles tile 2
	ld b, 5
.vwfvlines_outer_loop
	ld c, 8
.vwfvlines_loop
	push af
	or [hl]
	ld [hli], a
	inc hl
	pop af
	dec c
	jr nz, .vwfvlines_loop
	add hl, de
	add hl, de
	rlca
	rlca
	jr c, .vwfvlines_next
	add hl, de
.vwfvlines_next
	dec b
	jr nz, .vwfvlines_outer_loop
	ld hl, wPokedex_GFXFlags
	set DEXGFX_ROWTILES, [hl]
	ret

.GetDexNo:
; TODO: When we have search modes, we want to check based on wDexMons.
	ld a, DEXPOS_DEXNO
	; fallthrough
Pokedex_GetPosData:
; Sets hl to a pointer offset, or value, depending on position data type in a.
; Takes row in c and column in b as input (0-indexed).
	push bc
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
	pop bc
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

Pokedex_GetFirstIconTile:
; Get first icon tile number in a, l, wPokedex_FirstIconTile
	lb bc, 0, 3
	ld a, DEXPOS_ICONTILE_OFFSET
	call Pokedex_GetPosData
	ld a, l
	ld [wPokedex_FirstIconTile], a
	ret

PokedexStr_Feet:
; Feet uses its own pelicular display format, so replace the ?s too.
	db "′??″@"

Pokedex_Description:
	; Get tile number for icon/shape
	call Pokedex_GetFirstIconTile

	; Load icon/shape into memory
	ld a, DEXDISP_DESC
	ld [wPokedex_DisplayMode], a
	call Pokedex_GetCursorMon

_Pokedex_Description:
	; Set display mode again here, in case we begin execution here
	ld a, DEXDISP_DESC
	ld [wPokedex_DisplayMode], a

	; Move the dex number display.
	ld a, 17
	ld [wPokedexOAM_DexNoX], a
	ld a, 80
	ld [wPokedexOAM_DexNoY], a

	; Load the description tilemap.
	ld hl, DexTilemap_Description
	call Pokedex_LoadTilemapWithPokepic

	ld de, wStringBuffer1
	hlcoord 9, 1
	rst PlaceString

	; Possibly adjust units of display.
	ld a, [wOptions2]
	bit POKEDEX_UNITS, a
	jr nz, .units_ok

	hlcoord 15, 7
	ld de, PokedexStr_Feet
	rst PlaceString
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
	jmp .footprint_bank

.mon_caught
	call GetSpeciesAndFormIndex
	push bc

	; Get a pointer to the body information
	ld hl, PokemonBodyData
rept 4
	add hl, bc
endr

	; Height
	push hl
	ld a, BANK(PokemonBodyData)
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
	pop hl
	inc hl

	; Weight
	ld a, BANK(PokemonBodyData)
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
	pop bc

	; Category
	call Pokedex_GetDexEntryPointer
	hlcoord 9, 5
	push af
	call FarString
	; Dex entry
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

.footprint_bank
	; Type and footprint should use correct vram bank
	ld a, [wPokedex_MonInfoBank]
	and a
	jr nz, .sel_shiny
	hlcoord 18, 2, wAttrMap
	ld b, VRAM_BANK_1
	ld a, [hl]
	xor b
	ld [hli], a
	ld a, [hl]
	xor b
	ld [hli], a
	hlcoord 9, 3, wAttrMap
	assert VRAM_BANK_1 == 8
	ld c, b
.attr_loop
	ld a, [hl]
	xor b
	ld [hli], a
	dec c
	jr nz, .attr_loop
	inc hl
	ld a, [hl]
	xor b
	ld [hli], a
	ld a, [hl]
	xor b
	ld [hli], a

.sel_shiny
	; Sel/Shiny indicator
	ld a, SHINY_CHARM
	ld [wCurKeyItem], a
	call CheckKeyItem
	jr nc, .botmenu
	hlcoord 9, 10
	ld b, $28
.sel_shiny_loop
	ld [hl], b
	inc b
	ld de, wAttrMap - wTileMap
	add hl, de
	ld a, $08
	ld [hli], a
	ld de, wTileMap - wAttrMap
	add hl, de
	ld a, b
	cp $2e
	jr nz, .sel_shiny_loop

.botmenu
	; Bottom menu bar
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexTilemap)
	ldh [rSVBK], a
	ld b, 0
	call Pokedex_SetTilemap
	hldexcoord 2, 18
	ld a, $16
	ld [hli], a
	ld a, $f2
	ld b, 15
.botmenu_loop
	ld [hli], a
	dec b
	jr nz, .botmenu_loop
	ld [hl], $16
	hldexcoord 4, 18
	ld a, $3c
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	hldexcoord 15, 18
	ld a, $2e
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	hldexcoord 15, 18, wDexAttrmap
	set OAM_TILE_BANK, [hl]
	inc hl
	set OAM_TILE_BANK, [hl]
	inc hl
	set OAM_TILE_BANK, [hl]
	inc hl
	set OAM_X_FLIP, [hl]

	ld b, DEXTILE_FROM_DEXMAP
	call Pokedex_SetTilemap
	pop af
	ldh [rSVBK], a

	ld a, $57
	ld de, PHB_DescSwitchSCY
	call Pokedex_ScheduleScreenUpdateWithHBlank

.joypad_loop
	call Pokedex_GetInput
	rrca
	jr c, .pressed_a
	rrca
	jr c, .pressed_b
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
	jr .joypad_loop

.pressed_a
	; print other page description
	ld a, [wPokedexOAM_IsCaught]
	and a
	jr z, .joypad_loop
	lb bc, 5, 19
	hlcoord 1, 12
	push hl
	call ClearBox
	pop hl
	pop af
	pop de
	pop bc
	push de
	push bc ; switch page 1 and page 2 on the stack
	push af
	call FarString

	; swap P.1/P.2 tile
	hlcoord 2, 10
	ld a, [hl]
	inc [hl]
	cp $1d
	jr z, .page_ok
	ld [hl], $1d
.page_ok
	call Pokedex_ScheduleScreenUpdate
	jr .joypad_loop

.pressed_select
	; cycle shininess
	call Pokedex_SwitchNormalOrShinyPalette
	jr .joypad_loop

.pressed_up
	call Pokedex_PrevPageMon
	jr nz, .joypad_loop
	jr .reload_page

.pressed_down
	call Pokedex_NextPageMon
	jr nz, .joypad_loop
.reload_page
	pop af
	pop hl
	pop hl
	jmp Pokedex_Description

.pressed_right
	ld a, [wPokedexOAM_IsCaught]
	and a
	jr z, .pressed_left
	pop af
	pop hl
	pop hl
	jr Pokedex_Bio

 .pressed_left
	jr .joypad_loop
	; pop af
	; pop hl
	; pop hl
	; jmp Pokedex_Area

.pressed_start
	; cycle form (if applicable)
	ld a, 1
	call Pokedex_ChangeForm
	jr c, .joypad_loop
	jr .reload_page

.pressed_b
	pop af
	pop hl
	pop hl

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
	rst PlaceString

	ld a, [wPokedex_MonInfoBank]
	and a
	jr nz, .vram_bank_1
	xor a
	hlcoord 18, 3, wAttrMap
	ld [hli], a
	ld [hl], a
	hlcoord 18, 4, wAttrMap
	ld [hli], a
	ld [hl], a

.vram_bank_1
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

	ld a, $3f
	ld de, PHB_Row1
	jmp Pokedex_ScheduleScreenUpdateWithHBlank

Pokedex_Bio:
	ld a, DEXDISP_BIO
	ld [wPokedex_DisplayMode], a

	; Load the bio tilemap.
	ld hl, DexTilemap_Bio
	call Pokedex_LoadTilemapWithIconAndForm

	ld a, 117
	ld [wPokedexOAM_DexNoX], a
	ld a, 20
	ld [wPokedexOAM_DexNoY], a

	ld de, wStringBuffer1
	hlcoord 4, 1
	rst PlaceString

	call Pokedex_GetCursorSpecies
	call GetSpeciesAndFormIndex

	; Print category
	call Pokedex_GetDexEntryPointer
	hlcoord 4, 3
	call FarString

	; Print catch rate
	hlcoord 8, 5
	ld de, wBaseCatchRate
	lb bc, 1, 3
	call PrintNum

	; Print gender ratio
	ld a, [wBaseGender]
	swap a
	and $f
	jr z, .all_m
	cp GENDER_F100
	jr z, .all_f
	cp GENDER_UNKNOWN
	jr z, .unknown
	ld b, a ; no-optimize a = N - a
	ld a, 8
	sub b
.simplify_loop
	rrc b
	rrca
	jr nc, .simplify_loop
	rlc b
	rlca
	add "0"
	hlcoord 8, 9
	ld [hli], a
	inc hl
	inc hl
	ld a, b
	add "0"
	ld [hl], a
	jr .base_exp

.all_m
	hlcoord 12, 9
	ld [hl], $7d
.all_f
	ld de, .AllString
	jr .print

.unknown
	hlcoord 12, 9, wAttrMap
	ld [hl], 0
	ld de, .UnknownString
.print
	hlcoord 8, 9
	rst PlaceString
	hlcoord 9, 9, wAttrMap
	ld [hl], 0

	; Print base experience
.base_exp
	ld a, [wBaseExp]
	ld e, a
	ld d, 0
	ld a, [wInitialOptions]
	bit SCALED_EXP, a ; should we use gen 5+ formula?
	jr z, .got_exp
	ld a, [wCurPartySpecies]
	ld c, a
	ld a, [wCurForm]
	and EXTSPECIES_MASK
	ld b, a
	push bc
	farcall _GetNewBaseExp
	pop bc
	ld a, c
	ld [wCurPartySpecies], a
	ld a, b
	ld [wCurForm], a
	ldh a, [hMultiplicand + 1]
	ld d, a
	ldh a, [hMultiplicand + 2]
	ld e, a
.got_exp
	hlcoord 8, 7
	ld bc, 3
	call PrintNumFromReg

	; Print egg group(s)
	ld a, [wBaseEggGroups]
	ld c, a
	swap c
	cp c
	jr z, .print_group_1
	push bc
	call .GetEggGroupName
	hlcoord 6, 12
	ld a, "s"
	ld [hli], a
	inc hl
	ld a, b
	call FarString
	pop bc
.print_group_1
	ld a, c
	call .GetEggGroupName
	hlcoord 8, 11
	ld a, b
	call FarString
	
	; Print hatch rate
	ld a, [wBaseEggSteps]
	and $f
	cp $f
	ld de, NotApplicable
	jr z, .goteggsteps
	ld e, a
	ld d, 0
	ld hl, HatchSpeedNames
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
.goteggsteps
	hlcoord 8, 14
	rst PlaceString

	; Print growth rate
	ld a, [wBaseGrowthRate]
	ld e, a
	ld d, 0
	ld hl, GrowthRateNames
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 8, 16
	rst PlaceString

	ld a, $84
	ld de, PHB_BioStatsSwitchSCY
	call Pokedex_ScheduleScreenUpdateWithHBlank

.joypad_loop
	call Pokedex_GetInput
	rrca
	jr c, .pressed_a
	rrca
	jmp c, Pokedex_Main
	rrca
	jr c, .pressed_select
	rrca
	jr c, .pressed_start
	rrca
	jmp c, Pokedex_Stats
	rrca
	jmp c, _Pokedex_Description
	rrca
	jr c, .pressed_up
	rrca
	jr c, .pressed_down
	jr .joypad_loop

.pressed_select
	; cycle shininess
	call Pokedex_SwitchNormalOrShinyPalette
	jr .joypad_loop

.pressed_start
	xor a
	call Pokedex_ChangeForm
	jr c, .joypad_loop
	jr .reload_page

.pressed_up
	call Pokedex_PrevPageMon
	jr nz, .joypad_loop
	jr .reload_position

.pressed_down
	call Pokedex_NextPageMon
	jr nz, .joypad_loop
.reload_position
	call Pokedex_GetFirstIconTile
.reload_page
	call Pokedex_GetCursorMon
	jmp Pokedex_Bio

.pressed_a
	ld a, [wCurPartySpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call PlayCry
	jr .joypad_loop

.GetEggGroupName:
	and $f
	dec a
	ld c, a
	ld b, 0
	ld hl, EggGroupNames
	add hl, bc
	add hl, bc
	ld a, BANK(EggGroupNames)
	ld b, a
	call GetFarWord
	ld d, h
	ld e, l
	ret

.AllString
	db "All @"
.UnknownString
	db "Unknown@"
INCLUDE "data/pokedex_bio.asm"

Pokedex_Stats:
	xor a
	ldh [hPokedexStatsCurAbil], a
_Pokedex_Stats:
	ld a, DEXDISP_STATS
	ld [wPokedex_DisplayMode], a

	; Load the stats tilemap.
	ld hl, DexTilemap_Stats
	call Pokedex_LoadTilemapWithIconAndForm

	ld a, 117
	ld [wPokedexOAM_DexNoX], a
	ld a, 20
	ld [wPokedexOAM_DexNoY], a

	ld de, wStringBuffer1
	hlcoord 4, 1
	rst PlaceString

	call Pokedex_GetCursorSpecies
	call GetSpeciesAndFormIndex

	; load base stats + EV yield, starting with HP
	hlcoord 5, 5
	ld de, wBaseHP
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield1]
	rlca
	rlca
	and 3
	jr z, .atk
	add $30 ; get corresponding EV tile
	ld [hl], a

.atk
	hlcoord 5, 7
	ld de, wBaseAttack
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield1]
	swap a
	and 3
	jr z, .def
	add $30
	ld [hl], a

.def
	hlcoord 5, 9
	ld de, wBaseDefense
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield1]
	rrca
	rrca
	and 3
	jr z, .sat
	add $30
	ld [hl], a

.sat
	hlcoord 15, 5
	ld de, wBaseSpecialAttack
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield2]
	rlca
	rlca
	and 3
	jr z, .sdf
	add $30
	ld [hl], a

.sdf
	hlcoord 15, 7
	ld de, wBaseSpecialDefense
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield2]
	swap a
	and 3
	jr z, .spe
	add $30
	ld [hl], a

.spe
	hlcoord 15, 9
	ld de, wBaseSpeed
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield1]
	and 3
	jr z, .ability
	add $30
	ld [hl], a

.ability
	; load ability
	ldh a, [hPokedexStatsCurAbil]
	add "1"
	cp "3"
	jr nz, .got_tile
	ld a, $3f ; bold H
.got_tile
	hlcoord 9, 11
	ld [hl], a
	ldh a, [hPokedexStatsCurAbil]
	add LOW(wBaseAbility1)
	ld l, a
	adc HIGH(wBaseAbility1)
	sub l
	ld h, a
	ld b, [hl]
	push bc
	hlcoord 1, 13
	farcall PrintAbility
	pop bc
	farcall PrintAbilityDescription

	; use correct vram bank for types and footprint
	ld a, [wPokedex_MonInfoBank]
	and a
	jr nz, .vbank_1
	hlcoord 18, 2, wAttrMap
	ld b, VRAM_BANK_1
	ld a, [hl]
	xor b
	ld [hli], a
	ld a, [hl]
	xor b
	ld [hli], a
	hlcoord 4, 3, wAttrMap
	assert VRAM_BANK_1 == 8
	ld c, b
.attr_loop
	ld a, [hl]
	xor b
	ld [hli], a
	dec c
	jr nz, .attr_loop
	hlcoord 18, 3, wAttrMap
	ld a, [hl]
	xor b
	ld [hli], a
	ld a, [hl]
	xor b
	ld [hli], a

.vbank_1
	ld a, $84
	ld de, PHB_BioStatsSwitchSCY
	call Pokedex_ScheduleScreenUpdateWithHBlank

.joypad_loop
	call Pokedex_GetInput
	rrca
	jr c, .pressed_a
	rrca
	jmp c, Pokedex_Main
	rrca
	jr c, .pressed_select
	rrca
	jr c, .pressed_start
	rrca
	; jmp c, Pokedex_Area
	rrca
	jmp c, Pokedex_Bio
	rrca
	jr c, .pressed_up
	rrca
	jr c, .pressed_down
	jr .joypad_loop

.pressed_select
	; cycle shininess
	call Pokedex_SwitchNormalOrShinyPalette
	jr .joypad_loop

.pressed_start
	xor a
	call Pokedex_ChangeForm
	jr c, .joypad_loop
	jr .reload_page

.pressed_up
	call Pokedex_PrevPageMon
	jr nz, .joypad_loop
	jr .reload_position

.pressed_down
	call Pokedex_NextPageMon
	jr nz, .joypad_loop
.reload_position
	call Pokedex_GetFirstIconTile
.reload_page
	call Pokedex_GetCursorMon
	jmp _Pokedex_Stats

.pressed_a
	lb bc, 4, 19
	hlcoord 1, 13
	push hl
	call ClearBox
	ldh a, [hPokedexStatsCurAbil]
	dec a
	ld b, $3f ; bold H
	jr z, .got_char
	dec a
	ld b, "1"
	jr z, .got_char
	inc b
.got_char
	hlcoord 9, 11
	ld [hl], b
	ld a, b
	and 3 ; conveniently, $3f & $3 = $3
	dec a
	ldh [hPokedexStatsCurAbil], a
	add LOW(wBaseAbility1)
	ld l, a
	adc HIGH(wBaseAbility1)
	sub l
	ld h, a
	ld b, [hl]
	pop hl
	push bc
	farcall PrintAbility
	pop bc
	farcall PrintAbilityDescription
	call Pokedex_ScheduleScreenUpdate
	jr .joypad_loop

Pokedex_SearchInit:
; Call to fully initialize Search page and reset cursor pos
	ld a, DEXDISP_SEARCH
	ld [wPokedex_DisplayMode], a

	ld a, 3
	ld [wPokedex_SearchCursorY], a
	; fallthrough
Pokedex_SearchReset:
; Resets all search fields but preserves cursor pos
	ld hl, wPokedex_SearchData
	xor a
	ld [wPokedexOAM_DexNoY], a ; might as well do this here
	assert wPokedex_SearchDataEnd - wPokedex_SearchData == 6 ; rept {expression} doesn't assemble :(
rept 6 ; this is the same number of bytes as a loop, and less cycles
	ld [hli], a
endr
	; fallthrough
Pokedex_Search:
; Reloads Search page without reinitializing search fields/cursor
	; Load the search page tilemap.
	ld hl, DexTilemap_Search
	call Pokedex_LoadTilemap

	; Draw cursor
	ld a, [wPokedex_SearchCursorY]
	ld b, a
	ld c, 1
	call Coord2Tile
	ld [hl], "▶"

	; Fill fields based on current search data
	ld c, wPokedex_SearchBody - wPokedex_SearchData
	ld hl, wPokedex_SearchData
.load_fields_loop
	push hl
	push bc
	ld a, c
	cpl
	add wPokedex_SearchDataEnd - wPokedex_SearchData + 2
	ld e, a
	dec e
	srl e
	add a
	inc a
	ld b, a
	ld a, [hl]
	call Pokedex_SearchPrintFieldName
	pop bc
	pop hl
	inc hl
	dec c
	jr nz, .load_fields_loop

	; Load body and determine which tiles to use (similar to stats page)
.reload_body
	ld a, [wPokedex_SearchBody]
	and a
	jr nz, .not_blank
	hlcoord 8, 11
	ld a, $7f
	ld [hli], a
	ld [hl], a
	hlcoord 8, 12
	ld de, Pokedex_BlankString
	rst PlaceString
	jr .reload_pals

.not_blank
	dec a
	; call Pokedex_GetBodyShapeInA
	ld hl, wPokedex_GFXFlags
	set DEXGFX_ICONSHAPE, [hl]
	call Pokedex_GetFirstIconTile
	add 8
	hlcoord 8, 11
	ld [hli], a
	inc a
	ld [hl], a
	inc a
	hlcoord 9, 11
	ld [hli], a
	inc a
	ld [hli], a
	ld a, $7f ; clear rest of Blank_String
	ld [hli], a
	ld [hl], a

.reload_pals
	ldh a, [rSVBK]
	ld b, a
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1 palette 2
if !DEF(MONOCHROME)
	; red
if DEF(NOIR)
	ld a, LOW(palred 14 + palgreen 14 + palblue 14)
	ld [hli], a
	ld a, HIGH(palred 14 + palgreen 14 + palblue 14)
	ld [hli], a
else
	ld a, LOW(palred 26 + palgreen 10 + palblue 6)
	ld [hli], a
	ld a, HIGH(palred 26 + palgreen 10 + palblue 6)
	ld [hli], a
endc
	; black
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	; white
	dec a
	ld [hli], a
	ld [hl], a
else
	ld a, LOW(PAL_MONOCHROME_DARK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_DARK)
	ld [hli], a
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ld [hl], a
endc

	ld hl, wPokedex_SearchColor
	ld a, [hld]
	and a
	jr z, .done_pals
	ld a, [hl] ; wPokedex_SearchColor
	and a
	jr z, .done_pals
.black
	dec a
	add a
	add LOW(BodyColorPals)
	ld l, a
	adc HIGH(BodyColorPals)
	sub l
	ld h, a
	ld a, BANK(BodyColorPals)
	ld de, wBGPals1 palette 3 + 6
	ld bc, 2
	call FarCopyBytesToColorWRAM
	jr .done_pals

.done_pals
	ld a, b
	ldh [rSVBK], a
.refresh
	ld a, $f
	ld de, PHB_SearchSwitchSCY
	call Pokedex_ScheduleScreenUpdateWithHBlank

.joypad_loop
	call Pokedex_GetInput
	rrca
	jr c, .pressed_a
	rrca
	jr c, .pressed_b
	rrca
	jmp c, Pokedex_SearchReset ; pressed select
	rrca
	; jr c, .pressed_start
	rrca
	jmp c, .pressed_right
	rrca
	jmp c, .pressed_left
	rrca
	jr c, .pressed_up
	rrca
	jr c, .pressed_down
	jr .joypad_loop

.pressed_up
	ld a, [wPokedex_SearchCursorY]
	cp 3
	jr z, .joypad_loop
	ld d, -2
	jr .move_cursor

.pressed_down
	ld a, [wPokedex_SearchCursorY]
	cp 17
	jr nc, .joypad_loop
	ld d, 2
.move_cursor
	ld e, a
	ld c, 1
	ld b, a
	call Coord2Tile
	ld [hl], $7f ; clear old tile
	ld a, e
	add d
	ld [wPokedex_SearchCursorY], a
	ld c, 1
	ld b, a
	call Coord2Tile
	ld [hl], "▶"
	jr .refresh

.pressed_a
	ld a, [wPokedex_SearchCursorY]
	; cp 15
	; jr z, .pressed_start
	cp 17
	jr nz, .pressed_right
.pressed_b
	ldh a, [rSVBK]
	ld b, a
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wBGPals1 palette 2
	ld c, (1 palettes + 2) / 2
	ld a, $ff
.reset_pal_loop
	ld [hli], a
	ld [hli], a
	cpl
	dec c
	jr nz, .reset_pal_loop
	ld a, b
	ldh [rSVBK], a
	jmp Pokedex_Main

.pressed_right
	ld c, 1
	jr .switch_index

.pressed_left
	ld c, -1
.switch_index
	ld a, [wPokedex_SearchCursorY]
	ld b, a
	srl a
	dec a; index = wPokedex_SearchCursorY / 2 - 1
	cp 6 ; "Start!"
	jr nc, .joypad_loop
	ld e, a
	srl e
	call StackJumpTable

.SwitchIndexJumptable:
	dw .TypeSwitch
	dw .TypeSwitch
	dw .EggGroupSwitch
	dw .EggGroupSwitch
	dw .BodyColorSwitch
	dw .BodyShapeSwitch

.TypeSwitch:
	ld d, NUM_TYPES
	ld hl, wPokedex_SearchType1
	ld a, b
	cp 3
	jr z, .GetValue
	inc hl
	jr .GetValue

.EggGroupSwitch:
	ld d, NUM_EGG_GROUPS + 1
	ld hl, wPokedex_SearchGroup1
	ld a, b
	cp 7
	jr z, .GetValue
	inc hl
	jr .GetValue

.BodyColorSwitch:
	ld d, NUM_BODY_COLORS + 1
	ld hl, wPokedex_SearchColor
.GetValue:
	ld a, [hl]
	add c
	cp -1
	jr z, .loop_to_end ; go back to the last value (NUM_[field] - 1)
	cp d
	jr c, .no_loop
	xor a
	ld [hl], a
	jr .finish

.loop_to_end
	ld a, d
	dec a
.no_loop
	ld [hl], a
.finish
	call Pokedex_SearchPrintFieldName
	jmp .reload_pals

.BodyShapeSwitch:
	jmp .joypad_loop

Pokedex_SearchPrintFieldName:
; Inputs:
;   a = index + 1
;   b = row - 1
;   e = field
; Output:
;   name in wStringBuffer1

	; Get tile coord
	ld d, a
	inc b
	ld c, 8
	call Coord2Tile

	; Clear existing string
	push hl
	ld a, $7f
	ld bc, 12
	rst ByteFill

	; If index == 0, use blank string
	ld c, e
	ld a, d
	and a
	ld b, BANK(Pokedex_SearchPrintFieldName)
	ld de, Pokedex_BlankString
	jr z, .got_field

	; Otherwise, first determine which name pointer table to use
	dec a
	ld e, a
	ld b, 0
	ld d, b
	ld hl, .field_table
	add hl, bc ; c already = field
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Apply the index offset to hl, and get the address of the string
	add hl, de
	add hl, de
	ld a, b
	call GetFarWord
	ld d, h
	ld e, l

.got_field
	; Got everything, now print!
	pop hl
	ld a, b
	jmp FarString

.field_table
	dba TypeNames
	dba EggGroupNames
	dba BodyColorNames

Pokedex_BlankString:
	db "----@"

Pokedex_GetSearchResults:
	ld de, 0
.loop
	; Check if mon at index de was caught
	push de
	ld hl, wPokedexCaught
	ld b, CHECK_FLAG
	call FlagAction
	jr z, .next
	pop bc

	; Are we looking for any base data?
	push bc
	ld hl, wTempDexFound
	push hl
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc [hl]
	or [hl]
	pop hl
	jr z, .base_data_done

	; Check base data (types + egg groups)
	call GetBaseDataFromIndexBC
	call .CheckTypes ; check wPokedex_SearchType1
	jr nz, .next
	inc hl
	call .CheckTypes ; check wPokedex_SearchType2
	jr nz, .next

	inc hl
	call .CheckEggGroups ; check wPokedex_SearchGroup1
	jr nz, .next
	inc hl
	call .CheckEggGroups ; check wPokedex_SearchGroup2
	jr nz, .next

.base_data_done
	; Are we looking for body data?
	ld a, [hli]
	ld d, a ; color
	or [hl]
	ld e, a ; shape
	jr z, .body_done
	ld hl, PokemonBodyData + BODY_COLOR
rept BODY_DATA_SIZE ; faster than AddNTimes while BODY_DATA_SIZE is small
	add hl, bc
endr
	ld a, BANK(PokemonBodyData)
	call GetFarByte
	ld h, a

	inc d
	dec d
	jr z, .color_done
	and $f
	cp d
	jr nz, .next

.color_done
	inc e
	dec e
	jr z, .shape_done
	ld a, h
	swap a
	and $f
	cp e
	jr nz, .next

.shape_done
	; we got the mon we're looking for, add it to results
	pop de
	push de
	ld hl, wTempDexFound
	ld b, SET_FLAG
	call FlagAction

.next
	pop de
	inc de
	ld a, e
	cp LOW(NUM_EXT_POKEMON)
	jr nz, .loop
	ld a, d
	cp HIGH(NUM_EXT_POKEMON)
	jr nz, .loop
	ret

.CheckTypes:
	ld de, wBaseType1
	ld a, [hl]
	and a
	ret z
	ld a, [de]
	cp [hl]
	ret z
	inc de
	ld a, [de]
	cp [hl]
	ret

.CheckEggGroups:
	ld de, wBaseEggGroups
	ld a, [hl]
	and a
	ret z
	ld a, [de]
	and $f
	cp [hl]
	ret z
	ld a, [de]
	swap a
	and $f
	cp [hl]
	ret

Pokedex_InitData:
; Initializes the list of Pokémon seen and owned.
	; Reset cursor positioning and shiny flag.
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
	ld b, -1
	push de
	inc d
.natloop
	inc de
	inc de
	inc b
	dec d
	jr nz, .natloop
	ld c, e
	dec bc
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
	jmp CountSetBits16

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
	xor a ; ld a, FALSE
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

Pokedex_SwitchMonInfoBank:
; Switch which bank to store tile data in. Tiles are loaded as follows:
; 0: vTiles2 tile $40
; 1: vTiles5 tile $40
	ld hl, wPokedex_MonInfoBank
	ld a, [hl]
	xor 1
	ld [hl], a
	ret

Pokedex_GetCursorMonInVBK1:
	ld a, 1
	ld [wPokedex_MonInfoBank], a
	jr _Pokedex_GetCursorMon
Pokedex_GetCursorMon:
; Displays information about the mon the cursor is currently hovering.
	call Pokedex_SwitchMonInfoBank
	; fallthrough
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

	; If species is zero, there's nothing there. Just load question mark tiles, then reload the screen.
	ld a, c
	and a
	jr nz, .got_species

	; Display a questionmark in place of the frontpic.
	ld hl, wPokedex_GFXFlags
	bit DEXGFX_ROWTILES, [hl]
	call nz, DelayFrame
	ld hl, QuestionMarkLZ
	ld de, sScratch + 1 tiles
	ld a, BANK(sScratch)
	call GetSRAMBank
	ld a, BANK(QuestionMarkLZ)
	call FarDecompressToDE
	call CloseSRAM
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
	; ld c, 3
	; call DelayFrames
	jmp .done

.got_species
	; Species name.
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld [wNamedObjectIndex], a
	ld [wCurIconSpecies], a
	ld a, $10
	ld [wPokedexOAM_DexNoY], a
	bit MON_CAUGHT_F, b
	ld a, b
	ld [wCurForm], a
	ld [wNamedObjectIndex+1], a
	ld [wPokedex_Form], a
	ld [wCurIconForm], a
	push af
	push bc
	call GetPokemonName
	ld de, wStringBuffer1
	hlcoord 9, 2
	rst PlaceString
	pop bc

	; Get dex number.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexNumber)
	ldh [rSVBK], a
	call GetPokedexNumber
	ld de, wPokedexOAM_DexNoStr
	ld h, b
	ld l, c
	call FastPrintNum
	pop af
	ldh [rSVBK], a

	; Frontpic
	call GetBaseData
	farcall PrepareFrontpic
	ld hl, wPokedex_GFXFlags
	set DEXGFX_FRONTPIC, [hl]

	; Check if other eligible forms to switch to exists
	ld hl, wPokedex_Personality
	res 0, [hl] ; clear pokedex other eligible form flag
	ld a, 1
	push hl
	call Pokedex_CheckForOtherForms
	pop bc
	jr c, .no_variants
	ld a, [bc]
	inc a
	ld [bc], a

.no_variants
	; Frontpic pal
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

	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_DESC
	jr c, .done_2

	farcall LoadOverworldMonIcon
	ld h, d
	ld l, e
	ld a, BANK(wDexMonIconTiles)
	ldh [rSVBK], a
	ld de, wDexMonIconTiles
	ld a, b
	call FarDecompressToDE

	call Pokedex_GetCursorSpecies
	call GetSpeciesAndFormIndex
	ld hl, PokemonBodyData + 3 ; skip height and weight
rept 4
	add hl, bc
endr
	ld a, BANK(PokemonBodyData)
	call GetFarByte
	push af
	swap a
	and $f
	ld c, a
	ld b, 0
	ld hl, Shapes
	ld a, 4 * LEN_1BPP_TILE
	rst AddNTimes
	ld de, wDexMonShapeTiles
	lb bc, BANK(Shapes), 4
	call Pokedex_Copy1bpp

	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	pop af
	and $f
	add a
	add LOW(BodyColorPals)
	ld l, a
	adc HIGH(BodyColorPals)
	sub l
	ld h, a
	ld a, BANK(BodyColorPals)
	ld de, wBGPals1 palette 3 + 6
	ld bc, 2
	call FarCopyBytesToColorWRAM
	call Pokedex_GetMonIconPalette

	ld hl, wPokedex_GFXFlags
	set DEXGFX_ICONSHAPE, [hl]
.done_2
	pop af
	ldh [rSVBK], a
.done
	ld hl, wPokedex_GFXFlags
	set DEXGFX_POKEINFO, [hl]
	; fallthrough
Pokedex_ScheduleScreenUpdate:
; Schedules a screen refresh for the next Pokedex_GetInput.
	xor a
	; fallthrough
Pokedex_ScheduleScreenUpdateWithHBlank:
	ld hl, wPokedex_GFXFlags
	set DEXGFX_DEFERRED, [hl]
	and a
	ret z
	ld [wPokedex_PendingLYC], a
	ld a, e
	ld [wPokedex_PendingHBlankFunction], a
	ld a, d
	ld [wPokedex_PendingHBlankFunction + 1], a
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








































































































; String_SEEN:
	; rawchar "Seen", $ff
; String_OWN:
	; rawchar "Own", $ff

; Pokedex_DrawDexEntryScreenBG:

; Pokedex_DrawDexEntryScreenRightEdge:
; Pokedex_DrawSearchScreenBG:
	; call Pokedex_FillBackgroundColor2
	; hlcoord 0, 2
	; lb bc, 14, 18
	; call Pokedex_PlaceBorder
	; hlcoord 0, 1
	; ld de, .Title
	; call Pokedex_PlaceString
	; hlcoord 8, 4
	; ld de, .TypeLeftRightArrows
	; call Pokedex_PlaceString
	; hlcoord 8, 6
	; ld de, .TypeLeftRightArrows
	; call Pokedex_PlaceString
	; hlcoord 3, 4
	; ld de, .Types
	; rst PlaceString
	; hlcoord 3, 13
	; ld de, .Menu
	; rst PlaceString
	; ret

; .Title:
	; rawchar $3b, " Search ", $3c, $ff

; .TypeLeftRightArrows:
	; db $3d, "        ▷", $ff

; .Types:
	; db   "Type1"
	; next "Type2@"

; .Menu:
	; db   "Begin Search!"
	; next "Cancel@"

; Pokedex_DrawSearchResultsScreenBG:
; .BottomWindowText:
	; db   "Search Results"
	; next "  Type/"
	; next "    found!@"

; Pokedex_PlaceSearchResultsTypeStrings:
	; ld a, [wDexSearchMonType1]
	; hlcoord 0, 14
	; call Pokedex_PlaceTypeString
	; ld a, [wDexSearchMonType1]
	; ld b, a
	; ld a, [wDexSearchMonType2]
	; and a
	; ret z
	; cp b
	; ret z
	; hlcoord 1, 15
	; call Pokedex_PlaceTypeString
	; hlcoord 0, 15
	; ld [hl], "/"
	; ret

; Pokedex_DrawUnownModeBG:
	; call Pokedex_FillBackgroundColor2
	; hlcoord 2, 1
	; lb bc, 11, 13
	; call Pokedex_PlaceBorder
	; hlcoord 2, 14
	; lb bc, 1, 13
	; call Pokedex_PlaceBorder
	; hlcoord 2, 15
	; ld [hl], $5c
	; hlcoord 16, 15
	; ld [hl], $3e
	; hlcoord 6, 5
	; call PlaceFrontpicAtHL
	; ld de, 0
	; lb bc, 0, NUM_UNOWN
; .loop
	; ld hl, wUnownDex
	; add hl, de
	; ld a, [hl]
	; and a
	; jr z, .done
	; push af
	; ld hl, UnownModeLetterAndCursorCoords
; rept 4
	; add hl, de
; endr
	; ld a, [hli]
	; ld h, [hl]
	; ld l, a
	; pop af
	; cp 27
	; jr z, .exclamation
	; cp 28
	; jr z, .question
	; add "A" - 1
	; jr .got_letter
; .exclamation
	; ld a, "!"
	; jr .got_letter
; .question
	; ld a, "?"
; .got_letter
	; ld [hl], a
	; inc de
	; inc b
	; dec c
	; jr nz, .loop
; .done
	; ld a, b
	; ld [wDexUnownCount], a
	; ret

; UnownModeLetterAndCursorCoords:
; ;           letter, cursor
	; dwcoord   4,12,   3,12
	; dwcoord   4,11,   3,11
	; dwcoord   4,10,   3,10
	; dwcoord   4, 9,   3, 9
	; dwcoord   4, 8,   3, 8
	; dwcoord   4, 7,   3, 7
	; dwcoord   4, 6,   3, 6
	; dwcoord   4, 5,   3, 5
	; dwcoord   4, 4,   3, 4
	; dwcoord   4, 3,   3, 2
	; dwcoord   5, 3,   5, 2
	; dwcoord   6, 3,   6, 2
	; dwcoord   7, 3,   7, 2
	; dwcoord   8, 3,   8, 2
	; dwcoord   9, 3,   9, 2
	; dwcoord  10, 3,  10, 2
	; dwcoord  11, 3,  11, 2
	; dwcoord  12, 3,  12, 2
	; dwcoord  13, 3,  13, 2
	; dwcoord  14, 3,  15, 2
	; dwcoord  14, 4,  15, 4
	; dwcoord  14, 5,  15, 5
	; dwcoord  14, 6,  15, 6
	; dwcoord  14, 7,  15, 7
	; dwcoord  14, 8,  15, 8
	; dwcoord  14, 9,  15, 9
	; dwcoord  14,10,  15,10
	; dwcoord  14,11,  15,11

; Pokedex_FillBackgroundColor2:
	; hlcoord 0, 0
	; ld a, $32
	; ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	; rst ByteFill
	; ret

; Pokedex_PlaceString:
; Pokedex_PlaceBorder:
; Pokedex_DrawFootprint:
	; hlcoord 18, 1
	; ld a, $65
	; ld [hli], a
	; inc a
	; ld [hl], a
	; hlcoord 18, 2
	; ld a, $67
	; ld [hli], a
	; inc a
	; ld [hl], a
	; ret

; Pokedex_GetSelectedMon:
; ; Gets the species of the currently selected Pokémon. This corresponds to the
; ; position of the cursor in the main listing, but this function can be used
; ; on all Pokédex screens.
	; ld a, [wDexListingCursor]
	; ld hl, wDexListingScrollOffset
	; add [hl]
	; ld e, a
	; ld d, $0
	; ld hl, wPokedexDataStart
	; add hl, de
	; ld a, [hli]
	; ld [wTempSpecies], a
	; ret

; Pokedex_CheckCaught:
	; push de
	; push hl
	; ld hl, wTempSpecies
	; ld a, [hli]
	; ld c, a
	; dec c
	; ld b, [hl]
	; call CheckCaughtMon
	; pop hl
	; pop de
	; ret

; Pokedex_CheckSeen:
	; push de
	; push hl
	; ld hl, wTempSpecies
	; ld a, [hli]
	; ld c, a
	; dec c
	; ld b, [hl]
	; call CheckSeenMon
	; pop hl
	; pop de
	; ret

; Pokedex_OrderMonsByMode:
	; ld hl, wPokedexOrder
	; ld bc, wPokedexOrderEnd - wPokedexOrder
	; xor a
	; rst ByteFill
	; ld a, [wCurDexMode]
	; call StackJumpTable

; .Jumptable:
	; dw .NewMode
	; dw .OldMode
	; dw Pokedex_ABCMode

; .NewMode:
	; ld de, NewPokedexOrder
	; ld hl, wPokedexOrder
	; ld bc, NUM_POKEMON
; .loopnew
	; ld a, [de]
	; inc de
	; ld [hli], a
	; dec c
	; jr nz, .loopnew
	; dec b
	; jr nz, .loopnew
	; jr .FindLastSeen

; .OldMode:
	; ld hl, wPokedexDataStart
	; ld a, $1
	; ld c, NUM_POKEMON
; .loopold
	; ld [hli], a
	; inc a
	; dec c
	; jr nz, .loopold
	; ; fallthrough

; .FindLastSeen:
	; ld hl, wPokedexDataStart + NUM_POKEMON - 1
	; ld d, NUM_POKEMON
	; ld e, d
; .loopfindend
	; ld a, [hld]
	; ld [wTempSpecies], a
	; call Pokedex_CheckSeen
	; jr nz, .foundend
	; dec d
	; dec e
	; jr nz, .loopfindend
; .foundend
	; ld a, d
	; ld [wDexListingEnd], a
	; ret

; Pokedex_ABCMode:
	; xor a
	; ld [wDexListingEnd], a
	; ld hl, wPokedexDataStart
	; ld de, AlphabeticalPokedexOrder
	; ld c, NUM_POKEMON
; .loop1abc
	; push bc
	; ld a, [de]
	; ld [wTempSpecies], a
	; call Pokedex_CheckSeen
	; jr z, .skipabc
	; ld a, [wTempSpecies]
	; ld [hli], a
	; ld a, [wDexListingEnd]
	; inc a
	; ld [wDexListingEnd], a

; .skipabc
	; inc de
	; pop bc
	; dec c
	; jr nz, .loop1abc
	; ld a, [wDexListingEnd]
	; ld c, 0
; .loop2abc
	; cp NUM_POKEMON
	; ret z
	; ld [hl], c
	; inc hl
	; inc a
	; jr .loop2abc

INCLUDE "data/pokemon/dex_order_alpha.asm"
INCLUDE "data/pokemon/dex_order_new.asm"

; Pokedex_DisplayModeDescription:
	; xor a
	; ldh [hBGMapMode], a
	; hlcoord 0, 12
	; lb bc, 4, 18
	; call Pokedex_PlaceBorder
	; ld a, [wDexArrowCursorPosIndex]
	; ld hl, .Modes
	; ld e, a
	; ld d, 0
	; add hl, de
	; add hl, de
	; ld e, [hl]
	; inc hl
	; ld d, [hl]
	; hlcoord 1, 14
	; rst PlaceString
	; ld a, $1
	; ldh [hBGMapMode], a
	; ret

; .Modes:
	; dw .NewMode
	; dw .OldMode
	; dw .ABCMode
	; dw .UnownMode

; .NewMode:
	; db   "<PK><MN> are listed in"
	; next "regional order.@"

; .OldMode:
	; db   "<PK><MN> are listed in"
	; next "national order.@"

; .ABCMode:
	; db   "<PK><MN> are listed"
	; next "alphabetically.@"

; .UnownMode:
	; db   "Unown are listed"
	; next "in order caught.@"

; Pokedex_DisplayChangingModesMessage:
	; xor a
	; ldh [hBGMapMode], a
	; hlcoord 0, 12
	; lb bc, 4, 18
	; call Pokedex_PlaceBorder
	; ld de, String_ChangingModesPleaseWait
	; hlcoord 1, 14
	; rst PlaceString
	; ld a, $1
	; ldh [hBGMapMode], a
	; ld c, 64
	; call DelayFrames
	; ld de, SFX_CHANGE_DEX_MODE
	; call PlaySFX
	; ld c, 64
	; jmp DelayFrames

; String_ChangingModesPleaseWait:
	; db   "Changing modes."
	; next "Please wait.@"

; Pokedex_UpdateSearchMonType:
	; ld a, [wDexArrowCursorPosIndex]
	; cp 2
	; jr nc, .no_change
	; ld hl, hJoyLast
	; ld a, [hl]
	; and D_LEFT
	; jr nz, Pokedex_PrevSearchMonType
	; ld a, [hl]
	; and D_RIGHT
	; jr nz, Pokedex_NextSearchMonType
; .no_change
	; and a
	; ret

; Pokedex_PrevSearchMonType:
	; ld a, [wDexArrowCursorPosIndex]
	; and a
	; jr nz, .type2

	; ld hl, wDexSearchMonType1
	; ld a, [hl]
	; cp $1
	; jr z, .wrap_around
	; dec [hl]
	; jr .done

; .type2
	; ld hl, wDexSearchMonType2
	; ld a, [hl]
	; and a
	; jr z, .wrap_around
	; dec [hl]
	; jr .done

; .wrap_around
	; ld [hl], UNKNOWN_T

; .done
	; scf
	; ret

; Pokedex_NextSearchMonType:
	; ld a, [wDexArrowCursorPosIndex]
	; and a
	; jr nz, .type2

	; ld hl, wDexSearchMonType1
	; ld a, [hl]
	; cp UNKNOWN_T
	; jr nc, .type1_wrap_around
	; inc [hl]
	; jr .done
; .type1_wrap_around
	; ld [hl], 1
	; jr .done

; .type2
	; ld hl, wDexSearchMonType2
	; ld a, [hl]
	; cp UNKNOWN_T
	; jr nc, .type2_wrap_around
	; inc [hl]
	; jr .done
; .type2_wrap_around
	; ld [hl], 0

; .done
	; scf
	; ret

; Pokedex_PlaceSearchScreenTypeStrings:
	; xor a
	; ldh [hBGMapMode], a
	; hlcoord 9, 3
	; lb bc, 4, 8
	; call ClearBox
	; ld a, [wDexSearchMonType1]
	; hlcoord 9, 4
	; call Pokedex_PlaceTypeString
	; ld a, [wDexSearchMonType2]
	; hlcoord 9, 6
	; call Pokedex_PlaceTypeString
	; ld a, $1
	; ldh [hBGMapMode], a
	; ret

; Pokedex_PlaceTypeString:
	; push hl
	; ld e, a
	; ld d, 0
	; ld hl, PokedexTypeSearchStrings
; rept POKEDEX_TYPE_STRING_LENGTH
	; add hl, de
; endr
	; ld e, l
	; ld d, h
	; pop hl
	; rst PlaceString
	; ret

; INCLUDE "data/types/search_strings.asm"

; Pokedex_SearchForMons:
	; ld a, [wDexSearchMonType2]
	; and a
	; call nz, .Search
	; ld a, [wDexSearchMonType1]
	; and a
	; call nz, .Search
	; ret

; .Search:
	; dec a
	; ld e, a
	; ld d, 0
	; ld hl, PokedexTypeSearchConversionTable
	; add hl, de
	; ld a, [hl]
	; ld [wDexConvertedMonType], a
	; ld hl, wPokedexDataStart
	; ld de, wPokedexDataStart
	; ld c, NUM_POKEMON
	; xor a
	; ld [wDexSearchResultCount], a
; .loop
	; push bc
	; ld a, [hl]
	; and a
	; jr z, .next_mon
	; ld [wTempSpecies], a
	; ld [wCurSpecies], a
	; xor a
	; ld [wCurForm], a
	; call Pokedex_CheckCaught
	; jr z, .next_mon
	; push hl
	; push de
	; call GetBaseData
	; pop de
	; pop hl
	; ld a, [wDexConvertedMonType]
	; ld b, a
	; ld a, [wBaseType1]
	; cp b
	; jr z, .match_found
	; ld a, [wBaseType2]
	; cp b
	; jr nz, .next_mon

; .match_found
	; ld a, [wTempSpecies]
	; ld [de], a
	; inc de
	; ld a, [wDexSearchResultCount]
	; inc a
	; ld [wDexSearchResultCount], a

; .next_mon
	; inc hl
	; pop bc
	; dec c
	; jr nz, .loop

	; ld l, e
	; ld h, d
	; ld a, [wDexSearchResultCount]
	; ld c, 0

; .zero_remaining_mons
	; cp NUM_POKEMON
	; ret z
	; ld [hl], c
	; inc hl
	; inc a
	; jr .zero_remaining_mons

; INCLUDE "data/types/search_types.asm"

; Pokedex_DisplayTypeNotFoundMessage:
	; xor a
	; ldh [hBGMapMode], a
	; hlcoord 0, 12
	; lb bc, 4, 18
	; call Pokedex_PlaceBorder
	; ld de, .TypeNotFound
	; hlcoord 1, 14
	; rst PlaceString
	; ld a, $1
	; ldh [hBGMapMode], a
	; ld c, $80
	; jmp DelayFrames

; .TypeNotFound:
	; db   "The specified type"
	; next "was not found.@"

; Pokedex_CursorOAM:
	; ; y, x, tile, OAM attributes
	; db $10, $47, $31, $7
	; db $10, $4f, $32, $7
	; db $10, $57, $32, $7
	; db $10, $5f, $33, $7
	; db $10, $80, $33, $7 | X_FLIP
	; db $10, $88, $32, $7 | X_FLIP
	; db $10, $90, $32, $7 | X_FLIP
	; db $10, $98, $31, $7 | X_FLIP
	; db $fe ; tells LoadCursorOAM to set c = 0
	; db $18, $47, $30, $7
	; db $18, $98, $30, $7 | X_FLIP
	; db $20, $47, $30, $7 | Y_FLIP
	; db $28, $47, $31, $7 | Y_FLIP
	; db $28, $4f, $32, $7 | Y_FLIP
	; db $28, $57, $32, $7 | Y_FLIP
	; db $28, $5f, $33, $7 | Y_FLIP
	; db $28, $80, $33, $7 | X_FLIP | Y_FLIP
	; db $28, $88, $32, $7 | X_FLIP | Y_FLIP
	; db $28, $90, $32, $7 | X_FLIP | Y_FLIP
	; db $28, $98, $31, $7 | X_FLIP | Y_FLIP
	; db $20, $98, $30, $7 | X_FLIP | Y_FLIP
	; db $ff

; Pokedex_SearchResultsCursorOAM:
	; ; y, x, tile, OAM attributes
	; db $10, $47, $31, $7
	; db $10, $4f, $32, $7
	; db $10, $57, $32, $7
	; db $10, $5f, $32, $7
	; db $10, $67, $33, $7
	; db $10, $7e, $33, $7 | X_FLIP
	; db $10, $86, $32, $7 | X_FLIP
	; db $10, $8e, $32, $7 | X_FLIP
	; db $10, $96, $32, $7 | X_FLIP
	; db $10, $9e, $31, $7 | X_FLIP
	; db $fe ; tells LoadCursorOAM to set c = 0
	; db $18, $47, $30, $7
	; db $18, $9e, $30, $7 | X_FLIP
	; db $20, $47, $30, $7 | Y_FLIP
	; db $28, $47, $31, $7 | Y_FLIP
	; db $28, $4f, $32, $7 | Y_FLIP
	; db $28, $57, $32, $7 | Y_FLIP
	; db $28, $5f, $32, $7 | Y_FLIP
	; db $28, $67, $33, $7 | Y_FLIP
	; db $28, $7e, $33, $7 | X_FLIP | Y_FLIP
	; db $28, $86, $32, $7 | X_FLIP | Y_FLIP
	; db $28, $8e, $32, $7 | X_FLIP | Y_FLIP
	; db $28, $96, $32, $7 | X_FLIP | Y_FLIP
	; db $28, $9e, $31, $7 | X_FLIP | Y_FLIP
	; db $20, $9e, $30, $7 | X_FLIP | Y_FLIP
	; db $ff

; Pokedex_UpdateSearchResultsCursorOAM:
	; ld hl, Pokedex_SearchResultsCursorOAM
	; ; fallthrough

; Pokedex_UpdateCursor:
	; push bc
	; lb bc, 3, 0
	; ld a, [wCurDexMode]
	; cp DEXMODE_OLD
	; jr nz, .ok
	; ld b, c
	; ld a, [wDexListingCursor]
	; or a
	; jr nz, .ok
	; ld c, 3
; .ok
	; call Pokedex_LoadCursorOAM
	; pop bc
	; ret

; Pokedex_LoadCursorOAM:
	; ld de, wVirtualOAM
; .loop
	; bit 7, [hl]
	; jr nz, .special
	; ld a, [wDexListingCursor]
	; and $7
	; swap a
	; add [hl]
	; add b
	; inc hl
	; ld [de], a
	; inc de
	; ld a, [hli]
	; ld [de], a
	; inc de
	; ld a, [hli]
	; add c
	; ld [de], a
	; inc de
	; ld a, [hli]
	; ld [de], a
	; inc de
	; jr .loop
; .special
	; ld a, [hli]
	; cp $ff
	; ret z
	; ld c, 0
	; jr .loop

; Pokedex_UpdateCursorOAM:
	; ld hl, Pokedex_CursorOAM
	; call Pokedex_UpdateCursor
	; ; fallthrough

; Pokedex_PutScrollbarOAM:
; ; Writes the OAM data for the scrollbar in the new mode and ABC mode.
	; push de
	; ld a, [wDexListingEnd]
	; dec a
	; ld e, a
	; ld a, [wDexListingCursor]
	; ld hl, wDexListingScrollOffset
	; add [hl]
	; cp e
	; jr z, .asm_4133f
	; ld hl, $0
	; ld bc, $79
	; rst AddNTimes
	; ld e, l
	; ld d, h
	; ld b, $0
	; ld a, d
	; or e
	; jr z, .asm_41341
	; ld a, [wDexListingEnd]
	; ld c, a
; .asm_41333
	; ld a, e
	; sub c
	; ld e, a ; no-optimize a = X +/- carry
	; ld a, d ; no-optimize b|c|d|e|h|l -= carry
	; sbc 0
	; ld d, a
	; jr c, .asm_41341
	; inc b
	; jr .asm_41333
; .asm_4133f
	; ld b, $79
; .asm_41341
	; ld a, $14
	; add b
	; pop hl
	; ld [hli], a
	; ld a, $a1
	; ld [hli], a
	; ld a, $f
	; ld [hli], a
	; ld [hl], $0
	; ret

; Pokedex_InitArrowCursor:
	; xor a
	; ld [wDexArrowCursorPosIndex], a
	; ld [wDexArrowCursorDelayCounter], a
	; ld [wDexArrowCursorBlinkCounter], a
	; ret

; Pokedex_MoveArrowCursor:
; ; bc = [de] - 1
	; ld a, [de]
	; ld b, a
	; inc de
	; ld a, [de]
	; dec a
	; ld c, a
	; inc de
	; call Pokedex_BlinkArrowCursor

	; ld hl, hJoyPressed
	; ld a, [hl]
	; and D_LEFT | D_UP
	; and b
	; jr nz, .move_left_or_up
	; ld a, [hl]
	; and D_RIGHT | D_DOWN
	; and b
	; jr nz, .move_right_or_down
	; ld a, [hl]
	; and SELECT
	; and b
	; jr nz, .select
	; call Pokedex_ArrowCursorDelay
	; jr c, .no_action
	; ld hl, hJoyLast
	; ld a, [hl]
	; and D_LEFT | D_UP
	; and b
	; jr nz, .move_left_or_up
	; ld a, [hl]
	; and D_RIGHT | D_DOWN
	; and b
	; jr nz, .move_right_or_down
	; jr .no_action

; .move_left_or_up
	; ld a, [wDexArrowCursorPosIndex]
	; and a
	; jr z, .no_action
	; call Pokedex_GetArrowCursorPos
	; ld [hl], " "
	; ld hl, wDexArrowCursorPosIndex
	; dec [hl]
	; jr .update_cursor_pos

; .move_right_or_down
	; ld a, [wDexArrowCursorPosIndex]
	; cp c
	; jr nc, .no_action
	; call Pokedex_GetArrowCursorPos
	; ld [hl], " "
	; ld hl, wDexArrowCursorPosIndex
	; inc [hl]

; .update_cursor_pos
	; call Pokedex_GetArrowCursorPos
	; ld [hl], "▶"
	; ld a, 12
	; ld [wDexArrowCursorDelayCounter], a
	; xor a
	; ld [wDexArrowCursorBlinkCounter], a
	; scf
	; ret

; .no_action
	; and a
	; ret

; .select
	; call Pokedex_GetArrowCursorPos
	; ld [hl], " "
	; ld a, [wDexArrowCursorPosIndex]
	; cp c
	; jr c, .update
	; ld a, -1
; .update
	; inc a
	; ld [wDexArrowCursorPosIndex], a
	; jr .update_cursor_pos

; Pokedex_GetArrowCursorPos:
	; ld a, [wDexArrowCursorPosIndex]
	; add a
	; ld l, a
	; ld h, 0
	; add hl, de
	; ld a, [hli]
	; ld h, [hl]
	; ld l, a
	; ret

; Pokedex_BlinkArrowCursor:
	; ld hl, wDexArrowCursorBlinkCounter
	; ld a, [hl]
	; inc [hl]
	; and $8
	; jr z, .blink_on
	; call Pokedex_GetArrowCursorPos
	; ld [hl], " "
	; ret

; .blink_on
	; call Pokedex_GetArrowCursorPos
	; ld [hl], "▶"
	; ret

; Pokedex_ArrowCursorDelay:
; ; Updates the delay counter set when moving the arrow cursor.
; ; Returns whether the delay is active in carry.
	; ld hl, wDexArrowCursorDelayCounter
	; ld a, [hl]
	; and a
	; ret z

	; dec [hl]
	; scf
	; ret

; Pokedex_BlackOutBG:
; ; Make BG palettes black so that the BG becomes all black.
	; call _Pokedex_JustBlackOutBG
	; jmp DelayFrame

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

; Pokedex_LoadSelectedMonTiles:
; ; Loads the tiles of the currently selected Pokémon.
	; call Pokedex_GetSelectedMon
	; call Pokedex_CheckSeen
	; jr z, .QuestionMark
	; call Pokedex_GetSelectedMon
	; cp UNOWN
	; jr z, .use_first_unown
	; cp MAGIKARP
	; jr z, .use_first_magikarp
	; ld a, PLAIN_FORM
	; jr .continue
; .use_first_unown
	; ld a, [wFirstUnownSeen]
	; jr .continue
; .use_first_magikarp
	; ld a, [wFirstMagikarpSeen]
; .continue
	; ld [wCurForm], a
	; ld [wDexMonForm], a
	; ld a, [wTempSpecies]
	; ld [wCurPartySpecies], a
	; call GetBaseData
	; ld de, vTiles2
	; predef_jump GetFrontpic

; .QuestionMark:
	; ld a, BANK(sScratch)
	; call GetSRAMBank
	; ld hl, QuestionMarkLZ
	; ld de, sScratch + 1 tiles
	; call Decompress
	; ld hl, vTiles2
	; ld de, sScratch + 1 tiles
	; ld c, 7 * 7
	; ldh a, [hROMBank]
	; ld b, a
	; call Get2bpp
	; jmp CloseSRAM

; Pokedex_LoadAnyFootprint:
	; ld a, [wTempSpecies]
	; dec a
	; and ($ff ^ $07) ; $f8 ; $1f << 3
	; rrca
	; rrca
	; rrca
	; and %00011111
	; ld e, 0
	; ld d, a
	; ld a, [wTempSpecies]
	; dec a
	; and 7
	; swap a ; * $10
	; add a
	; ld l, a
	; ld h, 0
	; add hl, de
	; ld de, Footprints
	; add hl, de

	; ld e, l
	; ld d, h
	; ld hl, vTiles2 tile $65
	; lb bc, BANK(Footprints), 4
	; jmp Request1bpp

; Pokedex_LoadGFX:
	; call DisableLCD
; Pokedex_LoadGFX2:
	; ld hl, vTiles2
	; ld bc, $31 tiles
	; xor a
	; rst ByteFill
	; call LoadStandardFont
	; call LoadFontsExtra
	; ld hl, PokedexLZ
	; ld de, vTiles2 tile $31
	; call Decompress
	; ld hl, PokedexSlowpokeLZ
	; ld de, vTiles0
	; call Decompress
	; ld a, 6
	; call SkipMusic
	; jmp EnableLCD

; Pokedex_LoadUnownFont:
	; ld a, [wOptions2]
	; ld [wOptionsBuffer], a
	; and $ff - FONT_MASK
	; or UNOWN_FONT
	; ld [wOptions2], a
	; jmp LoadStandardFont

; Pokedex_LoadUnownFrontpicTiles:
	; ld a, [wCurForm]
	; push af
	; ld a, [wDexCurUnownIndex]
	; ld e, a
	; ld d, 0
	; ld hl, wUnownDex
	; add hl, de
	; ld a, [hl]
	; ld [wCurForm], a
	; ld a, UNOWN
	; ld [wCurPartySpecies], a
	; call GetBaseData
	; ld de, vTiles2 tile $00
	; predef GetFrontpic
	; pop af
	; ld [wCurForm], a
	; ret

NewPokedexEntry:
	; TODO
	ret

; Pokedex_SetBGMapMode3:
	; ld a, $3
	; jr Pokedex_SetBGMapMode

; Pokedex_SetBGMapMode4:
	; ld a, $4
; Pokedex_SetBGMapMode:
	; ldh [hBGMapMode], a
	; jmp Delay2

Pokedex_GetDexEntryPointer:
	call GetDexEntryPointer
	ld d, h
	ld e, l
	ret

DexTilemaps:
DexTilemap_Main:
INCBIN "gfx/pokedex/main.bin.lz"

DexTilemap_Description:
INCBIN "gfx/pokedex/description.bin.lz"

DexTilemap_Bio:
INCBIN "gfx/pokedex/bio.bin.lz"

DexTilemap_Stats:
INCBIN "gfx/pokedex/stats.bin.lz"

DexTilemap_Area:
INCBIN "gfx/pokedex/area.bin.lz"

DexTilemap_Search:
INCBIN "gfx/pokedex/search.bin.lz"

DexTilemap_Mode:
INCBIN "gfx/pokedex/mode.bin.lz"

PokedexLZ:
INCBIN "gfx/pokedex/pokedex.2bpp.lz"

PokedexSlowpokeLZ:
INCBIN "gfx/pokedex/slowpoke.2bpp.lz"

QuestionMarkLZ:
INCBIN "gfx/pokedex/question_mark.2bpp.lz"
