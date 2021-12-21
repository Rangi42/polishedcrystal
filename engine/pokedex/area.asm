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

	; Set d to region and e to location
	ldh a, [hPokedexAreaMode]
	ld d, a
	and $f
	ld e, a
	xor d
	swap a
	and $7
	ld d, a
	push de

	; Figure out area mode text
	ld a, e
	ld bc, 4
	ld hl, Pokedex_AreaTypeLists
	rst AddNTimes
	push hl

	; Retrieve the area tilemap
	ld hl, DexTilemap_Area
	call Pokedex_LoadTilemapWithIconAndForm

	pop hl
	decoord 16, 2
	ld bc, 4
	rst CopyBytes

	pop de
	call Pokedex_GetMonLocations

	; when we have the town map data, fix this
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
	jmp c, _Pokedex_Description
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
	and $f
	cp NUM_DEXAREA
	jr nz, _Pokedex_Area
	; fallthrough
.loopback_area_mode
	xor [hl] ; Will retain the other nibble type and set targeted one to 0.
	ld [hl], a
	jr _Pokedex_Area

.pressed_select
	; Switch displayed region
	ld hl, hPokedexAreaMode
	bit DEXAREA_UNKNOWN_F, [hl]
	jr nz, .joypad_loop
	ld hl, hPokedexAreaMode
	ld a, [hl]
	add $10
	ld [hl], a
	and $70
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

.pressed_left
	ld a, [wPokedexOAM_IsCaught]
	and a
	jmp z, _Pokedex_Description
	jmp Pokedex_Stats

.pressed_up
	call Pokedex_PrevPageMon
	jr nz, .joypad_loop
	jr .reload_position

.pressed_down
	call Pokedex_NextPageMon
	jmp nz, .joypad_loop
.reload_position
	call Pokedex_GetFirstIconTile
	call Pokedex_GetCursorMon
	jmp _Pokedex_Area

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
