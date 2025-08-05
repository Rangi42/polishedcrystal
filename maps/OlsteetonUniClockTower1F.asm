OlsteetonUniClockTower1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, OLSTEETON_UNI, 10
	warp_event  5,  7, OLSTEETON_UNI, 10
	warp_event  6,  0, OLSTEETON_UNI_CLOCK_TOWER_2F, 1

	def_coord_events

	def_bg_events
	bg_event  2,  5, BGEVENT_JUMPTEXT, OlsteetonUniClockTower1FStatueText
	bg_event  7,  5, BGEVENT_JUMPTEXT, OlsteetonUniClockTower1FStatueText

	def_object_events
	object_event  5,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClockTower1FTeacherText, -1
	itemball_event  1,  1, PARALYZEHEAL, 1, EVENT_SPROUT_TOWER1F_PARALYZEHEAL

	object_const_def


OlsteetonUniClockTower1FTeacherText:
	text "Here for the"
	line "Clock Tower"
	cont "Challenge?"

	para "Good luck..."
	line "See ya shortly,"
	cont "I'm sure."
	done

OlsteetonUniClockTower1FStatueText:
	text "The placard"
	line "displays a"
	cont "list of names."
	done
