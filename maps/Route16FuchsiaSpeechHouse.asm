Route16FuchsiaSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route16FuchsiaSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 1, ROUTE_16_NORTHWEST
	warp_def 7, 3, 1, ROUTE_16_NORTHWEST

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 7, SIGNPOST_JUMPSTD, picturebookshelf

.PersonEvents: db 2
	person_event SPRITE_SUPER_NERD, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x73379, -1
	person_event SPRITE_LADY, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route16FuchsiaSpeechHouseLadyText, -1

UnknownText_0x73379:
	text "If you cruise down"
	line "Cycling Road, you"

	para "will end up in"
	line "Fuchsia City."
	done

Route16FuchsiaSpeechHouseLadyText:
	text "The person who"
	line "used to live here"

	para "moved away three"
	line "years ago."

	para "I wonder where"
	line "she went?"
	done
