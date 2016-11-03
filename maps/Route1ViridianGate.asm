const_value set 2
	const ROUTE1VIRIDIANGATE_OFFICER

Route1ViridianGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route1ViridianGateOfficerScript:
	jumptextfaceplayer Route1ViridianGateOfficerText

Route1ViridianGateOfficerText:
	text "To the south is"
	line "Pallet Town."

	para "That's where"
	line "Prof.Oak lives."
	done

Route1ViridianGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $0, $4, 6, VIRIDIAN_CITY
	warp_def $0, $5, 7, VIRIDIAN_CITY
	warp_def $7, $4, 1, ROUTE_1
	warp_def $7, $5, 1, ROUTE_1

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route1ViridianGateOfficerScript, -1
