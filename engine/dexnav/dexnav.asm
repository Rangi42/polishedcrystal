; DexNav: search the current area for a chosen wild species.
; Behavior is modeled on CFRU's src/dexnav.c. See PC-DexNav-Decisions.md.

DexNav_ChooseWildEncounter:
; Set up a wild battle against [wDexNavHuntSpecies]/[wDexNavHuntForm]
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
	call DexNav_RollSlot
	call DexNav_CheckSlotIsTarget
	jr z, .got_slot
	pop hl
	jr .roll

.got_slot
	pop bc ; discard table pointer

	; Same Unown check as _ChooseWildEncounter
	ld a, [wDexNavHuntSpecies]
	cp UNOWN
	jr nz, .unown_check_done
	ld a, [wDexNavHuntForm]
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

	ld a, [wDexNavHuntSpecies]
	ld [wTempWildMonSpecies], a
	ld a, [wDexNavHuntForm]
	ld [wWildMonForm], a
	ld a, BATTLETYPE_DEXNAV
	ld [wBattleType], a
	xor a
	ret

DexNav_RollSlot:
; Pick a slot with the normal encounter odds.
; Input: hl = first slot, de = cumulative odds. Returns hl = the slot.
	push hl
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
	pop hl
	ld a, b
	add b
	add b
	ld c, a
	ld b, 0
	add hl, bc
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
	ld a, [wDexNavHuntSpecies]
	cp c
	jr nz, .done
	inc hl
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld c, a
	ld a, [wDexNavHuntForm]
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
	iffalsefwd .done
	; A hunt started while biking: get off the bike (D9).
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	closetext
	special UpdatePlayerSprite
	playmapmusic
	end

.done
	endtext

DexNavSpottedScript:
	playsound SFX_GRASS_RUSTLE
	showemote EMOTE_SHOCK, PLAYER, 15
	callasm DexNav_RespawnRustle
	end

DexNavFledScript:
	jumptext DexNavFledText

DexNavGotAwayScript:
	jumptext DexNavGotAwayText

DexNavFledText:
	text_ram wStringBuffer1
	text " noticed"
	line "you and fled!"
	done

DexNavGotAwayText:
	text_ram wStringBuffer1
	text " got"
	line "away…"
	done

DexNavBattleScript:
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

DexNav_ChooseTarget:
; Let the player pick a species from this area's list, then start the hunt.
; Sets [hScriptVar] to TRUE if the player has to get off their bike.
	xor a ; FALSE
	ldh [hScriptVar], a

	; Using the DexNav during a hunt offers to stop it (D9).
	call DexNav_CheckHuntObject
	jr nz, .no_hunt
	call DexNav_GetTargetName
	ld hl, .StopSearchText
	ld a, [wDexNavHuntFlags]
	bit DEXNAV_HUNT_SPONTANEOUS_F, a
	jr z, .got_stop_text
	ld hl, .StopSearchHiddenText
.got_stop_text
	call PrintText
	call YesNoBox
	ret c
	jmp DexNav_EndHunt

.no_hunt
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	ld hl, .TooDarkText
	jmp z, .print

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
	jmp z, .cancel
	ld a, [wMenuSelection]
	cp CANCEL
	jmp z, .cancel

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
	; Searching for a different species doesn't need the one-step cooldown.
	ld a, [wDexNavTargetSpecies]
	cp c
	jr nz, .new_target
	ld a, [wDexNavTargetForm]
	cp b
	jr z, .same_target
.new_target
	xor a
	ld [wDexNavCooldown], a
.same_target
	ld a, c
	ld [wDexNavTargetSpecies], a
	ld [wDexNavHuntSpecies], a
	ld a, b
	ld [wDexNavTargetForm], a
	ld [wDexNavHuntForm], a
	xor a
	ld [wDexNavHuntFlags], a
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
	; After a failed search, take a step before trying again (D18).
	ld a, [wDexNavCooldown]
	and a
	jr nz, .not_found
	call DexNav_SuccessRoll
	jr nc, .failed
	call DexNav_StartHunt
	jr nc, .failed
	call DexNav_RollBoosts
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ret nz
	ld a, [wOWState]
	bit OWSTATE_BIKING_FORCED, a
	ret nz
	ld a, TRUE
	ldh [hScriptVar], a
	ret

.failed
	ld a, TRUE
	ld [wDexNavCooldown], a
.not_found
	ld hl, .NotFoundText
	jr .print

.not_here
	call DexNav_GetTargetName
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

.StopSearchText:
	text "Stop searching"
	line "for "
	text_ram wStringBuffer1
	text "?"
	done

.StopSearchHiddenText:
	text "Stop searching?"
	done

.TooDarkText:
	text "It's too dark to"
	line "use the DexNav."
	prompt

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
	ld a, [wDexNavHuntSpecies]
	ld c, a
	ld a, [wDexNavHuntForm]
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
	call DexNav_MapReachableTiles
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
	xor a
	ld [wDexNavHuntSteps], a
	; fallthrough

DexNav_SpawnRustle:
; Spawn the rustle at coords d, e for environment data hl.
; Returns carry on success.
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

DexNav_RespawnRustle:
; showemote's cleanup (DespawnEmote) deletes every effect object, including
; the rustle, so put it back afterwards.
	call DexNav_CheckHuntObject
	ret z
	ld a, [wDexNavHuntX]
	ld d, a
	ld a, [wDexNavHuntY]
	ld e, a
	call DexNav_GetEnvironment
	jr DexNav_SpawnRustle

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

	; The player has to be able to walk there (CFRU flood-fills too).
	push hl
	call DexNav_GetReachCell
	ld a, [hl]
	pop hl
	bit DEXNAV_REACHED_F, a
	jr z, .fail

	call DexNav_OffsetToCoords
	jr nc, .fail

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

DexNav_OffsetToCoords:
; Turn offsets d, e from the player into map coords d, e.
; Returns carry if they're inside the map (object coords start at 4).
	ld a, [wPlayerMapX]
	add d
	ld d, a
	ld a, [wPlayerMapY]
	add e
	ld e, a
	ld a, d
	sub 4
	jr c, .outside
	ld c, a
	ld a, [wMapWidth]
	add a
	cp c
	jr c, .outside
	jr z, .outside
	ld a, e
	sub 4
	jr c, .outside
	ld c, a
	ld a, [wMapHeight]
	add a
	cp c
	jr c, .outside
	jr z, .outside
	scf
	ret

.outside
	and a
	ret

DexNav_GetReachCell:
; Return hl = wDexNavReach cell for offsets d, e from the player.
	ld a, e
	add DEXNAV_MAX_OFFSET
	ld c, a
	add a ; * 2
	add a ; * 4
	add a ; * 8
	add c ; * 9
	add d
	add DEXNAV_MAX_OFFSET
	ld hl, wDexNavReach
	add l
	ld l, a
	ret nc
	inc h
	ret

DexNav_MapReachableTiles:
; Flood-fill wDexNavReach (a square around the player) with the tiles the
; player can walk to without leaving it. Ledges count as blocked, since they
; only go one way, and side walls block the edges they're on, like they do in
; WillObjectBumpIntoTile / CanObjectLeaveTile. Surfing walks on water instead.
; Each cell: bit 7 = reached, bit 6 = walkable, bits 0-3 = side wall edges.
	farcall CheckOnWater
	ld a, LAND_TILE
	jr nz, .got_mode
	ld a, WATER_TILE
.got_mode
	ld [wDexNavReachMode], a

	; Which tiles can be walked on at all?
	ld e, -DEXNAV_MAX_OFFSET
.row_loop
	ld d, -DEXNAV_MAX_OFFSET
.cell_loop
	push de
	call DexNav_GetReachCell
	push hl
	call .GetCell
	pop hl
	ld [hl], a
	pop de
	inc d
	ld a, d
	cp DEXNAV_MAX_OFFSET + 1
	jr nz, .cell_loop
	inc e
	ld a, e
	cp DEXNAV_MAX_OFFSET + 1
	jr nz, .row_loop

	ld hl, wDexNavReach + DEXNAV_REACH_CENTER
	set DEXNAV_REACHED_F, [hl]

	; Spread out from the player until nothing changes.
.pass_loop
	ld b, FALSE
	ld hl, wDexNavReach
	ld e, 0
.pass_row
	ld d, 0
.pass_cell
	ld a, [hl]
	and (1 << DEXNAV_REACHED_F) | (1 << DEXNAV_WALKABLE_F)
	cp 1 << DEXNAV_WALKABLE_F
	jr nz, .next_cell
	ld c, [hl] ; this cell's side walls
	; from the left: neither our left edge nor its right edge is a wall
	ld a, d
	and a
	jr z, .no_left
	bit SIDE_WALL_LEFT_F, c
	jr nz, .no_left
	dec hl
	ld a, [hli]
	and (1 << DEXNAV_REACHED_F) | (1 << SIDE_WALL_RIGHT_F)
	cp 1 << DEXNAV_REACHED_F
	jr z, .mark
.no_left
	; from the right
	ld a, d
	cp DEXNAV_REACH_SIZE - 1
	jr z, .no_right
	bit SIDE_WALL_RIGHT_F, c
	jr nz, .no_right
	inc hl
	ld a, [hld]
	and (1 << DEXNAV_REACHED_F) | (1 << SIDE_WALL_LEFT_F)
	cp 1 << DEXNAV_REACHED_F
	jr z, .mark
.no_right
	; from above
	ld a, e
	and a
	jr z, .no_up
	bit SIDE_WALL_TOP_F, c
	jr nz, .no_up
	push hl
	ld a, l
	sub DEXNAV_REACH_SIZE
	ld l, a
	ld a, h
	sbc 0
	ld h, a
	ld a, [hl]
	pop hl
	and (1 << DEXNAV_REACHED_F) | (1 << SIDE_WALL_BOTTOM_F)
	cp 1 << DEXNAV_REACHED_F
	jr z, .mark
.no_up
	; from below
	ld a, e
	cp DEXNAV_REACH_SIZE - 1
	jr z, .next_cell
	bit SIDE_WALL_BOTTOM_F, c
	jr nz, .next_cell
	push hl
	ld a, l
	add DEXNAV_REACH_SIZE
	ld l, a
	ld a, h
	adc 0
	ld h, a
	ld a, [hl]
	pop hl
	and (1 << DEXNAV_REACHED_F) | (1 << SIDE_WALL_TOP_F)
	cp 1 << DEXNAV_REACHED_F
	jr nz, .next_cell
.mark
	set DEXNAV_REACHED_F, [hl]
	ld b, TRUE
.next_cell
	inc hl
	inc d
	ld a, d
	cp DEXNAV_REACH_SIZE
	jr nz, .pass_cell
	inc e
	ld a, e
	cp DEXNAV_REACH_SIZE
	jr nz, .pass_row
	ld a, b
	and a
	jr nz, .pass_loop
	ret

.GetCell:
; Return the starting wDexNavReach value for offsets d, e.
	call DexNav_OffsetToCoords
	jr nc, .blocked
	call GetCoordTileCollision
	ld c, a
	cp COLL_LEDGE_RIGHT
	jr c, .not_ledge
	cp COLL_LEDGE_UP_LEFT + 1
	jr c, .blocked
.not_ledge
	call GetTilePermission
	ld hl, wDexNavReachMode
	cp [hl]
	jr nz, .blocked
	ld a, c
	push bc
	farcall GetSideWallDirectionMask ; a = 0 if not a side wall
	pop bc
	or 1 << DEXNAV_WALKABLE_F
	ret

.blocked
	xor a
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
; Called after each step. Returns carry if a DexNav script was started.
	xor a
	ld [wDexNavCooldown], a
	call DexNav_CheckHuntObject
	jr nz, .no_hunt

	; Distance to the target (taxicab)
	ld a, [wDexNavHuntX]
	ld hl, wPlayerMapX
	sub [hl]
	jr nc, .dx_ok
	cpl
	inc a
.dx_ok
	ld c, a
	ld a, [wDexNavHuntY]
	ld hl, wPlayerMapY
	sub [hl]
	jr nc, .dy_ok
	cpl
	inc a
.dy_ok
	add c
	jr z, .reached

	; Running or biking nearby scares it off (D9).
	ld c, a
	ld a, [wPlayerState]
	assert PLAYER_RUN == 1 && PLAYER_BIKE == 2
	dec a
	cp PLAYER_BIKE
	jr nc, .not_rushing
	ld a, c
	cp DEXNAV_SNEAK_DISTANCE + 1
	ld hl, DexNavFledScript
	jr c, .lost_target
.not_rushing

	; It doesn't wait forever.
	ld hl, wDexNavHuntSteps
	inc [hl]
	ld a, [hl]
	cp DEXNAV_HUNT_STEPS
	ld hl, DexNavGotAwayScript
	jr nc, .lost_target
	and a
	ret

.lost_target
	push hl
	call DexNav_EndHunt
	call DexNav_GetTargetName
	pop hl
	jr .call_script

.reached
	call DexNav_EndHunt
	call DexNav_ChooseWildEncounter
	jr nz, .no_battle
	call DexNav_RaiseSearchLevel
	ld hl, DexNavBattleScript
.call_script
	ld a, BANK(DexNavBattleScript)
	call CallScript
	scf
	ret

.no_hunt
	; The rustle is gone (map change, battle, etc.), so the hunt is over.
	xor a
	ld [wDexNavHuntObject], a
	jr DexNav_TrySpontaneousHunt

.no_battle
	and a
	ret

DexNav_TrySpontaneousHunt:
; While the DexNav is registered, a hidden Pokemon sometimes appears on its
; own (D14/D19). Returns carry if it did and its script was started.
	ld hl, wRegisteredItems
	ld b, 4 ; wRegisteredItems:: ds 4
.registered_loop
	ld a, [hli]
	cp DEXNAV
	jr z, .registered
	dec b
	jr nz, .registered_loop
	and a
	ret

.registered
	call Random
	and DEXNAV_SPONTANEOUS_MASK
	ret nz
	ld a, [wStatusFlags2]
	and (1 << STATUSFLAGS2_SAFARI_GAME_F) | (1 << STATUSFLAGS2_BUG_CONTEST_TIMER_F)
	ret nz
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	jr z, .no

	; Only on the tiles wild Pokemon appear on here
	call DexNav_GetEnvironment
	ld a, [wPlayerTileCollision]
	ld c, a
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	cp c
	jr z, .on_encounter_tile
	ld a, [hl]
	cp c
	jr nz, .no
.on_encounter_tile

	farcall GetTimeOfDayNotEve
	call DexNav_GetSlotTable
	jr nc, .no
	call DexNav_RollSlot
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld [wDexNavHuntSpecies], a
	inc hl
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld [wDexNavHuntForm], a
	call DexNav_StartHunt
	jr nc, .no
	ld a, 1 << DEXNAV_HUNT_SPONTANEOUS_F
	ld [wDexNavHuntFlags], a
	call DexNav_RollBoosts
	ld a, BANK(DexNavSpottedScript)
	ld hl, DexNavSpottedScript
	call CallScript
	scf
	ret

.no
	and a
	ret

DexNav_GetTargetName:
; Put the hunted Pokemon's name in wStringBuffer1, or "It" if it appeared on
; its own (so fleeing doesn't spoil an unseen species).
	ld a, [wDexNavHuntFlags]
	bit DEXNAV_HUNT_SPONTANEOUS_F, a
	jr z, .named
	ld hl, .It
	ld de, wStringBuffer1
	ld bc, .ItEnd - .It
	jmp CopyBytes

.It:
	db "It@"
.ItEnd:

.named
	ld a, [wDexNavHuntSpecies]
	ld [wNamedObjectIndex], a
	ld a, [wDexNavHuntForm]
	ld [wNamedObjectIndex + 1], a
	jmp GetPokemonName

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

DexNav_GetSearchLevelPointer:
; hl = the hunt species' entry in wDexNavSearchLevels (D21)
	ld a, [wDexNavHuntSpecies]
	ld c, a
	ld a, [wDexNavHuntForm]
	ld b, a
	call GetSpeciesAndFormIndex
	ld hl, wDexNavSearchLevels
	add hl, bc
	ret

DexNav_RaiseSearchLevel:
; Each DexNav battle raises the hunt species' search level (CFRU).
	call DexNav_GetSearchLevelPointer
	ldh a, [rWBK]
	push af
	ld a, BANK(wDexNavSearchLevels)
	ldh [rWBK], a
	ld a, [hl]
	add DEXNAV_LEVEL_STEP
	jr nc, .ok
	ld a, $ff
.ok
	ld [hl], a
	pop af
	ldh [rWBK], a
	ret

DexNav_GetSearchTier:
; Returns a = the hunt species' search level tier (0 to DEXNAV_NUM_TIERS - 1).
	call DexNav_GetSearchLevelPointer
	ldh a, [rWBK]
	push af
	ld a, BANK(wDexNavSearchLevels)
	ldh [rWBK], a
	ld d, [hl]
	pop af
	ldh [rWBK], a
	ld hl, DexNavTierLevels
	ld c, 0
.loop
	ld a, d
	cp [hl]
	jr c, .done
	inc hl
	inc c
	ld a, c
	cp DEXNAV_NUM_TIERS - 1
	jr c, .loop
.done
	ld a, c
	ret

DexNavTierLevels:
; Lowest search level of tiers 1 and up
	db 5, 10, 25, 50, 100
	assert @ - DexNavTierLevels == DEXNAV_NUM_TIERS - 1

DexNavBoostChances:
; Percent chances per tier, from CFRU's dexnav_config.h
;	   egg move, Hidden Ability, 1 star, 2 stars, 3 stars
	db  0,  0,  0,  0,  0 ; level 0-4
	db 21,  0, 14,  1,  0 ; level 5-9
	db 46,  5, 17,  9,  1 ; level 10-24
	db 58, 15, 17, 16,  7 ; level 25-49
	db 63, 20, 15, 17,  6 ; level 50-99
	db 83, 23,  8, 24, 12 ; level 100+
	assert @ - DexNavBoostChances == DEXNAV_NUM_TIERS * DEXNAV_CHANCE_SIZE

DexNav_RollBoosts:
; Roll the hunt target's Hidden Ability and potential from its search level
; when the hunt starts (D20). A species that was never battled is still at
; level 0, so unseen species from spontaneous hunts get no boosts (D14).
	xor a
	ld [wDexNavHuntAbility], a
	ld [wDexNavHuntPotential], a
	call DexNav_GetSearchTier
	and a
	ret z
	ld hl, DexNavBoostChances
	ld bc, DEXNAV_CHANCE_SIZE
	rst AddNTimes

	; Hidden Ability, only for species caught before (CFRU)
	push hl
	ld a, [wDexNavHuntSpecies]
	ld c, a
	ld a, [wDexNavHuntForm]
	ld b, a
	call CheckCaughtMon
	pop hl
	jr z, .ability_done
	push hl
	ld bc, DEXNAV_CHANCE_HIDDEN_ABILITY
	add hl, bc
	ld a, 100
	call RandomRange
	cp [hl]
	pop hl
	jr nc, .ability_done
	ld a, HIDDEN_ABILITY
	ld [wDexNavHuntAbility], a
.ability_done

	; Potential: one roll against the 1, 2 and 3 star chances in turn
	ld bc, DEXNAV_CHANCE_ONE_STAR
	add hl, bc
	ld a, 100
	call RandomRange
	ld c, a
	lb de, 0, 0 ; stars, running total
	ld b, 3
.potential_loop
	inc d
	ld a, e
	add [hl]
	inc hl
	ld e, a
	ld a, c
	cp e
	jr c, .got_potential
	dec b
	jr nz, .potential_loop
	ret

.got_potential
	ld a, d
	ld [wDexNavHuntPotential], a
	ret

DexNav_ApplyPotential:
; Called from ApplyLegendaryDVs for BATTLETYPE_DEXNAV.
; Give [wDexNavHuntPotential] random stats perfect DVs.
; hl = last DV byte, as for ApplyLegendaryDVs.
	ld a, [wBattleMode]
	dec a ; WILD_BATTLE?
	ret nz
	ld a, [wDexNavHuntPotential]
	and a
	ret z
	push bc
	push de
	ld b, a
	ld c, 0 ; one bit per chosen stat
.pick_loop
	ld a, 6
	call RandomRange
	inc a
	ld e, a
	ld a, %1
.shift_loop
	dec e
	jr z, .got_bit
	add a
	jr .shift_loop
.got_bit
	ld d, a
	and c
	jr nz, .pick_loop ; already chosen
	ld a, d
	or c
	ld c, a
	dec b
	jr nz, .pick_loop

	; Same layout as ApplyLegendaryDVs: two stats per byte, last byte first
	ld b, 3
.stat_loop
	rrc c
	jr nc, .skip_low_nibble
	ld a, [hl]
	or $f
	ld [hl], a
.skip_low_nibble
	rrc c
	jr nc, .skip_high_nibble
	ld a, [hl]
	or $f0
	ld [hl], a
.skip_high_nibble
	dec hl
	dec b
	jr nz, .stat_loop
	pop de
	pop bc
	ret

DexNav_ApplyBattleBoosts:
; Called from LoadEnemyWildmon once the wild mon is built.
; Give a DexNav target the Hidden Ability rolled at hunt start.
	ld a, [wBattleType]
	cp BATTLETYPE_DEXNAV
	ret nz
	ld a, [wDexNavHuntAbility]
	and a
	ret z
	ld hl, wOTPartyMon1Ability
	or [hl]
	ld [hl], a
	ret
