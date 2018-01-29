GoldenrodNameRater_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

GoldenrodNameRater_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 8, GOLDENROD_CITY
	warp_def 7, 3, 8, GOLDENROD_CITY

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 1, 5, SIGNPOST_JUMPSTD, radio2
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; person events
	person_event SPRITE_GENTLEMAN, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GoldenrodNameRater, -1

GoldenrodNameRater:
	faceplayer
	opentext
	special SpecialNameRater
	waitendtext
