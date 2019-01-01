SeafoamIslandsB2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 8 ; warp events
	warp_event 25, 15, SEAFOAM_ISLANDS_B1F, 3
	warp_event 15,  7, SEAFOAM_ISLANDS_B1F, 4
	warp_event 13, 13, SEAFOAM_ISLANDS_B1F, 5
	warp_event  7, 15, SEAFOAM_ISLANDS_B1F, 6
	warp_event 35,  7, SEAFOAM_ISLANDS_B3F, 1
	warp_event 28,  9, SEAFOAM_ISLANDS_B3F, 2
	warp_event 35, 15, SEAFOAM_ISLANDS_B3F, 3
	warp_event  4, 13, SEAFOAM_ISLANDS_B3F, 4

	db 0 ; coord events

	db 2 ; bg events
	bg_event  7,  9, SIGNPOST_ITEM + PEARL, EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_1
	bg_event 35, 13, SIGNPOST_ITEM + PEARL, EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_2

	db 4 ; object events
	object_event 11,  4, SPRITE_SKIER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerSkierCady, -1
	object_event 16,  5, SPRITE_BOARDER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerBoarderShaun, -1
	object_event 25,  8, SPRITE_BOARDER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerBoarderBryce, -1
	itemball_event 15, 16, WATER_STONE, 1, EVENT_SEAFOAM_ISLANDS_B2F_WATER_STONE

GenericTrainerSkierCady:
	generictrainer SKIER, CADY, EVENT_BEAT_SKIER_CADY, SkierCadySeenText, SkierCadyBeatenText

	text "That was a hot"
	line "battle!"
	done

GenericTrainerBoarderShaun:
	generictrainer BOARDER, SHAUN, EVENT_BEAT_BOARDER_SHAUN, BoarderShaunSeenText, BoarderShaunBeatenText

	text "All right, please"
	line "pass through!"
	done

GenericTrainerBoarderBryce:
	generictrainer BOARDER, BRYCE, EVENT_BEAT_BOARDER_BRYCE, BoarderBryceSeenText, BoarderBryceBeatenText

	text "Trainers are"
	line "everywhere."
	done

SkierCadySeenText:
	text "To beat the cold,"
	line "try warm clothes"
	cont "and a hot drink!"
	done

SkierCadyBeatenText:
	text "Argh, all the way"
	line "out here!"
	done

BoarderShaunSeenText:
	text "Hey, hey, you're"
	line "in my way! Right!"
	done

BoarderShaunBeatenText:
	text "I got kicked"
	line "around…"
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

