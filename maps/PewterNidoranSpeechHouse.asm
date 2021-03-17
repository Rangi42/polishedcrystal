PewterNidoranSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, PEWTER_CITY, 1
	warp_event  3,  7, PEWTER_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  5, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterNidoranSpeechHouseSuperNerdText, -1
	pokemon_event  4,  5, NIDORAN_M, -1, -1, PAL_NPC_PURPLE, PewterNidoranText, -1

PewterNidoranSpeechHouseSuperNerdText:
	text "Nidoran, shake!"
	done

PewterNidoranText:
	text "Nidoran: Gau gau!"
	done
