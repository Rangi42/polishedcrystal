ValenciaIsland_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 18, 19, IVYS_LAB, 1
	warp_event  5, 19, IVYS_HOUSE, 1
	warp_event  3, 11, VALENCIA_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  8, 12, BGEVENT_JUMPTEXT, ValenciaIslandSignText
	bg_event 11,  5, BGEVENT_JUMPTEXT, ValenciaIslandGoneFishingSignText
	bg_event 13,  5, BGEVENT_JUMPTEXT, ValenciaIslandLockedDoorText
	bg_event 15, 19, BGEVENT_JUMPTEXT, IvysLabSignText
	bg_event 13,  3, BGEVENT_JUMPTEXT, IvysHouseSignText

	def_object_events
	object_event  7,  8, SPRITE_COOL_DUDE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ValenciaIslandCooltrainermText, -1
	object_event 10, 18, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ValenciaIslandYoungsterScript, -1

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
	jumpthistextfaceplayer

	text "Prof.Ivy is"
	line "smokin' hot,"
	cont "don't you think?"
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
