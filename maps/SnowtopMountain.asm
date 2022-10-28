SnowtopMountain_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SnowtopMountainFlyPoint

	def_warp_events
	warp_event  9, 31, RUGGED_ROAD_NORTH, 1

	def_coord_events
	coord_event 10, 28, 1, SnowtopMountainStopPanningScript
	coord_event 11, 28, 1, SnowtopMountainStopPanningScript
	coord_event 12, 28, 1, SnowtopMountainStopPanningScript
	coord_event 13, 28, 1, SnowtopMountainStopPanningScript
	coord_event 14, 28, 1, SnowtopMountainStopPanningScript
	coord_event 15, 28, 1, SnowtopMountainStopPanningScript
	coord_event 16, 28, 1, SnowtopMountainStopPanningScript
	coord_event 17, 28, 1, SnowtopMountainStopPanningScript
	coord_event 18, 28, 1, SnowtopMountainStopPanningScript
	coord_event 19, 28, 1, SnowtopMountainStopPanningScript

	def_bg_events
	bg_event 10, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 11, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 12, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 13, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 14, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 15, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 16, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 17, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 18, 27, BGEVENT_UP, SnowtopMountainStartPanningScript
	bg_event 19, 27, BGEVENT_UP, SnowtopMountainStartPanningScript

	def_object_events
	object_event -3, -3, SPRITE_MOM, SPRITEMOVEDATA_PLACEHOLDER_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 26, 11, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 0, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 16, 16, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 1, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 17, 11, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 14, 11, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 11, 13, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 14, 14, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  8, 16, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  6, 16, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  4,  7, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 4, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  4,  8, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 5, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  4, 10, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 6, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_const_def
	const SNOWTOPMOUNTAIN_PLAYER

SnowtopMountainFlyPoint:
	setflag ENGINE_FLYPOINT_SNOWTOP_MOUNTAIN
	endcallback

SnowtopMountainStartPanningScript:
	opentext
	writetext SnowtopMountainOutlookText
	yesorno
	iffalse_endtext
	closetext
	loadmem wPanningAroundTinyMap, TRUE
	changeblock 10, 28, $96
	changeblock 12, 28, $96
	changeblock 14, 28, $96
	changeblock 16, 28, $96
	changeblock 18, 28, $96
	callasm .PreparePlayerSubstitute
	appear SNOWTOPMOUNTAIN_PLAYER
	applymovement PLAYER, SnowtopMountainStartPanningMovement
	setscene $1
	callasm GenericFinishBridge
	end

.PreparePlayerSubstitute:
	ld a, [wPlayerGender]
	rrca
	ld b, SPRITE_CHRIS
	jr nc, .got_gender
	ld b, SPRITE_KRIS
.got_gender
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .got_sprite
	assert SPRITE_CHRIS + 1 == SPRITE_CHRIS_BIKE
	assert SPRITE_KRIS + 1 == SPRITE_KRIS_BIKE
	inc b
.got_sprite
	ld a, b
	farcall LoadSpriteAsMapObject1
	ld a, [wXCoord]
	ld [wSavedXCoord], a
	add 4
	ld d, a
	ld a, [wYCoord]
	add 4
	ld e, a
	ld b, SNOWTOPMOUNTAIN_PLAYER
	farjp CopyDECoordsToMapObject

SnowtopMountainStopPanningScript:
	setscene $0
.Continue
	callasm .CompareXCoords
	iffalsefwd .Ready
	ifgreater $7f, .GoRight
	applyonemovement PLAYER, step_left
	sjump .Continue
.GoRight
	applyonemovement PLAYER, step_right
	sjump .Continue
.Ready
	changeblock 10, 28, $71
	changeblock 12, 28, $71
	changeblock 14, 28, $71
	changeblock 16, 28, $71
	changeblock 18, 28, $71
	applymovement PLAYER, SnowtopMountainStopPanningMovement
	disappear SNOWTOPMOUNTAIN_PLAYER
	showtext SnowtopMountainWhatAViewText
	reloadmappart
	loadmem wPanningAroundTinyMap, FALSE
	end

.CompareXCoords:
	ld a, [wSavedXCoord]
	ld b, a
	ld a, [wXCoord]
	sub b
	ldh [hScriptVar], a
	ret

SnowtopMountainStartPanningMovement:
	hide_object
	slow_step_up
	step_end

SnowtopMountainStopPanningMovement:
	turn_head_up
	show_object
	step_end

SnowtopMountainOutlookText:
	text "I can see Olivine"
	line "City from here!"

	para "Want to look"
	line "around?"
	done

SnowtopMountainWhatAViewText:
	text "What a view!"
	done
