SeafoamIslandsB2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 8 ; warp events
	warp_event 25, 15, SEAFOAM_ISLANDS_B1F, 3
	warp_event 15, 7, SEAFOAM_ISLANDS_B1F, 4
	warp_event 13, 13, SEAFOAM_ISLANDS_B1F, 5
	warp_event 7, 15, SEAFOAM_ISLANDS_B1F, 6
	warp_event 35, 7, SEAFOAM_ISLANDS_B3F, 1
	warp_event 28, 9, SEAFOAM_ISLANDS_B3F, 2
	warp_event 35, 15, SEAFOAM_ISLANDS_B3F, 3
	warp_event 4, 13, SEAFOAM_ISLANDS_B3F, 4

	db 0 ; coord events

	db 2 ; bg events
	bg_event 7, 9, SIGNPOST_ITEM + PEARL, EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_1
	bg_event 35, 13, SIGNPOST_ITEM + PEARL, EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_2

	db 4 ; object events
	object_event 11, 4, SPRITE_SKIER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSkierCady, -1
	object_event 16, 5, SPRITE_BOARDER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderShaun, -1
	object_event 25, 8, SPRITE_BOARDER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderBryce, -1
	itemball_event 15, 16, WATER_STONE, 1, EVENT_SEAFOAM_ISLANDS_B2F_WATER_STONE

TrainerSkierCady:
	trainer SKIER, CADY, EVENT_BEAT_SKIER_CADY, SkierCadySeenText, SkierCadyBeatenText, 0, SkierCadyScript

SkierCadyScript:
	end_if_just_battled
	jumptextfaceplayer SkierCadyAfterText

TrainerBoarderShaun:
	trainer BOARDER, SHAUN, EVENT_BEAT_BOARDER_SHAUN, BoarderShaunSeenText, BoarderShaunBeatenText, 0, BoarderShaunScript

BoarderShaunScript:
	end_if_just_battled
	jumptextfaceplayer BoarderShaunAfterText

TrainerBoarderBryce:
	trainer BOARDER, BRYCE, EVENT_BEAT_BOARDER_BRYCE, BoarderBryceSeenText, BoarderBryceBeatenText, 0, BoarderBryceScript

BoarderBryceScript:
	end_if_just_battled
	jumptextfaceplayer BoarderBryceAfterText

SkierCadySeenText:
	text "To beat the cold,"
	line "try warm clothes"
	cont "and a hot drink!"
	done

SkierCadyBeatenText:
	text "Argh, all the way"
	line "out here!"
	done

SkierCadyAfterText:
	text "That was a hot"
	line "battle!"
	done

BoarderShaunSeenText:
	text "Hey, hey, you're"
	line "in my way! Right!"
	done

BoarderShaunBeatenText:
	text "I got kicked"
	line "around…"
	done

BoarderShaunAfterText:
	text "All right, please"
	line "pass through!"
	done

BoarderBryceSeenText:
	text "What did you"
	line "come all the way"
	cont "out here for,"
	cont "I wonder."
	done

BoarderBryceBeatenText:
	text "I lost all the"
	line "way out here…"
	done

BoarderBryceAfterText:
	text "Trainers are"
	line "everywhere."
	done
