const_value set 2

SeagallopFerryVermilionGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SeagallopFerryVermilionGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $0, $6, 11, VERMILION_CITY
	warp_def $5, $6, 2, SEAGALLOP_FERRY_NAVEL_GATE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
