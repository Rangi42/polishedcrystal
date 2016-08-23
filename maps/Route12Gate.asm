const_value set 2
	const ROUTE12GATE_OFFICER

Route12Gate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route12GateOfficerScript:
	jumptextfaceplayer Route12GateOfficerText

Route12GateOfficerText:
	text "Silence Bridge got"
	line "its name from all"

	para "the people quietly"
	line "fishing on it."
	done

Route12Gate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $0, $4, 4, ROUTE_12
	warp_def $0, $5, 5, ROUTE_12
	warp_def $7, $4, 6, ROUTE_12
	warp_def $7, $5, 6, ROUTE_12

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route12GateOfficerScript, -1
