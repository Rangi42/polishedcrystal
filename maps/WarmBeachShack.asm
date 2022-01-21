WarmBeachShack_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, WARM_BEACH, 1
	warp_event  3,  7, WARM_BEACH, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, WarmBeachShackFisherScript, -1
	object_event  3,  3, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, WarmBeachShackFisherScript, -1

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
	setval BODY_SLAM
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
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

Text_WarmBeachShackTutorTaught:
	text "Come again!"
	line "Boioing!"
	done
