CianwoodLugiaSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CianwoodLugiaSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 6, CIANWOOD_CITY
	warp_def 7, 3, 6, CIANWOOD_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 1, 0, SIGNPOST_JUMPSTD, picturebookshelf
	signpost 1, 1, SIGNPOST_JUMPSTD, picturebookshelf

.PersonEvents: db 4
	person_event SPRITE_TEACHER, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9e1bc, -1
	person_event SPRITE_LASS, 5, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9e23f, -1
	person_event SPRITE_TWIN, 2, 0, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9e2a9, -1
	person_event SPRITE_BLACK_BELT, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CianwoodHouseBlackBeltScript, -1

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
