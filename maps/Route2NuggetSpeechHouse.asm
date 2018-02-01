Route2NuggetSpeechHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 1, ROUTE_2_NORTH
	warp_def 7, 3, 1, ROUTE_2_NORTH

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_FISHER, 4, 1, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route2NuggetSpeechHouseFisherScript, -1

Route2NuggetSpeechHouseFisherScript:
	checkevent EVENT_GOT_NUGGET_FROM_GUY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem NUGGET
	iffalse_endtext
	setevent EVENT_GOT_NUGGET_FROM_GUY
	thisopenedtext

.Text2:
	text "That's a Nugget."

	para "I can't give you"
	line "any nuggets of"

	para "wisdom, so that'll"
	line "have to do!"
	done

.Text1:
	text "Hi! Wow, I'm glad"
	line "to see you."

	para "You're the first"
	line "visitor I've had"
	cont "in a long time."

	para "I'm super-happy!"
	line "Let me give you a"
	cont "little present."
	done
