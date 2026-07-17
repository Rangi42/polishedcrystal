SnowtopMountainOutside_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_SNOWTOPMOUNTAINOUTSIDE_NOOP
	scene_const SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SnowtopMountainOutsideFlyPointAndFixFacing
	callback MAPCALLBACK_TILES, SnowtopMountainOutsideItemCallback

	def_warp_events
	warp_event  9, 25, SNOWTOP_MOUNTAIN_INSIDE, 2
	warp_event 17, 27, SNOWTOP_POKECENTER_1F, 1

	def_coord_events
	coord_event  4, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event  5, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event  6, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event  7, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event  8, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event  9, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 10, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 11, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 12, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 13, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 14, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 15, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 16, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 17, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 18, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 19, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 20, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 21, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 22, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 23, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 24, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 25, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript
	coord_event 26, 22, SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING, SnowtopMountainOutsideStopPanningScript

	def_bg_events
	bg_event 10, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 11, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 12, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 13, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 14, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 15, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 16, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 17, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 18, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 19, 21, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript

	def_object_events
	object_event -3, -3, SPRITE_MOM, SPRITEMOVEDATA_PLACEHOLDER_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 26,  9, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 0, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 16, 14, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 1, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 17,  9, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 14,  9, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 10,  9, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 13, 12, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  8, 14, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  6, 14, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  5,  4, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 4, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  5,  5, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 5, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  5,  6, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 6, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_const_def
	const SNOWTOPMOUNTAINOUTSIDE_PLAYER

SnowtopMountainOutsideFlyPointAndFixFacing:
	setflag ENGINE_FLYPOINT_SNOWTOP_MOUNTAIN
	callasm .FixFacing
	endcallback

.FixFacing:
	ld hl, wPrevWarp
	ld a, [hli]
	cp 2 ; warp #2 of SNOWTOP_MOUNTAIN_INSIDE comes here
	ret nz
	assert wPrevWarp + 1 == wPrevMapGroup
	ld a, [hli]
	cp GROUP_SNOWTOP_MOUNTAIN_INSIDE
	ret nz
	assert wPrevMapGroup + 1 == wPrevMapNumber
	ld a, [hl]
	cp MAP_SNOWTOP_MOUNTAIN_INSIDE
	ret nz
	ld a, [wPlayerSpriteSetupFlags]
	or (1 << 5) | UP
	ld [wPlayerSpriteSetupFlags], a
	ret

SnowtopMountainOutsideItemCallback:
	checkevent EVENT_OLIVINE_CITY_HIDDEN_RARE_CANDY
	iftruefwd .done
	changeblock 4, 8, $8b
.done
	endcallback

SnowtopMountainOutsideStartPanningScript:
	opentext
	writetext SnowtopMountainOutsideOutlookText
	yesorno
	iffalse_endtext
	closetext
	loadmem wPanningAroundTinyMap, TRUE
	changeblock 10, 22, $6f
	changeblock 12, 22, $6f
	changeblock 14, 22, $6f
	changeblock 16, 22, $6f
	changeblock 18, 22, $6f
	callasm .PreparePlayerSubstitute
	appear SNOWTOPMOUNTAINOUTSIDE_PLAYER
	applymovement PLAYER, SnowtopMountainOutsideStartPanningMovement
	setscene SCENE_SNOWTOPMOUNTAINOUTSIDE_PANNING
	callasm GenericFinishBridge
	end

.PreparePlayerSubstitute:
	farcall GetPlayerSpriteInA
	farcall LoadSpriteAsMapObject1
	ld a, [wXCoord]
	ld [wSavedXCoord], a
	add 4
	ld d, a
	ld a, [wYCoord]
	add 4
	ld e, a
	ld b, SNOWTOPMOUNTAINOUTSIDE_PLAYER
	farjp CopyDECoordsToMapObject

SnowtopMountainOutsideStopPanningScript:
	setscene SCENE_SNOWTOPMOUNTAINOUTSIDE_NOOP
.ContinueY
	callasm .CompareYCoord
	iffalsefwd .ContinueX
	applyonemovement PLAYER, step_down
	sjump .ContinueY
.ContinueX
	callasm .CompareXCoord
	iffalsefwd .Ready
	ifgreater $7f, .GoRight
	applyonemovement PLAYER, step_left
	sjump .ContinueX
.GoRight
	applyonemovement PLAYER, step_right
	sjump .ContinueX
.Ready
	changeblock 10, 22, $71
	changeblock 12, 22, $71
	changeblock 14, 22, $71
	changeblock 16, 22, $71
	changeblock 18, 22, $71
	applymovement PLAYER, SnowtopMountainOutsideStopPanningMovement
	disappear SNOWTOPMOUNTAINOUTSIDE_PLAYER
	showtext SnowtopMountainOutsideWhatAViewText
	refreshmap
	loadmem wPanningAroundTinyMap, FALSE
	end

.CompareYCoord:
	ld a, [wYCoord]
	sub 22
	ldh [hScriptVar], a
	ret

.CompareXCoord:
	ld a, [wSavedXCoord]
	ld b, a
	ld a, [wXCoord]
	sub b
	ldh [hScriptVar], a
	ret

SnowtopMountainOutsideStartPanningMovement:
	hide_object
	slow_step_up
	step_end

SnowtopMountainOutsideStopPanningMovement:
	turn_head_up
	show_object
	step_end

SnowtopMountainOutsideOutlookText:
	text "I can see Olivine"
	line "City from here!"

	para "Want to look"
	line "around?"
	done

SnowtopMountainOutsideWhatAViewText:
	text "What a view!"
	done
