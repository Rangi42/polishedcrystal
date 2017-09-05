IndigoPlateau_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, IndigoPlateauFlyPoint

IndigoPlateau_MapEventHeader:

.Warps: db 2
	warp_def 5, 9, 1, INDIGO_PLATEAU_POKECENTER_1F
	warp_def 5, 10, 2, INDIGO_PLATEAU_POKECENTER_1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 7, 11, SIGNPOST_JUMPTEXT, IndigoPlateauSignText

.PersonEvents: db 0

IndigoPlateauFlyPoint:
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	return

IndigoPlateauSignText:
	text "Indigo Plateau"

	para "The Ultimate Goal"
	line "for Trainers!"

	para "#mon League HQ"
	done
