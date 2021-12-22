Pokedex_AreaTypeLists:
	rawchar "Morn"
	rawchar "Day "
	rawchar "Nite"
	rawchar "Surf"
	rawchar "Fish"
	rawchar "Tree"
	rawchar "Game" ; bug catching/safari zone

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
	cp NUM_DEXAREA
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
	jr z, .joypad_loop
	inc [hl]
	ld a, [hl]
	and DEXAREA_TYPE_MASK
	cp NUM_DEXAREA
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
; Caution: runs in WRAM3.
	; Get a pointer to location type string for printing.
	call Pokedex_GetAreaMode
	ld l, e
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, Pokedex_AreaTypeLists
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wVirtualOAMSprite36
	ld a, 4 ; loop iterator
	ld b, 132 ; x
	ld c, 30 ; y
.type_loop
	push af
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	add 8
	ld b, a
	ld a, [de]
	inc de
	ld [hli], a
	xor a
	ld [hli], a
	pop af
	dec a
	jr nz, .type_loop
	ret

Pokedex_GetMonLocations:
; Creates a table of nest coordinates for the given area mode.
; Parameters: d = region, e = type
; Returns carry if area is unknown.
	ld a, BANK(wDexAreaMons)
	call StackCallInWRAMBankA
.Function:
	; Clear existing area data.
	xor a
	ld hl, wDexAreaMons
	ld bc, wDexAreaMonsEnd - wDexAreaMons
	rst ByteFill
	dec a
	ld [wDexAreaHighlight], a
	scf
	ret

DexAreaPals:
INCLUDE "gfx/pokedex/area.pal"
