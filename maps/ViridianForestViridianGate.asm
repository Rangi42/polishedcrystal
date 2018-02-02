ViridianForestViridianGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  4,  0, VIRIDIAN_FOREST, 2
	warp_event  5,  0, VIRIDIAN_FOREST, 3
	warp_event  4,  7, ROUTE_2_SOUTH, 2
	warp_event  5,  7, ROUTE_2_SOUTH, 2

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianForestViridianGateOfficerText, -1

ViridianForestViridianGateOfficerText:
	text "Be careful,"
	line "Viridian Forest"

	para "is a natural"
	line "maze!"
	done
