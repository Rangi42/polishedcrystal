FuchsiaMart_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 1
	warp_event  3,  7, FUCHSIA_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_FUCHSIA
	object_event  3,  2, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaMartFisherText, -1
	object_event  7,  6, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaMartCooltrainerFText, -1

FuchsiaMartFisherText:
	text "I was hoping to"
	line "buy some Safari"

	para "Zone souvenirs,"
	line "but they're not"

	para "being sold any"
	line "more…"
	done

FuchsiaMartCooltrainerFText:
	text "The Safari Zone"
	line "Warden's grand-"
	cont "daughter lives in"
	cont "town."
	done
