LavenderNameRater_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 2, 7, 4, LAVENDER_TOWN
	warp_event 3, 7, 4, LAVENDER_TOWN

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 2, 3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LavenderNameRater, -1

LavenderNameRater:
	faceplayer
	opentext
	special SpecialNameRater
	waitendtext
