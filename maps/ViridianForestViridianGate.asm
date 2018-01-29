ViridianForestViridianGate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ViridianForestViridianGate_MapEventHeader:
	db 4 ; warps
	warp_def 0, 4, 2, VIRIDIAN_FOREST
	warp_def 0, 5, 3, VIRIDIAN_FOREST
	warp_def 7, 4, 2, ROUTE_2_SOUTH
	warp_def 7, 5, 2, ROUTE_2_SOUTH

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianForestViridianGateOfficerText, -1

ViridianForestViridianGateOfficerText:
	text "Be careful,"
	line "Viridian Forest"

	para "is a natural"
	line "maze!"
	done
