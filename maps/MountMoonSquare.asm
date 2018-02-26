MountMoonSquare_MapScriptHeader:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, UnknownScript_0x77093
	callback MAPCALLBACK_OBJECTS, UnknownScript_0x77097

	db 2 ; warp events
	warp_event 21, 11, ROUTE_4, 2
	warp_event 13,  7, MOUNT_MOON_GIFT_SHOP, 1

	db 1 ; coord events
	coord_event  7, 11, 0, ClefairyDance

	db 2 ; bg events
	bg_event  7,  7, SIGNPOST_ITEM + MOON_STONE, EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	bg_event 17,  7, SIGNPOST_JUMPTEXT, DontLitterSignText

	db 3 ; object events
	object_event  6,  6, SPRITE_CLEFAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_SQUARE_CLEFAIRY
	object_event  7,  6, SPRITE_CLEFAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_SQUARE_CLEFAIRY
	object_event  7,  7, SPRITE_N64, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, PAL_NPC_ROCK, PERSONTYPE_COMMAND, jumpstd, smashrock, 0, EVENT_MT_MOON_SQUARE_ROCK

	const_def 1 ; object constants
	const MOUNTMOONSQUARE_CLEFAIRY1
	const MOUNTMOONSQUARE_CLEFAIRY2
	const MOUNTMOONSQUARE_ROCK

UnknownScript_0x77093:
	setevent EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	return

UnknownScript_0x77097:
	disappear MOUNTMOONSQUARE_ROCK
	return

ClefairyDance:
	checkflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
	iftrue .NoDancing
	checkcode VAR_WEEKDAY
	ifnotequal MONDAY, .NoDancing
	checktime 1 << NITE
	iffalse .NoDancing
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
	applymovement MOUNTMOONSQUARE_CLEFAIRY1, MovementData_0x77123
	cry CLEFAIRY
	applyonemovement MOUNTMOONSQUARE_CLEFAIRY1, slow_jump_step_right
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_CLEFAIRY1, MovementData_0x77128
	cry CLEFAIRY
	applyonemovement MOUNTMOONSQUARE_CLEFAIRY1, slow_jump_step_left
	cry CLEFAIRY
	applymovement MOUNTMOONSQUARE_CLEFAIRY1, MovementData_0x77123
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
	applymovement MOUNTMOONSQUARE_CLEFAIRY1, MovementData_0x77134
	disappear MOUNTMOONSQUARE_CLEFAIRY1
	disappear MOUNTMOONSQUARE_CLEFAIRY2
	stopfollow
	clearevent EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE
	setflag ENGINE_MT_MOON_SQUARE_CLEFAIRY
.NoDancing:
	end

MovementData_0x77123:
	slow_step_down
	slow_jump_step_down
	step_end

MovementData_0x77128:
	slow_step_up
	slow_jump_step_up
	step_end

MovementData_0x77134:
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
