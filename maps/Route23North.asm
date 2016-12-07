Route23North_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

VictoryRoadSign:
	jumptext VictoryRoadSignText

VictoryRoadSignText:
	text "Victory Road"
	done

Route23North_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $1f, $4, 1, VICTORY_ROAD
	warp_def $1f, $e, 10, VICTORY_ROAD

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 32, 3, SIGNPOST_READ, VictoryRoadSign

.PersonEvents:
	db 0
