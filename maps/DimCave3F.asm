DimCave3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, DimCave3FBouldersLand
	callback MAPCALLBACK_STONETABLE, DimCave3FSetUpStoneTable

	def_warp_events
	warp_event  5,  5, DIM_CAVE_4F, 4
	warp_event 28, 22, DIM_CAVE_4F, 5
	warp_event 15, 10, DIM_CAVE_4F, 6 ; hole
	warp_event 29,  5, DIM_CAVE_2F, 2
	warp_event 27, 25, DIM_CAVE_2F, 3
	warp_event 14, 21, DIM_CAVE_2F, 4

	def_coord_events

	def_bg_events
	bg_event  2,  5, BGEVENT_ITEM + STAR_PIECE, EVENT_DIM_CAVE_3F_HIDDEN_STAR_PIECE
	bg_event 26,  6, BGEVENT_ITEM + ZINC, EVENT_DIM_CAVE_3F_HIDDEN_ZINC

	def_object_events
	strengthboulder_event  3, 17, EVENT_BOULDER_IN_DIM_CAVE_3F
	object_event 15,  8, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptext, DimCaveFallenBoulderText, EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
	object_event 14,  4, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerHugo, -1
	object_event 22, 11, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBlackbeltTakeo, -1
	object_event 10, 27, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerFloyd, -1
	object_event 25, 22, SPRITE_HIKER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DimCave3FPokefanmScript, -1
	itemball_event 18,  3, METAL_COAT, 1, EVENT_DIM_CAVE_3F_METAL_COAT
	itemball_event 10, 29, ESCAPE_ROPE, 1, EVENT_DIM_CAVE_3F_ESCAPE_ROPE
	tmhmball_event 20,  9, TM_REST, EVENT_DIM_CAVE_3F_TM_REST

	object_const_def
	const DIMCAVE3F_BOULDER

DimCave3FBouldersLand:
	checkevent EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
	iftrue .skip
	changeblock 14, 8, $c7
	changeblock 14, 26, $cf
.skip
	return

DimCave3FSetUpStoneTable:
	usestonetable .StoneTable
	return

.StoneTable:
	stonetable 6, DIMCAVE3F_BOULDER, .Boulder
	db -1 ; end

.Boulder:
	disappear DIMCAVE3F_BOULDER
	clearevent EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	pause 30
	playsound SFX_STRENGTH
	earthquake 80
	jumpthistext

	text "The boulder fell"
	line "through."
	done

GenericTrainerEngineerHugo:
	generictrainer ENGINEER, HUGO, EVENT_BEAT_ENGINEER_HUGO, .SeenText, .BeatenText

	text "The noise of that"
	line "mine cart gave me"
	cont "a scare."

	para "You always have to"
	line "stay alert for a"
	cont "cave-in here."
	done

.SeenText:
	text "Cave-in!"
	done

.BeatenText:
	text "Oh, you just"
	line "pushed a boulder!"
	done

GenericTrainerBlackbeltTakeo:
	generictrainer BLACKBELT_T, TAKEO, EVENT_BEAT_BLACKBELT_TAKEO, .SeenText, .BeatenText

	text "All I want is to"
	line "train in peace."
	done

.SeenText:
	text "I'm training here"
	line "alone with my"
	cont "#mon."

	para "Leave at once!"
	done

.BeatenText:
	text "Clearly I need"
	line "more training…"
	done

GenericTrainerHikerFloyd:
	generictrainer HIKER, FLOYD, EVENT_BEAT_HIKER_FLOYD, .SeenText, .BeatenText

	text "I am SO lost in"
	line "here!"

	para "I should stick to"
	line "hiking outdoors."
	done

.SeenText:
	text "This cave makes me"
	line "so ANGRY!"

	para "I'll battle to let"
	line "off some steam!"
	done

.BeatenText:
	text "I got beat down by"
	line "a kid!"
	done

DimCave3FPokefanmScript:
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iftrue_jumpopenedtext .YesText
	jumpthisopenedtext

	text "What?! Do you"
	line "have a map?"
	done

.QuestionText:
	text "Are you lost?"
	done

.YesText:
	text "Me too!"

	para "The Power Plant"
	line "messes with my"

	para "compass, and I"
	line "don't have a map."
	done
