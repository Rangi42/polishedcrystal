const_value set 2
	const MOVEDELETERSHOUSE_MOVE_DELETER
	const MOVEDELETERSHOUSE_MOVE_REMINDER

MoveDeletersHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MoveDeleterScript:
	faceplayer
	opentext
	special MoveDeletion
	waitbutton
	closetext
	end

MoveReminderScript:
	faceplayer
	opentext
	special MoveReminder
	waitbutton
	closetext
	end

MoveDeletersHouseBookshelf:
	jumpstd difficultbookshelf

MoveDeletersHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 6, BLACKTHORN_CITY
	warp_def $7, $3, 6, BLACKTHORN_CITY

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 7, SIGNPOST_READ, MoveDeletersHouseBookshelf

.PersonEvents:
	db 2
	person_event SPRITE_SUPER_NERD, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MoveDeleterScript, -1
	person_event SPRITE_HEX_MANIAC, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MoveReminderScript, -1
