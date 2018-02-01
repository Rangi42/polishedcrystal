Route1ViridianGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 4, 0, 6, VIRIDIAN_CITY
	warp_event 5, 0, 7, VIRIDIAN_CITY
	warp_event 4, 7, 1, ROUTE_1
	warp_event 5, 7, 1, ROUTE_1

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event 0, 4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route1ViridianGateOfficerText, -1
	object_event 6, 4, SPRITE_ROCKER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, Route1ViridianGateRockerText, -1

Route1ViridianGateOfficerText:
	text "To the south is"
	line "Pallet Town."

	para "That's where"
	line "Prof.Oak lives."
	done

Route1ViridianGateRockerText:
	text "If you really"
	line "think about it,"

	para "aren't we ALL on"
	line "the road to Vir-"
	cont "idian City?"
	done
