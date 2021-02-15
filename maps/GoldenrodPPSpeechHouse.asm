GoldenrodPPSpeechHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 7
	warp_event  3,  7, GOLDENROD_CITY, 7

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPSTD, radio2

	def_object_events
	object_event  1,  4, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPPSpeechHouseFisherText, -1
	object_event  5,  3, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodPPSpeechHouseLassText, -1

GoldenrodPPSpeechHouseFisherText:
	text "Once while I was"
	line "battling, my"

	para "#mon couldn't"
	line "make any moves."

	para "The Power Points,"
	line "or PP, of its"

	para "moves were all"
	line "gone."
	done

GoldenrodPPSpeechHouseLassText:
	text "Sometimes, a"
	line "healthy #mon"

	para "may be unable to"
	line "use its moves."

	para "If that happens,"
	line "heal it at a #-"
	cont "mon Center or use"
	cont "an item."
	done
