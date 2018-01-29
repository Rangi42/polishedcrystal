IndigoPlateau_MapScriptHeader:
	db 0 ; map triggers

	db 1 ; map callbacks
	dbw MAPCALLBACK_NEWMAP, IndigoPlateauFlyPoint

IndigoPlateau_MapEventHeader:
	db 2 ; warps
	warp_def 5, 9, 1, INDIGO_PLATEAU_POKECENTER_1F
	warp_def 5, 10, 2, INDIGO_PLATEAU_POKECENTER_1F

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 7, 11, SIGNPOST_JUMPTEXT, IndigoPlateauSignText

	db 0 ; person events

IndigoPlateauFlyPoint:
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	return

IndigoPlateauSignText:
	text "Indigo Plateau"

	para "The Ultimate Goal"
	line "for Trainers!"

	para "#mon League HQ"
	done
