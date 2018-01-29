CliffCave_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

CliffCave_MapEventHeader:
	db 7 ; warps
	warp_def 19, 5, 2, ROUTE_47
	warp_def 9, 7, 3, ROUTE_47
	warp_def 33, 5, 4, ROUTE_47
	warp_def 17, 3, 6, CLIFF_CAVE
	warp_def 17, 7, 7, CLIFF_CAVE
	warp_def 3, 3, 4, CLIFF_CAVE
	warp_def 27, 7, 5, CLIFF_CAVE

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 9, 9, SIGNPOST_ITEM + ULTRA_BALL, EVENT_CLIFF_CAVE_HIDDEN_ULTRA_BALL

	db 2 ; person events
	person_event SPRITE_ROCKET, 5, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM22, EVENT_CLEARED_YELLOW_FOREST
	person_event SPRITE_ROCKET, 33, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CliffCaveRocketText, EVENT_CLEARED_YELLOW_FOREST

TrainerGruntM22:
	trainer EVENT_BEAT_ROCKET_GRUNTM_22, GRUNTM, 22, GruntM22SeenText, GruntM22BeatenText, 0, GruntM22Script

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
