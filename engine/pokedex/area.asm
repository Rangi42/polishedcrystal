Pokedex_AreaTypeLists:
	list_start Pokedex_AreaTypeLists
	setcharmap no_ngrams
	li "Morning"
	li "Day"
	li "Night"
	li "Surfing"
	li "Old Rod"
	li "Good Rod"
	li "Super Rod"
	li "Headbutt"
	li "Rock Smash"
	li "Bug Contest"
	setcharmap default
	assert_list_length NUM_DEXAREAS

Pokedex_Area:
	; TODO: maybe preset depending on time of day?
	xor a
	ldh [hPokedexAreaMode], a
	; fallthrough
Pokedex_Area_ResetLocationData:
; For when scrolling to a new species or forme.
	; Write palette data. Not redundant, because scrolling reloads
	; BG7, i.e. type icon palettes.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, DexAreaPals
	ld de, wBGPals1 palette 3
	ld bc, 5 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a

	; Clear "Area Unknown" marker.
	ld hl, hPokedexAreaMode
	res DEXAREA_UNKNOWN_F, [hl]

	; Iterate all location types to check if we should print "Area Unknown".
	ld d, 0 ; region
.outer_loop
	ld e, 0 ; type
.inner_loop
	push de
	call Pokedex_GetMonLocations
	pop de
	jr nc, _Pokedex_Area
	inc e
	ld a, e
	cp NUM_DEXAREAS
	jr nz, .area_unknown
	inc d
	ld a, d
	cp NUM_REGIONS
	jr z, .area_unknown

	; Check if we have unlocked the region
	cp ORANGE_REGION
	jr nz, .check_kanto
	ld a, [wStatusFlags2]
	bit 3, a ; ENGINE_SEEN_SHAMOUTI_ISLAND
	jr z, .area_unknown
	; Redundant to run the check below again, but means less space used.
.check_kanto
	ld a, [wStatusFlags]
	bit 6, a ; ENGINE_CREDITS_SKIP
	jr nz, .outer_loop
.area_unknown
	ld hl, hPokedexAreaMode
	set DEXAREA_UNKNOWN_F, [hl]
	; fallthrough
_Pokedex_Area:
	ld a, DEXDISP_AREA
	ld [wPokedex_DisplayMode], a

	call Pokedex_GetAreaMode
	push de

	; Retrieve the area tilemap
	ld hl, DexTilemap_Kanto
	dec d
	jr z, .got_tilemap
	ld hl, DexTilemap_Orange
	dec d
	jr z, .got_tilemap
	ld hl, DexTilemap_Johto
.got_tilemap
	call Pokedex_LoadTilemapWithIconAndForm

	pop de
	call Pokedex_GetMonLocations
	call Pokedex_SortAreaMons

	ld a, 11
	ld de, PHB_AreaSwitchTileMode
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
	; Switch area type displayed
	ld hl, hPokedexAreaMode
	bit DEXAREA_UNKNOWN_F, [hl]
	jr nz, .joypad_loop
	inc [hl]
	ld a, [hl]
	and DEXAREA_TYPE_MASK
	cp NUM_DEXAREAS
	jr nz, _Pokedex_Area
	; fallthrough
.loopback_area_mode
	xor [hl] ; Will retain the other nibble type and set targeted one to 0.
	ld [hl], a
	jr _Pokedex_Area

.pressed_b
	ld hl, Pokedex_Main
	jr .switch_dex_screen

.pressed_select
	; Switch displayed region
	ld hl, hPokedexAreaMode
	bit DEXAREA_UNKNOWN_F, [hl]
	jr nz, .joypad_loop
	ld hl, hPokedexAreaMode
	ld a, [hl]
	add $10
	ld [hl], a
	and DEXAREA_REGION_MASK
	cp NUM_REGIONS << 4
	jr z, .loopback_area_mode
	jr _Pokedex_Area

	; Check if we've visited Kanto.
	push hl
	ld hl, wStatusFlags
	bit 6, [hl] ; ENGINE_CREDITS_SKIP
	pop hl
	jr z, .loopback_area_mode

	; If we're switching to Orange Islands, check if we've visited it.
	cp ORANGE_REGION << 4
	jmp nz, _Pokedex_Area
	push hl
	ld hl, wStatusFlags2
	bit 3, [hl] ; ENGINE_SEEN_SHAMOUTI_ISLAND
	pop hl
	jmp nz, _Pokedex_Area
	jr .loopback_area_mode

.pressed_start
	xor a
	call Pokedex_ChangeForm
	jr c, .joypad_loop
	call Pokedex_GetCursorMon
	jmp Pokedex_Area_ResetLocationData

.pressed_right
	ld hl, _Pokedex_Description
	jr .switch_dex_screen

.pressed_left
	ld a, [wPokedexOAM_IsCaught]
	and a
	jr z, .pressed_right
	ld hl, Pokedex_Stats
.switch_dex_screen
	; Restore previous palettes.
	push hl
	ld a, CGB_POKEDEX_PREPARE_ONLY
	call Pokedex_GetCGBLayout
	call Pokedex_GetCursorMon
	pop hl
	jp hl

.pressed_up
	call Pokedex_PrevPageMon
	jmp nz, .joypad_loop
	jr .reload_position

.pressed_down
	call Pokedex_NextPageMon
	jmp nz, .joypad_loop
.reload_position
	call Pokedex_GetFirstIconTile
	call Pokedex_GetCursorMon
	jmp Pokedex_Area_ResetLocationData

Pokedex_GetAreaMode:
; Returns region displayed in d, location type in e.
; Returns nz if area is "unknown" (unavailable).
	ldh a, [hPokedexAreaMode]
	ld d, a
	and DEXAREA_TYPE_MASK
	ld e, a
	xor d
	push af
	and DEXAREA_REGION_MASK
	swap a
	ld d, a
	pop af
	bit DEXAREA_UNKNOWN_F, a
	ret

Pokedex_GetAreaOAM:
; Handles OAM data for the area screen.
; Caution: runs in the wDex* WRAMX bank.
	; Write Area Unknown
	lb de, 9, 6
	lb hl, VRAM_BANK_1, $34
	lb bc, 52, 91 ; x, y
	ldh a, [hPokedexAreaMode]
	bit DEXAREA_UNKNOWN_F, a
	push af
	call nz, Pokedex_WriteOAM
	pop af
	jr nz, .a_sel_done

	; Write nest highlight
	ld hl, wDexAreaHighlightOAM
	ld de, wVirtualOAMSprite06
	ld bc, 4
	rst CopyBytes

	; Write (A) button
	lb de, 2, 7
	lb hl, VRAM_BANK_1 | 1, $3d
	lb bc, 146, 30 ; x, y
	call Pokedex_WriteOAM

	; Write (SEL) button
	ldh a, [hPokedexAreaMode]
	and DEXAREA_REGION_MASK
	cp ORANGE_REGION << 4
	lb de, 1, 9
	lb hl, 0, $0b
	lb bc, 115, 143
	jr nz, .not_orange
	ld b, 107
.not_orange
	call Pokedex_WriteOAM
	ld d, 1
	ld l, $11
	call Pokedex_WriteOAM
	ld d, 1
	ld l, $10
	dec b
	dec b
	call Pokedex_WriteOAM

	; Write nest OAM tiles + attributes. Set y to 0 because we don't want to
	; render any by default.
	ld c, 0
	ld d, 15 ; 10+10 but the final 5 are reserved for type vwf name by default
	; e (OAM slot) is kept from previous writing
	lb hl, VRAM_BANK_1, $3f
	call Pokedex_WriteOAMSingleTile

.a_sel_done
	; We want to print a VWF string. To do this, we must first clear the tiles.
	xor a
	ld hl, wDexAreaTypeTiles
	ld bc, wDexAreaTypeTilesEnd - wDexAreaTypeTiles
	push hl
	rst ByteFill

	; Get a pointer to location type string for printing.
	call Pokedex_GetAreaMode
	ld a, e
	ld hl, Pokedex_AreaTypeLists
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	push hl

	; We want to right-justify it, so get the vwf length.
	call GetVWFLength
	cpl
	add $36
	ld c, a
	ld b, 0
	call PlaceVWFString
	pop hl
	ld de, vTiles0 tile $40
	lb bc, 0, 7
	call Pokedex_Get2bpp

	lb bc, 94, 29
	lb de, 7, 27
	lb hl, 0, $40
	call Pokedex_WriteOAM

	; Copy 5 of the OAM slots to backup for h-blank benefit
	ld hl, wVirtualOAMSprite27
	ld de, wDexAreaTypeOAMCopy
	ld bc, 20
	rst CopyBytes
	ret

Pokedex_GetMonLocations:
; Creates a table of nest coordinates for the given area mode.
; Parameters: d = region, e = type
; Returns carry if area is unknown.
	ld a, BANK(wDexAreaMons)
	call StackCallInWRAMBankA
.Function:
	; Clear existing area data.
	ld a, [wDexAreaMonOffset]
	and $80
	ld hl, wDexAreaMons
	jr nz, .got_mon_table
	inc h
.got_mon_table
	xor a
	ld bc, wDexAreaMonsEnd - wDexAreaMons
	push hl
	rst ByteFill
	ld hl, wDexAreaHighlightOAM
	ld c, 4
	rst ByteFill
	dec a
	ld [wDexAreaHighlight], a

	; just turn every landmark on for now
	pop hl
	ld a, KANTO_LANDMARK
.loop
	dec a
	ret z
	push af
	ld e, a
	farcall GetLandmarkCoords
	ld a, d ; y
	sub 5
	ld [hli], a
	ld a, e ; x
	sub 4
	ld [hli], a
	pop af
	jr .loop

Pokedex_SortAreaMons:
; Sorts area mons for the benefit of hblank processing
	ld a, BANK(wDexAreaMons)
	call StackCallInWRAMBankA
.Function:
	ld a, [wDexAreaMonOffset]
	and $80
	ld hl, wDexAreaMons
	jr nz, .got_mon_table
	inc h
.got_mon_table
	; First, check if we should assign a highlighted nest.
	ld a, [wDexAreaHighlight]
	inc a
	jr z, .no_highlight

	; We have a highlight nest. Remove from the wDexAreaMons table and
	; place it seperately. This is so we don't need to worry about handling
	; it when doing the regular nest list iteration.
	dec a
	push hl
	add a
	ld l, a
	ld d, h
	ld e, l
	ld hl, wDexAreaHighlightOAM
	ld a, [de]
	ld [hli], a
	ld a, -2
	ld [de], a
	inc de
	ld a, [de]
	ld [hli], a
	ld a, -2
	ld [de], a
	ld a, 0 ; nest tile ID
	ld [de], a
	inc de
	ld a, 1 ; nest tile attributes
	ld [de], a
	pop hl

.no_highlight
	; Sort the AreaMons array
	; Sorting indices will be off by 2 to ensure that null entries are
	; placed last (interpreted as -2). -1 is used as a terminator for the
	; sorting index callback, so setting the terminator to 1 will result in
	; the result we want.
	ld bc, wDexAreaMonsTerminator - wDexAreaMons
	add hl, bc
	ld [hl], 1
	push hl
	ld hl, Pokedex_GetAreaMonIndex
	ld de, Pokedex_DoAreaInsertSort
	call SortItems
	pop hl
	dec [hl]
	ret

Pokedex_GetAreaMonIndex:
	push hl
	push bc
	ld a, [wDexAreaMonOffset]
	and $80
	ld h, HIGH(wDexAreaMons)
	jr nz, .got_mon_table
	inc h
.got_mon_table
	sla b
	ld l, b
	ld a, [hl]
	pop bc
	pop hl
	sub 2
	ret

Pokedex_DoAreaInsertSort:
; Assumes b>a.
	push af
	ld a, [wDexAreaMonOffset]
	and $80
	ld h, HIGH(wDexAreaMons)
	jr nz, .got_mon_table
	inc h
.got_mon_table
	pop af

	; Get target item
	ld l, b
	sla l

	; Iterate b-a times (we use inc, not dec, to iterate, so doing a-b is ok)
	sub b
	ld d, h
	ld e, l
	ld b, [hl]
	inc hl
	ld c, [hl]
	push bc
	ld c, a

.loop
	dec de
	ld a, [de]
	ld [hld], a
	dec de
	ld a, [de]
	ld [hld], a
	inc c
	jr nz, .loop
	pop bc
	ld a, b
	ld [de], a
	inc de
	ld a, c
	ld [de], a
	ret

; area hblank functions

PHB_AreaSwitchTileMode:
	push hl
	push de
	push bc

	; There's nothing stopping us from changing rLCDC on a technical level, but
	; doing it too early might result in part of the scanline reading from the
	; wrong tileset section. Thus, we busyloop until mode0.
	ld c, 34
	call PHB_BusyLoop1

	; Switch where we're reading tile data from.
	ld hl, rLCDC
	set rLCDC_TILE_DATA, [hl]

	ld c, 8
	call PHB_BusyLoop

	call PHB_WriteNestOAM_FirstRun

	ld b, 22
	call PHB_WaitUntilLY_Mode0

	xor a
	ldh [rSCX], a
	add 9
	ldh [rSCY], a

	jmp PopBCDEHL

PHB_BusyLoop3:
; BusyLoop4 isn't needed, increment c by 1 instead.
	nop ; no-optimize nops
	; fallthrough
PHB_BusyLoop2:
	nop ; no-optimize nops
	; fallthrough
PHB_BusyLoop1:
	nop ; no-optimize nops
	; fallthrough
PHB_BusyLoop:
; Busyloops for (c-1)*4+1 cycles.
; Use functions above to avoid extra inline nops.
; Note that c=0 underflows.
	dec c
	jr nz, PHB_BusyLoop
	ret

PHB_AreaSwitchTileMode2:
	push hl
	push de
	push bc
	ld hl, rSTAT
.busyloop
	ld a, [hl]
	and $3
	jr nz, .busyloop

	ld a, 4
	ldh [rSCX], a
	ld a, -104 ; line 7 of tile 3 (0-indexed)
	ldh [rSCY], a
	ld b, $87
	call PHB_WaitUntilLY_Mode0

	ld hl, rLCDC
	res rLCDC_TILE_DATA, [hl]
	ld a, 8
	ldh [rSCY], a
	ld a, 11
	ld de, PHB_AreaSwitchTileMode
	call Pokedex_UnsafeSetHBlankFunction
	jmp PopBCDEHL

PHB_WriteNestOAM_FirstRun:
; Called from a seperate PHB function. Thus, the fact that this takes more
; cycles than PHB_WriteNestOAM is accounted for.
	push hl
	push de
	push bc
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexAreaMonOffset)
	ldh [rSVBK], a

	ld hl, wDexAreaMonOffset
	ld a, [hl]
	and $80
	ld [hl], a
	jr _PHB_WriteNestOAM

PHB_WriteNestOAM:
	push hl
	push de
	push bc
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDexAreaMonOffset)
	ldh [rSVBK], a
_PHB_WriteNestOAM:
	; Write the first 8 (4x2) OAM slots
	ld a, [wDexAreaMonOffset]

	; This leaves a as a*2, so check bit 2, not bit 1 for "every other time".
	call .GetAreaMonsIndex

	; Ensure that this codepath takes the same amount of cycles no matter
	; whether bit 2 is set or not.
	bit 2, a
	ld l, LOW(oamSprite12YCoord)
	ld a, LOW(oamSprite22YCoord)
	jr z, .got_oam_ptr ; z: 3 cycles, nz: 2 cycles
	ld l, a ; 1 cycle (total 2+1=3, same as z)
.got_oam_ptr
	ld a, 2
.outer_loop
	push af
	ld h, 4
	jr .stack_loop_nopush
.stack_loop
	push bc
.stack_loop_nopush
	ld a, [de]
	inc de
	ld b, a
	ld a, [de]
	inc de
	ld c, a
	dec h
	jr nz, .stack_loop
	ld h, HIGH(oamSprite12YCoord)
	ld de, 3
rept 3
	ld a, b
	ld [hli], a
	ld [hl], c
	add hl, de
	pop bc
endr
	ld a, b
	ld [hli], a
	ld [hl], c
	add hl, de

	ld c, 17
	call PHB_BusyLoop1

	ld a, [wDexAreaMonOffset]
	add 4
	call .GetAreaMonsIndex

	pop af
	dec a
	jr nz, .outer_loop

	ld c, 3
	call PHB_BusyLoop3

	ld a, [wDexAreaMonOffset]
	add 10
	ld [wDexAreaMonOffset], a

	; Handle the final 2 OAM slots.
	sub 2
	call .GetAreaMonsIndex

	; Push tiles
	ld a, [de]
	inc de
	ld b, a
	ld a, [de]
	inc de
	ld c, a
	push bc
	ld a, [de]
	inc de
	ld b, a
	ld a, [de]
	inc de
	ld c, a
	ld de, 3

	; Pop and write to OAM
	ld a, b
	ld [hli], a
	ld [hl], c
	add hl, de
	pop bc
	ld a, b
	ld [hli], a
	ld [hl], c

	; Figure out next h-blank. If next Y-coord is 0, we are at the end.
	; If so, set pending interrupt to bottom menu handling.
	; Otherwise, set next h-blank event to WriteNestOAM with LYC=a-4.
	ld a, [wDexAreaMonOffset]
	call .GetAreaMonsIndex
	ld a, [de]
	sub 20 ; 4 lines to process, -8 because effective OAM xy is 8 more
	ld de, PHB_WriteNestOAM

	; DON'T desync the timing for each possibility of the conditional!
	push af
	call nc, Pokedex_UnsafeSetHBlankFunction
	pop af
	ld a, $86
	ld de, PHB_AreaSwitchTileMode2
	call c, Pokedex_UnsafeSetHBlankFunction
	pop af
	ldh [rSVBK], a
	jmp PopBCDEHL

.GetAreaMonsIndex:
; de = wDexAreaMons + a*2. Leaves a as a*2.
	assert (LOW(wDexAreaMons) == 0), "wDexAreaMons isn't $xx00"
	assert (LOW(wDexAreaMons) == 0), "wDexAreaMons2 isn't $xx00"
	assert (wDexAreaMons2 == wDexAreaMons + $100)

	; Needs to be cycle-equal whether the conditional is nc or c.
	ld d, HIGH(wDexAreaMons)
	add a
	jr nc, .got_mon_table
	inc d
.got_mon_table
	ld e, a
	ret

DexAreaPals:
INCLUDE "gfx/pokedex/area.pal"
