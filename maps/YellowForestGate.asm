const_value set 2
	const YELLOWFORESTGATE_OFFICER

YellowForestGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

YellowForestGateOfficerScript:
	jumptextfaceplayer YellowForestGateOfficerText

YellowForestGateOfficerText:
	text "There are rare"
	line "#mon in"
	cont "Yellow Forest!"
	
	para "Don't forget to"
	line "bring # Balls!"
	done

YellowForestGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $0, $4, 1, YELLOW_FOREST
	warp_def $0, $5, 2, YELLOW_FOREST
	warp_def $7, $4, 1, ROUTE_48
	warp_def $7, $5, 1, ROUTE_48

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, YellowForestGateOfficerScript, -1
