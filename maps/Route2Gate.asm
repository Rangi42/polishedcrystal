Route2Gate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  4,  0, ROUTE_2_NORTH, 2
	warp_event  5,  0, ROUTE_2_NORTH, 3
	warp_event  4,  7, ROUTE_2_SOUTH, 1
	warp_event  5,  7, ROUTE_2_SOUTH, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  6,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9b955, -1

UnknownText_0x9b955:
	text "Are you <PLAYER>?"

	para "I work as Prof."
	line "Oak's Aide."

	para "I had no idea that"
	line "you were out here."

	para "Prof.Oak's Lab is"
	line "nearby in Pallet"
	cont "Town."
	done
