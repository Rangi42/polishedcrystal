SnowtopMountainOutside_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_SNOWTOPMOUNTAINOUTSIDE_NOOP
	scene_const SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SnowtopMountainOutsideFlyPointAndFixFacing

	def_warp_events
	warp_event  9, 31, SNOWTOP_MOUNTAIN_INSIDE, 2
	warp_event 17, 33, SNOWTOP_POKECENTER_1F, 1

	def_coord_events
	coord_event  4, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event  5, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event  6, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event  7, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event  8, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event  9, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 10, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 11, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 12, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 13, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 14, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 15, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 16, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 17, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 18, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 19, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 20, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 21, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 22, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 23, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 24, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 25, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript
	coord_event 26, 28, SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE, SnowtopMountainOutsideStopPanningScript

	def_bg_events
	bg_event 10, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 11, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 12, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 13, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 14, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 15, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 16, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 17, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 18, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript
	bg_event 19, 27, BGEVENT_UP, SnowtopMountainOutsideStartPanningScript

	def_object_events
	object_event -3, -3, SPRITE_MOM, SPRITEMOVEDATA_PLACEHOLDER_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 26, 11, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 0, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 16, 16, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 1, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 17, 11, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 14, 11, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 11, 13, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 3, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 14, 14, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  8, 16, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  6, 16, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 2, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  5,  7, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 4, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  5,  8, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 5, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  5, 10, SPRITE_SAILBOAT, SPRITEMOVEDATA_TINY_WINDOWS, 0, 6, (1 << EVE) | (1 << NITE), PAL_NPC_TINY_WINDOW, OBJECTTYPE_SCRIPT, 0, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_const_def
	const SNOWTOPMOUNTAINOUTSIDE_PLAYER

SnowtopMountainOutsideFlyPointAndFixFacing:
	setflag ENGINE_FLYPOINT_SNOWTOP_MOUNTAIN
	callasm .FixFacing
	endcallback

.FixFacing:
	ld hl, wPrevWarp
	ld a, [hli]
	cp 2
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

SnowtopMountainOutsideStartPanningScript:
	opentext
	writetext SnowtopMountainOutsideOutlookText
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
	appear SNOWTOPMOUNTAINOUTSIDE_PLAYER
	applymovement PLAYER, SnowtopMountainOutsideStartPanningMovement
	setscene SCENE_SNOWTOPMOUNTAINOUTSIDE_SUICUNE
	callasm GenericFinishBridge
	end

.PreparePlayerSubstitute:
	ld a, [wPlayerGender]
	ld b, SPRITE_CHRIS
	and a ; PLAYER_MALE
	jr z, .got_gender
	ld b, SPRITE_KRIS
	dec a ; PLAYER_FEMALE
	jr z, .got_gender
	; PLAYER_ENBY
	ld b, SPRITE_CRYS
.got_gender
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .got_sprite
	assert SPRITE_CHRIS + 1 == SPRITE_CHRIS_BIKE
	assert SPRITE_KRIS + 1 == SPRITE_KRIS_BIKE
	assert SPRITE_CRYS + 1 == SPRITE_CRYS_BIKE
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
	changeblock 10, 28, $71
	changeblock 12, 28, $71
	changeblock 14, 28, $71
	changeblock 16, 28, $71
	changeblock 18, 28, $71
	applymovement PLAYER, SnowtopMountainOutsideStopPanningMovement
	disappear SNOWTOPMOUNTAINOUTSIDE_PLAYER
	showtext SnowtopMountainOutsideWhatAViewText
	refreshmap
	loadmem wPanningAroundTinyMap, FALSE
	end

.CompareYCoord:
	ld a, [wYCoord]
	sub 28
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
