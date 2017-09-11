Route5UndergroundEntrance_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route5UndergroundEntrance_MapEventHeader:

.Warps: db 3
	warp_def 7, 3, 1, ROUTE_5
	warp_def 7, 4, 1, ROUTE_5
	warp_def 4, 4, 1, UNDERGROUND

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_TEACHER, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18b558, -1

UnknownText_0x18b558:
	text "Many cities in"
	line "Johto have long"

	para "histories. I'd"
	line "love to visit!"
	done
