CeruleanTradeSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 3
	warp_event  3,  7, CERULEAN_CITY, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanTradeSpeechHouseGrannyText, -1
	object_event  3,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanTradeSpeechHouseGrampsText, -1
	pokemon_event  6,  2, POLIWRATH, -1, -1, PAL_NPC_BLUE, CeruleanTradeSpeechHouseRhydonText, -1
	pokemon_event  5,  6, IVYSAUR, -1, -1, PAL_NPC_GREEN, CeruleanTradeSpeechHouseZubatText, -1

CeruleanTradeSpeechHouseGrannyText:
	text "My husband lives"
	line "happily with #-"
	cont "mon he got through"
	cont "trades."
	done

CeruleanTradeSpeechHouseGrampsText:
	text "Ah… I'm so happy…"
	done

CeruleanTradeSpeechHouseRhydonText:
	text "Poliwrath: Ribbit!"
	done

CeruleanTradeSpeechHouseZubatText:
	text "Ivysaur: Sauur!"
	done
