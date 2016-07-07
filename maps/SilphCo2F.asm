const_value set 2
	const SILPHCO2F_SCIENTIST1
	const SILPHCO2F_SCIENTIST2

SilphCo2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SilphCo2FScientist1Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_UP_GRADE
	iftrue SilphCo2FScientist1GaveUpGradeScript
	writetext SilphCo2FScientist1Text1
	buttonsound
	verbosegiveitem UP_GRADE
	iffalse SilphCo2FScientist1NoRoomForUpGradeScript
	setevent EVENT_GOT_UP_GRADE
SilphCo2FScientist1GaveUpGradeScript:
	writetext SilphCo2FScientist1Text2
	waitbutton
SilphCo2FScientist1NoRoomForUpGradeScript:
	closetext
	end

SilphCo2FScientist2Script:
	jumptextfaceplayer SilphCo2FScientist2Text

SilphCo2FScientist1Text1:
	text "You traveled here"
	line "from Johto?"

	para "Since you came"
	line "such a long way,"

	para "have this neat"
	line "little souvenir."
	done

SilphCo2FScientist1Text2:
	text "It's Silph Co.'s"
	line "latest product."

	para "It's not for sale"
	line "anywhere yet."
	done

SilphCo2FScientist2Text:
	text "TODO:"
	line "sell new Balls"
	done

SilphCo2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $d, 3, SILPH_CO_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_SCIENTIST, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo2FScientist1Script, -1
	person_event SPRITE_SCIENTIST, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo2FScientist2Script, -1
