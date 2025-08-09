OlsteetonUni_MapScriptHeader:
	def_scene_scripts

	def_callbacks


	def_warp_events
	warp_event  6, 12, OLSTEETON_UNI_GATE, 3
	warp_event  6, 13, OLSTEETON_UNI_GATE, 4
	warp_event  8,  9, OLSTEETON_UNI_LIBRARY_1F, 2
	warp_event 19,  9, OLSTEETON_UNI_SCIENCE_CENTER, 1
	warp_event 13, 20, OLSTEETON_UNI_OFFICE, 1
	warp_event 13, 21, OLSTEETON_UNI_OFFICE, 2
	warp_event 20, 20, OLSTEETON_UNI_OFFICE, 3
	warp_event 20, 21, OLSTEETON_UNI_OFFICE, 4
	warp_event 17, 21, OLSTEETON_UNI_OFFICE, 6
	warp_event 25,  9, OLSTEETON_UNI_CLOCK_TOWER_1F, 1
	warp_event  6, 19, OLSTEETON_UNI_CLASSROOM_BLDG, 1
	warp_event 25, 17, OLSTEETON_UNI_DORM_WEST_1F, 1
	warp_event 29, 15, OLSTEETON_UNI_DINING_HALL, 1
	warp_event 30, 15, OLSTEETON_UNI_DINING_HALL, 1
	warp_event 33, 17, OLSTEETON_UNI_DORM_EAST_1F, 2
	warp_event 34,  7, OLSTEETON_UNI_GYM_DEPT, 1




	def_coord_events


	def_bg_events
	bg_event  6, 11, BGEVENT_JUMPTEXT, AcademySignText
	bg_event 10, 10, BGEVENT_JUMPTEXT, LibrarySignText
	bg_event 20, 10, BGEVENT_JUMPTEXT, ScienceSignText
	bg_event 24, 10, BGEVENT_JUMPTEXT, ClockSignText
	bg_event  5, 20, BGEVENT_JUMPTEXT, ClassroomSignText
	bg_event 26, 18, BGEVENT_JUMPTEXT, DormWestSignText
	bg_event 34, 18, BGEVENT_JUMPTEXT, DormEastSignText
	bg_event 13, 19, BGEVENT_JUMPTEXT, OfficeSignText
	bg_event 23, 21, BGEVENT_JUMPTEXT, LeavingSignText
	bg_event 32,  8, BGEVENT_JUMPTEXT, GymSignText
	bg_event 29, 21, BGEVENT_ITEM + FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

	def_object_events
	fruittree_event 23,  7, FRUITTREE_AZALEA_TOWN, WHT_APRICORN, PAL_NPC_WHITE
	object_event 21, 24, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniSnorelaxText, -1


	object_const_def


AcademySignText:
	text "Bouffalant"
	line "Academy"
	done

LibrarySignText:
	text "Academy Library"
	done

ScienceSignText:
	text "Academy #mon"
	line "Science Center"
	done

ClockSignText:
	text "Oak Memorial"
	line "Clock Tower"
	done

ClassroomSignText:
	text "Classroom Building"
	done

DormWestSignText:
	text "Academy Dorm"
	line "Western Tower"
	done

DormEastSignText:
	text "Academy Dorm"
	line "Eastern Tower"
	done
GymSignText:
	text "Gym Leader"
	line "Training Program"
	done

OfficeSignText:
	text "Academy Offices"
	done
LeavingSignText:
	text "SOUTH: Route 103"
	line "NORTH: Academy"
	done

OlsteetonUniSnorelaxText:
	text "Snorlax: Snorrr"
	line "It's in a"
	cont "deep sleep..."
	done
