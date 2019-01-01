ValenciaIsland_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 18, 19, IVYS_LAB, 1
	warp_event  5, 19, IVYS_HOUSE, 1
	warp_event  3, 11, VALENCIA_HOUSE, 1

	db 0 ; coord events

	db 5 ; bg events
	bg_event  8, 12, SIGNPOST_JUMPTEXT, ValenciaIslandSignText
	bg_event 11,  5, SIGNPOST_JUMPTEXT, ValenciaIslandGoneFishingSignText
	bg_event 13,  5, SIGNPOST_JUMPTEXT, ValenciaIslandLockedDoorText
	bg_event 15, 19, SIGNPOST_JUMPTEXT, IvysLabSignText
	bg_event 13,  3, SIGNPOST_JUMPTEXT, IvysHouseSignText

	db 2 ; object events
	object_event  7,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, ValenciaIslandCooltrainermText, -1
	object_event 10, 18, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ValenciaIslandYoungsterScript, -1

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
