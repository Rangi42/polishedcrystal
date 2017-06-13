const_value set 2

NavelRockOutside_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NavelRockOutside_MapEventHeader:
.Warps:
	db 3
	warp_def $19, $c, 1, SEAGALLOP_FERRY_NAVEL_GATE
	warp_def $19, $d, 1, SEAGALLOP_FERRY_NAVEL_GATE
	warp_def $f, $c, 1, NAVEL_ROCK_INSIDE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
