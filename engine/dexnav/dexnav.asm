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
	jr nz, .one_time
	; Evening normally uses day or night encounters at random,
	; so a target from either table can be found.
	ld a, DAY
	call .try
	ret z
	ld a, NITE
.one_time
	call .try
	ret z
	; While surfing, fishing species can be found too (D3).
	jmp DexNav_ChooseFishEncounter

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
	; fallthrough

DexNav_SetUpBattle:
; Finish setting up the DexNav battle for the hunt species at level a.
; Returns z.
	; Chain level bonus, rolled at hunt start (CFRU caps it at MAX_LEVEL)
	ld hl, wDexNavHuntLevelBonus
	add [hl]
	cp MAX_LEVEL + 1
	jr c, .got_level
	ld a, MAX_LEVEL
.got_level
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
; Returns z if the wild slot at hl is the DexNav target. Clobbers a.
	ld a, BANK(JohtoGrassWildMons)
	; fallthrough

DexNav_CheckSlotIsTargetInBank:
; Same for a slot in bank a (fishing entries put species and form at the
; same offsets as wild slots).
	push de
	call DexNav_GetSlotMonInBank
	ld a, [wDexNavHuntSpecies]
	cp e
	jr nz, .done
	ld a, [wDexNavHuntForm]
	cp d
.done
	pop de
	ret

DexNav_GetSlotMon:
; Return e = species and d = form of the wild slot at hl. Preserves hl and bc.
	ld a, BANK(JohtoGrassWildMons)
	; fallthrough

DexNav_GetSlotMonInBank:
; Same for a slot in bank a.
	push hl
	inc hl ; skip level (or a fishing entry's chance)
	call GetFarWord
	ld e, l
	ld d, h
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
	jmp DexNav_BreakHunt

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
	ld [wDexNavListCursor], a

	ldh a, [hBGMapMode]
	push af
	ld a, [wMenuScrollPosition]
	push af
	call DexNav_OpenPage
.menu_loop
	ld hl, .MenuHeader
	call CopyMenuHeader
	; Scroll so the remembered entry is on screen.
	ld a, [wDexNavListCursor]
	ld c, 0
	cp DEXNAV_MENU_ROWS + 1
	jr c, .got_scroll
	sub DEXNAV_MENU_ROWS
	ld c, a
	ld a, DEXNAV_MENU_ROWS
.got_scroll
	ld [wMenuCursorBuffer], a
	ld a, c
	ld [wMenuScrollPosition], a
	call InitScrollingMenu
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld hl, wMenuCursorY
	add [hl]
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
	push bc
	call ExitAllMenus
	pop bc
	pop af
	ld [wMenuScrollPosition], a
	pop af
	ldh [hBGMapMode], a

	; The chain is for one species (D24), so ask before searching for another.
	ld a, [wDexNavChain]
	and a
	jr z, .confirmed
	call DexNav_IsChainSpecies
	jr z, .confirmed
	push bc
	ld a, c
	ld [wNamedObjectIndex], a
	ld a, b
	ld [wNamedObjectIndex + 1], a
	call GetPokemonName
	ld hl, .SearchInsteadText
	call PrintText
	call YesNoBox
	pop bc
	ret c
.confirmed

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
	call ExitAllMenus
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

.SearchInsteadText:
	text "Search instead"
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
	menu_coords 1, DEXNAV_MENU_TOP, SCREEN_WIDTH - 2, DEXNAV_MENU_TOP + DEXNAV_MENU_ROWS * 2
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
	call DexNav_CheckHuntCaught
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
	and a
	jr nz, .roll
	; A fishing species (D3): its odds are out of 256, not 100.
	call DexNav_FindFishTable
	add a
	ret c
	ld c, a
	call Random
	cp c
	ret

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
	call DexNav_IsEnvironmentTile
	jr nz, .fail

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

DexNav_IsEnvironmentTile:
; Returns z if collision a is one of environment hl's tiles. Clobbers c and hl.
	ld c, a
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	cp c
	ret z
	ld a, [hl]
	cp c
	ret

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

DexNav_BreakHunt:
; End the hunt (flee, timeout, cancel). A searched hunt ends the chain too;
; one that appeared on its own doesn't (D24).
	call DexNav_EndHunt
	ld a, [wDexNavHuntFlags]
	bit DEXNAV_HUNT_SPONTANEOUS_F, a
	ret nz
	; fallthrough

DexNav_BreakChain:
	xor a
	ld [wDexNavChain], a
	ret

DexNav_UpdateChain:
; Called from ExitBattle. Winning or catching in a DexNav battle extends the
; chain (CFRU: 0 -> 2, then +1, and 100 wraps to 1) if it's the chain's
; species, or starts a new chain for it (ORAS, D24); any other battle ends it.
	ld a, [wBattleType]
	cp BATTLETYPE_DEXNAV
	jr nz, DexNav_BreakChain
	ld a, [wBattleResult]
	and ~BATTLERESULT_BITMASK
	assert WIN == 0
	jr nz, DexNav_BreakChain
	call DexNav_GetHuntMon
	ld hl, wDexNavChain
	ld a, [hl]
	and a
	jr z, .new_chain
	call DexNav_IsChainSpecies
	jr nz, .new_chain
	ld a, [hl]
	add DEXNAV_CHAIN_STEP
	cp DEXNAV_MAX_CHAIN + 1
	jr c, .got_chain
	ld a, 1
	jr .got_chain

.new_chain
	ld a, c
	ld [wDexNavChainSpecies], a
	ld a, b
	ld [wDexNavChainForm], a
	ld a, DEXNAV_CHAIN_START
.got_chain
	ld [hl], a
	ret

DexNav_IsChainSpecies:
; Returns z if species c / form b is the chain's.
	ld a, [wDexNavChainSpecies]
	cp c
	ret nz
	ld a, [wDexNavChainForm]
	cp b
	ret

DexNav_HandleNewMap:
; Map setup command: a real map change (not Continue or a battle) breaks the
; chain (D13 Strict).
	call DexNav_BreakChain
	farjp HandleNewMap

DexNav_TryWildEncounter:
; RandomEncounter's TryWildEncounter call: with "Hunt encounters" set to No,
; no random encounters while a hunt is going (D16). Returns nz for no battle.
	ld a, [wInitialOptions2]
	bit DEXNAV_CALM_OPT, a
	jr z, .encounter
	call DexNav_CheckHuntObject
	jr nz, .encounter
	or 1 ; nz
	ret

.encounter
	farjp TryWildEncounter

DexNav_ClearSavedData:
	xor a
	ld hl, wDexNavSavedData
	ld bc, wDexNavSavedDataEnd - wDexNavSavedData
	rst ByteFill
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
	call DexNav_BreakHunt
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
	call DexNav_IsEnvironmentTile
	jr nz, .no

	farcall GetTimeOfDayNotEve
	call DexNav_GetSlotTable
	jr nc, .no
	call DexNav_RollSlot
	call DexNav_GetSlotMon
	ld a, e
	ld [wDexNavHuntSpecies], a
	ld a, d
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

DexNav_CheckHuntCaught:
; Returns nz if the hunt species has been caught.
	call DexNav_GetHuntMon
	jmp CheckCaughtMon

DexNav_GetHuntIndex:
; Return bc = the hunt species' GetSpeciesAndFormIndex.
	call DexNav_GetHuntMon
	jmp GetSpeciesAndFormIndex

DexNav_GetHuntMon:
; Return c = hunt species, b = hunt form.
	ld a, [wDexNavHuntSpecies]
	ld c, a
	ld a, [wDexNavHuntForm]
	ld b, a
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

DexNav_OpenPage:
; Fade to the full-screen list page: this area's name, the list box (drawn
; by the scrolling menu) and a prompt. ExitAllMenus returns to the map.
	call FadeToMenu_BackupSprites
	call ClearTileMap
	hlcoord 0, 0
	lb bc, 1, SCREEN_WIDTH - 2
	call Textbox
	call GetCurrentLandmark
	ld e, a
	farcall GetLandmarkName
	; Some names have a line break ('¯'); show them on one line.
	ld hl, wStringBuffer1
.name_loop
	ld a, [hl]
	cp '@'
	jr z, .got_name
	cp '¯'
	jr nz, .next_char
	ld [hl], ' '
.next_char
	inc hl
	jr .name_loop
.got_name
	ld de, wStringBuffer1
	hlcoord 1, 1
	rst PlaceString
	hlcoord 0, DEXNAV_PROMPT_Y
	lb bc, 2, SCREEN_WIDTH - 2
	call Textbox
	ld de, .PromptString
	hlcoord 1, DEXNAV_PROMPT_Y + 1
	rst PlaceString
	ld a, CGB_PLAIN
	call GetCGBLayout
	call ApplyAttrAndTilemapInVBlank
	farjp FadeInPalettes

.PromptString:
	db "Search for which<LNBRK>#mon?@"

DexNav_BuildList:
; Fill wDexNavList with each distinct species/form in this area's table for
; the current time of day (both day and night in the evening).
; Format: count, (species, form) * count, -1. Returns nc if no wild data.
	xor a
	ld [wDexNavList], a
	ld a, [wTimeOfDay]
	cp EVE
	jr nz, .one_time
	ld a, DAY
	call .add_table
	ret nc
	ld a, NITE
.one_time
	call .add_table
	ret nc
	jmp DexNav_AddFishToList

.add_table
	call DexNav_GetSlotTable
	ret nc
.slot_loop
	call DexNav_GetSlotMon
	push hl
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

DexNav_AddFishToList:
; While surfing, add the species the player's rods can hook here (D3).
; Returns carry.
	assert NUM_WATERMON + DEXNAV_MAX_FISH_ENTRIES <= DEXNAV_LIST_MAX
	call DexNav_GetFishGroup
	jr nc, .done
	ld e, 0 ; Old Rod first
.rod_loop
	push af
	push de
	call DexNav_GetFishRodTable
	jr nc, .next_rod
.entry_loop
	ld a, BANK(FishGroups)
	call DexNav_GetSlotMonInBank
	push hl
	push bc
	call DexNav_BuildList.AddToList
	pop bc
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .entry_loop
.next_rod
	pop de
	pop af
	inc e
	ld d, a
	ld a, e
	cp NUM_DEXNAV_RODS
	ld a, d
	jr c, .rod_loop
.done
	scf
	ret

DexNav_GetFishGroup:
; Returns carry and a = this map's fishing group while surfing.
	farcall CheckOnWater
	jr nz, .no
	farjp GetFishingGroup
.no
	and a
	ret

DexNav_GetFishRodTable:
; For fishing group a and rod e (0 = Old, 1 = Good, 2 = Super), return carry,
; hl = the rod's first entry (in BANK(FishGroups)) and b = its entry count,
; if the player has that rod.
	assert GOOD_ROD == OLD_ROD + 1 && SUPER_ROD == OLD_ROD + 2
	assert FISHGROUP_DATA_LENGTH == 8 && NUM_FISHGROUPS * 8 < $100
	ld d, a
	push de
	ld a, e
	add OLD_ROD
	call _CheckKeyItem
	pop de
	ret nc
	ld a, d
	add a
	add a
	add a
	add e
	add e
	ld c, a
	ld b, 0
	ld hl, FishGroups + 2 ; skip the bite chances
	add hl, bc
	ld a, BANK(FishGroups)
	call GetFarWord
	; Old Rod tables have 3 entries; Good and Super Rod tables have 4.
	ld b, 3
	ld a, e
	and a
	jr z, .got_count
	inc b
.got_count
	scf
	ret

DexNav_FindFishTable:
; Find the best rod the player has that can hook the hunt species here (D3).
; Returns carry, hl = that rod's first entry and b = its entry count, with
; a = the species' odds there (out of 256). Returns nc and a = 0 otherwise.
	call DexNav_GetFishGroup
	jr nc, .none
	ld e, NUM_DEXNAV_RODS - 1
.rod_loop
	push af
	push de
	call DexNav_GetFishRodTable
	jr nc, .next_rod
	push hl
	push bc
	; The chances are cumulative, so each entry's odds are the difference.
	xor a
	ld [wDexNavOddsPrev], a
	ld [wDexNavOddsSum], a
.entry_loop
	ld a, BANK(FishGroups)
	call GetFarByte
	ld c, a
	ld a, [wDexNavOddsPrev]
	ld d, a
	ld a, c
	ld [wDexNavOddsPrev], a
	sub d
	ld d, a
	ld a, BANK(FishGroups)
	call DexNav_CheckSlotIsTargetInBank
	jr nz, .next_entry
	ld a, [wDexNavOddsSum]
	add d
	ld [wDexNavOddsSum], a
.next_entry
	inc hl
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .entry_loop
	pop bc
	pop hl
	ld a, [wDexNavOddsSum]
	and a
	jr nz, .found
.next_rod
	pop de
	pop af
	dec e
	bit 7, e
	jr z, .rod_loop
.none
	xor a
	ret

.found
	pop de ; discard rod
	pop de ; discard fishing group
	scf
	ret

DexNav_ChooseFishEncounter:
; Set up a DexNav battle for a fishing species, with the best rod the player
; has that can hook it here. Returns z on success, nz if it can't be found.
	call DexNav_FindFishTable
	jr nc, .fail
.roll
	; Roll entries with the rod's odds until one is the target, like Fish does.
	push hl
	call Random
	ld c, a
.entry_loop
	ld a, BANK(FishGroups)
	call GetFarByte
	cp c
	jr nc, .got_entry
	inc hl
	inc hl
	inc hl
	inc hl
	jr .entry_loop

.got_entry
	ld a, BANK(FishGroups)
	call DexNav_CheckSlotIsTargetInBank
	jr z, .found
	pop hl
	jr .roll

.found
	pop bc ; discard first entry
	inc hl ; skip chance
	inc hl ; skip species
	inc hl ; skip form
	ld a, BANK(FishGroups)
	call GetFarByte
	; Fished Pokemon don't get the badge or surfing level adjustments.
	jmp DexNav_SetUpBattle

.fail
	or 1
	ret

DexNav_GetSearchLevelPointer:
; hl = the hunt species' entry in wDexNavSearchLevels (D21)
	call DexNav_GetHuntIndex
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

DexNav_TryLoadSaveFile:
; Continue: load the search levels before the save, so the backup copy that
; loading may write keeps them.
	call DexNav_ClearSearchLevels
	ld a, BANK(sDexNavMagic)
	call GetSRAMBank
	ld a, [sDexNavMagic]
	cp DEXNAV_SAVE_MAGIC
	ld hl, sDexNavSearchLevels
	ld de, wDexNavSearchLevels
	call z, DexNav_CopySearchLevels
	call CloseSRAM
	farjp TryLoadSaveFile

DexNav_BackupPartyMonMail:
; Called while saving the game.
	ld a, BANK(sDexNavMagic)
	call GetSRAMBank
	ld a, DEXNAV_SAVE_MAGIC
	ld [sDexNavMagic], a
	ld hl, wDexNavSearchLevels
	ld de, sDexNavSearchLevels
	call DexNav_CopySearchLevels
	call CloseSRAM
	farjp BackupPartyMonMail

DexNav_SetInitialOptions:
; New Game (and New Game+): start with no search levels.
	call DexNav_ClearSearchLevels
	farjp SetInitialOptions

DexNav_ClearSearchLevels:
	ldh a, [rWBK]
	push af
	ld a, BANK(wDexNavSearchLevels)
	ldh [rWBK], a
	ld hl, wDexNavSearchLevels
	ld bc, NUM_EXT_POKEMON
	xor a
	rst ByteFill
	jr DexNav_RestoreWRAMBank

DexNav_CopySearchLevels:
; Copy the search-level table from hl to de with WRAMX 2 switched in.
	ldh a, [rWBK]
	push af
	ld a, BANK(wDexNavSearchLevels)
	ldh [rWBK], a
	ld bc, NUM_EXT_POKEMON
	rst CopyBytes
DexNav_RestoreWRAMBank:
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

DexNavShinyPasses:
; Extra passes through the shiny check per tier (D10), close to CFRU's
; searchLevel * 6 / 100 bonus
	db 0, 0, 0, 1, 2, 3
	assert @ - DexNavShinyPasses == DEXNAV_NUM_TIERS

DexNav_RollBoosts:
; Roll the hunt target's egg move, Hidden Ability and potential from its
; search level when the hunt starts (D20). A species that was never battled
; is still at level 0, so unseen species from spontaneous hunts get no
; boosts (D14).
	xor a
	ld [wDexNavHuntAbility], a
	ld [wDexNavHuntPotential], a
	ld [wDexNavHuntEggMove], a
	ld [wDexNavHuntShinyPasses], a

	; Chain boosts (CFRU), whatever the search level, but only from a chain
	; for this species (D24)
	; Level: +chain / 5, and sometimes +10 more
	call DexNav_GetHuntChain
	ld b, -1
.divide_by_5
	inc b
	sub 5
	jr nc, .divide_by_5
	call DexNav_RollChainBonus
	jr nc, .got_level_bonus
	ld a, DEXNAV_CHAIN_BONUS_LEVELS
	add b
	ld b, a
.got_level_bonus
	ld a, b
	ld [wDexNavHuntLevelBonus], a
	; Shiny passes: some at the chain milestones, and sometimes a few more
	call DexNav_GetHuntChain
	ld b, DEXNAV_CHAIN_PASSES_1
	cp DEXNAV_CHAIN_MILESTONE_1
	jr z, .got_chain_passes
	ld b, DEXNAV_CHAIN_PASSES_2
	cp DEXNAV_CHAIN_MILESTONE_2
	jr z, .got_chain_passes
	ld b, 0
.got_chain_passes
	call DexNav_RollChainBonus
	jr nc, .got_bonus_passes
	ld a, DEXNAV_CHAIN_BONUS_PASSES
	add b
	ld b, a
.got_bonus_passes
	ld a, b
	ld [wDexNavHuntShinyPasses], a

	; Search level boosts
	call DexNav_GetSearchTier
	and a
	ret z
	ld c, a
	ld b, 0
	ld hl, DexNavShinyPasses
	add hl, bc
	ld a, [wDexNavHuntShinyPasses]
	add [hl]
	ld [wDexNavHuntShinyPasses], a
	ld a, c
	ld hl, DexNavBoostChances
	ld bc, DEXNAV_CHANCE_SIZE
	rst AddNTimes

	; Egg move (DEXNAV_CHANCE_EGG_MOVE is the first column)
	assert DEXNAV_CHANCE_EGG_MOVE == 0
	ld a, 100
	call RandomRange
	cp [hl]
	jr nc, .egg_move_done
	push hl
	call DexNav_PickEggMove
	pop hl
.egg_move_done

	; Hidden Ability, only for species caught before (CFRU)
	push hl
	call DexNav_CheckHuntCaught
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

DexNav_GetHuntChain:
; Return a = the chain if it's for the hunt species, else 0. Preserves b.
	push bc
	call DexNav_GetHuntMon
	call DexNav_IsChainSpecies
	pop bc
	ld a, 0
	ret nz
	ld a, [wDexNavChain]
	ret

DexNav_RollChainBonus:
; Return carry DEXNAV_CHAIN_BONUS_CHANCE percent of the time. Preserves bc.
	ld a, 100
	call RandomRange
	cp DEXNAV_CHAIN_BONUS_CHANCE
	ret

DexNav_PickEggMove:
; Set wDexNavHuntEggMove to a random move from the hunt species' egg moves
; (the same lists breeding uses), or leave it at 0 if it has none.
	call DexNav_GetHuntIndex
	ld hl, EggSpeciesMovesPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EggSpeciesMovesPointers)
	call GetFarWord
	inc hl ; skip species
	inc hl ; and form
	; Count the moves
	push hl
	ld c, 0
.count_loop
	ld a, BANK(EggSpeciesMoves)
	call GetFarByte
	inc a
	jr z, .counted
	inc hl
	inc c
	jr .count_loop
.counted
	pop hl
	ld a, c
	and a
	ret z
	call RandomRange
	ld c, a
	ld b, 0
	add hl, bc
	ld a, BANK(EggSpeciesMoves)
	call GetFarByte
	ld [wDexNavHuntEggMove], a
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
; Called from LoadEnemyWildmon once the wild mon is built, before its PP is
; filled. Give a DexNav target the boosts rolled at hunt start.
	ld a, [wBattleType]
	cp BATTLETYPE_DEXNAV
	ret nz
	ld a, [wDexNavHuntAbility]
	ld hl, wOTPartyMon1Ability
	or [hl]
	ld [hl], a

	; The egg move goes in the first slot (CFRU), unless it's already known.
	ld a, [wDexNavHuntEggMove]
	and a
	jr z, .egg_move_done
	ld hl, wOTPartyMon1Moves
	ld c, NUM_MOVES
.known_loop
	cp [hl]
	jr z, .egg_move_done
	inc hl
	dec c
	jr nz, .known_loop
	ld [wOTPartyMon1Moves], a
.egg_move_done

	; Extra passes through the normal shiny check (D10)
	ld a, [wDexNavHuntShinyPasses]
	and a
	ret z
	ld b, a
	ld hl, wOTPartyMon1Shiny
	bit MON_SHINY_F, [hl]
	ret nz
	ld a, SHINY_CHARM
	call _CheckKeyItem
	ld c, SHINY_NUMERATOR
	jr nc, .shiny_loop
	ld c, CHARMED_SHINY_NUMERATOR
.shiny_loop
if !DEF(DEBUG) ; debug builds skip the 1/256 step so shinies can be tested
	call Random
	and a
	jr nz, .next_pass
endc
	call Random
	cp c
	jr c, .shiny
.next_pass
	dec b
	jr nz, .shiny_loop
	ret

.shiny
	ld hl, wOTPartyMon1Shiny
	set MON_SHINY_F, [hl]
	ret
