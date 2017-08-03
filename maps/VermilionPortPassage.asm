VermilionPortPassage_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VermilionPortPassage_MapEventHeader:

.Warps: db 5
	warp_def $16, $3, 8, VERMILION_CITY
	warp_def $16, $4, 9, VERMILION_CITY
	warp_def $1a, $3, 4, VERMILION_PORT_PASSAGE
	warp_def $2, $3, 3, VERMILION_PORT_PASSAGE
	warp_def $e, $3, 1, VERMILION_PORT

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_TEACHER, 23, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, TeacherScript_0x7701a, -1

TeacherScript_0x7701a:
	jumptextfaceplayer UnknownText_0x7701d

UnknownText_0x7701d:
	text "The Fast Ship"
	line "sails on Wednes-"
	cont "days and Sundays"
	cont "every week."
	done
