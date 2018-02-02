Route5CleanseTagSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, ROUTE_5, 4
	warp_event  3,  7, ROUTE_5, 4

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 2 ; object events
	object_event  2,  5, SPRITE_GRANNY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, GrannyScript_0x18b634, -1
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18b6de, -1

GrannyScript_0x18b634:
	faceplayer
	opentext
	checkevent EVENT_GOT_CLEANSE_TAG
	iftrue UnknownScript_0x18b649
	writetext UnknownText_0x18b655
	buttonsound
	verbosegiveitem CLEANSE_TAG
	iffalse UnknownScript_0x18b64d
	setevent EVENT_GOT_CLEANSE_TAG
UnknownScript_0x18b649:
	writetext UnknownText_0x18b6a7
	waitbutton
UnknownScript_0x18b64d:
	endtext

UnknownText_0x18b655:
	text "Eeyaaaah!"

	para "I sense a sinister"
	line "shadow hovering"
	cont "over you."

	para "Take this to ward"
	line "it off!"
	done

UnknownText_0x18b6a7:
	text "You were in mortal"
	line "danger, but you"
	cont "are protected now."
	done

UnknownText_0x18b6de:
	text "My grandma is into"
	line "warding off what"

	para "she believes to be"
	line "evil spirits."

	para "I'm sorry that she"
	line "startled you."
	done
