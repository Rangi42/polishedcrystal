OlsteetonUni_MapScriptHeader:
	def_scene_scripts

	def_callbacks


	def_warp_events
	warp_event  4, 10, OLSTEETON_UNI_GATE, 3
	warp_event  4, 11, OLSTEETON_UNI_GATE, 4
	warp_event  6,  7, OLSTEETON_UNI_LIBRARY_1F, 2
	warp_event 17,  7, OLSTEETON_UNI_SCIENCE_CENTER, 1
	warp_event  11, 18, OLSTEETON_UNI_OFFICE, 1
	warp_event  11, 19, OLSTEETON_UNI_OFFICE, 2
	warp_event  18, 18, OLSTEETON_UNI_OFFICE, 3
	warp_event  18, 19, OLSTEETON_UNI_OFFICE, 4
	warp_event  15, 19, OLSTEETON_UNI_OFFICE, 6
	warp_event  23,  7, OLSTEETON_UNI_CLOCK_TOWER_1F, 1
	warp_event  4, 17, OLSTEETON_UNI_CLASSROOM_BLDG, 1
	warp_event 23, 15, OLSTEETON_UNI_DORM_WEST_1F, 1
	warp_event 27, 13, OLSTEETON_UNI_DINING_HALL, 1
	warp_event 28, 13, OLSTEETON_UNI_DINING_HALL, 1
	warp_event 31, 15, OLSTEETON_UNI_DORM_EAST_1F, 2
	warp_event 32,  5, OLSTEETON_UNI_GYM_DEPT, 1




	def_coord_events


	def_bg_events
	bg_event  4,  9, BGEVENT_JUMPTEXT, AcademySignText
	bg_event  8,  8, BGEVENT_JUMPTEXT, LibrarySignText
	bg_event 18,  8, BGEVENT_JUMPTEXT, ScienceSignText
	bg_event 22,  8, BGEVENT_JUMPTEXT, ClockSignText
	bg_event  3, 18, BGEVENT_JUMPTEXT, ClassroomSignText
	bg_event 24, 16, BGEVENT_JUMPTEXT, DormWestSignText
	bg_event 32, 16, BGEVENT_JUMPTEXT, DormEastSignText
	bg_event 11, 17, BGEVENT_JUMPTEXT, OfficeSignText
	bg_event 19, 21, BGEVENT_JUMPTEXT, LeavingSignText
	bg_event 30,  6, BGEVENT_JUMPTEXT, GymSignText
	bg_event 27, 19, BGEVENT_ITEM + FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

	def_object_events
	fruittree_event 21,  5, FRUITTREE_AZALEA_TOWN, WHT_APRICORN, PAL_NPC_WHITE

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
