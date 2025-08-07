OlsteetonUniGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, OLSTEETON, 23
	warp_event  0,  5, OLSTEETON, 24
	warp_event  9,  4, OLSTEETON_UNI, 1
	warp_event  9,  5, OLSTEETON_UNI, 2


	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, OlsteetonUniGateOfficerScript, -1
	pokemon_event  4,  2, SCYTHER, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_GREEN, OlsteetonUniGateScytherText, -1

OlsteetonUniGateOfficerScript:
	faceplayer
	opentext
	jumpopenedtext OlsteetonUniGateOfficerText1

OlsteetonUniGateOfficerText1:
	text "Oh, to be"
	line "a new student"
	cont "again..."

	para "Ah well,"
	line "at least I"

	para "can help keep"
	line "the campus safe."
	done

OlsteetonUniGateScytherText:
	text "ScyhtaSchythe!"
	done