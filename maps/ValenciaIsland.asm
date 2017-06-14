const_value set 2

ValenciaIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ValenciaIslandCooltrainermScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

ValenciaIslandYoungsterScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

ValenciaIslandSign:
	habitatlist .Text, VALENCIA_ISLAND

.Text:
	text "Valencia Island"

	para "Bitter Oranges"
	line "and Sweet Breezes"
	done

ValenciaIslandGoneFishingSign:
	jumptext .Text

.Text:
	text "Gone Fishing"

	para "(On vacation"
	line "in Alola!)"
	done

ValenciaIslandLockedDoor:
	jumptext .Text

.Text:
	text "It's locked…"
	done

IvysLabSign:
	jumptext .Text

.Text:
	text "Ivy Research"
	line "№.2 Bayview"
	done

IvysHouseSign:
	jumptext .Text

.Text:
	text "Ivy's House"
	done

ValenciaIsland_MapEventHeader:
.Warps:
	db 3
	warp_def $13, $12, 1, IVYS_LAB
	warp_def $13, $5, 1, IVYS_HOUSE
	warp_def $b, $3, 1, VALENCIA_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 12, 8, SIGNPOST_READ, ValenciaIslandSign
	signpost 5, 11, SIGNPOST_READ, ValenciaIslandGoneFishingSign
	signpost 5, 13, SIGNPOST_READ, ValenciaIslandLockedDoor
	signpost 19, 15, SIGNPOST_READ, IvysLabSign
	signpost 3, 13, SIGNPOST_READ, IvysHouseSign

.PersonEvents:
	db 2
	person_event SPRITE_COOLTRAINER_M, 8, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ValenciaIslandCooltrainermScript, -1
	person_event SPRITE_YOUNGSTER, 18, 10, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ValenciaIslandYoungsterScript, -1
