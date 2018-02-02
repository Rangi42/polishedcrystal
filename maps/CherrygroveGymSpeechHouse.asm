CherrygroveGymSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CHERRYGROVE_CITY, 3
	warp_event  3,  7, CHERRYGROVE_CITY, 3

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x196aea, -1
	object_event  5,  5, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x196b65, -1

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
