Route12Gate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route12Gate_MapEventHeader:

.Warps: db 5
	warp_def 0, 4, 1, ROUTE_12_NORTH
	warp_def 0, 5, 2, ROUTE_12_NORTH
	warp_def 9, 4, 4, ROUTE_12_SOUTH
	warp_def 9, 5, 4, ROUTE_12_SOUTH
	warp_def 8, 8, 1, ROUTE_12_GATE_2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 5, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route12GateOfficerText, -1

Route12GateOfficerText:
	text "Silence Bridge got"
	line "its name from all"

	para "the people quietly"
	line "fishing on it."
	done
