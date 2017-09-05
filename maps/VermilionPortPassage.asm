VermilionPortPassage_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VermilionPortPassage_MapEventHeader:

.Warps: db 5
	warp_def 22, 3, 8, VERMILION_CITY
	warp_def 22, 4, 9, VERMILION_CITY
	warp_def 26, 3, 4, VERMILION_PORT_PASSAGE
	warp_def 2, 3, 3, VERMILION_PORT_PASSAGE
	warp_def 14, 3, 1, VERMILION_PORT

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_TEACHER, 23, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7701d, -1

UnknownText_0x7701d:
	text "The Fast Ship"
	line "sails on Wednes-"
	cont "days and Sundays"
	cont "every week."
	done
