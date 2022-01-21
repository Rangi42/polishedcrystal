MountMoonSquare_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, UnknownScript_0x77093
	callback MAPCALLBACK_OBJECTS, UnknownScript_0x77097

	def_warp_events
	warp_event 21, 11, ROUTE_4, 2
	warp_event 13,  7, MOUNT_MOON_GIFT_SHOP, 1

	def_coord_events
	coord_event  7, 11, 0, ClefairyDance

	def_bg_events
	bg_event  7,  7, BGEVENT_ITEM + MOON_STONE, EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	bg_event 17,  7, BGEVENT_JUMPTEXT, DontLitterSignText

	def_object_events
	object_event  6,  6, SPRITE_CLEFAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_SQUARE_CLEFAIRY
	object_event  7,  6, SPRITE_CLEFAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_SQUARE_CLEFAIRY
	object_event  7,  7, SPRITE_N64, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_COMMAND, jumpstd, smashrock, 0, EVENT_MT_MOON_SQUARE_ROCK

	object_const_def
	const MOUNTMOONSQUARE_CLEFAIRY1
	const MOUNTMOONSQUARE_CLEFAIRY2
	const MOUNTMOONSQUARE_ROCK

UnknownScript_0x77093:
	setevent EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	endcallback

UnknownScript_0x77097:
	disappear MOUNTMOONSQUARE_ROCK
	endcallback

ClefairyDance:
	checkflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
	iftrue DoNothingScript
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, DoNothingScript
	checktime 1 << NITE
	iffalse DoNothingScript
	appear MOUNTMOONSQUARE_CLEFAIRY1
	appear MOUNTMOONSQUARE_CLEFAIRY2
	applyonemovement PLAYER, step_up
	pause 15
	appear MOUNTMOONSQUARE_ROCK
	turnobject MOUNTMOONSQUARE_CLEFAIRY1, RIGHT
	cry CLEFAIRY
	waitsfx
	pause 30
	follow MOUNTMOONSQUARE_CLEFAIRY1, MOUNTMOONSQUARE_CLEFAIRY2
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_CLEFAIRY1, ClefairyDanceStep1
	cry CLEFAIRY
	applyonemovement MOUNTMOONSQUARE_CLEFAIRY1, slow_jump_step_right
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_CLEFAIRY1, ClefairyDanceStep3
	cry CLEFAIRY
	applyonemovement MOUNTMOONSQUARE_CLEFAIRY1, slow_jump_step_left
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_CLEFAIRY1, ClefairyDanceStep1
	stopfollow
	applyonemovement MOUNTMOONSQUARE_CLEFAIRY2, slow_step_down
	follow MOUNTMOONSQUARE_CLEFAIRY1, MOUNTMOONSQUARE_CLEFAIRY2
	applyonemovement MOUNTMOONSQUARE_CLEFAIRY1, slow_step_right
	stopfollow
	turnobject MOUNTMOONSQUARE_CLEFAIRY1, DOWN
	pause 10
	showemote EMOTE_SHOCK, MOUNTMOONSQUARE_CLEFAIRY1, 15
	turnobject MOUNTMOONSQUARE_CLEFAIRY1, DOWN
	cry CLEFAIRY
	pause 15
	follow MOUNTMOONSQUARE_CLEFAIRY1, MOUNTMOONSQUARE_CLEFAIRY2
	applymovement MOUNTMOONSQUARE_CLEFAIRY1, ClefairyFleeMovement
	disappear MOUNTMOONSQUARE_CLEFAIRY1
	disappear MOUNTMOONSQUARE_CLEFAIRY2
	stopfollow
	clearevent EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	setflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
	end

ClefairyDanceStep1:
	slow_step_down
	slow_jump_step_down
	step_end

ClefairyDanceStep3:
	slow_step_up
	slow_jump_step_up
	step_end

ClefairyFleeMovement:
	step_right
	step_right
	step_right
	jump_step_right
	step_right
	step_right
	step_end

DontLitterSignText:
	text "Mt.Moon Square"
	line "Don't Litter"
	done
