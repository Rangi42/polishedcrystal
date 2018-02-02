VermilionPortPassage_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event  3, 22, VERMILION_CITY, 8
	warp_event  4, 22, VERMILION_CITY, 9
	warp_event  3, 26, VERMILION_PORT_PASSAGE, 4
	warp_event  3,  2, VERMILION_PORT_PASSAGE, 3
	warp_event  3, 14, VERMILION_PORT, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5, 23, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7701d, -1

UnknownText_0x7701d:
	text "The Fast Ship"
	line "sails on Wednes-"
	cont "days and Sundays"
	cont "every week."
	done
