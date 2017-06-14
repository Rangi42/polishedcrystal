IndigoPlateau_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	return

IndigoPlateauSign:
	habitatlist IndigoPlateauSignText, INDIGO_PLATEAU

IndigoPlateauSignText:
	text "Indigo Plateau"

	para "The Ultimate Goal"
	line "for Trainers!"

	para "#mon League HQ"
	done

IndigoPlateau_MapEventHeader:
.Warps:
	db 2
	warp_def $5, $9, 1, INDIGO_PLATEAU_POKECENTER_1F
	warp_def $5, $a, 2, INDIGO_PLATEAU_POKECENTER_1F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 7, 11, SIGNPOST_READ, IndigoPlateauSign

.PersonEvents:
	db 0
