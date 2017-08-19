DarkCaveBlackthornEntrance_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

DarkCaveBlackthornEntrance_MapEventHeader:

.Warps: db 2
	warp_def 3, 23, 1, ROUTE_45
	warp_def 25, 3, 2, DARK_CAVE_VIOLET_ENTRANCE

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_PHARMACIST, 3, 7, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PharmacistScript_0x18c720, -1
	itemball_event 24, 21, REVIVE, 1, EVENT_DARK_CAVE_BLACKTHORN_ENTRANCE_REVIVE
	tmhmball_event 22, 7, TM_DARK_PULSE, EVENT_DARK_CAVE_BLACKTHORN_ENTRANCE_TM_DARK_PULSE

PharmacistScript_0x18c720:
	faceplayer
	opentext
	checkevent EVENT_GOT_BLACKGLASSES_IN_DARK_CAVE
	iftrue UnknownScript_0x18c735
	writetext UnknownText_0x18c73f
	buttonsound
	verbosegiveitem BLACKGLASSES
	iffalse UnknownScript_0x18c739
	setevent EVENT_GOT_BLACKGLASSES_IN_DARK_CAVE
UnknownScript_0x18c735:
	writetext UnknownText_0x18c80c
	waitbutton
UnknownScript_0x18c739:
	endtext

UnknownText_0x18c73f:
	text "Whoa! You startled"
	line "me there!"

	para "I had my Black-"
	line "Glasses on, so I"

	para "didn't notice you"
	line "at all."

	para "What am I doing"
	line "here?"

	para "Hey, don't you"
	line "worry about it."

	para "I'll give you a"
	line "pair of Black-"
	cont "Glasses, so forget"
	cont "you saw me, OK?"
	done

UnknownText_0x18c80c:
	text "BlackGlasses ups"
	line "the power of Dark-"
	cont "type moves."
	done
