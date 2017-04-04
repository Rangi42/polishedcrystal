const_value set 2

Route16West_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route16WestCutTree:
	jumpstd cuttree

Route16West_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $1, $23, 1, PSYCHIC_INVERS_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
