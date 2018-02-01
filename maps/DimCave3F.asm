DimCave3F_MapScriptHeader:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_TILES, DimCave3FBouldersLand
	callback MAPCALLBACK_CMDQUEUE, DimCave3FSetUpStoneTable

	db 6 ; warp events
	warp_event 5, 5, 4, DIM_CAVE_4F
	warp_event 28, 22, 5, DIM_CAVE_4F
	warp_event 15, 10, 6, DIM_CAVE_4F ; hole
	warp_event 29, 5, 2, DIM_CAVE_2F
	warp_event 27, 25, 3, DIM_CAVE_2F
	warp_event 14, 21, 4, DIM_CAVE_2F

	db 0 ; coord events

	db 2 ; bg events
	bg_event 2, 5, SIGNPOST_ITEM + STAR_PIECE, EVENT_DIM_CAVE_3F_HIDDEN_STAR_PIECE
	bg_event 26, 6, SIGNPOST_ITEM + ZINC, EVENT_DIM_CAVE_3F_HIDDEN_ZINC

	db 9 ; object events
	strengthboulder_event 3, 17, EVENT_BOULDER_IN_DIM_CAVE_3F
	object_event 15, 8, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave3FFallenBoulderScript, EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
	object_event 14, 4, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerEngineerHugo, -1
	object_event 22, 11, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 5, TrainerBlackbeltTakeo, -1
	object_event 10, 27, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerHikerFloyd, -1
	object_event 25, 22, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, DimCave3FPokefanmScript, -1
	itemball_event 18, 3, METAL_COAT, 1, EVENT_DIM_CAVE_3F_METAL_COAT
	itemball_event 10, 29, ESCAPE_ROPE, 1, EVENT_DIM_CAVE_3F_ESCAPE_ROPE
	tmhmball_event 20, 9, TM_REST, EVENT_DIM_CAVE_3F_TM_REST

	const_def 1 ; object constants
	const DIMCAVE3F_BOULDER

DimCave3FBouldersLand:
	checkevent EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
	iftrue .skip
	changeblock 14, 8, $c7
	changeblock 14, 26, $cf
.skip
	return

DimCave3FSetUpStoneTable:
	writecmdqueue .CommandQueue
	return

.CommandQueue:
	dbw CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.StoneTable:
	stonetable 6, DIMCAVE3F_BOULDER, .Boulder
	db -1 ; end

.Boulder:
	disappear DIMCAVE3F_BOULDER
	clearevent EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	pause 30
	playsound SFX_STRENGTH
	earthquake 80
	thistext

	text "The boulder fell"
	line "through."
	done

TrainerEngineerHugo:
	trainer ENGINEER, HUGO, EVENT_BEAT_ENGINEER_HUGO, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Cave-in!"
	done

.BeatenText:
	text "Oh, you just"
	line "pushed a boulder!"
	done

.AfterText:
	text "The noise of that"
	line "mine cart gave me"
	cont "a scare."

	para "You always have to"
	line "stay alert for a"
	cont "cave-in here."
	done

TrainerBlackbeltTakeo:
	trainer BLACKBELT_T, TAKEO, EVENT_BEAT_BLACKBELT_TAKEO, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "All I want is to"
	line "train in peace."
	done

TrainerHikerFloyd:
	trainer HIKER, FLOYD, EVENT_BEAT_HIKER_FLOYD, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "I am SO lost in"
	line "here!"

	para "I should stick to"
	line "hiking outdoors."
	done

DimCave3FPokefanmScript:
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iftrue .Yes
	jumpopenedtext .NoText

.Yes:
	jumpopenedtext .YesText

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

.NoText:
	text "What?! Do you"
	line "have a map?"
	done

DimCave3FFallenBoulderScript:
	thistext

	text "It's stuck on the"
	line "button."
	done
