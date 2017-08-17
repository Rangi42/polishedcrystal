ViridianForestViridianGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ViridianForestViridianGate_MapEventHeader:

.Warps: db 4
	warp_def 0, 4, 2, VIRIDIAN_FOREST
	warp_def 0, 5, 3, VIRIDIAN_FOREST
	warp_def 7, 4, 2, ROUTE_2_SOUTH
	warp_def 7, 5, 2, ROUTE_2_SOUTH

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianForestViridianGateOfficerText, -1

ViridianForestViridianGateOfficerText:
	text "Be careful,"
	line "Viridian Forest"

	para "is a natural"
	line "maze!"
	done
