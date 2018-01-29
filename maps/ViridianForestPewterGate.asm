ViridianForestPewterGate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

ViridianForestPewterGate_MapEventHeader:
	db 4 ; warps
	warp_def 7, 4, 1, VIRIDIAN_FOREST
	warp_def 7, 5, 1, VIRIDIAN_FOREST
	warp_def 0, 4, 5, ROUTE_2_NORTH
	warp_def 0, 5, 6, ROUTE_2_NORTH

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianForestPewterGateOfficerText, -1

ViridianForestPewterGateOfficerText:
	text "Are you headed"
	line "to Pewter City?"

	para "Be sure to check"
	line "out the Museum!"
	done
