const_value set 2
	const ROUTE16GATE_OFFICER

Route16Gate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route16GateOfficerScript:
	jumptextfaceplayer Route16GateOfficerText
	end

Route16GateOfficerText:
	text "…"
	done

Route16Gate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $4, $0, 4, ROUTE_16_NORTH
	warp_def $5, $0, 5, ROUTE_16_NORTH
	warp_def $4, $9, 6, ROUTE_16_NORTH
	warp_def $5, $9, 7, ROUTE_16_NORTH

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route16GateOfficerScript, -1
