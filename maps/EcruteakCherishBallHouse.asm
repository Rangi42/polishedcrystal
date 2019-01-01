EcruteakCherishBallHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  7, ECRUTEAK_CITY, 16
	warp_event  4,  7, ECRUTEAK_CITY, 16

	db 0 ; coord events

	db 1 ; bg events
	bg_event  2,  1, SIGNPOST_JUMPSTD, radio2

	db 2 ; object events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, EcruteakCherishBallHouseGrampsScript, -1
	object_event  5,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakCherishBallHouseGrannyText, -1

EcruteakCherishBallHouseGrampsScript:
	checkevent EVENT_GOT_CHERISH_BALL_FROM_ECRUTEAK
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem CHERISH_BALL
	iffalse_endtext
	setevent EVENT_GOT_CHERISH_BALL_FROM_ECRUTEAK
	thisopenedtext

.Text2:
	text "I will always"
	line "cherish the time"

	para "I spent with"
	line "#mon."
	done

.Text1:
	text "I've lived a long"
	line "life, and I have"

	para "memories that I"
	line "will cherish for-"
	cont "ever."

	para "Take this and make"
	line "a new memory to"
	cont "cherish."
	done

EcruteakCherishBallHouseGrannyText:
	text "Fashions change"
	line "over the years,"

	para "but Ecruteak re-"
	line "mains as trad-"
	cont "itional as ever."
	done
