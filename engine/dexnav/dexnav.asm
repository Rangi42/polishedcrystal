; DexNav: search the current area for a chosen wild species.
; Behavior is modeled on CFRU's src/dexnav.c. See PC-DexNav-Decisions.md.

DexNav_ChooseWildEncounter:
; Set up a wild battle against [wDexNavTargetSpecies]/[wDexNavTargetForm]
; using this area's land or water table for the current time of day.
; Returns z and sets wTempWildMonSpecies, wWildMonForm, wCurPartyLevel
; and wBattleType on success; nz if the target isn't found here.
	farcall SetBadgeBaseLevel
	ld a, [wTimeOfDay]
	cp EVE
	jr nz, .try
	; Evening normally uses day or night encounters at random,
	; so a target from either table can be found.
	ld a, DAY
	call .try
	ret z
	ld a, NITE
.try
	call DexNav_GetSlotTable
	jr nc, .fail

	; Make sure the target is in this table, or the roll below never ends.
	push hl
.find_loop
	call DexNav_CheckSlotIsTarget
	jr z, .found
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .find_loop
	pop hl
.fail
	or 1
	ret

.found
	pop hl
.roll
	; Roll slots with the normal encounter odds until one is the target,
	; so the level comes from the same distribution as a normal encounter.
	push hl
	push de
	ld a, 100
	call RandomRange
	inc a
	ld c, a
	ld b, -1
	ld h, d
	ld l, e
.prob_bracket_loop
	inc b
	ld a, BANK(GrassMonProbTable)
	call GetFarByte
	inc hl
	cp c
	jr c, .prob_bracket_loop
	pop de
	pop hl
	push hl
	ld a, b
	add b
	add b
	ld c, a
	ld b, 0
	add hl, bc
	call DexNav_CheckSlotIsTarget
	jr z, .got_slot
	pop hl
	jr .roll

.got_slot
	pop bc ; discard table pointer

	; Same Unown check as _ChooseWildEncounter
	ld a, [wDexNavTargetSpecies]
	cp UNOWN
	jr nz, .unown_check_done
	ld a, [wDexNavTargetForm]
	bit MON_EXTSPECIES_F, a
	jr nz, .unown_check_done
	ld a, [wUnlockedUnowns]
	and a
	jr z, .fail
.unown_check_done

	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld b, a

	; Same surfing level boost as _ChooseWildEncounter
	push bc
	farcall CheckOnWater
	pop bc
	jr nz, .level_ok
	call Random
	cp 35 percent
	jr c, .level_ok
	inc b
	cp 65 percent
	jr c, .level_ok
	inc b
	cp 85 percent
	jr c, .level_ok
	inc b
	cp 95 percent
	jr c, .level_ok
	inc b
.level_ok
	ld a, b
	farcall AdjustLevelForBadges
	ld [wCurPartyLevel], a

	ld a, [wDexNavTargetSpecies]
	ld [wTempWildMonSpecies], a
	ld a, [wDexNavTargetForm]
	ld [wWildMonForm], a
	ld a, BATTLETYPE_DEXNAV
	ld [wBattleType], a
	xor a
	ret

DexNav_GetSlotTable:
; Find this area's wild slots for time of day a (ignored on water).
; Returns carry and hl = first slot (in BANK(JohtoGrassWildMons)),
; de = cumulative odds (in BANK(GrassMonProbTable)), b = slot count.
; Returns nc if this area has no wild data.
	push af
	farcall LoadWildMonDataPointer
	jr nc, .none
	inc hl ; skip map group
	inc hl ; skip map number
	inc hl ; skip encounter chance
	farcall CheckOnWater
	jr nz, .grass
	pop af
	ld de, WaterMonProbTable
	ld b, NUM_WATERMON
	scf
	ret

.grass
	pop af
	ld bc, NUM_GRASSMON * 3
	rst AddNTimes
	ld de, GrassMonProbTable
	ld b, NUM_GRASSMON
	scf
	ret

.none
	pop af
	and a
	ret

DexNav_CheckSlotIsTarget:
; Returns z if the wild slot at hl is the DexNav target. Clobbers a and c.
	push hl
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld c, a
	ld a, [wDexNavTargetSpecies]
	cp c
	jr nz, .done
	inc hl
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld c, a
	ld a, [wDexNavTargetForm]
	cp c
.done
	pop hl
	ret

DexNav_UseItem:
; Key item effect (Bag or Select). The Bag closes first, then this script runs.
	ld a, BANK(DexNavUseScript)
	ld hl, DexNavUseScript
	call FarQueueScript
	ld a, TRUE
	ld [wItemEffectSucceeded], a
	ret

DexNavUseScript:
	special UpdateTimePals
	opentext
	callasm DexNav_ChooseTarget
	endtext

DexNavBattleScript:
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

DexNav_ChooseTarget:
; Let the player pick a species from this area's list, then start the hunt.
	call DexNav_BuildList
	ld hl, .NoWildDataText
	jmp nc, .print

	; Start the cursor on the last target if it's in the list.
	ld hl, wDexNavList
	ld a, [hli]
	ld c, a
	ld b, 1
.find_target_loop
	ld a, [wDexNavTargetSpecies]
	cp [hl]
	inc hl
	ld a, [wDexNavTargetForm]
	jr nz, .next_target
	cp [hl]
	jr z, .got_cursor
.next_target
	inc hl
	inc b
	dec c
	jr nz, .find_target_loop
	ld b, 1
.got_cursor
	ld a, b
	cp DEXNAV_MENU_ROWS + 1
	jr c, .cursor_ok
	ld a, 1
.cursor_ok
	ld [wDexNavListCursor], a

	ldh a, [hBGMapMode]
	push af
	ld a, [wMenuScrollPosition]
	push af
	call LoadStandardMenuHeader
	ld hl, .WhichMonText
	call PrintText
.menu_loop
	ld hl, .MenuHeader
	call CopyMenuHeader
	ld a, [wDexNavListCursor]
	ld [wMenuCursorBuffer], a
	xor a
	ld [wMenuScrollPosition], a
	call InitScrollingMenu
	call DexNav_HideSpritesUnderMenu
	call ScrollingMenu
	ld a, [wMenuCursorY]
	ld [wDexNavListCursor], a
	ld a, [wMenuJoypad]
	cp PAD_B
	jr z, .cancel
	ld a, [wMenuSelection]
	cp CANCEL
	jr z, .cancel

	; Only seen species can be searched for (D14).
	ld c, a
	ld a, [wMenuSelectionQuantity]
	ld b, a
	push bc
	call CheckSeenMon
	pop bc
	jr nz, .seen
	ld de, SFX_WRONG
	call PlaySFX
	call WaitSFX
	jr .menu_loop

.seen
	ld a, c
	ld [wDexNavTargetSpecies], a
	ld a, b
	ld [wDexNavTargetForm], a
	call ExitMenu
	pop af
	ld [wMenuScrollPosition], a
	pop af
	ldh [hBGMapMode], a

	call DexNav_ChooseWildEncounter
	jr nz, .not_here
	; The battle is set up again when the player reaches the target,
	; so don't let other battles inherit BATTLETYPE_DEXNAV meanwhile.
	xor a ; BATTLETYPE_NORMAL
	ld [wBattleType], a
	call DexNav_SuccessRoll
	jr nc, .not_found
	call DexNav_StartHunt
	ret c
.not_found
	ld hl, .NotFoundText
	jr .print

.not_here
	ld a, [wDexNavTargetSpecies]
	ld [wNamedObjectIndex], a
	ld a, [wDexNavTargetForm]
	ld [wNamedObjectIndex + 1], a
	call GetPokemonName
	ld hl, .NotHereText
.print
	jmp PrintText

.cancel
	call ExitMenu
	pop af
	ld [wMenuScrollPosition], a
	pop af
	ldh [hBGMapMode], a
	ret

.NotFoundText:
	text "It doesn't seem"
	line "to be nearby…"

	para "Try looking in"
	line "another spot."
	prompt

.MenuHeader:
	db MENU_BACKUP_TILES
	; The border is drawn one tile outside these coords (see InitScrollingMenu).
	menu_coords DEXNAV_MENU_LEFT, 1, SCREEN_WIDTH - 2, 1 + DEXNAV_MENU_ROWS * 2
	dw .MenuData
	db 1 ; default option

.MenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS ; flags
	db DEXNAV_MENU_ROWS, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; species + form
	dba wDexNavList
	dba .PlaceSpeciesName
	dba DoNothing
	dba DoNothing

.PlaceSpeciesName:
; Unseen species show as "?????".
	push de
	ld a, [wMenuSelection]
	ld c, a
	ld a, [wMenuSelectionQuantity]
	ld b, a
	push bc
	call CheckSeenMon
	pop bc
	ld de, .UnseenString
	jr z, .got_name
	ld a, c
	ld [wNamedObjectIndex], a
	ld a, b
	ld [wNamedObjectIndex + 1], a
	call GetPokemonName
.got_name
	pop hl
	rst PlaceString
	ret

.UnseenString:
	db "?????@"

.WhichMonText:
	text "Search for which"
	line "#mon?"
	done

.NotHereText:
	text_ram wStringBuffer1
	text " isn't"
	line "around here."
	prompt

.NoWildDataText:
	text "No wild #mon"
	line "live here."
	prompt

DexNav_SuccessRoll:
; Returns carry if the search finds the target (D18). Caught species always
; do; others succeed with twice their encounter odds in this area.
	ld a, [wDexNavTargetSpecies]
	ld c, a
	ld a, [wDexNavTargetForm]
	ld b, a
	call CheckCaughtMon
	scf
	ret nz
	ld a, [wTimeOfDay]
	cp EVE
	jr nz, .got_time
	ld a, DAY
	call .GetOdds
	and a
	jr nz, .roll
	ld a, NITE
.got_time
	call .GetOdds
.roll
	add a
	cp 100
	ccf
	ret c
	ld c, a
	ld a, 100
	call RandomRange
	cp c
	ret

.GetOdds:
; Return the total encounter odds (out of 100) for the target in this area
; at time of day a.
	call DexNav_GetSlotTable
	ld a, 0
	ret nc
	xor a
	ld [wDexNavOddsPrev], a
	ld [wDexNavOddsSum], a
.odds_loop
	push bc
	push hl
	ld h, d
	ld l, e
	ld a, BANK(GrassMonProbTable)
	call GetFarByte
	pop hl
	inc de
	; The table is cumulative, so this slot's odds are the difference.
	ld b, a
	ld a, [wDexNavOddsPrev]
	ld c, a
	ld a, b
	ld [wDexNavOddsPrev], a
	sub c
	ld b, a
	call DexNav_CheckSlotIsTarget
	jr nz, .next_slot
	ld a, [wDexNavOddsSum]
	add b
	ld [wDexNavOddsSum], a
.next_slot
	inc hl
	inc hl
	inc hl
	pop bc
	dec b
	jr nz, .odds_loop
	ld a, [wDexNavOddsSum]
	ret

DexNav_StartHunt:
; Pick a tile 3-6 steps away that suits this area and start a rustle there.
; Returns carry on success.
	call DexNav_EndHunt
	call DexNav_GetEnvironment
	ld a, DEXNAV_TILE_TRIES
.try_loop
	push af
	push hl
	call DexNav_TryRandomTile
	pop hl
	jr c, .found
	pop af
	dec a
	jr nz, .try_loop
	and a
	ret

.found
	pop af
	; d, e = target coords; hl = environment data
	push hl
	call FindFirstEmptyObjectStruct
	jr nc, .no_slot
	ld [wDexNavHuntObject], a
	; Effect objects track the object in their range field; point it at
	; itself so the rustle stays on the target tile.
	ld [wTempObjectCopyRange], a
	ld a, TEMP_OBJECT
	ld [wTempObjectCopyMapObjectIndex], a
	ld a, -1
	ld [wTempObjectCopySprite], a
	ld [wTempObjectCopyRadius], a
	ld a, $80
	ld [wTempObjectCopySpriteVTile], a
	ld a, d
	ld [wTempObjectCopyX], a
	ld [wDexNavHuntX], a
	ld a, e
	ld [wTempObjectCopyY], a
	ld [wDexNavHuntY], a
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld [wTempObjectCopyMovement], a
	ld a, [hli]
	ld [wTempObjectCopyPalette], a
	ld a, [hl]
	push af
	push de
	farcall CopyTempObjectToObjectStruct
	pop de
	pop af
	; Skip the effect's movement function, which would make it follow its
	; parent and expire. Tracking itself with no duration keeps it forever.
	ld hl, OBJECT_ACTION
	add hl, de
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, de
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld [hl], 0
	ld hl, OBJECT_1D
	add hl, de
	ld [hl], e
	inc hl
	ld [hl], d
	scf
	ret

.no_slot
	pop hl
	xor a
	ld [wDexNavHuntObject], a
	ret

DexNav_TryRandomTile:
; Try one random tile near the player for environment data hl.
; Returns carry and its coords in d, e if it's usable.
	ld a, DEXNAV_MAX_OFFSET * 2 + 1
	call RandomRange
	sub DEXNAV_MAX_OFFSET
	ld d, a
	ld a, DEXNAV_MAX_OFFSET * 2 + 1
	call RandomRange
	sub DEXNAV_MAX_OFFSET
	ld e, a

	; 3-6 steps away (taxicab)
	ld a, d
	bit 7, a
	jr z, .dx_ok
	cpl
	inc a
.dx_ok
	ld c, a
	ld a, e
	bit 7, a
	jr z, .dy_ok
	cpl
	inc a
.dy_ok
	add c
	cp DEXNAV_MIN_DISTANCE
	jr c, .fail
	cp DEXNAV_MAX_DISTANCE + 1
	jr nc, .fail

	ld a, [wPlayerMapX]
	add d
	ld d, a
	ld a, [wPlayerMapY]
	add e
	ld e, a

	; Stay inside the map (object coords start at 4)
	ld a, d
	sub 4
	jr c, .fail
	ld c, a
	ld a, [wMapWidth]
	add a
	cp c
	jr c, .fail
	jr z, .fail
	ld a, e
	sub 4
	jr c, .fail
	ld c, a
	ld a, [wMapHeight]
	add a
	cp c
	jr c, .fail
	jr z, .fail

	; The tile must be the kind wild Pokemon live on here
	push de
	push hl
	call GetCoordTileCollision
	pop hl
	pop de
	ld c, a
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	cp c
	jr z, .collision_ok
	ld a, [hl]
	cp c
	jr nz, .fail
.collision_ok

	; Nobody can be standing there
	push de
	ldh a, [hMapObjectIndexBuffer]
	push af
	ld a, -1
	ldh [hMapObjectIndexBuffer], a
	farcall IsNPCAtCoord
	sbc a
	ld c, a
	pop af
	ldh [hMapObjectIndexBuffer], a
	pop de
	ld a, c
	and a
	jr nz, .fail
	scf
	ret

.fail
	and a
	ret

DexNav_GetEnvironment:
; Return hl = which tiles a hunt can use here, and how the rustle looks:
; movement, palette, action, collision 1, collision 2.
	farcall CheckOnWater
	ld hl, .Water
	ret z
	ld hl, .Cave
	ld a, [wEnvironment]
	cp CAVE
	ret z
	cp DUNGEON
	ret z
	ld hl, .Grass
	ret

.Grass:
	db SPRITEMOVEDATA_GRASS, PAL_OW_COPY_BG_GREEN, OBJECT_ACTION_GRASS_SHAKE
	db COLL_TALL_GRASS, COLL_LONG_GRASS
.Water:
	db SPRITEMOVEDATA_PUDDLE, PAL_OW_BLUE, OBJECT_ACTION_PUDDLE_SPLASH
	db COLL_WATER, COLL_WATER
.Cave:
	db SPRITEMOVEDATA_BOULDERDUST, PAL_OW_EMOTE_GRAY, OBJECT_ACTION_BOULDER_DUST
	db COLL_FLOOR, COLL_FLOOR

DexNav_CheckHuntObject:
; Returns z and bc = the rustle's object struct if the hunt is still going.
	ld a, [wDexNavHuntObject]
	and a
	jr z, .no
	call GetObjectStruct
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	cp STEP_TYPE_TRACKING_OBJECT
	ret nz
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [wDexNavHuntX]
	cp [hl]
	ret nz
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [wDexNavHuntY]
	cp [hl]
	ret
.no
	inc a ; nz
	ret

DexNav_EndHunt:
	call DexNav_CheckHuntObject
	jr nz, .done
	farcall DeleteMapObject
.done
	xor a
	ld [wDexNavHuntObject], a
	ret

DexNav_StepCheck:
; Called after each step. Returns carry if a DexNav battle script was started.
	call DexNav_CheckHuntObject
	jr nz, .no_hunt
	ld a, [wPlayerMapX]
	ld hl, wDexNavHuntX
	cp [hl]
	jr nz, .no_battle
	ld a, [wPlayerMapY]
	ld hl, wDexNavHuntY
	cp [hl]
	jr nz, .no_battle
	call DexNav_EndHunt
	call DexNav_ChooseWildEncounter
	jr nz, .no_battle
	ld a, BANK(DexNavBattleScript)
	ld hl, DexNavBattleScript
	call CallScript
	scf
	ret

.no_hunt
	; The rustle is gone (map change, battle, etc.), so the hunt is over.
	xor a
	ld [wDexNavHuntObject], a
.no_battle
	and a
	ret

DexNav_HideSpritesUnderMenu:
; Hide sprites (including the player) that would draw over the list,
; like ClearSpritesUnderStartMenu.
	ld hl, wShadowOAMSprite00XCoord
	ld de, OBJ_SIZE
	ld c, OAM_COUNT
.loop
	ld a, [hl]
	cp (DEXNAV_MENU_LEFT - 1) * TILE_WIDTH ; left border
	jr c, .next
	dec l
	ld [hl], OAM_YCOORD_HIDDEN
	inc l
.next
	add hl, de
	dec c
	jr nz, .loop
	ldh a, [hOAMUpdate]
	push af
	ld a, TRUE
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hOAMUpdate], a
	ret

DexNav_BuildList:
; Fill wDexNavList with each distinct species/form in this area's table for
; the current time of day (both day and night in the evening).
; Format: count, (species, form) * count, -1. Returns nc if no wild data.
	xor a
	ld [wDexNavList], a
	ld a, [wTimeOfDay]
	cp EVE
	jr nz, .add_table
	ld a, DAY
	call .add_table
	ret nc
	ld a, NITE
.add_table
	call DexNav_GetSlotTable
	ret nc
.slot_loop
	push hl
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld e, a
	inc hl
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld d, a
	push bc
	call .AddToList
	pop bc
	pop hl
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .slot_loop
	scf
	ret

.AddToList:
; Append species e / form d unless it's already listed.
	ld hl, wDexNavList
	ld a, [hli]
	and a
	jr z, .append
	ld c, a
.dupe_loop
	ld a, [hli]
	cp e
	ld a, [hli]
	jr nz, .next
	cp d
	ret z
.next
	dec c
	jr nz, .dupe_loop
.append
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld [hl], CANCEL
	ld hl, wDexNavList
	inc [hl]
	ret
