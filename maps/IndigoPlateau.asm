IndigoPlateau_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, IndigoPlateauFlyPoint

	db 2 ; warp events
	warp_event  9,  5, INDIGO_PLATEAU_POKECENTER_1F, 1
	warp_event 10,  5, INDIGO_PLATEAU_POKECENTER_1F, 2

	db 0 ; coord events

	db 1 ; bg events
	bg_event 11,  7, SIGNPOST_JUMPTEXT, IndigoPlateauSignText

	db 0 ; object events

IndigoPlateauFlyPoint:
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	return

IndigoPlateauSignText:
	text "Indigo Plateau"

	para "The Ultimate Goal"
	line "for Trainers!"

	para "#mon League HQ"
	done
