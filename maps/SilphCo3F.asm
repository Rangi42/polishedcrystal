const_value set 2
	const SILPHCO3F_SCIENTIST1
	const SILPHCO3F_SCIENTIST2
	const SILPHCO3F_SCIENTIST3
	const SILPHCO3F_OFFICER

SilphCo3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SilphCo3FScientist1Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_CHERISH_BALL_FROM_SAFFRON
	iftrue .GotItem
	writetext SilphCo3FScientist1Text1
	buttonsound
	verbosegiveitem CHERISH_BALL
	iffalse .Done
	setevent EVENT_GOT_CHERISH_BALL_FROM_SAFFRON
.GotItem:
	writetext SilphCo3FScientist1Text2
	waitbutton
.Done:
	closetext
	end

SilphCo3FScientist2Script:
	jumptextfaceplayer SilphCo3FScientist2Text

SilphCo3FScientist3Script:
	jumptextfaceplayer SilphCo3FScientist3Text

SilphCo3FOfficerScript:
	jumptextfaceplayer SilphCo3FOfficerText

SilphCo3FDeptSign:
	jumptext SilphCo3FDeptSignText

SilphCo3FElevator:
	jumptext SilphCo3FElevatorText

SilphCo3FBookshelf:
	jumpstd difficultbookshelf

SilphCo3FScientist1Text1:
	text "Silph and Devon"
	line "partnered up"

	para "to design some"
	line "special new #"
	cont "Balls."

	para "We sell them in"
	line "Kanto, Johto, and"
	cont "Hoenn."

	para "But they're not"
	line "all on the market"
	cont "yet. Like this!"
	done

SilphCo3FScientist1Text2:
	text "That's an un-"
	line "released proto-"
	cont "type # Ball."

	para "Don't waste it!"
	done

SilphCo3FScientist2Text:
	text "Silph just entered"
	line "a partnership with"
	cont "Devon Corp."

	para "We licensed some"
	line "of each others'"
	cont "products."
	done

SilphCo3FScientist3Text:
	text "# Balls work on"
	line "the same principle"

	para "as the PC Storage"
	line "System."

	para "#mon are con-"
	line "verted into"
	cont "digital data and"

	para "reformed in a"
	line "new location."
	done

SilphCo3FOfficerText:
	text "I can't let you on"
	line "the upper floors,"

	para "even if you are"
	line "trustworthy."

	para "Sorry, but those"
	line "are the rules."
	done

SilphCo3FDeptSignText:
	text "Silph Co. 3F"
	line "# Ball Tech"
	done

SilphCo3FElevatorText:
	text "Out Of Order"
	done

SilphCo3F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $b, 2, SILPH_CO_2F

.XYTriggers:
	db 0

.Signposts:
	db 8
	signpost 2, 3, SIGNPOST_READ, SilphCo3FDeptSign
	signpost 2, 9, SIGNPOST_READ, SilphCo3FDeptSign
	signpost 0, 5, SIGNPOST_READ, SilphCo3FElevator
	signpost 3, 0, SIGNPOST_READ, SilphCo3FBookshelf
	signpost 3, 6, SIGNPOST_READ, SilphCo3FBookshelf
	signpost 3, 7, SIGNPOST_READ, SilphCo3FBookshelf
	signpost 3, 12, SIGNPOST_READ, SilphCo3FBookshelf
	signpost 3, 13, SIGNPOST_READ, SilphCo3FBookshelf

.PersonEvents:
	db 4
	person_event SPRITE_SCIENTIST, 5, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo3FScientist1Script, -1
	person_event SPRITE_SCIENTIST, 5, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo3FScientist2Script, -1
	person_event SPRITE_SCIENTIST, 7, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo3FScientist3Script, -1
	person_event SPRITE_OFFICER, 1, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCo3FOfficerScript, -1
