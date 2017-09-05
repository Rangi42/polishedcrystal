Route15FuchsiaGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route15FuchsiaGate_MapEventHeader:

.Warps: db 5
	warp_def 5, 0, 7, FUCHSIA_CITY
	warp_def 6, 0, 8, FUCHSIA_CITY
	warp_def 5, 9, 1, ROUTE_15
	warp_def 6, 9, 2, ROUTE_15
	warp_def 8, 8, 1, ROUTE_15_FUCHSIA_GATE_2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1967a1, -1

UnknownText_0x1967a1:
	text "You're working on"
	line "a #dex? That's"

	para "really something."
	line "Don't give up!"
	done
