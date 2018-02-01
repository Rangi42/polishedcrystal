ViridianForestPewterGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 4, 7, 1, VIRIDIAN_FOREST
	warp_event 5, 7, 1, VIRIDIAN_FOREST
	warp_event 4, 0, 5, ROUTE_2_NORTH
	warp_event 5, 0, 6, ROUTE_2_NORTH

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 0, 4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianForestPewterGateOfficerText, -1

ViridianForestPewterGateOfficerText:
	text "Are you headed"
	line "to Pewter City?"

	para "Be sure to check"
	line "out the Museum!"
	done
