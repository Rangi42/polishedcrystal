SilphCo2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13,  0, SILPH_CO_1F, 3
	warp_event 11,  0, SILPH_CO_3F, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, SilphCoElevatorText
	bg_event  2,  3, BGEVENT_JUMPTEXT, SilphCo2FDeptSignText
	bg_event  9,  3, BGEVENT_JUMPTEXT, SilphCo2FDeptSignText
	bg_event  1,  1, BGEVENT_JUMPTEXT, SilphCo2FPrinterText
	bg_event 14,  5, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event 15,  5, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  6,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo2FScientist1Text, -1
	object_event 12,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo2FScientist2Text, -1
	object_event  3,  6, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCo2FEmployee1Script, -1
	object_event 12,  9, SPRITE_SILPH_EMPLOYEE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, SilphCo2FSilphEmployee2Text, -1

SilphCo2FEmployee1Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_UPGRADE
	iftruefwd .GaveUpgrade
	writetext .Text1
	promptbutton
	verbosegiveitem UPGRADE
	iffalsefwd .NoRoomForUpgrade
	setevent EVENT_GOT_UPGRADE
.GaveUpgrade:
	writetext .Text2
	waitbutton
.NoRoomForUpgrade:
	endtext

.Text1:
	text "You traveled here"
	line "from Johto?"

	para "Since you came"
	line "such a long way,"

	para "have this neat"
	line "little souvenir."
	done

.Text2:
	text "It's Silph Co.'s"
	line "latest product."

	para "It's not for sale"
	line "anywhere yet."
	done

SilphCo2FSilphEmployee2Text:
	text "We used to use"
	line "teleporters to get"

	para "around, but they"
	line "were disabled."

	para "Good thing I'm on"
	line "the second floor!"
	done

SilphCo2FScientist1Text:
	text "We're always work-"
	line "ing on new TMs."

	para "Some have been"
	line "discontinued, but"

	para "others are so pop-"
	line "ular that they"

	para "haven't changed in"
	line "over 30 years!"
	done

SilphCo2FScientist2Text:
	text "I'm coding! Don't"
	line "break my concen-"
	cont "tration!"
	done

SilphCo2FDeptSignText:
	text "Silph Co. 2F"
	line "Software Dev."
	done

SilphCo2FPrinterText:
	text "It's a printer."
	done
