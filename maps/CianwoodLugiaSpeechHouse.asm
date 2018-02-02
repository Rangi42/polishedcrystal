CianwoodLugiaSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, CIANWOOD_CITY, 6
	warp_event  3,  7, CIANWOOD_CITY, 6

	db 0 ; coord events

	db 2 ; bg events
	bg_event  0,  1, SIGNPOST_JUMPSTD, picturebookshelf
	bg_event  1,  1, SIGNPOST_JUMPSTD, picturebookshelf

	db 4 ; object events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9e1bc, -1
	object_event  6,  5, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9e23f, -1
	object_event  0,  2, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9e2a9, -1
	object_event  5,  3, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, CianwoodHouseBlackBeltScript, -1

CianwoodHouseBlackBeltScript:
	checkevent EVENT_GOT_ASSAULT_VEST_FROM_CIANWOOD
	iftrue_jumptextfaceplayer CianwoodHouseBlackBeltText2
	faceplayer
	opentext
	writetext CianwoodHouseBlackBeltText1
	buttonsound
	verbosegiveitem ASSAULT_VEST
	iffalse_endtext
	setevent EVENT_GOT_ASSAULT_VEST_FROM_CIANWOOD
	jumpopenedtext CianwoodHouseBlackBeltText2

CianwoodHouseBlackBeltText1:
	text "I went to the Gym"
	line "wearing this vest,"
	cont "but was laughed"

	para "out of the build-"
	line "ing! I can't wear"
	cont "it there again,"

	para "so you might as"
	line "well have it."
	done

CianwoodHouseBlackBeltText2:
	text "Right. I'm gonna"
	line "train hard and"

	para "earn my spot in"
	line "the Gym!"
	done

UnknownText_0x9e1bc:
	text "You came from"
	line "Olivine?"

	para "Do you remember"
	line "the four islands"
	cont "along the way?"

	para "I heard that a"
	line "mythical sea crea-"
	cont "ture is hiding in"
	cont "them."
	done

UnknownText_0x9e23f:
	text "I heard that you"
	line "can only see it if"

	para "you have a Silver"
	line "Wing."

	para "It must have the"
	line "same scent as the"
	cont "creature."
	done

UnknownText_0x9e2a9:
	text "I've heard that"
	line "the whirlpools"

	para "around the islands"
	line "are caused by the"
	cont "sea creature."

	para "You might need a"
	line "special move to"
	cont "get past them."
	done
