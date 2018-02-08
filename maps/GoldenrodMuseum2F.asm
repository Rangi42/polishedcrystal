GoldenrodMuseum2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event 13,  7, GOLDENROD_MUSEUM_1F, 3

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 10,  3, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_ROCK, PERSONTYPE_COMMAND, jumptext, GoldenrodMuseum2FBigPearlText, -1

GoldenrodMuseum2FBigPearlText:
	text "It's a huge pearl"
	line "fished up from"
	cont "Goldenrod Harbor."
	done
