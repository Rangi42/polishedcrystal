const_value set 2
	const CELADONUNIVERSITYWILLOWSOFFICE_WILLOW
	const CELADONUNIVERSITYWILLOWSOFFICE_SCIENTIST

CeladonUniversityWillowsOffice_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityWillowsOfficeWillowScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityWillowsOfficeScientistScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityWillowsOfficeBlackboard:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityWillowsOfficeBookshelf1:
	jumptext .Text

.Text:
	text "It's a book about"
	line "a legendary #-"
	cont "mon that lives"
	cont "above the clouds."

	para "It flies grace-"
	line "fully like a"
	cont "meteor."
	done

CeladonUniversityWillowsOfficeBookshelf2:
	jumptext .Text

.Text:
	text "It's a promotional"
	line "flyer for the"
	cont "Safari Zone."

	para "Lots of exotic-"
	line "looking #mon"
	cont "adorn it."
	done

CeladonUniversityWillowsOfficeComputer:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityWillowsOffice_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $5, $3, 3, CELADON_UNIVERSITY_2F
	warp_def $5, $4, 3, CELADON_UNIVERSITY_2F

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 0, 0, SIGNPOST_READ, CeladonUniversityWillowsOfficeBlackboard
	signpost 0, 1, SIGNPOST_READ, CeladonUniversityWillowsOfficeBlackboard
	signpost 1, 2, SIGNPOST_READ, CeladonUniversityWillowsOfficeBookshelf1
	signpost 1, 3, SIGNPOST_READ, CeladonUniversityWillowsOfficeBookshelf2
	signpost 2, 5, SIGNPOST_READ, CeladonUniversityWillowsOfficeComputer

.PersonEvents:
	db 2
	person_event SPRITE_WILLOW, 2, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonUniversityWillowsOfficeWillowScript, -1
	person_event SPRITE_SCIENTIST, 3, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityWillowsOfficeScientistScript, -1
