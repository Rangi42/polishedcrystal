Route8SaffronGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route8SaffronGate_MapEventHeader:

.Warps: db 4
	warp_def 4, 0, 14, SAFFRON_CITY
	warp_def 5, 0, 15, SAFFRON_CITY
	warp_def 4, 9, 1, ROUTE_8
	warp_def 5, 9, 2, ROUTE_8

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7f419, -1

UnknownText_0x7f419:
	text "Have you been to"
	line "Lavender Town?"

	para "There's a tall"
	line "Radio Tower there."
	done
