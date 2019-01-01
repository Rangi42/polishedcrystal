GoldenrodMuseum1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  6,  7, GOLDENROD_CITY, 18
	warp_event  7,  7, GOLDENROD_CITY, 18
	warp_event 13,  7, GOLDENROD_MUSEUM_2F, 1

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  1,  2, SPRITE_SLOWPOKETAIL, SPRITEMOVEDATA_ARCH_TREE_DOWN, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
	object_event  2,  2, SPRITE_SLOWPOKETAIL, SPRITEMOVEDATA_ARCH_TREE_UP, 0, 0, -1, -1, PAL_NPC_TREE, PERSONTYPE_COMMAND, end, NULL, -1
