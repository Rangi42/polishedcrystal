const_value set 2
	const CELADONUNIVERSITYDEANSOFFICE_DEAN

CeladonUniversityDeansOffice_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityDeansOfficeDeanScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityDeansOfficeSignpost1:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityDeansOfficeSignpost2:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityDeansOfficeComputer:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityDeansOfficeBookshelf:
	jumptext .Text

.Text:
	text "It's a complete set"
	line "of books of the"

	para "Encyclopedia"
	line "#monica."
	done

CeladonUniversityDeansOffice_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 5, CELADON_UNIVERSITY_1F
	warp_def $7, $3, 5, CELADON_UNIVERSITY_1F

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 0, 2, SIGNPOST_READ, CeladonUniversityDeansOfficeSignpost1
	signpost 0, 3, SIGNPOST_READ, CeladonUniversityDeansOfficeSignpost2
	signpost 4, 5, SIGNPOST_READ, CeladonUniversityDeansOfficeComputer
	signpost 1, 1, SIGNPOST_READ, CeladonUniversityDeansOfficeBookshelf

.PersonEvents:
	db 1
	person_event SPRITE_DEAN, 2, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityDeansOfficeDeanScript, -1
