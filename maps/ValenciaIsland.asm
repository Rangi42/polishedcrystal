ValenciaIsland_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ValenciaIsland_MapEventHeader:

.Warps: db 3
	warp_def 19, 18, 1, IVYS_LAB
	warp_def 19, 5, 1, IVYS_HOUSE
	warp_def 11, 3, 1, VALENCIA_HOUSE

.XYTriggers: db 0

.Signposts: db 5
	signpost 12, 8, SIGNPOST_JUMPTEXT, ValenciaIslandSignText
	signpost 5, 11, SIGNPOST_JUMPTEXT, ValenciaIslandGoneFishingSignText
	signpost 5, 13, SIGNPOST_JUMPTEXT, ValenciaIslandLockedDoorText
	signpost 19, 15, SIGNPOST_JUMPTEXT, IvysLabSignText
	signpost 3, 13, SIGNPOST_JUMPTEXT, IvysHouseSignText

.PersonEvents: db 2
	person_event SPRITE_COOLTRAINER_M, 8, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, ValenciaIslandCooltrainermText, -1
	person_event SPRITE_YOUNGSTER, 18, 10, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ValenciaIslandYoungsterScript, -1

ValenciaIslandCooltrainermText:
	text "A couple of strong"
	line "trainers live in"
	cont "that house."

	para "They're a mother"
	line "and her daughter…"
	cont "Or maybe her son?"

	para "Anyway, they're on"
	line "vacation now."
	done

ValenciaIslandYoungsterScript:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "Prof.Ivy is smokin'"
	line "hot, don't you"
	cont "think?"
	done

.Text2:
	text "You may be cute,"
	line "but Prof.Ivy is"
	cont "smokin' hot!"
	done

ValenciaIslandSignText:
	text "Valencia Island"

	para "Bitter Oranges"
	line "and Sweet Breezes"
	done

ValenciaIslandGoneFishingSignText:
	text "Gone Fishing"

	para "(On vacation"
	line "in Alola!)"
	done

ValenciaIslandLockedDoorText:
	text "It's locked…"
	done

IvysLabSignText:
	text "Ivy Research"
	line "№.2 Bayview"
	done

IvysHouseSignText:
	text "Ivy's House"
	done
