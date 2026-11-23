	const_def 1
	const PAL_FOR_MAP
	const PAL_FOR_LANDMARK
	const PAL_FOR_TILESET
	const PAL_FOR_OVERCAST
	const PAL_FOR_DARKNESS

DEF PALSET_TYPE_MASK  EQU %11000000
DEF PALSET_START_MASK EQU %00111000
DEF PALSET_COUNT_MASK EQU %00000111

	const_def
	const PALTYPE_SINGLE      ; 0
	const PALTYPE_TIMEOFDAY   ; 1
	const PALTYPE_TIMEWEATHER ; 2
	const PALTYPE_SPECIAL     ; 3

LoadBlindingFlashPalette::
	ld de, wBGPals1 palette PAL_BG_TEXT
	ld hl, BlindingFlashPalette
	ld bc, 1 palettes
	jmp FarCopyColorWRAM

LoadLinkTradePalette:
	ld de, wBGPals1 palette 2
	ld hl, LinkTradePalette
	ld bc, 6 palettes
	jmp FarCopyColorWRAM

LoadSpecialMapPalette:
; Load a special map, landmark, or tileset palette if one applies.
	call InitializeSpecialPaletteRegisters
	ld hl, SpecialBGPalettes
.loop
	ld a, [hli]
	and a
	jr z, .not_special
	call CheckIfSpecialPaletteApplies
	jr nz, .next

	; b = type
	ld a, [hli]
	ld b, a
	and PALSET_START_MASK
	ld [wSpecialPalStart], a
	ld a, b
	rlca
	rlca
	ld b, a
	rlca
	and PALSET_COUNT_MASK << 3
	add 1 << 3
	ld [wSpecialPalCount], a
	ld a, b
	and PALSET_TYPE_MASK >> 6
	ld b, a
	; hl = source
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, b
	and a ; PAL_SINGLE?
	jr z, LoadSpecialBGPalettes
	dec a ; PAL_TIMEOFDAY?
	jr z, LoadSpecialTimeOfDayBGPalettes
	dec a ; PAL_TIMEWEATHER?
	jr z, LoadSpecialTimeWeatherBGPalettes
	; PAL_SPECIAL
	jp hl

.next
rept 3
	inc hl
endr
	jr .loop

.not_special
	and a
	ret

LoadSpecialTimeWeatherBGPalettes:
	push hl
	farcall GetOvercastIndex
	pop hl
	and a
	jr z, LoadSpecialTimeOfDayBGPalettes
	; skip the four regular time-of-day pals to reach the four overcast time-of-day pals
	ld a, [wSpecialPalCount]
	add a ; * 2 (most we can do in 8-bit without overflow)
	ld c, a
	ld b, 0
	add hl, bc ; + 2
	add hl, bc ; + 4
	; fallthrough
; don't copy the eighth palette, it's loaded based on the map's sign
LoadSpecialTimeOfDayBGPalettes:
	ld a, [wSpecialPalCount]
	ld c, a
	ld b, 0
	ld a, [wTimeOfDayPal]
	and 3
	rst AddNTimes
	; fallthrough
LoadSpecialBGPalettes:
	; de = wBGPals1 + [wSpecialPalStart]
	ld a, [wSpecialPalStart]
	add LOW(wBGPals1)
	ld e, a
	adc HIGH(wBGPals1)
	sub e
	ld d, a
	; bc = [wSpecialPalCount]
	ld a, [wSpecialPalCount]
	ld c, a
	ld b, 0
	call FarCopyColorWRAM
	scf
	ret

PokeCenterSpecialCase:
	ld hl, PokeCenterPalette
	call LoadSpecialBGPalettes
	; Shamouti has the default orange floors
	call RegionCheck
	ld a, e
	cp ORANGE_REGION
	jr z, .done
	; Kanto has blue floors
	ld hl, wBGPals1 palette PAL_BG_WATER
	dec e ; KANTO_REGION?
	jr z, .got_roof_pal
	; Snowtop Mountain has brown floors
	call GetWorldMapLocation
	cp SNOWTOP_MOUNTAIN
	ld hl, wBGPals1 palette PAL_BG_BROWN
	jr z, .got_roof_pal
	; Johto has red floors
	ld hl, wBGPals1 palette PAL_BG_RED
.got_roof_pal
	ld de, wBGPals1 palette PAL_BG_ROOF
	ld bc, 1 palettes
	call FarCopyColorWRAM
.done
	scf
	ret

MartSpecialCase:
	ld hl, MartPalette
	call LoadSpecialBGPalettes
	ld hl, wMapBlocksBank
	ld a, [hli]
	cp BANK(GenericMart_BlockData)
	jr nz, .not_generic_mart
	ld a, [hli]
	cp LOW(GenericMart_BlockData)
	jr nz, .not_generic_mart
	ld a, [hl]
	cp HIGH(GenericMart_BlockData)
	jr nz, .not_generic_mart
	ld hl, MartBluePalette
	ld de, wBGPals1 palette PAL_BG_GREEN
	ld bc, 1 palettes
	call FarCopyColorWRAM
.not_generic_mart
	scf
	ret

MagnetTrainSpecialCase:
	; The Magnet Train animation sets the environment to TOWN instead of INDOOR.
	ld a, [wEnvironment]
	assert TOWN == 0
	and a
	ret z
	; The Mart palette just replaces YELLOW (for the seats and caution stripes)
	; with the more muted Goldenrod roof palette.
	ld hl, MartPalette
	jr LoadSpecialBGPalettes

HiddenGrottoSpecialCase:
	ld a, [wTimeOfDayPal]
	and 3
	cp NITE
	ld hl, HiddenGrottoPalette
	jr nz, .got_palette
	ld hl, HiddenGrottoPalette + 7 palettes
.got_palette
	call LoadSpecialBGPalettes
	ld a, [wBackupMapGroup]
	ld hl, wBGPals1 palette PAL_BG_RED
	cp GROUP_BELLCHIME_TRAIL
	jr nz, .not_bellchime_trail_grotto
	ld a, [wBackupMapNumber]
	cp MAP_BELLCHIME_TRAIL
	jr z, .continue
.not_bellchime_trail_grotto
	ld hl, wBGPals1 palette PAL_BG_GRAY
	cp GROUP_CHERRYGROVE_BAY
	jr nz, .not_cherrygrove_bay
	ld a, [wBackupMapNumber]
	cp MAP_CHERRYGROVE_BAY
	jr z, .continue
.not_cherrygrove_bay
	ld hl, wBGPals1 palette PAL_BG_WATER
	cp GROUP_YELLOW_FOREST
	jr nz, .done
	ld a, [wBackupMapNumber]
	cp MAP_YELLOW_FOREST
	jr nz, .done
.continue
	ld de, wBGPals1 palette PAL_BG_GREEN
	ld bc, 1 palettes
	call FarCopyColorWRAM
	ld hl, wBGPals1 palette PAL_BG_GREEN color 1
	ld de, wBGPals1 palette PAL_BG_ROOF color 1
	ld bc, 3 colors
	call FarCopyColorWRAM
.done
	scf
	ret

InitializeSpecialPaletteRegisters:
	; b, c, d, e = [wMapGroup], [wMapNumber], landmark, [wMapTileset]
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld d, a
	ld a, [wMapTileset]
	ld e, a
	ret

CheckIfSpecialPaletteApplies:
	dec a ; PAL_FOR_MAP?
	jr nz, .not_map
	ld a, [hli]
	cp b ; [wMapGroup]
	ld a, [hli]
	ret nz
	cp c ; [wMapNumber]
	ret
.not_map
	dec a ; PAL_FOR_LANDMARK?
	jr nz, .not_landmark
	ld a, [hli]
	cp d ; landmark
	ret
.not_landmark
	dec a ; PAL_FOR_TILESET?
	jr nz, .not_tileset
	ld a, [hli]
	cp e ; [wTileset]
	ret
.not_tileset
	dec a ; PAL_FOR_OVERCAST?
	jr nz, .not_overcast
	push hl
	farcall GetOvercastIndex
	pop hl
	; invert z
	sub 1 ; no-optimize a++|a-- (dec a can't set carry)
	sbc a ; sets a to 0 if carry was not set, i.e. a != 0
	ret
.not_overcast
	; PAL_FOR_DARKNESS
	push hl
	push de
	call GetMapTimeOfDay
	pop de
	pop hl
	or ~IN_DARKNESS
	inc a
	ret nz
	ld a, [wStatusFlags]
	bit 2, a ; Flash
	ret

INCLUDE "data/maps/palettes.asm"

LoadMapPals::
	; Which palette group is based on whether we're outside or inside
	ld a, [wEnvironment]
	and 7
	ld e, a
	ld d, 0
	ld hl, EnvironmentColorsPointers
	add hl, de
	ld e, [hl]
	add hl, de

	; Further refine by time of day
	ld a, [wTimeOfDayPal]
	and 3
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld e, l
	ld d, h

	; Switch to palettes WRAM bank
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a

	ld hl, wBGPals1
	ld b, 7
.outer_loop
	ld a, [de] ; lookup index for TilesetBGPalette
	push de
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, TilesetBGPalette
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld c, 1 palettes
.inner_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .inner_loop
	pop de
	inc de
	dec b
	jr nz, .outer_loop

	pop af
	ldh [rWBK], a

	; special map palettes may overwrite only a subset of the default ones
	call LoadSpecialMapPalette

	ld hl, wPalFlags
	bit MAP_CONNECTION_PAL_F, [hl]
	res MAP_CONNECTION_PAL_F, [hl]
	jr nz, .skip_clearing_obj_pals
	farcall ClearSavedObjPals
.skip_clearing_obj_pals

	; only non-indoor environments load roof palettes
	ld a, [wEnvironment]
	cp FIRST_INDOOR_ENV
	jr nc, .finish
	; some exceptions to the usual rules which do not load roof palettes
	ld a, [wMapTileset]
	cp TILESET_SNOWTOP_MOUNTAIN ; covers map_id SNOWTOP_MOUNTAIN_OUTSIDE
	jr z, .finish
	cp TILESET_FOREST ; covers map_id YELLOW_FOREST
	jr z, .finish
	cp TILESET_FARAWAY_ISLAND ; covers map_id FARAWAY_ISLAND_SOUTH
	jr z, .finish

	; load a roof palette based on map group and overcast weather
	farcall GetOvercastIndex
	and a
	ld hl, RoofPals
	jr z, .not_overcast
	ld hl, OvercastRoofPals
.not_overcast
	ld a, [wMapGroup]
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld de, 4
	ld a, [wTimeOfDayPal]
	and 3
	cp NITE
	jr c, .morn_day
	jr z, .nite
; eve
	add hl, de
.nite
	add hl, de
.morn_day
	ld de, wBGPals1 palette PAL_BG_ROOF + 2
	ld bc, 4
	call FarCopyColorWRAM

.finish
	jmp InitializeSwappedPalette

; input: `de` = palette table (in this bank), `b` = BG palette ID (0-7)
; palette table order: regular morn, day, nite, eve, overcast morn, day, nite, eve
SwapColorPalette::
	ld a, d
	ld c, a

	; If `d` is PALSWAP_BG_INDEX, then `e` must be a `PAL_BG_*` index instead of
	; `de` being a pointer. Use the default BG colors in that case.
	cp PALSWAP_BG_INDEX
	jr z, .use_bg_index

	; If `d` is PALSWAP_ROOF_INDEX, then `e` must be a `GROUP_*` index instead of
	; `de` being a pointer. Use the roof BG colors in that case.
	cp PALSWAP_ROOF_INDEX
	jr z, .use_roof_index

	; Do not swap if the palette table is NULL.
	; This allows maps to specify multiple `palette_swap`s for the same palette.
	or e
	ret z

	; Set `hl` to the selected state's time-of-day palette in the table at `de`.
	ld a, PALSTATE_TIME_OF_DAY
	farcall GetPalState
	and 3
	; hl = de + a * 8
	add a
	add a
	add a
	ld l, a
	ld h, 0
	add hl, de

	; Skip past the regular palettes to the overcast ones if applicable.
	ld a, PALSTATE_OVERCAST_INDEX
	farcall GetPalState
	and a
	ld a, 0 ; no-optimize a = 0
	jr z, .finish
	ld a, 4 palettes
	jr .finish

.use_bg_index
	; Set `hl` to the selected state's time-of-day palette in the default BG palettes.
	ld a, PALSTATE_OVERCAST_INDEX
	farcall GetPalState
	and a
	ld hl, TilesetBGPalette
	jr z, .not_overcast_bg
	ld hl, OvercastBGPalette
.not_overcast_bg
	; hl += e * 1 palettes
	ld a, e
	add a
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, PALSTATE_TIME_OF_DAY
	farcall GetPalState
	and 3
	; hl += a * 8 palettes
	rrca
	rrca
	jr .finish

.use_roof_index
	; Set `hl` to the selected state's time-of-day palette in the default BG palettes.
	ld a, PALSTATE_OVERCAST_INDEX
	farcall GetPalState
	and a
	ld hl, RoofPals
	jr z, .not_overcast_roof
	ld hl, OvercastRoofPals
.not_overcast_roof
	; hl += e * 2 colors * 3
	ld a, e
	add a
	add a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld a, PALSTATE_TIME_OF_DAY
	farcall GetPalState
	and 3
	jr z, .morn_roof
	dec a ; morn/day/nite/eve being 0/1/2/3 becomes 0/0/1/2
.morn_roof
	; hl += a * 2 colors
	add a
	add a

.finish
	ld e, a
	ld d, 0
	add hl, de

	; Previous-state palettes become active; current-state palettes are the target.
	; d = [wPalState] == PREV_PALSTATE ? LOW(wBGPals2) : LOW(wBGPals1)
	ld a, [wPalState]
	assert PREV_PALSTATE == 0
	and a
	ld d, LOW(wBGPals2)
	jr z, .got_target
	ld d, LOW(wBGPals1)
.got_target
	; Set `de` to the `b`th palette of `wBGPals1` or `wBGPals2`.
	ld a, b
	add a
	add a
	add a
	add d ; LOW(wBGPals1) or LOW(wBGPals2)
	ld e, a
	assert HIGH(wBGPals1) == HIGH(wBGPals2)
	adc HIGH(wBGPals1)
	sub e
	ld d, a

	; Apply the swapped palette.
	; Only update middle colors for roofs.
	ld a, c
	cp PALSWAP_ROOF_INDEX
	ld bc, 1 palettes
	jr nz, .whole_palette
	inc de
	inc de
	ld c, 2 colors
.whole_palette
	jmp FarCopyColorWRAM

UpdatePaletteSwapState::
; wPaletteSwapStates stores the current state of each entry.
; wPaletteSwapInits records which entries have been initialized.
; Input: `c` PALETTE_SWAP_INSIDE_F set inside the rectangle,
;        `e` = this entry's state bit.
; Output: `c` PALETTE_SWAP_CHANGED_F set on first check or a state change.
	ld a, [wPaletteSwapStates]
	ld d, a
	; Build this entry's new state in `a`.
	bit PALETTE_SWAP_INSIDE_F, c
	jr nz, .inside
	ld a, e
	cpl
	and d
	jr .compare
.inside
	or e

	; Store only on first check or if the current state changed.
.compare
	cp d
	jr nz, .changed
	ld a, [wPaletteSwapInits]
	and e
	ret nz
	jr .finish
.changed
	ld [wPaletteSwapStates], a
.finish
	ld a, [wPaletteSwapInits]
	or e
	ld [wPaletteSwapInits], a
	set PALETTE_SWAP_CHANGED_F, c
	ret

CatchUpPaletteSwapFade::
; Rebuild BG palette `b` from palette list `de` under the fade's previous and
; current conditions, then catch its active palette up to the current step.
	push bc
	push de
	ld a, [wPalWhiteState]
	and a
	jr z, .swap_previous

	; de = wBGPals2 palette b
	ld a, b
	add a
	add a
	add a
	add LOW(wBGPals2)
	ld e, a
	adc HIGH(wBGPals2)
	sub e
	ld d, a

	farcall CopyWhitePal
	jr .got_previous

.swap_previous
	xor a
	assert PREV_PALSTATE == 0
	ld [wPalState], a
	push bc
	call SwapColorPalette
	pop bc

.got_previous
	pop de
	ld a, CURR_PALSTATE
	ld [wPalState], a
	call SwapColorPalette
	pop bc
	ld a, b
	farjp CatchUpBGPaletteFade

INCLUDE "data/tileset_palettes.asm"

INCLUDE "data/maps/environment_colors.asm"
