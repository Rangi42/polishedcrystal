const_value set 2
	const CELADONUNIVERSITYHYPERTESTROOM_WESTWOOD
	const CELADONUNIVERSITYHYPERTESTROOM_SCIENTIST
	const CELADONUNIVERSITYHYPERTESTROOM_TWIN1
	const CELADONUNIVERSITYHYPERTESTROOM_TWIN2

CeladonUniversityHyperTestRoom_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityHyperTestRoomWestwoodScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityHyperTestRoomScientistScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityHyperTestRoomTwin1Script:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityHyperTestRoomTwin2Script:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

CeladonUniversityHyperTestRoomMagikarpSign:
	refreshscreen $0
	pokepic MAGIKARP
	waitbutton
	closepokepic
	jumptext .Text

.Text:
	text "A Magikarp is"
	line "swimming around."
	done

CeladonUniversityHyperTestRoomBookshelf:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityHyperTestRoomComputer:
	jumptext .Text

.Text:
	text "TODO"
	done

CeladonUniversityHyperTestRoom_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $2, 4, CELADON_UNIVERSITY_2F
	warp_def $b, $3, 4, CELADON_UNIVERSITY_2F

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 1, 2, SIGNPOST_READ, CeladonUniversityHyperTestRoomMagikarpSign
	signpost 1, 6, SIGNPOST_READ, CeladonUniversityHyperTestRoomBookshelf
	signpost 1, 7, SIGNPOST_READ, CeladonUniversityHyperTestRoomBookshelf
	signpost 4, 7, SIGNPOST_READ, CeladonUniversityHyperTestRoomComputer
	signpost 6, 7, SIGNPOST_READ, CeladonUniversityHyperTestRoomComputer

.PersonEvents:
	db 4
	person_event SPRITE_WESTWOOD, 2, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonUniversityHyperTestRoomWestwoodScript, -1
	person_event SPRITE_SCIENTIST, 7, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityHyperTestRoomScientistScript, -1
	person_event SPRITE_TWIN, 6, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityHyperTestRoomTwin1Script, -1
	person_event SPRITE_TWIN, 8, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityHyperTestRoomTwin2Script, -1
