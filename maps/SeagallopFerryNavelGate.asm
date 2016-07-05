const_value set 2

SeagallopFerryNavelGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SeagallopFerryNavelGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $0, $6, 1, NAVEL_ROCK_OUTSIDE
	warp_def $5, $6, 2, SEAGALLOP_FERRY_VERMILION_GATE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
