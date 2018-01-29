MoveDeletersHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

MoveDeletersHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 6, BLACKTHORN_CITY
	warp_def 7, 3, 6, BLACKTHORN_CITY

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

	db 2 ; person events
	person_event SPRITE_SUPER_NERD, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MoveDeleterScript, -1
	person_event SPRITE_HEX_MANIAC, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MoveReminderScript, -1

MoveDeleterScript:
	faceplayer
	opentext
	special MoveDeletion
	waitendtext

MoveReminderScript:
	faceplayer
	opentext
	special MoveReminder
	waitendtext
