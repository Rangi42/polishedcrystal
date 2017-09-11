EcruteakCherishBallHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

EcruteakCherishBallHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 3, 16, ECRUTEAK_CITY
	warp_def 7, 4, 16, ECRUTEAK_CITY

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 2, SIGNPOST_JUMPSTD, radio2

.PersonEvents: db 2
	person_event SPRITE_GRAMPS, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, EcruteakCherishBallHouseGrampsScript, -1
	person_event SPRITE_GRANNY, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakCherishBallHouseGrannyText, -1

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
