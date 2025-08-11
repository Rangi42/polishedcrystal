Pokedex_AreaTypeLists:
	list_start
	setcharmap no_ngrams
	li "Morning"
	li "Day"
	li "Night"
	li "Surfing"
	li "Old Rod"
	li "Good Rod"
	li "Super Rod"
	li "Headbutt"
if DEF(FAITHFUL)
	li "Rock Smash"
else
	li "Brick Break"
endc
	li "Bug Contest"
	li "Roaming"
	setcharmap default
	assert_list_length NUM_DEXAREAS

Pokedex_Area:
	ldh a, [rWBK]
	push af
	ld a, $1
	ldh [rWBK], a
	; default to current region and time of day
	call RegionCheck
	assert DEXAREA_REGION_MASK == %01110000
	swap e
	ld a, [wTimeOfDay]
	cp EVE
	jr nz, .not_evening
	ld a, DAY ; evening may have day or nite mons
.not_evening
	assert DEXAREA_MORNING == MORN
	assert DEXAREA_DAY == DAY
	assert DEXAREA_NIGHT == NITE
	; combine current region and time into area mode
	or e
	ld e, a
	ld a, BANK(wDexAreaLastMode)
	ldh [rWBK], a
	ld a, e
	ldh [hPokedexAreaMode], a
	ld [wDexAreaLastMode], a
	pop af
	ldh [rWBK], a
	; fallthrough
Pokedex_Area_ResetLocationData:
; For when scrolling to a new species or form.
	; Write palette data. Not redundant, because scrolling reloads
	; BG7, i.e. type icon palettes.
	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rWBK], a
	ld hl, DexAreaPals
	ld de, wBGPals1 palette 3
	ld bc, 5 palettes
	rst CopyBytes
	pop af
	ldh [rWBK], a

	call Pokedex_ReloadValidLocations
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
	jmp c, .pressed_start
	rrca
	jmp c, .pressed_right
	rrca
	jmp c, .pressed_left
	rrca
	jmp c, .pressed_up
	rrca
	jmp c, .pressed_down
	jr .joypad_loop

.pressed_a
	; Switch area type displayed
	call Pokedex_GetAreaMode
	call Pokedex_GetRegionAreaFlag
	call Pokedex_CountLocations
	jr z, .joypad_loop

	; Block 1 valid location too, to avoid updating wDexAreaLastMode.
	dec a
	jr z, .joypad_loop

	ld b, 1 ; update lastmode if applicable
	ld hl, hPokedexAreaMode
	inc [hl]
	ld a, [hl]
	and DEXAREA_TYPE_MASK
	cp NUM_DEXAREAS
	jr nz, .cycle_area
	; fallthrough
.loopback_area_mode
	xor [hl] ; Will retain the other nibble type and set targeted one to 0.
	ld [hl], a
.cycle_area
	push bc
	call Pokedex_CycleToKnownArea
	pop bc
	ld hl, hPokedexAreaMode
	jr c, .unknown
	dec b
	jr nz, _Pokedex_Area
	ldh a, [rWBK]
	push af
	ld a, BANK(wDexAreaLastMode)
	ldh [rWBK], a
	ld a, [hl]
	ld [wDexAreaLastMode], a
	pop af
	ldh [rWBK], a
	jmp _Pokedex_Area

.unknown
	set DEXAREA_UNKNOWN_F, [hl]
	jmp _Pokedex_Area

.pressed_b
	ld hl, Pokedex_Main
	jr .switch_dex_screen

.pressed_select
	; Check if there's at least one region with a valid nest.
	ld b, -1 ; all regions
	call Pokedex_CountLocations
	jr z, .joypad_loop
	ld b, 0 ; don't update lastmode

	; Switch displayed region
	ld hl, hPokedexAreaMode
	ld a, [hl]
	add $10
	ld [hl], a
	and DEXAREA_REGION_MASK
	cp NUM_REGIONS << 4
	jr z, .loopback_area_mode

	; Check if we've visited Kanto.
	push hl
	ld hl, wStatusFlags
	bit STATUSFLAGS_HALL_OF_FAME_F, [hl]
	pop hl
	jr z, .loopback_area_mode

	; If we're switching to Orange Islands, check if we've visited it.
	cp ORANGE_REGION << 4
	jr nz, .cycle_area
	push hl
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_SEEN_SHAMOUTI_F, [hl]
	pop hl
	jr nz, .cycle_area
	jr .loopback_area_mode

.pressed_start
	ld a, 1
	call Pokedex_ChangeForm
	jmp c, .joypad_loop
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
	call GetCGBLayout
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

Pokedex_ReloadValidLocations:
	ld a, BANK(wDexAreaRegionLocations)
	call StackCallInWRAMBankA
.Function:
	ld hl, wDexAreaRegionLocations
	xor a
	ld bc, NUM_DEXAREAS
	rst ByteFill

	; Clear "Area Unknown" marker.
	ld hl, hPokedexAreaMode
	res DEXAREA_UNKNOWN_F, [hl]
	push hl

	; Iterate all location types to check if we should print "Area Unknown".
	ld d, 0 ; region
	ld b, 1 ; bitflag for first region
.outer_loop
	ld e, 0 ; type
	ld hl, wDexAreaRegionLocations
.inner_loop
	push hl
	push de
	push bc
	call Pokedex_GetMonLocations
	pop bc
	pop de
	pop hl
	jr c, .next
	ld a, [hl]
	or b
	ld [hl], a
.next
	inc hl
	inc e
	ld a, e
	cp NUM_DEXAREAS
	jr nz, .inner_loop
	sla b
	inc d
	ld a, d
	cp NUM_REGIONS
	jr z, .finish

	; Check if we have unlocked the region
	cp ORANGE_REGION
	jr nz, .check_kanto
	push hl
	ld hl, wStatusFlags2
	ld a, BANK(wStatusFlags2)
	call GetFarWRAMByte
	pop hl
	bit STATUSFLAGS2_SEEN_SHAMOUTI_F, a
	jr z, .finish
	; Redundant to run the check below again, but means less space used.
.check_kanto
	push hl
	ld hl, wStatusFlags
	ld a, BANK(wStatusFlags)
	call GetFarWRAMByte
	pop hl
	bit STATUSFLAGS_HALL_OF_FAME_F, a
	jr nz, .outer_loop

.finish
	; Cycle to a known area, preferring last used mode.
	pop hl
	push hl
	ld a, [hl]
	and DEXAREA_REGION_MASK
	ld [hl], a
	ld a, [wDexAreaLastMode]
	and DEXAREA_TYPE_MASK
	or [hl]
	ld [hl], a
	call Pokedex_CycleToKnownArea
	pop hl
	ret nc
	set DEXAREA_UNKNOWN_F, [hl]
	ret

Pokedex_GetRegionAreaFlag:
; Set b to the bitflag for region in d.
	ld a, $80
	inc d
.area_bitflag
	rlca
	dec d
	jr nz, .area_bitflag
	ld b, a
	ret

Pokedex_CountLocations:
; Count valid locations for region bitflags in b.
; Returns amount in e. Returns z if no valid locations were found.
	ld a, BANK(wDexAreaRegionLocations)
	call StackCallInWRAMBankA
.Function:
	lb de, NUM_DEXAREAS, 0
	ld hl, wDexAreaRegionLocations
.loop
	ld a, [hli]
	and b
	jr z, .invalid_location
	inc e
.invalid_location
	dec d
	jr nz, .loop

	; If e is 0, a is also 0 from previous [hl]. So this returns z correctly.
	or e
	ret

Pokedex_CycleToKnownArea:
; Cycles hPokedexAreaMode to a location type with at least one nest.
; Returns carry if the current region doesn't have one.
	ld a, BANK(wDexAreaRegionLocations)
	call StackCallInWRAMBankA
.Function:
	call Pokedex_GetAreaMode
	call Pokedex_GetRegionAreaFlag

	; Set hl to wDexAreaRegionLocations+e (e=current type)
	ld a, e
	add LOW(wDexAreaRegionLocations)
	ld l, a
	adc HIGH(wDexAreaRegionLocations)
	sub l
	ld h, a

	; We want to know our former location in case we fail to find a location.
	ld d, e

.loop
	ld a, [hli]
	and b
	jr nz, .found_location

	; Try the next location
	inc e
	ld a, e
	cp NUM_DEXAREAS
	jr nz, .got_new_area

	; Loopback to the first area.
	ld hl, wDexAreaRegionLocations
	xor a
	ld e, a
.got_new_area
	; Check if we ended up where we started.
	cp d
	jr nz, .loop

	; Failed to find a location, set carry.
	scf
	ret
.found_location
	ldh a, [hPokedexAreaMode]

	; Resets carry, so we don't need to "xor a" later.
	and DEXAREA_REGION_MASK
	or e
	ldh [hPokedexAreaMode], a
	ret

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
	lb de, 9, 10
	lb hl, OAM_BANK1 | 0, $34
	lb bc, 52, 91 ; x, y
	ldh a, [hPokedexAreaMode]
	bit DEXAREA_UNKNOWN_F, a
	push af
	call nz, Pokedex_WriteOAM
	pop af
	jr nz, .a_highlight_done

	; Write nest highlight
	ld hl, wDexAreaHighlightY
	ld a, [hli]
	ld b, [hl]
	ld c, a
	lb de, 1, 6
	lb hl, OAM_BANK1 | 2, $3f
	call Pokedex_WriteOAM

	; Write nest OAM tiles + attributes. Set y to 0 because we don't want to
	; render any by default.
	ld c, 0
	lb de, 15, 10 ; the other 15 slots is dealt with as part of hblank
	; e (OAM slot) is kept from previous writing
	lb hl, OAM_BANK1 | 3, $3f
	call Pokedex_WriteOAMSingleTile
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
	ld de, vTiles0 tile $20
	lb bc, 0, 7
	call Pokedex_Get2bpp

	lb bc, 94, 29
	lb de, 7, 27
	lb hl, 0, $20
	call Pokedex_WriteOAM

	; Write (A) button
	call Pokedex_GetAreaMode
	call Pokedex_GetRegionAreaFlag
	call Pokedex_CountLocations
	dec a
	jr z, .a_highlight_done
	lb de, 2, 25
	lb hl, OAM_BANK1 | 1, $3d
	lb bc, 146, 30 ; x, y
	call Pokedex_WriteOAM

.a_highlight_done
	; Write (SEL) button
	ld b, -1
	call Pokedex_CountLocations
	ret z

	ldh a, [hPokedexAreaMode]
	and DEXAREA_REGION_MASK
	cp ORANGE_REGION << 4
	lb de, 1, 7
	lb hl, 3, $0b
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
	jmp Pokedex_WriteOAM

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
	rst ByteFill
	ld hl, wDexAreaHighlightY
	ld [hli], a
	ld [hl], a
	dec a
	ld [wDexAreaHighlight], a

	push de
	call Pokedex_MonHasCosmeticForms
	pop de
	push af
	call Pokedex_GetCursorSpecies
	pop af

	; Don't let this interfere with gender when checking locations
	res MON_CAUGHT_F, b
	jr c, .not_cosmetic
	set MON_COSMETIC_F, b ; shares bit with caught, but this is safe
.not_cosmetic
	ld a, e
	cp DEXAREA_WILDS
	jr c, .wild
	sub DEXAREA_FISH ; also sub DEXAREA_HEADBUTT
	jr c, .fish

	jr z, .headbutt
	dec a ; cp DEXAREA_ROCK_SMASH
	jr z, .rock_smash
	dec a
	jr z, .contest

	; Roamers.
	ld hl, wRoamMon1Species
	ld a, d ; region
	ld e, 3 ; iterator
	scf ; Mark as unknown unless otherwise specified later.
.loop
	push de
	push af
	ld a, BANK(wRoamMon1)
	ldh [rWBK], a
	ld a, [hl]
	ld de, wRoamMon1Form - wRoamMon1Species
	add hl, de
	cp c
	jr nz, .next
	ld a, [hl]
	call DexCompareWildForm
	jr nz, .next
	push hl
	ld de, wRoamMon1MapGroup - wRoamMon1Form
	add hl, de
	ld a, [hli]
	ld e, [hl]
	ld d, a
	pop hl
	inc a
	jr z, .next
	ld a, BANK(wDexAreaMons)
	ldh [rWBK], a
	pop af
	call Pokedex_SetWildLandmark_MaintainNoCarry
	push af

.next
	ld de, wRoamMon2Species - wRoamMon1Form
.next_add
	add hl, de
	pop af
	pop de
	dec e
	jr nz, .loop
	ret

.contest
	farjp GetContestLocations
.wild
	farjp GetWildLocations
.fish
	farjp GetFishLocations
.headbutt
	farjp GetHeadbuttLocations
.rock_smash
	farjp GetRockSmashLocations

Pokedex_SetWildLandmark:
; Add landmark for map group d, map number e.
; Parameters: a = allowed region, or -1 if any region is allowed.
; Returns carry if insertion failed (a != -1).
	push hl
	push de
	push bc
	push de
	push af
	ld b, d
	ld c, e
	call GetWorldMapLocation
	ld e, a
	ld a, [wDexAreaMonOffset]
	and $80
	ld h, HIGH(wDexAreaMons)
	jr nz, .got_mon_table
	inc h
.got_mon_table
	call .GetAreaMonID
	add a
	ld l, a

	; Compare region in b against region in a.
	pop af
	cp b
	pop bc ; previously pushed map group+map number in de
	jr z, .region_ok

	; Preserves a and jumps to end, returning carry if applicable.
	cp -1 ; aka 255
	jr c, .end

.region_ok
	push af
	push hl

	; Check player map group+number
	ld a, BANK(wMapGroup)
	ld hl, wMapGroup
	call GetFarWRAMByte
	cp b
	jr nz, .highlight_done
	ld a, BANK(wMapNumber)
	ld hl, wMapNumber
	call GetFarWRAMByte
	cp c
	jr nz, .highlight_done
	call .GetAreaMonID
	ld [wDexAreaHighlight], a
.highlight_done
	farcall GetLandmarkCoords
	pop hl
	ld a, d ; y
	sub 5
	ld [hli], a
	ld a, e
	sub 4
	ld [hl], a
	pop af
.end
	jmp PopBCDEHL

.GetAreaMonID:
	; To avoid wasteful use of WRAM, we essentially unionize area coordinates
	; on a per-region basis. Handle that here.
	ld a, e

	; Wrap back to 0 across regions.
	lb bc, JOHTO_REGION, KANTO_LANDMARK
	sub c
	jr c, .got_landmark
	inc b ; KANTO_REGION
	ld c, SHAMOUTI_LANDMARK - KANTO_LANDMARK
	sub c
	jr c, .got_landmark
	ld c, 0
	inc b ; ORANGE_REGION
.got_landmark
	add c
	ret

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
	ld de, wDexAreaHighlight
	ld a, [de]
	inc de
	inc a
	jr z, .no_highlight

	; We have a highlight nest. Remove from the wDexAreaMons table and
	; place it seperately. This is so we don't need to worry about handling
	; it when doing the regular nest list iteration.
	dec a
	push hl
	add a
	ld l, a
	ld a, [hl]
	ld [de], a
	inc de
	xor a
	ld [hli], a
	ld a, [hl]
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
	ld b, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
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
	set B_LCDC_BLOCKS, [hl]

	ld c, 172
	call PHB_BusyLoop1

	ldh a, [rWBK]
	push af
	ld a, BANK(wDexAreaModeCopy)
	ldh [rWBK], a
	ld a, [wDexAreaModeCopy]
	bit DEXAREA_UNKNOWN_F, a
	jr z, .not_unknown

	; Don't mess with the "Area Unknown" icon if applicable.
	ld a, $86
	ld de, PHB_AreaSwitchTileMode2
	call Pokedex_UnsafeSetHBlankFunction

	ld c, 173
	call PHB_BusyLoop2
	jr .done_writing_nests

.not_unknown
	call PHB_WriteNestOAM_FirstRun

.done_writing_nests
	pop af
	ldh [rWBK], a

	ld c, 77
	call PHB_BusyLoop2

	ld hl, oamSprite39Attributes
	ld c, 3
	ld de, -3
	ld a, OAM_BANK1 | 3
	ld b, $3f
.loop
rept 5
	ld [hld], a
	ld [hl], b
	add hl, de
endr
	push bc
	ld c, 44
	call PHB_BusyLoop
	pop bc
	dec c
	jr nz, .loop

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
; Busyloops for (c-1)*4+15 cycles ("ld c, N; call PHB_BusyLoop; (...); ret").
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
	and STAT_MODE ; wait until mode 0
	jr nz, .busyloop

	ld a, 4
	ldh [rSCX], a
	ld a, -104 ; line 7 of tile 3 (0-indexed)
	ldh [rSCY], a
	ld b, $87
	call PHB_WaitUntilLY_Mode0

	ld hl, rLCDC
	res B_LCDC_BLOCKS, [hl]
	ld a, 8
	ldh [rSCY], a
	ld a, 11
	ld de, PHB_AreaSwitchTileMode
	call Pokedex_UnsafeSetHBlankFunction

	ldh a, [rWBK]
	push af
	ld a, BANK(wDexAreaShadowOAM)
	ldh [rWBK], a
	lb bc, 41, LOW(rDMA)
	ld a, HIGH(wDexAreaShadowOAM)
	call hPushOAM
	pop af
	ldh [rWBK], a
	jmp PopBCDEHL

PHB_WriteNestOAM_FirstRun:
; Called from a seperate PHB function. Thus, the fact that this takes more
; cycles than PHB_WriteNestOAM is accounted for.
	push hl
	push de
	push bc
	ldh a, [rWBK]
	push af
	ld a, BANK(wDexAreaMonOffset)
	ldh [rWBK], a

	ld hl, wDexAreaMonOffset
	ld a, [hl]
	and $80
	ld [hl], a
	ld a, LOW(oamSprite10YCoord)
	ld [wDexAreaSpriteSlot], a
	jr _PHB_WriteNestOAM

PHB_WriteNestOAM:
	push hl
	push de
	push bc
	ldh a, [rWBK]
	push af
	ld a, BANK(wDexAreaMonOffset)
	ldh [rWBK], a
_PHB_WriteNestOAM:
	ld hl, wDexAreaMonOffset
	ld a, [hli]
	ld l, [hl] ; wDexAreaSpriteSlot

	; We need to waste 6 cycles, PHB_BusyLoop takes too long.
	inc [hl]
	dec [hl]

	; Write the first 8 (4x2) OAM slots
	call .GetAreaMonsIndex
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

	; conditional needs to take the same time whether nz or z.
	ld b, LOW(oamSprite10YCoord)
	ld hl, wDexAreaSpriteSlot
	ld a, [hl]
	add 40
	cp LOW(oamSprite39YCoord) + 4
	jr nz, .got_new_oam_ptr
	ld a, b
.got_new_oam_ptr
	ld [hld], a

	; Figure out next h-blank. If next Y-coord is 0, we are at the end.
	; If so, set pending interrupt to bottom menu handling.
	; Otherwise, set next h-blank event to WriteNestOAM with LYC=a-4.
	ld a, [hl] ; wDexAreaMonOffset
	call .GetAreaMonsIndex
	ld a, [de]
	sub 20 ; 4 lines to process, -16 because effective OAM y is 16 more
	ld de, PHB_WriteNestOAM

	; conditional needs to take the same time.
	push af
	call nc, Pokedex_UnsafeSetHBlankFunction
	pop af
	ld a, $86
	ld de, PHB_AreaSwitchTileMode2
	call c, Pokedex_UnsafeSetHBlankFunction
	pop af
	ldh [rWBK], a
	jmp PopBCDEHL

.GetAreaMonsIndex:
; de = wDexAreaMons + a*2. Leaves a as a*2.
	assert LOW(wDexAreaMons) == 0, "wDexAreaMons isn't $xx00"
	assert LOW(wDexAreaMons) == 0, "wDexAreaMons2 isn't $xx00"
	assert wDexAreaMons2 == wDexAreaMons + $100

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
