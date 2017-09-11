WarmBeachShack_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

WarmBeachShack_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 1, WARM_BEACH
	warp_def 7, 3, 1, WARM_BEACH

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_FISHER, 3, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, WarmBeachShackFisherScript, -1
	person_event SPRITE_FISHER, 3, 3, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, WarmBeachShackFisherScript, -1

WarmBeachShackFisherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_BODY_SLAM_INTRO
	iftrue WarmBeachShackTutorBodySlamScript
	writetext WarmBeachShackFisherText
	waitbutton
	setevent EVENT_LISTENED_TO_BODY_SLAM_INTRO
WarmBeachShackTutorBodySlamScript:
	writetext Text_WarmBeachShackTutorBodySlamQuestion
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	yesorno
	iffalse .TutorRefused
	writebyte BODY_SLAM
	writetext Text_WarmBeachShackTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_WarmBeachShackTutorRefused

.NoSilverLeaf
	waitbutton
	jumpopenedtext Text_WarmBeachShackTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_WarmBeachShackTutorTaught

WarmBeachShackFisherText:
	text "Ready?"
	line "Boing!"

	para "We're having a"
	line "Body Slam match to"

	para "see who wimps out"
	line "first."
	done

Text_WarmBeachShackTutorBodySlamQuestion:
	text "How about I teach"
	line "Body Slam to a"

	para "#mon of yours"
	line "for a Silver Leaf?"
	done

Text_WarmBeachShackTutorNoSilverLeaf:
	text "Huh? You don't"
	line "have any!"
	done

Text_WarmBeachShackTutorRefused:
	text "Alright then."
	done

Text_WarmBeachShackTutorClear:
	text ""
	done

Text_WarmBeachShackTutorTaught:
	text "Come again!"
	line "Boioing!"
	done
