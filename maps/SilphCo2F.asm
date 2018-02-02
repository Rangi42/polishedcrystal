SilphCo2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 13,  0, SILPH_CO_1F, 3
	warp_event 11,  0, SILPH_CO_3F, 1

	db 0 ; coord events

	db 8 ; bg events
	bg_event  3,  2, SIGNPOST_JUMPTEXT, SilphCo2FDeptSignText
	bg_event  9,  2, SIGNPOST_JUMPTEXT, SilphCo2FDeptSignText
	bg_event  5,  0, SIGNPOST_JUMPTEXT, SilphCo2FElevatorText
	bg_event  0,  3, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  6,  3, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  7,  3, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event 12,  3, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event 13,  3, SIGNPOST_JUMPSTD, difficultbookshelf

	db 4 ; object events
	object_event  4,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo2FScientist1Script, -1
	object_event 14,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SilphCo2FScientist2Text, -1
	object_event  8,  5, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SilphCo2FSilphEmployee1Text, -1
	object_event  2,  5, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SilphCo2FSilphEmployee2Text, -1

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
	endtext

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
	text "I'm coding! Don't"
	line "break my concen-"
	cont "tration!"
	done

SilphCo2FSilphEmployee1Text:
	text "We used to use"
	line "teleporters to get"

	para "around, but they"
	line "were disabled."

	para "Good thing I'm on"
	line "the second floor!"
	done

SilphCo2FSilphEmployee2Text:
	text "We're always work-"
	line "ing on new TMs."

	para "Some have been"
	line "discontinued, but"

	para "others are so pop-"
	line "ular that they"

	para "haven't changed in"
	line "over 20 years!"
	done

SilphCo2FDeptSignText:
	text "Silph Co. 2F"
	line "Software Dev."
	done

SilphCo2FElevatorText:
	text "Out Of Order"
	done
