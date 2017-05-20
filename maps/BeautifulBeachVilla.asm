const_value set 2

BeautifulBeachVilla_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

BeautifulBeachVilla_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 3, BEAUTIFUL_BEACH
	warp_def $7, $3, 3, BEAUTIFUL_BEACH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
