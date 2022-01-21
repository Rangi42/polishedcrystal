IcePathB2FMahoganySide_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17,  1, ICE_PATH_B1F, 2
	warp_event  9, 11, ICE_PATH_B3F, 1
	warp_event 11,  4, ICE_PATH_B1F, 3
	warp_event  4,  6, ICE_PATH_B1F, 4
	warp_event  4, 12, ICE_PATH_B1F, 5
	warp_event 12, 12, ICE_PATH_B1F, 6

	def_coord_events

	def_bg_events
	bg_event  0, 17, BGEVENT_ITEM + CARBOS, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_HIDDEN_CARBOS

	def_object_events
	object_event 11,  3, SPRITE_ICE_BOULDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptext, IcePathB2FMahoganySideBoulderText, EVENT_BOULDER_IN_ICE_PATH_1A
	object_event  4,  7, SPRITE_ICE_BOULDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptext, IcePathB2FMahoganySideBoulderText, EVENT_BOULDER_IN_ICE_PATH_2A
	object_event  3, 12, SPRITE_ICE_BOULDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptext, IcePathB2FMahoganySideBoulderText, EVENT_BOULDER_IN_ICE_PATH_3A
	object_event 12, 13, SPRITE_ICE_BOULDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptext, IcePathB2FMahoganySideBoulderText, EVENT_BOULDER_IN_ICE_PATH_4A
	itemball_event  8,  9, ICE_STONE, 1, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_ICE_STONE
	itemball_event  0,  2, MAX_POTION, 1, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_MAX_POTION

IcePathB2FMahoganySideBoulderText:
	text "It's immovably"
	line "imbedded in ice."
	done
