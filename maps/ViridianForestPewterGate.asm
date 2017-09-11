ViridianForestPewterGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ViridianForestPewterGate_MapEventHeader:

.Warps: db 4
	warp_def 7, 4, 1, VIRIDIAN_FOREST
	warp_def 7, 5, 1, VIRIDIAN_FOREST
	warp_def 0, 4, 5, ROUTE_2_NORTH
	warp_def 0, 5, 6, ROUTE_2_NORTH

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianForestPewterGateOfficerText, -1

ViridianForestPewterGateOfficerText:
	text "Are you headed"
	line "to Pewter City?"

	para "Be sure to check"
	line "out the Museum!"
	done
