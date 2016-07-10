const_value set 2
	const SILPHCO2F_SCIENTIST1
	const SILPHCO2F_SCIENTIST2
	const SILPHCO2F_SCIENTIST3

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

SilphCo2FScientist3Script:
	jumptextfaceplayer SilphCo2FScientist3Text

SilphCo2FDeptSign:
	jumptext SilphCo2FDeptSignText

SilphCo2FElevator:
	jumptext SilphCo2FElevatorText

SilphCo2FBookshelf:
	jumpstd difficultbookshelf

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
	text "We used to use"
	line "teleporters to get"

	para "around, but they"
	line "were disabled."

	para "Good thing I'm on"
	line "the second floor!"
	done

SilphCo2FScientist3Text:
	text "I'm coding! Don't"
	line "break my concen-"
	cont "tration!"
	done

SilphCo2FDeptSignText:
	text "Silph Co. 2F"
	line "Software Dev."
	done

SilphCo2FElevatorText:
	text "Out Of Order"
	done

SilphCo2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $0, $d, 3, SILPH_CO_1F
	warp_def $0, $b, 1, SILPH_CO_3F

.XYTriggers:
	db 0

.Signposts:
	db 8
	signpost 2, 3, SIGNPOST_READ, SilphCo2FDeptSign
	signpost 2, 9, SIGNPOST_READ, SilphCo2FDeptSign
	signpost 0, 5, SIGNPOST_READ, SilphCo2FElevator
	signpost 3, 0, SIGNPOST_READ, SilphCo2FBookshelf
	signpost 3, 6, SIGNPOST_READ, SilphCo2FBookshelf
	signpost 3, 7, SIGNPOST_READ, SilphCo2FBookshelf
	signpost 3, 12, SIGNPOST_READ, SilphCo2FBookshelf
	signpost 3, 13, SIGNPOST_READ, SilphCo2FBookshelf

.PersonEvents:
	db 3
	person_event SPRITE_SCIENTIST, 5, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo2FScientist1Script, -1
	person_event SPRITE_SCIENTIST, 5, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo2FScientist2Script, -1
	person_event SPRITE_SCIENTIST, 4, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo2FScientist3Script, -1
