CliffCave_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 7 ; warp events
	warp_event 5, 19, 2, ROUTE_47
	warp_event 7, 9, 3, ROUTE_47
	warp_event 5, 33, 4, ROUTE_47
	warp_event 3, 17, 6, CLIFF_CAVE
	warp_event 7, 17, 7, CLIFF_CAVE
	warp_event 3, 3, 4, CLIFF_CAVE
	warp_event 7, 27, 5, CLIFF_CAVE

	db 0 ; coord events

	db 1 ; bg events
	bg_event 9, 9, SIGNPOST_ITEM + ULTRA_BALL, EVENT_CLIFF_CAVE_HIDDEN_ULTRA_BALL

	db 2 ; object events
	object_event 9, 5, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM22, EVENT_CLEARED_YELLOW_FOREST
	object_event 5, 33, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CliffCaveRocketText, EVENT_CLEARED_YELLOW_FOREST

TrainerGruntM22:
	trainer GRUNTM, 22, EVENT_BEAT_ROCKET_GRUNTM_22, GruntM22SeenText, GruntM22BeatenText, 0, GruntM22Script

GruntM22Script:
	end_if_just_battled
	jumptextfaceplayer GruntM22AfterText

GruntM22SeenText:
	text "Hey! You got past"
	line "the guards!"
	done

GruntM22BeatenText:
	text "Aieee!"
	done

GruntM22AfterText:
	text "No wonder you"
	line "were able to"
	cont "reach here."
	done

CliffCaveRocketText:
	text "Don't just wander"
	line "around during a"
	cont "Team Rocket"
	cont "operation!"
	done
