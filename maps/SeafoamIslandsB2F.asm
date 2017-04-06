const_value set 2
	const SEAFOAMISLANDSB2F_SKIER
	const SEAFOAMISLANDSB2F_BOARDER1
	const SEAFOAMISLANDSB2F_BOARDER2
	const SEAFOAMISLANDSB2F_POKE_BALL

SeafoamIslandsB2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerSkierCady:
	trainer EVENT_BEAT_SKIER_CADY, SKIER, CADY, SkierCadySeenText, SkierCadyBeatenText, 0, SkierCadyScript

SkierCadyScript:
	end_if_just_battled
	opentext
	writetext SkierCadyAfterText
	waitbutton
	closetext
	end

TrainerBoarderShaun:
	trainer EVENT_BEAT_BOARDER_SHAUN, BOARDER, SHAUN, BoarderShaunSeenText, BoarderShaunBeatenText, 0, BoarderShaunScript

BoarderShaunScript:
	end_if_just_battled
	opentext
	writetext BoarderShaunAfterText
	waitbutton
	closetext
	end

TrainerBoarderBryce:
	trainer EVENT_BEAT_BOARDER_BRYCE, BOARDER, BRYCE, BoarderBryceSeenText, BoarderBryceBeatenText, 0, BoarderBryceScript

BoarderBryceScript:
	end_if_just_battled
	opentext
	writetext BoarderBryceAfterText
	waitbutton
	closetext
	end

SeafoamIslandsB2FWaterStone:
	itemball WATER_STONE

SeafoamIslandsB2FHiddenPearl1:
	dwb EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_1, PEARL

SeafoamIslandsB2FHiddenPearl2:
	dwb EVENT_SEAFOAM_ISLANDS_B2F_HIDDEN_PEARL_2, PEARL

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

SeafoamIslandsB2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 8
	warp_def $f, $19, 3, SEAFOAM_ISLANDS_B1F
	warp_def $7, $f, 4, SEAFOAM_ISLANDS_B1F
	warp_def $d, $d, 5, SEAFOAM_ISLANDS_B1F
	warp_def $f, $7, 6, SEAFOAM_ISLANDS_B1F
	warp_def $7, $23, 1, SEAFOAM_ISLANDS_B3F
	warp_def $9, $1c, 2, SEAFOAM_ISLANDS_B3F
	warp_def $f, $23, 3, SEAFOAM_ISLANDS_B3F
	warp_def $d, $4, 4, SEAFOAM_ISLANDS_B3F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 9, 7, SIGNPOST_ITEM, SeafoamIslandsB2FHiddenPearl1
	signpost 13, 35, SIGNPOST_ITEM, SeafoamIslandsB2FHiddenPearl2

.PersonEvents:
	db 4
	person_event SPRITE_SKIER, 4, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSkierCady, -1
	person_event SPRITE_BOARDER, 5, 16, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderShaun, -1
	person_event SPRITE_BOARDER, 8, 25, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderBryce, -1
	person_event SPRITE_BALL_CUT_FRUIT, 16, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SeafoamIslandsB2FWaterStone, EVENT_SEAFOAM_ISLANDS_B2F_WATER_STONE
