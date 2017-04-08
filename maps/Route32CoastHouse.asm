const_value set 2

Route32CoastHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route32CoastHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 2, ROUTE_32_COAST
	warp_def $7, $3, 2, ROUTE_32_COAST

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
