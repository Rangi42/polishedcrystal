CeruleanCoupleHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 10
	warp_event  3,  7, CERULEAN_CITY, 10

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanCoupleHousePokefanMText, -1
	object_event  2,  3, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanCoupleHousePokefanFText, -1

CeruleanCoupleHousePokefanMText:
	text "I first met my"
	line "dear wife in this"
	cont "city."

	para "Her eyes were a"
	line "deep cerulean…"
	done

CeruleanCoupleHousePokefanFText:
	text "The language of"
	line "love needs no"
	cont "translation."

	para "You'll under-"
	line "stand some day."
	done
