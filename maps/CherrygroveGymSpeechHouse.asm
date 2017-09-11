CherrygroveGymSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CherrygroveGymSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, CHERRYGROVE_CITY
	warp_def 7, 3, 3, CHERRYGROVE_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_POKEFAN_M, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x196aea, -1
	person_event SPRITE_CHILD, 5, 5, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x196b65, -1

UnknownText_0x196aea:
	text "You're trying to"
	line "see how good you"

	para "are as a #mon"
	line "trainer?"

	para "You better visit"
	line "the #mon Gyms"

	para "all over Johto and"
	line "collect Badges."
	done

UnknownText_0x196b65:
	text "When I get older,"
	line "I'm going to be a"
	cont "Gym Leader!"

	para "I make my #mon"
	line "battle with my"

	para "friend's to make"
	line "them tougher!"
	done
