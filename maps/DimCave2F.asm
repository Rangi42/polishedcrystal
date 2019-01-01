DimCave2F_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, DimCave2FBouldersLand

	db 8 ; warp events
	warp_event 15,  1, CERULEAN_CAPE, 2
	warp_event 29,  5, DIM_CAVE_3F, 4
	warp_event 27, 25, DIM_CAVE_3F, 5
	warp_event 14, 20, DIM_CAVE_3F, 6 ; hole
	warp_event 30,  2, DIM_CAVE_1F, 1
	warp_event  5, 17, DIM_CAVE_1F, 2
	warp_event 28, 18, DIM_CAVE_1F, 3
	warp_event 26, 32, DIM_CAVE_1F, 4

	db 0 ; coord events

	db 2 ; bg events
	bg_event  6,  4, SIGNPOST_ITEM + STARDUST, EVENT_DIM_CAVE_2F_HIDDEN_STARDUST
	bg_event  2, 19, SIGNPOST_ITEM + MOON_STONE, EVENT_DIM_CAVE_2F_HIDDEN_MOON_STONE

	db 7 ; object events
	object_event 14, 21, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, DimCaveFallenBoulderText, EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	object_event 15, 12, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerEngineerLang, -1
	object_event  7, 16, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerHikerDerrick, -1
	itemball_event 28, 12, MAX_REVIVE, 1, EVENT_DIM_CAVE_2F_MAX_REVIVE
	itemball_event  2, 15, IRON, 1, EVENT_DIM_CAVE_2F_IRON
	itemball_event 24, 18, LIGHT_CLAY, 1, EVENT_DIM_CAVE_2F_LIGHT_CLAY
	tmhmball_event 31, 33, TM_FACADE, EVENT_DIM_CAVE_2F_TM_FACADE

DimCave2FBouldersLand:
	checkevent EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	iftrue .skip
	changeblock 14, 20, $c5
	changeblock 26, 20, $ba
.skip
	return

GenericTrainerEngineerLang:
	generictrainer ENGINEER, LANG, EVENT_BEAT_ENGINEER_LANG, .SeenText, .BeatenText

	text "Three years ago"
	line "the Power Plant"
	cont "was a wreck."

	para "We got it up and"
	line "running to power"

	para "the Magnet Train"
	line "to Johto."
	done

.SeenText:
	text "We mined ore from"
	line "this mountain to"

	para "refurbish the"
	line "Power Plant!"
	done

.BeatenText:
	text "A power failure!"
	done

GenericTrainerHikerDerrick:
	generictrainer HIKER, DERRICK, EVENT_BEAT_HIKER_DERRICK, .SeenText, .BeatenText

	text "It goes without"
	line "saying, but I love"

	para "hiking with my"
	line "#mon."
	done

.SeenText:
	text "♪ A-hiking we"
	line "will go, a-hiking"
	cont "we will go… ♪"
	done

.BeatenText:
	text "♪ Eee-iiii-ah-"
	line "dee-oh, a-hiking"
	cont "we will go! ♪"
	done

DimCaveFallenBoulderText:
	text "It's stuck on the"
	line "button."
	done
