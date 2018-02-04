Route12SuperRodHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, ROUTE_12_SOUTH, 1
	warp_event  3,  7, ROUTE_12_SOUTH, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x7f484, -1

FishingGuruScript_0x7f484:
	checkevent EVENT_GOT_SUPER_ROD
	iftrue_jumptextfaceplayer UnknownText_0x7f57c
	faceplayer
	opentext
	writetext UnknownText_0x7f4af
	yesorno
	iffalse UnknownScript_0x7f4a6
	writetext UnknownText_0x7f52f
	buttonsound
	verbosegiveitem SUPER_ROD
	iffalse UnknownScript_0x7f4aa
	setevent EVENT_GOT_SUPER_ROD
	thisopenedtext

UnknownText_0x7f57c:
	text "Try your hand at"
	line "fishing wherever"
	cont "there is water."

	para "Remember--you can"
	line "catch different"

	para "#mon using"
	line "different Rods."
	done

UnknownScript_0x7f4a6:
	writetext UnknownText_0x7f5ec
	waitbutton
UnknownScript_0x7f4aa:
	endtext

UnknownText_0x7f4af:
	text "I'm the Fishing"
	line "Guru's younger"
	cont "brother."

	para "I can see that you"
	line "like fishing."

	para "There's no doubt"
	line "in my mind at all!"

	para "So? I know I'm"
	line "right."
	done

UnknownText_0x7f52f:
	text "Yes, yes. Just as"
	line "I thought!"

	para "Here, fishing fan!"
	line "Take this--it's a"
	cont "Super Rod."
	done

UnknownText_0x7f5ec:
	text "Huh? My own eyes"
	line "deceived me?"
	done
