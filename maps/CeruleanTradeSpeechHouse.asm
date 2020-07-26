CeruleanTradeSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 3
	warp_event  3,  7, CERULEAN_CITY, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18814d, -1
	object_event  3,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18818a, -1
	pokemon_event  6,  2, POLIWRATH, -1, -1, PAL_NPC_BLUE, UnknownText_0x18819c, -1
	pokemon_event  5,  6, IVYSAUR, -1, -1, PAL_NPC_GREEN, UnknownText_0x1881b5, -1

UnknownText_0x18814d:
	text "My husband lives"
	line "happily with #-"
	cont "mon he got through"
	cont "trades."
	done

UnknownText_0x18818a:
	text "Ah… I'm so happy…"
	done

UnknownText_0x18819c:
	text "Poliwrath: Ribbit!"
	done

UnknownText_0x1881b5:
	text "Ivysaur: Sauur!"
	done
