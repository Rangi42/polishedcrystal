GoldenrodNameRater_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, GOLDENROD_CITY, 8
	warp_event  3,  7, GOLDENROD_CITY, 8

	db 0 ; coord events

	db 2 ; bg events
	bg_event  5,  1, SIGNPOST_JUMPSTD, radio2
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; object events
	object_event  2,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GoldenrodNameRater, -1

GoldenrodNameRater:
	faceplayer
	opentext
	special SpecialNameRater
	waitendtext
