SeafoamIslandsB2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SeafoamIslandsB2F_MapEventHeader:

.Warps: db 8
	warp_def 15, 25, 3, SEAFOAM_ISLANDS_B1F
	warp_def 7, 15, 4, SEAFOAM_ISLANDS_B1F
	warp_def 13, 13, 5, SEAFOAM_ISLANDS_B1F
	warp_def 15, 7, 6, SEAFOAM_ISLANDS_B1F
	warp_def 7, 35, 1, SEAFOAM_ISLANDS_B3F
	warp_def 9, 28, 2, SEAFOAM_ISLANDS_B3F
	warp_def 15, 35, 3, SEAFOAM_ISLANDS_B3F
	warp_def 13, 4, 4, SEAFOAM_ISLANDS_B3F

.XYTriggers: db 0

.Signposts: db 2
	signpost 9, 7, SIGNPOST_ITEM + PEARL, EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_1
	signpost 13, 35, SIGNPOST_ITEM + PEARL, EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_2

.PersonEvents: db 4
	person_event SPRITE_SKIER, 4, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSkierCady, -1
	person_event SPRITE_BOARDER, 5, 16, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderShaun, -1
	person_event SPRITE_BOARDER, 8, 25, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderBryce, -1
	itemball_event 16, 15, WATER_STONE, 1, EVENT_SEAFOAM_ISLANDS_B2F_WATER_STONE

TrainerSkierCady:
	trainer EVENT_BEAT_SKIER_CADY, SKIER, CADY, SkierCadySeenText, SkierCadyBeatenText, 0, SkierCadyScript

SkierCadyScript:
	end_if_just_battled
	jumptextfaceplayer SkierCadyAfterText

TrainerBoarderShaun:
	trainer EVENT_BEAT_BOARDER_SHAUN, BOARDER, SHAUN, BoarderShaunSeenText, BoarderShaunBeatenText, 0, BoarderShaunScript

BoarderShaunScript:
	end_if_just_battled
	jumptextfaceplayer BoarderShaunAfterText

TrainerBoarderBryce:
	trainer EVENT_BEAT_BOARDER_BRYCE, BOARDER, BRYCE, BoarderBryceSeenText, BoarderBryceBeatenText, 0, BoarderBryceScript

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
