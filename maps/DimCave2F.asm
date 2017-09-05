DimCave2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, DimCave2FBouldersLand

DimCave2F_MapEventHeader:

.Warps: db 8
	warp_def 1, 15, 2, CERULEAN_CAPE
	warp_def 5, 29, 4, DIM_CAVE_3F
	warp_def 25, 27, 5, DIM_CAVE_3F
	warp_def 20, 14, 6, DIM_CAVE_3F ; hole
	warp_def 2, 30, 1, DIM_CAVE_1F
	warp_def 17, 5, 2, DIM_CAVE_1F
	warp_def 18, 28, 3, DIM_CAVE_1F
	warp_def 32, 26, 4, DIM_CAVE_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 4, 6, SIGNPOST_ITEM + STARDUST, EVENT_DIM_CAVE_2F_HIDDEN_STARDUST
	signpost 19, 2, SIGNPOST_ITEM + MOON_STONE, EVENT_DIM_CAVE_2F_HIDDEN_MOON_STONE

.PersonEvents: db 7
	person_event SPRITE_BOULDER_ROCK_FOSSIL, 21, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave2FFallenBoulderScript, EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	person_event SPRITE_ENGINEER, 12, 15, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerEngineerLang, -1
	person_event SPRITE_POKEFAN_M, 16, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerDerrick, -1
	itemball_event 12, 28, MAX_REVIVE, 1, EVENT_DIM_CAVE_2F_MAX_REVIVE
	itemball_event 15, 2, IRON, 1, EVENT_DIM_CAVE_2F_IRON
	itemball_event 18, 24, LIGHT_CLAY, 1, EVENT_DIM_CAVE_2F_LIGHT_CLAY
	tmhmball_event 33, 31, TM_FACADE, EVENT_DIM_CAVE_2F_TM_FACADE

DimCave2FBouldersLand:
	checkevent EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	iftrue .skip
	changeblock 14, 20, $c5
	changeblock 26, 20, $ba
.skip
	return

TrainerEngineerLang:
	trainer EVENT_BEAT_ENGINEER_LANG, ENGINEER, LANG, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "We mined ore from"
	line "this mountain to"

	para "refurbish the"
	line "Power Plant!"
	done

.BeatenText:
	text "A power failure!"
	done

.AfterText:
	text "Three years ago"
	line "the Power Plant"
	cont "was a wreck."

	para "We got it up and"
	line "running to power"

	para "the Magnet Train"
	line "to Johto."
	done

TrainerHikerDerrick:
	trainer EVENT_BEAT_HIKER_DERRICK, HIKER, DERRICK, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "It goes without"
	line "saying, but I love"

	para "hiking with my"
	line "#mon."
	done

DimCave2FFallenBoulderScript:
	thistext

	text "It's stuck on the"
	line "button."
	done
