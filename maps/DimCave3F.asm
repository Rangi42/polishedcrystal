DimCave3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_TILES, DimCave3FBouldersLand
	dbw MAPCALLBACK_CMDQUEUE, DimCave3FSetUpStoneTable

DimCave3F_MapEventHeader:

.Warps: db 6
	warp_def 5, 5, 4, DIM_CAVE_4F
	warp_def 22, 28, 5, DIM_CAVE_4F
	warp_def 10, 15, 6, DIM_CAVE_4F ; hole
	warp_def 5, 29, 2, DIM_CAVE_2F
	warp_def 25, 27, 3, DIM_CAVE_2F
	warp_def 21, 14, 4, DIM_CAVE_2F

.XYTriggers: db 0

.Signposts: db 2
	signpost 5, 2, SIGNPOST_ITEM + STAR_PIECE, EVENT_DIM_CAVE_3F_HIDDEN_STAR_PIECE
	signpost 6, 26, SIGNPOST_ITEM + ZINC, EVENT_DIM_CAVE_3F_HIDDEN_ZINC

.PersonEvents: db 9
	strengthboulder_event 17, 3, EVENT_BOULDER_IN_DIM_CAVE_3F
	person_event SPRITE_BOULDER_ROCK_FOSSIL, 8, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave3FFallenBoulderScript, EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
	person_event SPRITE_ENGINEER, 4, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerEngineerHugo, -1
	person_event SPRITE_BLACK_BELT, 11, 22, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 5, TrainerBlackbeltTakeo, -1
	person_event SPRITE_POKEFAN_M, 27, 10, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerHikerFloyd, -1
	person_event SPRITE_POKEFAN_M, 22, 25, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, DimCave3FPokefanmScript, -1
	itemball_event 3, 18, METAL_COAT, 1, EVENT_DIM_CAVE_3F_METAL_COAT
	itemball_event 29, 10, ESCAPE_ROPE, 1, EVENT_DIM_CAVE_3F_ESCAPE_ROPE
	tmhmball_event 9, 20, TM_REST, EVENT_DIM_CAVE_3F_TM_REST

const_value set 1
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
	trainer EVENT_BEAT_ENGINEER_HUGO, ENGINEER, HUGO, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_BLACKBELT_TAKEO, BLACKBELT_T, TAKEO, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_HIKER_FLOYD, HIKER, FLOYD, .SeenText, .BeatenText, 0, .Script

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
