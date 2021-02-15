MountMortarB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  3, MOUNT_MORTAR_1F_INSIDE, 5
	warp_event 19, 29, MOUNT_MORTAR_1F_OUTSIDE, 7

	def_coord_events

	def_bg_events
	bg_event  4,  6, BGEVENT_ITEM + MAX_REVIVE, EVENT_MOUNT_MORTAR_B1F_HIDDEN_MAX_REVIVE

	def_object_events
	object_event 11, 31, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MountMortarB1FHikerScript, -1
	object_event 16,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MountMortarB1FKiyoScript, -1
	strengthboulder_event  9, 10
	itemball_event 29, 12, HYPER_POTION, 1, EVENT_MOUNT_MORTAR_B1F_HYPER_POTION
	itemball_event  4, 16, CARBOS, 1, EVENT_MOUNT_MORTAR_B1F_CARBOS
	itemball_event 34, 24, PROTECTOR, 1, EVENT_MOUNT_MORTAR_B1F_PROTECTOR
	itemball_event 32,  3, MAX_ETHER, 1, EVENT_MOUNT_MORTAR_B1F_MAX_ETHER
	itemball_event 21, 26, PP_UP, 1, EVENT_MOUNT_MORTAR_B1F_PP_UP

MountMortarB1FHikerScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_DEFENSE_CURL_INTRO
	iftrue MountMortarB1FTutorDefenseCurlScript
	writetext MountMortarB1FHikerText
	waitbutton
	setevent EVENT_LISTENED_TO_DEFENSE_CURL_INTRO
MountMortarB1FTutorDefenseCurlScript:
	writetext Text_MountMortarB1FTutorDefenseCurl
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_MountMortarB1FTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte DEFENSE_CURL
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_MountMortarB1FTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_MountMortarB1FTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_MountMortarB1FTutorTaught

MountMortarB1FKiyoScript:
	checkevent EVENT_GOT_TYROGUE_FROM_KIYO
	iftrue_jumptextfaceplayer MountMortarB1FKiyoGotTyrogueText
	faceplayer
	checkevent EVENT_BEAT_KIYO
	iftrue UnknownScript_0x7e217
	showtext MountMortarB1FKiyoIntroText
	winlosstext MountMortarB1FKiyoWinText, 0
	loadtrainer KARATE_KING, KIYO
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_KIYO
UnknownScript_0x7e217:
	opentext
	writetext MountMortarB1FTyrogueRewardText
	buttonsound
	waitsfx
	checkcode VAR_PARTYCOUNT
	ifequal $6, UnknownScript_0x7e237
	writetext MountMortarB1FReceiveMonText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke TYROGUE, 10
	writebyte PREMIER_BALL
	special SetLastPartyMonBall
	setevent EVENT_GOT_TYROGUE_FROM_KIYO
	jumpthisopenedtext

MountMortarB1FKiyoGotTyrogueText:
	text "Tyrogue is a"
	line "Fighting-type."

	para "It evolves into a"
	line "tougher #mon."

	para "Keep up the hard"
	line "work. I'll keep"
	cont "training too."

	para "Farewell!"
	done

UnknownScript_0x7e237:
	jumpopenedtext MountMortarB1FKiyoFullPartyText

MountMortarB1FHikerText:
	text "My #mon used"
if DEF(FAITHFUL)
	line "Rock Smash on a"
else
	line "Brick Break on a"
endc

	para "boulder, but it"
	line "was undamaged."

	para "It turned out to"
	line "be a Geodude that"
	cont "used Defense Curl!"
	done

Text_MountMortarB1FTutorDefenseCurl:
	text "I can teach your"
	line "#mon to use"

	para "Defense Curl for"
	line "one Silver Leaf."
	done

Text_MountMortarB1FTutorNoSilverLeaf:
	text "Shucks, you don't"
	line "have a Silver"
	cont "Leaf."
	done

Text_MountMortarB1FTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Defense Curl?"
	done

Text_MountMortarB1FTutorRefused:
	text "I'll be right here"
	line "waiting."
	done

Text_MountMortarB1FTutorTaught:
	text "There! Now your"
	line "#mon can use"
	cont "Defense Curl!"
	done

MountMortarB1FKiyoIntroText:
	text "Hey!"

	para "I am the Karate"
	line "King!"

	para "I train alone here"
	line "in the dark!"

	para "You!"
	line "Battle with me!"

	para "Hwaaarggh!"
	done

MountMortarB1FKiyoWinText:
	text "Waaaarggh!"
	line "I'm beaten!"
	done

MountMortarB1FTyrogueRewardText:
	text "I… I'm crushed…"

	para "My training is"
	line "still not enough…"

	para "But a loss is a"
	line "loss. I admit it."

	para "As proof that you"
	line "defeated me, I'll"

	para "give you a rare"
	line "fighting #mon."
	done

MountMortarB1FReceiveMonText:
	text "<PLAYER> received"
	line "Tyrogue."
	done

MountMortarB1FKiyoFullPartyText:
	text "You have no room"
	line "in your party!"
	done
