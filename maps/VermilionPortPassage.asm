VermilionPortPassage_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

VermilionPortPassage_MapEventHeader:
	db 5 ; warps
	warp_def 22, 3, 8, VERMILION_CITY
	warp_def 22, 4, 9, VERMILION_CITY
	warp_def 26, 3, 4, VERMILION_PORT_PASSAGE
	warp_def 2, 3, 3, VERMILION_PORT_PASSAGE
	warp_def 14, 3, 1, VERMILION_PORT

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_TEACHER, 23, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7701d, -1

UnknownText_0x7701d:
	text "The Fast Ship"
	line "sails on Wednes-"
	cont "days and Sundays"
	cont "every week."
	done
