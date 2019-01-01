IcePathB2FMahoganySide_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event 17,  1, ICE_PATH_B1F, 2
	warp_event  9, 11, ICE_PATH_B3F, 1
	warp_event 11,  4, ICE_PATH_B1F, 3
	warp_event  4,  6, ICE_PATH_B1F, 4
	warp_event  4, 12, ICE_PATH_B1F, 5
	warp_event 12, 12, ICE_PATH_B1F, 6

	db 0 ; coord events

	db 1 ; bg events
	bg_event  0, 17, SIGNPOST_ITEM + CARBOS, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_HIDDEN_CARBOS

	db 6 ; object events
	object_event 11,  3, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, BoulderText_0x7e5ad, EVENT_BOULDER_IN_ICE_PATH_1A
	object_event  4,  7, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, BoulderText_0x7e5ad, EVENT_BOULDER_IN_ICE_PATH_2A
	object_event  3, 12, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, BoulderText_0x7e5ad, EVENT_BOULDER_IN_ICE_PATH_3A
	object_event 12, 13, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, BoulderText_0x7e5ad, EVENT_BOULDER_IN_ICE_PATH_4A
	itemball_event  8,  9, FULL_HEAL, 1, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_FULL_HEAL
	itemball_event  0,  2, MAX_POTION, 1, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_MAX_POTION

BoulderText_0x7e5ad:
	text "It's immovably"
	line "imbedded in ice."
	done
