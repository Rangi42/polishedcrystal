const_value set 2
	const ROUTE16FUCHSIASPEECHHOUSE_SUPER_NERD

Route16FuchsiaSpeechHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SuperNerdScript_0x73373:
	jumptextfaceplayer UnknownText_0x73379

Route16FuchsiaSpeechHouseBookshelf:
	jumpstd picturebookshelf

UnknownText_0x73379:
	text "If you cruise down"
	line "Cycling Road, you"

	para "will end up in"
	line "Fuchsia City."
	done

Route16FuchsiaSpeechHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 1, ROUTE_16_NORTH
	warp_def $7, $3, 1, ROUTE_16_NORTH

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 7, SIGNPOST_READ, Route16FuchsiaSpeechHouseBookshelf

.PersonEvents:
	db 1
	person_event SPRITE_SUPER_NERD, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x73373, -1
