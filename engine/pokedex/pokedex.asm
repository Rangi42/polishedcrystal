Pokedex:
	ld a, [wDexPrevCursorPos]
	ld [wPokedex_CursorPos], a
	ld a, [wDexPrevOffset]
	ld [wPokedex_Offset], a

	call StackDexGraphics
	call Pokedex_Main

	ld a, [wDexPrevCursorPos]
	ld [wPokedex_CursorPos], a

	call Pokedex_MainLoop

	ld a, [wPokedex_CursorPos]
	ld [wDexPrevCursorPos], a
	ld a, [wPokedex_Offset]
	ld [wDexPrevOffset], a
	ret

Pokedex_LoadTilemap:
	ld a, BANK(wDexTilemap)
	call StackCallInWRAMBankA
.Function:
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

	hlcoord 1, 1, wAttrmap
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
	ldh [rSVBK], a
	ld de, wDexTilemap
	ld a, BANK(DexTilemaps)
	call FarDecompressToDE

	ld b, DEXTILE_FROM_DEXMAP
	call Pokedex_SetTilemap
	ld a, BANK(wStringBuffer1)
	ldh [rSVBK], a

	; Print species name
	ld de, wStringBuffer1
	hlcoord 4, 1
	rst PlaceString

	; Set dex number display position
	ld a, 116
	ld [wPokedexOAM_DexNoX], a
	ld a, 20
	ld [wPokedexOAM_DexNoY], a

	; Display mini
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
	assert DEXDISP_AREA > DEXDISP_STATS
	cp DEXDISP_STATS ; stats+area pages shouldn't display shape
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
; Input: a = 0 (check caught), 1 (check seen). For this function's purpose,
; any mon with cosmetic forms are considered caught even if only seen.
	push af
	call Pokedex_MonHasCosmeticForms
	jr c, .not_cosmetic
	pop af
	ld a, 1
	call Pokedex_CheckForOtherForms
	ret c
	ld a, BANK(wDexMons)
	call StackCallInWRAMBankA
.StackCall1:
	ld a, [hl]
	and CAUGHT_MASK
	or b
	ld b, a
	jr .StackCall2

.not_cosmetic
	pop af
	call Pokedex_CheckForOtherForms
	ret c
	ld a, BANK(wDexMons)
	call StackCallInWRAMBankA
.StackCall2:
	ld [hl], b
	jmp Pokedex_ScheduleScreenUpdate

Pokedex_MonHasCosmeticForms:
; Returns carry if the given mon on the cursor doesn't have cosmetic forms.
	call Pokedex_GetCursorSpecies
	; fallthrough
_Pokedex_MonHasCosmeticForms:
	; Used to track when we reach the end of the cosmetic table
	ld de, -VariantSpeciesAndFormTable
	ld hl, CosmeticSpeciesAndFormTable
.loop
	ld a, [hli]
	cp c
	ld a, [hli]
	jr nz, .next
	xor b
	and EXTSPECIES_MASK
	ret z ; At this point, carry isn't set.
.next
	push hl
	add hl, de
	pop hl
	jr nc, .loop
	ret ; At this point, carry is set.

Pokedex_CheckForOtherForms:
; Input: a = 0 (check caught), 1 (check seen)
; Output: b = form, c = species, hl = pointer to mon form
; carry flag set if no other eligible form found
	; Some routines use numbers other than 1 to mean "check seen" for
	; optimization reasons, but we use the MSB of e for other things.
	and 1
	ld e, a
	call Pokedex_GetCursorSpecies
	res MON_CAUGHT_F, b

	; If our current working form is the base form, treat any forms found
	; in the table as immediately valid.
	ld a, b
	and FORM_MASK
	cp PLAIN_FORM + 1
	jr nc, .baseform_check_done
	set 7, e
.baseform_check_done
	ld d, 0
	push hl
	ld hl, CosmeticSpeciesAndFormTable
	call .FindVariant
	pop hl
	ret

.found_current_variant
	; Mark that we've found the current variant.
	set 7, e
	; fallthrough
.FindVariant:
.variant_loop
	; Check for list terminator.
	ld a, [hli]
	and a
	jr z, .cont

	; Is this the correct species?
	cp c
	ld a, [hli]
	jr nz, .variant_loop

	; Is this the actual species? FORM_MASK+1 references upper species bits.
	xor b
	cp FORM_MASK + 1
	jr nc, .variant_loop

	; With the previous xor, this will return zero if this is the same form.
	and FORM_MASK
	jr z, .found_current_variant

	; Check if we've caught or seen the mon (depending on e)
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

	; If this is below our current working form, switch to this new one.
	bit 7, e
	jr nz, .got_form

	; Otherwise, if this is the first form for the species in the table,
	; store it for later. We want to switch to it in case we are currently
	; working with the base form, or if there's no form below our current
	; and the base form isn't valid.
	dec d
	inc d
	jr nz, .variant_loop
	ld d, a ; possible form to switch to, but we should check if others are viable (including base form)
	jr .variant_loop

.cont
	; We didn't find anything to switch to right away. Check if there's an
	; entry in the table at all beyond our currently working form.
	ld a, d
	and a
	jr nz, .test_base

	; Otherwise, bail out if our working form is the base form.
	ld a, b
	and FORM_MASK
	cp PLAIN_FORM + 1
	ret c
.test_base
	; Is the base form valid?
	ld a, b
	and EXTSPECIES_MASK
	inc a
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
; Leaves the mini alone and doesn't schedule a reload.
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
	scf
	ret

Pokedex_SwitchNormalOrShinyPaletteAndUpdate:
; Also reloads mini palette.
	call Pokedex_SwitchNormalOrShinyPalette
	ret nc
	; fallthrough
Pokedex_GetMonIconPalette:
	ld a, BANK(wBGPals1)
	call StackCallInWRAMBankA
.Function:
	ld a, [wCurIconSpecies]
	ld c, a
	ld a, [wCurIconForm]
	ld b, a
	ld a, [wPokedex_Shiny]
	farcall GetMonPalInBCDE
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
	ld c, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
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
	jr z, .next
	cp DEXDISP_STATS
	jr z, .next

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
; For a new dex entry, return species+form from wTempMon.
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_NEWDESC
	jr nz, .not_newdesc
	ld a, BANK(wTempSpecies)
	call StackCallInWRAMBankA
.StackCall1:
	ld a, [wTempSpecies]
	ld c, a
	ld a, [wTempForm]
	set MON_CAUGHT_F, a
	ld b, a
	ret

.not_newdesc
	ld a, BANK(wDexMons)
	call StackCallInWRAMBankA
.StackCall2:
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
	jr .loop

.pressed_a
	; Do nothing if we haven't seen what the cursor is hovering.
	call Pokedex_GetCursorSpecies
	ld a, c
	and a
	call nz, Pokedex_Description
	jr .loop

.pressed_b
	; Usually just returns from dex, but in search mode, return to search.
	ld a, [wPokedex_InSearchMode]
	and a
	ret z
	; fallthrough
.pressed_start
	call Pokedex_Search
	jr .loop
.pressed_select
	call Pokedex_Mode
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
	decoord 1, 9, wAttrmap
	hlcoord 1, 12, wAttrmap
	ld c, SCREEN_WIDTH * 6 - 2
	call .ShiftRowData
	hlcoord 19, 9
	ld [hl], POKEDEX_SCROLLTILE_TOP
	hlcoord 19, 12
	ld [hl], POKEDEX_SCROLLTILE_BAR
	ld c, b
	call Pokedex_UpdateRow
	xor a
	ld d, a
	ret

Pokedex_UpdateRow:
; Populate tiles used for the given row in c with dex numbers and icon.
	ld a, BANK(wDexMonTiles)
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
	ld [hl], a

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
	ld a, BANK(wDexMons)
	ldh [rSVBK], a
	ld a, [hli]
	and a
	ld d, [hl]
	push af
	ld a, BANK(wDexMonTiles)
	ldh [rSVBK], a
	pop af
	jr nz, .got_species

	; Blank the palette and do nothing else.
	pop hl
if !DEF(MONOCHROME)
	ld d, 6
	ld a, -1 ; RGB 31, 31, 31
.blank_pal
	ld [hli], a
	dec d
	jr nz, .blank_pal
else
rept 3
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ld [hli], a
endr
endc
	push af
	jr .species_done

.got_species
	; Palette.
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
	farcall GetMonPalInBCDE
	pop hl
	pop af
	push af
	jr nz, .species_caught

	; Apply transparency
	push bc
	ld b, d
	ld c, e
	farcall ApplyWhiteTransparency
	ld d, b
	ld e, c
	pop bc
	farcall ApplyWhiteTransparency

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
if !DEF(MONOCHROME)
	ld bc, palred 0 + palgreen 0 + palblue 0
else
	ld bc, PAL_MONOCHROME_BLACK
endc
	jr nz, .got_outline_pal
if !DEF(MONOCHROME)
	ld bc, palred 16 + palgreen 16 + palblue 16
else
	ld bc, PAL_MONOCHROME_DARK
endc
.got_outline_pal
	ld a, c
	ld [hli], a
	ld [hl], b

	; Icon
	pop bc
	push af
	farcall LoadMiniForSpeciesAndForm
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
	ld a, h
	or l
	jr nz, .do_vwf
	pop af
	jr .vwf_done

.do_vwf
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
.vwf_done
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
	ld a, DEXPOS_MONS
	call Pokedex_GetPosData
	ld a, BANK(wDexMons)
	ldh [rSVBK], a
	push bc
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld a, BANK(wDexMonTiles)
	ldh [rSVBK], a

	; If there's blank space here, we assume that the list is properly ordered.
	; This is because the only point when we have non-contiguous dex numbers,
	; we also have no blank spaces.
	ld a, c
	and a
	jr z, .not_seen

	; Otherwise, get the dex number for the species the usual way.
	call Pokedex_GetDexNumber
	ld h, b
	ld l, c
	pop bc
	ret

.not_seen
	pop bc
	ld hl, wPokedex_Rows
	ld a, [wPokedex_Offset]
	add c
	inc a
	sub [hl]
	jr c, .get_dexno
	jr nz, .end_of_list
	inc hl
	ld a, b
	sub [hl]
	jr c, .get_dexno
.end_of_list
	ld hl, 0
	ret

.get_dexno
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
	ld c, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
	inc hl
	ld b, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
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
	dw vTiles4 tile $20, 20 tiles, 4 tiles
	dw vTiles0 tile $28, 18 tiles, 4 tiles
	dw $20, 20, 4
	dw $28, 18, 4

	; offset-based
	dw wTilemap + 9 * SCREEN_WIDTH + 1, SCREEN_WIDTH * 3, 4
	dw wAttrmap + 9 * SCREEN_WIDTH + 1, SCREEN_WIDTH * 3, 4
	dw wDexPalCopy + 1, 6 * 5 + 1, 6

Pokedex_GetDexNumber:
; Optimized version of GetDexNumber for the benefit of the pokédex, which needs
; to query several Pokédex numbers in quick succession for things like the list.
; Instead of iterating NewPokedexOrder in case we're in johto mode, it checks a
; conversion table (wDexConversionTable) after figuring out the national dex No.
; Do not use this function outside the pokédex, because the conversion table
; isn't initialized at that point.
	ld a, BANK(wPokedexMode)
	call StackCallInWRAMBankA
.StackCall1:
	call GetNationalDexNumber
	ld a, [wPokedexMode]
	and a
	ret nz

	ld a, BANK(wDexConversionTable)
	call StackCallInWRAMBankA
.StackCall2:
	push hl
	ld hl, wDexConversionTable - 2
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, [hl]
	pop hl
	ld b, a
	ret


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

Pokedex_SetDispModeUnlessNewMon:
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_NEWDESC
	ret z
	ld a, DEXDISP_DESC
	ld [wPokedex_DisplayMode], a
	ret

Pokedex_Description:
	; Get tile number for icon/shape
	call Pokedex_GetFirstIconTile

	; Load icon/shape into memory
	call Pokedex_SetDispModeUnlessNewMon
	call Pokedex_GetCursorMon

_Pokedex_Description:
	; Set display mode again here, in case we begin execution here
	call Pokedex_SetDispModeUnlessNewMon

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

	; Clear the P.1 tiles.
	hlcoord 1, 9
	ld a, $7f
	ld [hli], a
	ld [hl], a
	hlcoord 0, 10
	ld a, $37
	ld [hli], a
	ld a, $31
	ld [hli], a
	ld [hli], a
	ld [hl], a

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

	; Multiply by 500/127
	xor a
	ldh [hMultiplicand + 0], a
	ld a, HIGH(1000)
	ldh [hMultiplicand + 1], a
	ld a, LOW(1000)
	ldh [hMultiplicand + 2], a
	farcall Multiply
	ld b, 4
	ld a, 127
	ldh [hDivisor], a
	farcall Divide
	ldh a, [hQuotient + 1]
	ld h, a
	ldh a, [hQuotient + 2]
	ld l, a
	inc hl
	srl h
	rr l
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
	farcall Multiply
	ld a, 35
	ldh [hMultiplier], a
	farcall Multiply
	ld a, 192
	ldh [hMultiplier], a
	farcall Multiply
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
	hlcoord 18, 2, wAttrmap
	ld b, VRAM_BANK_1
	ld a, [hl]
	xor b
	ld [hli], a
	ld a, [hl]
	xor b
	ld [hli], a
	hlcoord 9, 3, wAttrmap
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
	; Don't display bottom menu or shiny hint in new dex entry mode.
	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_NEWDESC
	jr z, .botmenu_done

	; Sel/Shiny indicator
	ld a, SHINY_CHARM
	ld [wCurKeyItem], a
	call CheckKeyItem
	jr nc, .botmenu
	hlcoord 9, 10
	ld b, $00
.sel_shiny_loop
	ld [hl], b
	inc b
	ld de, wAttrmap - wTilemap
	add hl, de
	ld a, VRAM_BANK_1 | 0
	ld [hli], a
	ld de, wTilemap - wAttrmap
	add hl, de
	ld a, b
	cp $06
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
	ld a, "<BLACK>"
	ld b, 15
.botmenu_loop
	ld [hli], a
	dec b
	jr nz, .botmenu_loop
	ld [hl], $16
	; "Area" uses tiles $29-$2b in bank 1
	ld a, $29
	hldexcoord 15, 18
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	; "Info" uses tiles $2c-$2e in bank 0
	inc a
	hldexcoord 4, 18
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

.botmenu_done
	ld a, $57
	ld de, PHB_DescSwitchSCY
	call Pokedex_ScheduleScreenUpdateWithHBlank

	ld a, [wPokedex_DisplayMode]
	cp DEXDISP_NEWDESC
	jr nz, .joypad_loop
	call Pokedex_GetCursorSpecies
	call PlayMonCry

.newdesc_joypad
	call Pokedex_GetInput
	rrca
	jr c, .newdesc_a
	rrca
	jr nc, .newdesc_joypad

.newdesc_a
	call .SwitchPage
	jr z, .newdesc_joypad
	pop af
	pop hl
	pop hl
	ret

.SwitchPage:
; Returns nz if switching from page 2 to page 1.
	lb bc, 5, 19
	hlcoord 1, 12
	call ClearBox
	pop hl ; preserve the return address...
	pop af
	pop de
	pop bc
	push de
	push bc ; switch page 1 and page 2 on the stack
	push af
	push hl ; return the return address to its proper place
	hlcoord 1, 12
	call FarString

	; swap P.1/P.2 tile
	hlcoord 2, 10
	ld a, [hl]
	inc [hl]
	cp $1d
	jr z, .page_ok
	ld [hl], $1d
.page_ok
	push af
	call Pokedex_ScheduleScreenUpdate
	pop af
	ret

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
	call nz, .SwitchPage
	jr .joypad_loop

.pressed_select
	; cycle shininess
	call Pokedex_SwitchNormalOrShinyPaletteAndUpdate
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
	jmp Pokedex_Bio

.pressed_left
	pop af
	pop hl
	pop hl
	jmp Pokedex_Area

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

	xor a
	ld [wPokedex_DisplayMode], a

	call ClearSpriteAnims
	lb de, $50, $09
	ld a, SPRITE_ANIM_INDEX_DEX_CURSOR
	call InitSpriteAnimStruct

	ld a, [wPokedex_InSearchMode]
	and a
	jr z, .print_seen_own

	; Replace with Results/
	hlcoord 9, 6
	ld de, .ResultString
	rst PlaceString

	xor a
	ld h, a
	ld l, a
	ld b, a
	ld c, 5
	ld a, [wPokedex_Rows]
	dec a
	call nz, AddNTimes
	ld a, [wPokedex_LastCol]
	ld c, a
	add hl, bc
	ld d, h
	ld e, l
	hlcoord 16, 7
	lb bc, 2, 3
	call PrintNumFromReg
	jr .minibox_done

.print_seen_own
	hlcoord 11, 7
	lb bc, 2, 3
	ld de, wPokedex_NumSeen
	call PrintNum
	hlcoord 17, 7
	lb bc, 2, 3
	ld de, wPokedex_NumOwned
	call PrintNum

.minibox_done
	ld c, 0
	call Pokedex_UpdateRow
	ld c, 1
	call Pokedex_UpdateRow
	ld c, 2
	call Pokedex_UpdateRow

	call Pokedex_GetCursorMon

	ld a, $3f
	ld de, PHB_Row1
	jmp Pokedex_ScheduleScreenUpdateWithHBlank

.ResultString:
	db " Results/  @"

Pokedex_Bio:
	ld a, DEXDISP_BIO
	ld [wPokedex_DisplayMode], a

	; Load the bio tilemap.
	ld hl, DexTilemap_Bio
	call Pokedex_LoadTilemapWithIconAndForm

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
	hlcoord 12, 9, wAttrmap
	ld [hl], 0
	ld de, Unknown
.print
	hlcoord 8, 9
	rst PlaceString
	hlcoord 9, 9, wAttrmap
	ld [hl], 0

	; Print base experience
.base_exp
	ld a, [wBaseExp]
	ld e, a
	ld d, 0
	ld a, [wInitialOptions]
	bit SCALED_EXP_OPT, a ; should we use gen 5+ formula?
	jr z, .got_exp
	ld a, [wCurPartySpecies]
	ld c, a
	ld a, [wCurForm]
	and SPECIESFORM_MASK
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
	ld de, Unknown
	ld a, [wBaseEggGroups]
	assert EGG_NONE * $11 == $ff
	inc a
	jr z, .goteggsteps
	ld a, [wBaseEggSteps]
	and $f
	cp HATCH_UNKNOWN
	jr z, .goteggsteps
	ld e, a
	ld d, 0
	ld hl, HatchSpeedNames
	add hl, de
	ld e, [hl]
	add hl, de
	ld e, l
	ld d, h
.goteggsteps
	hlcoord 8, 14
	rst PlaceString

	; Print growth rate
	ld a, [wBaseGrowthRate]
	ld e, a
	ld d, 0
	ld hl, GrowthRateNames
	add hl, de
	ld e, [hl]
	add hl, de
	ld e, l
	ld d, h
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
	call Pokedex_SwitchNormalOrShinyPaletteAndUpdate
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
	call PlayMonCry
	jr .joypad_loop

.GetEggGroupName:
	and $f
	dec a
	ld e, a
	ld d, 0
	ld hl, EggGroupNames
	add hl, de
	ld a, BANK(EggGroupNames)
	ld b, a
	call GetFarByte
	ld e, a
	add hl, de
	ld d, h
	ld e, l
	ret

.AllString:
	db "100%@"

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
	call .print_ev_dots

	hlcoord 5, 7
	ld de, wBaseAttack
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield1]
	swap a
	call .print_ev_dots

	hlcoord 5, 9
	ld de, wBaseDefense
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield1]
	rrca
	rrca
	call .print_ev_dots

	hlcoord 15, 5
	ld de, wBaseSpecialAttack
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield2]
	rlca
	rlca
	call .print_ev_dots

	hlcoord 15, 7
	ld de, wBaseSpecialDefense
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield2]
	swap a
	call .print_ev_dots

	hlcoord 15, 9
	ld de, wBaseSpeed
	lb bc, 1, 3
	call PrintNum
	ld a, [wBaseEVYield1]
	call .print_ev_dots

	ldh a, [hPokedexStatsCurAbil]
	add LOW(wBaseAbility1)
	ld l, a
	adc HIGH(wBaseAbility1)
	sub l
	ld h, a
	ld b, [hl]
	hlcoord 1, 13
	call Pokedex_PrintAbilityWithDescription

	; use correct vram bank for types and footprint
	ld a, [wPokedex_MonInfoBank]
	and a
	jr nz, .vbank_1
	hlcoord 18, 2, wAttrmap
	ld b, VRAM_BANK_1
	ld a, [hl]
	xor b
	ld [hli], a
	ld a, [hl]
	xor b
	ld [hli], a
	hlcoord 4, 3, wAttrmap
	assert VRAM_BANK_1 == 8
	ld c, b
.attr_loop
	ld a, [hl]
	xor b
	ld [hli], a
	dec c
	jr nz, .attr_loop
	hlcoord 18, 3, wAttrmap
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
	jmp c, Pokedex_Area
	rrca
	jmp c, Pokedex_Bio
	rrca
	jr c, .pressed_up
	rrca
	jr c, .pressed_down
	jr .joypad_loop

.pressed_select
	; cycle shininess
	call Pokedex_SwitchNormalOrShinyPaletteAndUpdate
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
	inc a
	cp 3
	jr nz, .got_new_abil
	xor a
.got_new_abil
	ldh [hPokedexStatsCurAbil], a
	add LOW(wBaseAbility1)
	ld l, a
	adc HIGH(wBaseAbility1)
	sub l
	ld h, a
	ld b, [hl]
	pop hl
	call Pokedex_PrintAbilityWithDescription
	call Pokedex_ScheduleScreenUpdate
	jr .joypad_loop

.print_ev_dots
	and 3
	ret z
	add $2c - 1 ; get corresponding EV tile
	ld [hl], a
	ret

Pokedex_PrintAbilityWithDescription:
	push bc
	farcall PrintAbility
	pop bc
	ld a, [wTextboxFlags]
	push af
	set NO_LINE_SPACING_F, a
	ld [wTextboxFlags], a
	farcall PrintAbilityDescription
	pop af
	ld [wTextboxFlags], a
	ret

Pokedex_SetModeSearchPals:
	ld a, BANK(wBGPals1)
	call StackCallInWRAMBankA
.Function:
	ld hl, DexModeSearchPals
	ld de, wBGPals1 palette 2
	ld bc, 1 palettes
	rst CopyBytes
	ret

Pokedex_ResetModeSearchPals:
; Sets BG2 to white/black/white/black, BG3:0 to white. Mid 2 are irrelevant.
	ld a, BANK(wBGPals1)
	call StackCallInWRAMBankA
.Function:
	ld hl, wBGPals1 palette 2
if !DEF(MONOCHROME)
	ld c, (1 palettes + 2) / 2
	ld a, -1 ; RGB 31, 31, 31
.loop
	ld [hli], a
	ld [hli], a
	cpl
	dec c
	jr nz, .loop
	ret
else
	; Also sets color 1 on BG3, not just 0, but that's fine.
	ld b, 3
.outer_loop
	ld de, .colors
	ld c, 4
.inner_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .inner_loop
	dec b
	jr nz, .outer_loop
	ret

.colors
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_BLACK
endc

Pokedex_Mode:
	ld a, [wPokedexMode]
	ld [wPokedex_MenuCursorY], a
	ld [wPokedexOAM_DexNoY], a
Pokedex_Mode_ReloadPals:
	ld a, DEXDISP_MODE
	ld [wPokedex_DisplayMode], a
	call Pokedex_SetModeSearchPals
	; fallthrough
_Pokedex_Mode:
	ld hl, DexTilemap_Mode
	call Pokedex_LoadTilemap

	; Maybe add Unown Mode option
	ld de, ENGINE_UNOWN_DEX
	farcall CheckEngineFlag
	jr c, .done_unown_mode

	hlcoord 2, 8
	ld de, .UnownMode
	rst PlaceString

.done_unown_mode
	hlcoord 1, 4
	ld a, [wPokedex_MenuCursorY]
	push af
	ld bc, SCREEN_WIDTH * 2
	rst AddNTimes
	ld [hl], "▶"

	; explain menu option
	pop af
	ld hl, .MenuDescriptions
	call GetNthString
	ld d, h
	ld e, l
	hlcoord 2, 14
	rst PlaceString

	; disable hblank int
	ld a, $57
	ld de, PHB_ModeSwitchSCY
	call Pokedex_ScheduleScreenUpdateWithHBlank
.joypad_loop
	call Pokedex_GetInput
	rrca
	jr c, .pressed_a
	rrca
	jr c, .return ; pressed b
	rrca
	jr c, .return ; pressed select
	rrca ; skip start
	rrca ; skip right
	rrca ; skip left
	rrca
	jr c, .pressed_up
	rrca
	jr c, .pressed_down
	jr .joypad_loop

.pressed_a
	ld a, [wPokedex_MenuCursorY]
	cp 2
	jr c, .change_mode
	jr nz, .return
	jmp Pokedex_Unown

.change_mode
	ld [wPokedexMode], a

	; In search mode, reload search results.
	ld a, [wPokedex_InSearchMode]
	and a
	push af
	call z, Pokedex_InitData
	pop af
	call nz, Pokedex_GetSearchResults
	xor a
	ld [wPokedex_CursorPos], a
	ld [wPokedex_Offset], a
.return
	call Pokedex_ResetModeSearchPals
	jmp Pokedex_Main

.pressed_up
	ld b, -1 ; Menu movement modifier
.change_menu
	ld a, [wPokedex_MenuCursorY]
.change_menu_loop
	add b

	; Check if we went past top or bottom.
	cp NUM_DEXMODE
	jr nc, .change_menu_loop
	ld [wPokedex_MenuCursorY], a

	cp DEXMODE_UNOWN
	jmp nz, _Pokedex_Mode

	push bc
	ld de, ENGINE_UNOWN_DEX
	farcall CheckEngineFlag
	pop bc
	jr c, .change_menu
	jmp _Pokedex_Mode

.pressed_down
	ld b, 1
	jr .change_menu

.UnownMode:
	db "Unown Mode@"

.MenuDescriptions:
	db   "<PK><MN> are listed in"
	next "regional order.@"

	db   "<PK><MN> are listed in"
	next "national order.@"

	db   "Display Unown"
	next "information.@"

	db   "Return to the <PK><MN>"
	next "list.@"

Pokedex_Search:
; Call to fully initialize Search page and reset cursor pos
	ld a, DEXDISP_SEARCH
	ld [wPokedex_DisplayMode], a

	call Pokedex_SetModeSearchPals

	xor a
	ld [wPokedexOAM_DexNoY], a
	ld [wPokedex_MenuCursorY], a

	; In search mode, don't reset current fields.
	ld a, [wPokedex_InSearchMode]
	and a
	jr nz, _Pokedex_Search
	; fallthrough
Pokedex_SearchReset:
; Resets all search fields but preserves cursor pos
	xor a
	ld hl, wPokedex_Search
	ld bc, NUM_DEXSEARCH
	rst ByteFill
	; fallthrough
_Pokedex_Search:
	ld hl, DexTilemap_Search
	call Pokedex_LoadTilemap

	; Update body shape tiles.
	ld a, [wPokedex_SearchBody]
	and a
	jr z, .shape_done

	dec a
	ld hl, Shapes
	ld bc, 4 * LEN_1BPP_TILE
	rst AddNTimes
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexMonShapeTiles)
	ldh [rSVBK], a
	ld de, wDexMonShapeTiles
	lb bc, BANK(Shapes), 4
	call Pokedex_Copy1bpp

	; Blank "----" for body.
	hlcoord 7, 16
	ld de, .BlankDefaultString
	rst PlaceString

	; Display shape tiles and switch tile bank and palette
	call Pokedex_GetFirstIconTile
	ld b, a
	ld a, [wPokedex_MonInfoBank]
	swap a
	rrca
	add b
	add 4 ; shape, not mini
	xor $80
	hlcoord 8, 15
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, wAttrmap - (wTilemap + SCREEN_WIDTH)
	add hl, bc
	ld a, VRAM_BANK_1 | 3
	ld [hli], a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	ld [hl], a

	; This will also do a useless write of mini data, but that is fine.
	ld hl, wPokedex_GFXFlags
	set DEXGFX_ICONSHAPE, [hl]
	pop af
	ldh [rSVBK], a

.shape_done
	; Update body shape pal.
	ld a, [wPokedex_SearchColor]
	add a
	add LOW(BodyColorPalsIncludingNull)
	ld l, a
	adc HIGH(BodyColorPalsIncludingNull)
	sub l
	ld h, a
	ld de, wBGPals1 palette 3 + 6
	ld bc, 2
	ld a, BANK(BodyColorPalsIncludingNull)
	call FarCopyBytesToColorWRAM
	; Draw cursor
	hlcoord 1, 3
	ld a, [wPokedex_MenuCursorY]
	ld bc, SCREEN_WIDTH * 2
	rst AddNTimes
	ld [hl], "▶"

	; Fill fields based on current search data
	hlcoord 7, 4

	; Body is handled seperately, hence "- 1".
	ld a, NUM_DEXSEARCH - 1
	ld bc, .SearchStringTableLocations
	ld de, wPokedex_Search
.print_loop
	push af
	push de
	push hl
	ld a, [de]
	and a
	ld de, .BlankDefaultString
	push af
	push bc
	call nz, PlaceString
	pop bc
	ld a, [bc]
	ld l, a
	inc bc
	ld a, [bc]
	ld h, a
	inc bc
	pop af
	jr z, .next_print
	dec a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [bc]
	push af
	call GetFarByte
	ld d, 0
	ld e, a
	pop af
	add hl, de
	ld d, h
	ld e, l
.print
	pop hl
	push hl
	push bc
	call FarString
	pop bc
.next_print
	pop hl
	inc bc
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop de
	inc de
	pop af
	dec a
	jr nz, .print_loop

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
	jr c, .pressed_start
	rrca
	jmp c, .pressed_right
	rrca
	jmp c, .pressed_left
	rrca
	jr c, .pressed_up
	rrca
	jr c, .pressed_down
	jr .joypad_loop

.pressed_a
	ld a, [wPokedex_MenuCursorY]
	cp NUM_DEXSEARCH ; Start!
	jr c, .pressed_right
.pressed_start
	call ClearSpriteAnims
	lb de, 120, 120
	ld a, SPRITE_ANIM_INDEX_DEX_SLOWPOKE
	call InitSpriteAnimStruct

	; Set a search timer.
	ldh a, [hVBlankCounter]
	and a
	call z, DelayFrame
	ldh a, [hVBlankCounter]
	inc a
	ld [wPokedex_SearchInProgress], a

	; Marks that we need to reload the list if we press B upon no results.
	ld a, 1
	ld [wPokedex_InSearchMode], a
	call Pokedex_GetSearchResults
	push af
	ld a, [wPokedex_SearchInProgress]
	ld b, a
.wait_81_frames
	call DelayFrame
	ldh a, [hVBlankCounter]
	sub b
	cp 81
	jr c, .wait_81_frames
	xor a
	ld [wPokedex_SearchInProgress], a
	call ClearSpriteAnims
	pop af
	jr nz, .reset_cursor

	; If we didn't get any search results, play an error sound.
	ld de, SFX_WRONG
	call PlaySFX
	jr .joypad_loop

.pressed_b
	; If we're currently in search mode, reinitialize the dex list first.
	ld a, [wPokedex_InSearchMode]
	and a
	jr z, .reset_pals
	xor a
	ld [wPokedex_InSearchMode], a
	call Pokedex_InitData
.reset_cursor
	xor a
	ld [wPokedex_CursorPos], a
	ld [wPokedex_Offset], a
.reset_pals
	call Pokedex_ResetModeSearchPals
	jmp Pokedex_Main

.pressed_up
	ld b, -1
	jr .move_cursor

.pressed_down
	ld b, 1
.move_cursor
	ld a, [wPokedex_MenuCursorY]
.cursor_move_loop
	add b
	; + 1 includes "Start!" as an option among carry
	cp NUM_DEXSEARCH + 1
	jr nc, .cursor_move_loop
	ld [wPokedex_MenuCursorY], a
.reload
	jmp _Pokedex_Search

.pressed_right
	ld b, 1
	jr .switch_index

.pressed_left
	ld b, -1
.switch_index
	ld a, [wPokedex_MenuCursorY]

	; do nothing if we're on "Start"
	cp NUM_DEXSEARCH
	jmp z, .joypad_loop

	push af
	add LOW(wPokedex_Search)
	ld l, a
	adc HIGH(wPokedex_Search)
	sub l
	ld h, a
	push hl
	ld de, .SearchOptionRanges - wPokedex_Search
	add hl, de
	pop de
	ld a, [de]

.switch_loop
	; This is very inefficient, but minimizes code size (and isn't *that* slow)
	add b
	cp [hl]
	jr nc, .switch_loop
	ld [de], a

	; If we're messing with shape, switch icon bank.
	pop af
	cp DEXSEARCH_SHAPE
	call z, Pokedex_SwitchMonInfoBank
	jr .reload

.SearchOptionRanges:
	db 2 ; by Number/by Name
	db NUM_TYPES
	db NUM_TYPES
	db NUM_EGG_GROUPS
	db NUM_EGG_GROUPS
	db NUM_BODY_COLORS
	db NUM_SHAPES

.SearchStringTableLocations:
	dab .DexOrdering
	dab TypeNames
	dab TypeNames
	dab EggGroupNames
	dab EggGroupNames
	dab BodyColorNames

.DexOrdering:
	; "byNumber" is default and thus part of the tilemap
	dr .byNameString

.byNameString:
	db "by Name  @"

.BlankDefaultString:
	; Blanks the default "----" string.
	db "    @"

Pokedex_ResetDexMonsAndTemp:
; Resets wDexMons and wTempDex RAM.
	xor a
	ld hl, wPokedex_FinalEntry
	ld [hli], a
	ld [hl], a
	ld hl, wTempDex
	ld bc, wTempDexEnd - wTempDex
	rst ByteFill

	; Wipe the current wDexMons data.
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
	ret

Pokedex_ConvertFinalEntryToRowCols:
	ld hl, wPokedex_FinalEntry
	ld a, [hli]
	ld b, [hl]
	ld hl, hDividend + 1
	ld [hld], a
	ld [hl], b
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	farcall Divide
	ldh a, [hRemainder]
	inc a
	ld [wPokedex_LastCol], a
	ldh a, [hQuotient + 2]
	inc a
	ld [wPokedex_Rows], a
	ret

Pokedex_GetSearchResults:
; Returns z if there was no search results.
	call Pokedex_ResetDexMonsAndTemp

	ld a, [wPokedex_SearchOrder]
	and a
	ld a, 2
	jr nz, .got_search_order
	ld a, [wPokedexMode]
	xor 1 ; for IterateSpecies, 0=national, 1=regional
.got_search_order
	ld hl, .SpeciesCallback
	call Pokedex_IterateSpecies
	call Pokedex_ConvertFinalEntryToRowCols

	; If the first byte in wDexMons is blank, there was
	; no search results found, otherwise it'd be 1-254,
	; signifying a species.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexMons)
	ldh [rSVBK], a
	ld a, [wDexMons]
	and a
	pop bc ; preserve flags
	ld a, b
	ldh [rSVBK], a
	ret

.SpeciesCallback:
	call Pokedex_HandleSeenOwn
	ret z

	jr c, .caught

	; Check if we're doing a null search. - 1 to exclude search order.
	ld hl, wPokedex_SearchData
	ld d, NUM_DEXSEARCH - 1
	xor a
.check_null_search
	or [hl]
	inc hl
	dec d
	jr nz, .check_null_search

	; If we aren't, skip this entry.
	and a
	ret nz

	; Otherwise, append the species. This will return nc
	; as desired.
	jr .search_done

.caught
	; Are we looking for any base data?
	; Preserve species+form for appending into wDexMons later.
	push bc

	; de contains cosmetic species index, we want regional index
	call GetSpeciesAndFormIndex

	ld hl, wPokedex_SearchData
	push hl
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	or [hl]
	jr z, .base_data_done
	pop hl

	; Check base data (types + egg groups)
	call GetBaseDataFromIndexBC
	call .CheckTypes ; check wPokedex_SearchType1
	jr nz, .invalid
	inc hl
	call .CheckTypes ; check wPokedex_SearchType2
	jr nz, .invalid

	inc hl
	call .CheckEggGroups ; check wPokedex_SearchGroup1
	jr nz, .invalid
	inc hl
	call .CheckEggGroups ; check wPokedex_SearchGroup2
	jr nz, .invalid
	push hl

.base_data_done
	; Are we looking for body data?
	inc hl
	ld a, [hli]
	ld d, a ; color
	ld e, [hl] ; shape
	or [hl]
	pop hl
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
	dec d
	and $f
	cp d
	jr nz, .invalid

.color_done
	inc e
	dec e
	jr z, .body_done
	dec e
	ld a, h
	swap a
	and $f
	cp e
	jr nz, .invalid

.body_done
	; We found a valid search result. Append to wDexMons.
	pop bc
	set MON_CAUGHT_F, b

	; Mark that the mon is caught for later return.
	scf

.search_done
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexMons)
	ldh [rSVBK], a

.check_finalentry
	; First, get the last entry handled in wDexMons.
	ld hl, wPokedex_FinalEntry + 1
	ld a, [hld]
	ld e, [hl]
	ld d, a

	; Check if the final entry matches. If not, we want to
	; move on to the next wDexMons entry.
	push hl
	ld hl, wDexMons
	add hl, de
	add hl, de

	; Don't overwrite unless the entry is blank, or the same
	; species.

	; Is the entry blank?
	inc [hl]
	dec [hl]
	jr z, .overwrite_ok

	; Is it the same species?
	ld a, [hli]
	cp c
	jr nz, .next_dexmon
	ld a, [hld]
	xor b
	and EXTSPECIES_MASK
	jr nz, .next_dexmon

	; Overwrite with current species data.
.overwrite_ok
	ld a, c
	ld [hli], a
	ld [hl], b
	pop hl
	pop af
	ldh [rSVBK], a
	ret

.next_dexmon
	pop hl

	; Increment FinalEntry and try again.
	; Then increment it for the next one.
	inc [hl]
	jr nz, .check_finalentry
	inc hl
	inc [hl]
	jr .check_finalentry

.invalid
	; Entry doesn't match search terms.
	pop bc

	; This might override a carry from before. This is intentional, since we
	; only reach this code if a captured mon is an invalid search result.
	; Returning carry will tell the iterator to move on to the next species.
	xor a
	ret

.CheckTypes:
	ld de, wBaseType1
	ld a, [hl]
	and a
	ret z
	ld a, [de]
	inc a
	cp [hl]
	ret z
	inc de
	ld a, [de]
	inc a
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

BodyColorPalsIncludingNull:
if !DEF(MONOCHROME)
	RGB 00, 00, 00
else
	RGB_MONOCHROME_BLACK
endc
BodyColorPals:
	table_width 2
INCLUDE "gfx/pokedex/body_colors.pal"
	assert_table_length NUM_BODY_COLORS

Pokedex_InitData:
; Initializes the list of Pokémon seen and owned.
	; Reset cursor positioning and wTempDex data.
	call Pokedex_ResetDexMonsAndTemp

	; Then populate the list with seen/captured Pokémon. Do seen first, because
	; a captured altform takes predecence over a seen regular form.
	ld hl, .SpeciesCallback
	call Pokedex_IterateSpeciesWithMode

	; Set up LastCol and Rows
	call Pokedex_ConvertFinalEntryToRowCols

	; Write to seen/owned
	ld hl, wTempDexSeen
	ld de, wPokedex_NumSeen
	ld bc, 4
	rst CopyBytes
	ret

.SpeciesCallback:
	; We can't stackcall to wDexMons because HandleSeenOwn assumes wram1.
	call Pokedex_HandleSeenOwn
	ret z

	; This is placed here because we want to preserve HandleSeenOwn flags.
	ldh a, [rSVBK]
	push af

	; Get dex number.
	ld d, b
	ld e, c
	jr nc, .not_caught
	set MON_CAUGHT_F, d
.not_caught
	call Pokedex_GetDexNumber
	dec bc

	; Track which entry we appended last.
	ld hl, wPokedex_FinalEntry
	ld a, c
	ld [hli], a
	ld [hl], b

	; Append to wDexMons.
	ld a, BANK(wDexMons)
	ldh [rSVBK], a
	ld hl, wDexMons
	add hl, bc
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	pop af
	ldh [rSVBK], a
	ret

Pokedex_CountSeenOwn:
; Returns amount of seen in wTempDexSeen, owned in wTempDexOwn. Preserves regs.
	push hl
	push de
	push bc
	push af
	ld hl, wDexCacheValid
	ld a, [hli]
	and a
	ld de, wTempDexSeen
	ld bc, 4
	jr z, .cache_not_valid
	rst CopyBytes
	jr .done

.cache_not_valid
	; Reset temp dex data.
	push hl
	push de
	push bc
	ld hl, wTempDex
	ld bc, wTempDexEnd - wTempDex
	xor a
	rst ByteFill
	ld hl, Pokedex_HandleSeenOwn
	call Pokedex_IterateSpecies
	pop bc
	pop hl
	pop de
	rst CopyBytes
	ld a, 1
	ld [wDexCacheValid], a
.done
	jmp PopAFBCDEHL

Pokedex_HandleSeenOwn:
; IterateSpecies callback that handles seen/owned statistics.
; Returns c if we've caught the mon, nz if we've seen it, otherwise z.
; It uses bc as input for species+form, de as input for extended index.
; Final results are stored in wTempDexSeen and wTempDexOwn assuming this
; is used as main callback (and not chained with another that messes with
; the way it handles things). Not that the one invoking this callback has to
; clear wTempDex-wTempDexEnd itself.
	; First, check if we own the Pokémon.
	ld hl, wPokedexCaught
	call .CheckDexFlag
	jr z, .check_seen

	; We still want to handle seen data, but we want to return carry.
	call .check_seen

	; Return nz|c. This assumes [hl] isn't 65535.
	ld hl, wTempDexOwn + 1
	scf
	; fallthrough
.IncrementHLPointer:
; big endian, hl starts at the least significant byte. This is because other
; code assumes basically everything is big endian, and copying this data is
; simplified this way...
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret

.check_seen
	; Check if we've already verified seen data for this. If so,
	; we don't need to bother checking another one.
	ld hl, wTempDexLast
	ld a, [hli]
	cp c
	ld a, [hld]
	jr nz, .not_last
	xor b
	and EXTSPECIES_MASK
	ret z

.not_last
	push hl
	ld hl, wPokedexSeen
	call .CheckDexFlag
	pop hl
	ret z

	; Carry is unset as a result of the flag check, no need to fix it here.
	ld a, c
	ld [hli], a
	ld [hl], b
	ld hl, wTempDexSeen + 1
	jr .IncrementHLPointer

.CheckDexFlag:
	push de
	push bc
	ld b, CHECK_FLAG
	; Not PokedexFlagAction, it's pointless when we already have extended index.
	call FlagAction
	pop bc
	pop de
	ret

Pokedex_IterateSpeciesWithMode:
	; wPokedexMode is 0 (johto)/1 (national), but IterateSpecies swaps them for
	; simplicity. So do a xor 1 here.
	ld a, [wPokedexMode]
	xor 1
Pokedex_IterateSpecies:
; Iterates all species. For each iteration, use hl as callback for a function to
; call for each valid species ID including all forms. bc contains species+form
; being checked. and de contains the resulting variant (not cosmetic) index.
; Iterate in the following order depending on a: 0 (natdex), 1 (johto), 2 (a-z)
	ld b, 0
	ld c, b
	ld de, NUM_POKEMON
	inc d ; to simplify looping checks
	and a ; cp DEXMODE_OLD
	jr nz, .species_loop
	inc c
.species_loop
	push de
	push bc
	push af

	; Get current species
	call .GetSpeciesID

	; Set de to extended index including regional variant.
	ld d, b
	ld e, c
	swap d
	srl d
	dec de

	; Begin at form 1, not form 0.
	inc b

	push hl
	push de
	push bc
	call _hl_
	pop bc
	pop de
	pop hl
	jr c, .next_species

	; Iterate through the variant form table to find any entries that match this
	; species. The reason for the NUM_SPECIES offset is because we want de to
	; contain the converted 16bit extended ID when calling hl.
	ld de, NUM_SPECIES
	push hl
.form_loop
	ld hl, CosmeticSpeciesAndFormTable - NUM_SPECIES * 2
	add hl, de
	add hl, de

	; Check if the 8bit species byte matches.
	ld a, [hli]
	and a
	jr z, .pop_hl_next_species
	cp c
	jr nz, .next_form

	; Check if the extspecies bits match.
	ld a, [hl]
	xor b ; if this leaves EXTSPECIES_MASK bits nonzero, they don't match.
	and EXTSPECIES_MASK
	jr nz, .next_form
	ld b, [hl]
	pop hl
	push hl
	push de
	push bc
	call _hl_
	pop bc
	pop de
	jr c, .pop_hl_next_species
.next_form
	inc de
	jr .form_loop

.pop_hl_next_species
	pop hl
.next_species
	; Check if we've iterated all the species.
	pop af
	pop bc
	pop de
	inc bc

	; If iterating using old order, we need to skip c=255 and c=0
	and a ; cp DEXMODE_OLD
	jr nz, .next_species_new_order

	; Skip c=255 and c=0
	inc c
	jr nz, .next_species_old_order
	inc b
	inc c
	inc c
.next_species_old_order
	dec c
.next_species_new_order
	dec e
	jr nz, .species_loop
	dec d
	jr nz, .species_loop
	ret

.GetSpeciesID:
	and a ; cp DEXMODE_OLD
	jr nz, .new_dex_order

	; Move the 9th bit to extspecies.
	swap b
	sla b
	ret

.new_dex_order
	push hl
	dec a ; cp DEXMODE_NEW
	ld hl, NewPokedexOrder
	jr z, .got_dex_order
	ld hl, AlphabeticalPokedexOrder
.got_dex_order
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
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

Pokedex_LoadUndiscoveredPokepic:
; Always returns z.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	ld a, 7
	ld [wMonPicSize], a
	ld hl, QuestionMarkLZ
	call GetPaddedFrontpicAddress
	ld a, BANK(QuestionMarkLZ)
	call FarDecompressToDE
	pop af
	ldh [rSVBK], a
	ld hl, wPokedex_GFXFlags
	set DEXGFX_FRONTPIC, [hl]

	ld hl, Pokedex_QuestionMarkPal
	ld de, wBGPals1 palette 6 + 2
	ld a, BANK(Pokedex_QuestionMarkPal)
	ld bc, 4
	call FarCopyBytesToColorWRAM
	xor a
	ret

Pokedex_QuestionMarkPal:
INCLUDE "gfx/pokedex/question_mark.pal"

Pokedex_SwitchMonInfoBank:
; Switch which bank to store tile data in. Tiles are loaded as follows:
; 0: vTiles2 tile $40
; 1: vTiles5 tile $40
	ld hl, wPokedex_MonInfoBank
	ld a, [hl]
	xor 1
	ld [hl], a
	ret

Pokedex_GetCursorMon:
; Displays information about the mon the cursor is currently hovering.
	call Pokedex_SwitchMonInfoBank
	; Set up proper palettes and switch between vbk0 and vbk1 usage.
	swap a
	rrca

	; Frontpic pal
	hlcoord 1, 1, wAttrmap
	lb bc, 7, 7
	add $6 ; BG6, potentially with VRAM_BANK_1
	call FillBoxWithByte

	hlcoord 18, 3, wAttrmap
	lb bc, 2, 2
	call FillBoxWithByte

	; Mon infobox pal
	inc a ; BG7, potentially with VRAM_BANK_1
	hlcoord 9, 4, wAttrmap
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
	ld hl, wBGPals1 palette 7 + 2
if !DEF(MONOCHROME)
	ld a, -1 ; RGB 31, 31, 31
	ld c, 6
	rst ByteFill
else
rept 3
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_WHITE)
	ld [hli], a
endr
endc
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

	call Pokedex_LoadUndiscoveredPokepic
	set DEXGFX_POKEINFO, [hl]

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
	call Pokedex_GetDexNumber
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexNoStrNumber)
	ldh [rSVBK], a
	ld de, wDexNoStrNumber
	ld h, b
	ld l, c
	call FastPrintNum
	pop af
	ldh [rSVBK], a

	; Frontpic
	call GetBaseData
	ldh a, [rSVBK]
	push af
	ld a, BANK(wCurPartySpecies)
	ldh [rSVBK], a
	farcall PrepareFrontpic
	pop af
	ldh [rSVBK], a
	ld hl, wPokedex_GFXFlags
	set DEXGFX_FRONTPIC, [hl]

	; Check if this mon has variants
	ld hl, wPokedex_Personality
	res 0, [hl]
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

	; If we haven't caught the mon, clear type and footprint icons
	pop af
	ldh a, [rSVBK]
	push af
	lb bc, NUM_TYPES, NUM_TYPES
	jr z, .got_types
	; Otherwise, also include type and footprint icons.
	ld a, TRUE
	ld [wPokedexOAM_IsCaught], a
	ld a, [wBaseType1]
	ld c, a
	ld a, [wBaseType2]
	cp c
	ld b, NUM_TYPES ; one past the last type
	jr z, .got_types
	ld b, a
.got_types
	; First type pal+icon
	push bc
	ld b, 0
	ld a, 4 * LEN_1BPP_TILE
	ld hl, TypeIconGFX
	rst AddNTimes
	ld de, wBGPals1 palette 7 + 2
	call Pokedex_CopyTypeIconPals
	pop bc
	ld de, wDexMonType1Tiles
	ld a, BANK(wDexMonType1Tiles)
	ldh [rSVBK], a
	push bc
	lb bc, BANK(TypeIconGFX), 4
	call Pokedex_Copy1bpp
	pop bc
	; Second type pal+icon
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
	; Footprint icon
	pop af
	push af
	ld hl, BlankFootprint
	jr z, .got_footprint
	call Pokedex_GetCursorSpecies
	call GetSpeciesAndFormIndex
	ld hl, FootprintPointers
	add hl, bc
	add hl, bc
	ld a, BANK(FootprintPointers)
	call GetFarWord
.got_footprint
	ld a, BANK(Footprints)
	ld de, wDexMonFootprintTiles
	call FarDecompressToDE
	; Expand 1bpp to 2bpp
	ld hl, wDexMonFootprintTiles + 4 * LEN_1BPP_TILE - 1
	ld de, wDexMonFootprintTiles + 4 tiles - 1
	ld c, 4 * LEN_1BPP_TILE
.footprint_loop
	ld a, [hld]
	ld [de], a
	dec de
	ld [de], a
	dec de
	dec c
	jr nz, .footprint_loop

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

	farcall LoadMini
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

	; If this is the initial h-blank setup, force a screen refresh and activate
	; LCD H-Blank.
	ld hl, wPokedex_PendingLYC
	inc [hl]
	dec [hl]
	ld [hli], a
	ld a, e
	ld [hli], a
	ld [hl], d
	ret nz

	; Needs to be set up immediately during init.
	call Pokedex_RefreshScreen

	ld a, 1 << rSTAT_INT_LYC
	ldh [rSTAT], a
	ld hl, rIF
	res LCD_STAT, [hl]
	ld hl, rIE
	set LCD_STAT, [hl]
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

INCLUDE "data/pokemon/dex_order_alpha.asm"
INCLUDE "data/pokemon/dex_order_new.asm"


NewPokedexEntry:
	; Disable H-blank as invoked in battles.
	ld hl, rIE
	res LCD_STAT, [hl]

	call ClearPalettes
	call DelayFrame
	call StackDexGraphics

	ld a, DEXDISP_NEWDESC
	ld [wPokedex_DisplayMode], a

	; Ensure that we write the mon graphics to vbk0.
	ld a, 1 ; will be switched to 0 upon next Pokedex_GetCursorMon call.
	ld [wPokedex_MonInfoBank], a
	jmp Pokedex_Description

Pokedex_GetDexEntryPointer:
	call GetDexEntryPointer
	ld d, h
	ld e, l
	ret

DexModeSearchPals:
INCLUDE "gfx/pokedex/mode_search.pal"
