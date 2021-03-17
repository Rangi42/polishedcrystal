CeruleanPoliceStation_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 2
	warp_event  3,  7, CERULEAN_CITY, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanPoliceStationFishingGuruText, -1
	object_event  5,  4, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanPoliceStationPokefanFText, -1
	pokemon_event  3,  5, DIGLETT, -1, -1, PAL_NPC_BROWN, CeruleanDiglettText, -1

CeruleanPoliceStationFishingGuruText:
	text "I heard that some"
	line "shady character is"
	cont "skulking about."

	para "I won't stand for"
	line "it if he turns out"
	cont "to be a thief."
	done

CeruleanPoliceStationPokefanFText:
	text "We were held up by"
	line "robbers before."
	done

CeruleanDiglettText:
	text "Diglett: Dug dug."
	done
