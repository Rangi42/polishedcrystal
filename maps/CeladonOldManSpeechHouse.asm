CeladonOldManSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CELADON_CITY, 15
	warp_event  3,  7, CELADON_CITY, 15

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonOldManSpeechHouseGrampsText, -1
	object_event  5,  4, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonOldManSpeechHouseLadyText, -1

CeladonOldManSpeechHouseGrampsText:
	text "Whashat?"
	line "#-mon?"
	cont "Never heard of it."
	done

CeladonOldManSpeechHouseLadyText:
	text "I'm sorry about"
	line "my grandpa."

	para "Age hasn't been"
	line "kind to him."
	done
