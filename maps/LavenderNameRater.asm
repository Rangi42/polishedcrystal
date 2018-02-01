LavenderNameRater_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 4, LAVENDER_TOWN
	warp_def 7, 3, 4, LAVENDER_TOWN

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_GENTLEMAN, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LavenderNameRater, -1

LavenderNameRater:
	faceplayer
	opentext
	special SpecialNameRater
	waitendtext
