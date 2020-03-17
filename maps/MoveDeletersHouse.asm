MoveDeletersHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, BLACKTHORN_CITY, 6
	warp_event  3,  7, BLACKTHORN_CITY, 6

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; object events
	object_event  2,  3, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MoveDeleterScript, -1

MoveDeleterScript:
	faceplayer
	opentext
	special MoveDeletion
	waitendtext
