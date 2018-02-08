Route46_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  7, 33, ROUTE_29_46_GATE, 1
	warp_event  8, 33, ROUTE_29_46_GATE, 2
	warp_event 14,  5, DARK_CAVE_VIOLET_ENTRANCE, 3

	db 0 ; coord events

	db 1 ; bg events
	bg_event  9, 27, SIGNPOST_JUMPTEXT, Route46SignText

	db 8 ; object events
	object_event 15, 13, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, Route46HikerScript, -1
	object_event 12, 19, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerHikerBailey, -1
	object_event  4, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerCamperTed, -1
	object_event  2, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_TRAINER, 2, TrainerPicnickerErin1, -1
	object_event  7, 26, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Route46LassText, -1
	fruittree_event  7,  5, FRUITTREE_ROUTE_46_1, CHERI_BERRY
	fruittree_event  8,  6, FRUITTREE_ROUTE_46_2, CHESTO_BERRY
	itemball_event  1, 15, X_SPEED, 1, EVENT_ROUTE_46_X_SPEED

Route46HikerScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_ROLLOUT_INTRO
	iftrue Route46TutorRoute46Script
	writetext Route46HikerText
	waitbutton
	setevent EVENT_LISTENED_TO_ROLLOUT_INTRO
Route46TutorRoute46Script:
	writetext Text_Route46TutorRollout
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_Route46TutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte ROLLOUT
	writetext Text_Route46TutorClear
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_Route46TutorRefused

.NoSilverLeaf
	jumpopenedtext Text_Route46TutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_Route46TutorTaught

GenericTrainerCamperTed:
	generictrainer CAMPER, TED, EVENT_BEAT_CAMPER_TED, CamperTedSeenText, CamperTedBeatenText

	text "I did my best but"
	line "came up short."

	para "No excuses--I"
	line "admit I lost."
	done

TrainerPicnickerErin1:
	trainer PICNICKER, ERIN1, EVENT_BEAT_PICNICKER_ERIN, PicnickerErin1SeenText, PicnickerErin1BeatenText, 0, PicnickerErin1Script

PicnickerErin1Script:
	writecode VAR_CALLERID, PHONE_PICNICKER_ERIN
	opentext
	checkflag ENGINE_ERIN
	iftrue UnknownScript_0x1a96da
	checkcellnum PHONE_PICNICKER_ERIN
	iftrue UnknownScript_0x1a975b
	checkevent EVENT_ERIN_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x1a96c3
	writetext UnknownText_0x1a98c6
	buttonsound
	setevent EVENT_ERIN_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1a974f
	jump UnknownScript_0x1a96c6

UnknownScript_0x1a96c3:
	scall UnknownScript_0x1a9753
UnknownScript_0x1a96c6:
	askforphonenumber PHONE_PICNICKER_ERIN
	ifequal $1, UnknownScript_0x1a9763
	ifequal $2, UnknownScript_0x1a975f
	trainertotext PICNICKER, ERIN1, $0
	scall UnknownScript_0x1a9757
	jump UnknownScript_0x1a975b

UnknownScript_0x1a96da:
	scall UnknownScript_0x1a9767
	winlosstext PicnickerErin1BeatenText, 0
	copybytetovar wErinFightCount
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer PICNICKER, ERIN1
	startbattle
	reloadmapafterbattle
	loadvar wErinFightCount, 1
	clearflag ENGINE_ERIN
	end

.LoadFight1:
	loadtrainer PICNICKER, ERIN2
	startbattle
	reloadmapafterbattle
	loadvar wErinFightCount, 2
	clearflag ENGINE_ERIN
	end

.LoadFight2:
	loadtrainer PICNICKER, ERIN3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ERIN
	checkevent EVENT_ERIN_CALCIUM
	iftrue UnknownScript_0x1a973b
	checkevent EVENT_GOT_CALCIUM_FROM_ERIN
	iftrue UnknownScript_0x1a973a
	scall UnknownScript_0x1a9772
	verbosegiveitem CALCIUM
	iffalse UnknownScript_0x1a976b
	setevent EVENT_GOT_CALCIUM_FROM_ERIN
	jump UnknownScript_0x1a975b

UnknownScript_0x1a973a:
	end

UnknownScript_0x1a973b:
	opentext
	writetext UnknownText_0x1a9927
	waitbutton
	verbosegiveitem CALCIUM
	iffalse UnknownScript_0x1a976b
	clearevent EVENT_ERIN_CALCIUM
	setevent EVENT_GOT_CALCIUM_FROM_ERIN
	jump UnknownScript_0x1a975b

UnknownScript_0x1a974f:
	jumpstd asknumber1f

UnknownScript_0x1a9753:
	jumpstd asknumber2f

UnknownScript_0x1a9757:
	jumpstd registerednumberf

UnknownScript_0x1a975b:
	jumpstd numberacceptedf

UnknownScript_0x1a975f:
	jumpstd numberdeclinedf

UnknownScript_0x1a9763:
	jumpstd phonefullf

UnknownScript_0x1a9767:
	jumpstd rematchf

UnknownScript_0x1a976b:
	setevent EVENT_ERIN_CALCIUM
	jumpstd packfullf
	end

UnknownScript_0x1a9772:
	jumpstd rematchgiftf

GenericTrainerHikerBailey:
	generictrainer HIKER, BAILEY, EVENT_BEAT_HIKER_BAILEY, HikerBaileySeenText, HikerBaileyBeatenText

	text "It's over. I don't"
	line "mind. We Hikers"
	cont "are like that."
	done

Route46HikerText:
	text "A Donphan charged"
	line "at me and I roll-"

	para "ed all the way"
	line "down here!"

	para "Still, it taught"
	line "me a lesson…"

	para "Be careful around"
	line "angry Pokemon!"
	done

Text_Route46TutorRollout:
	text "I'll teach your"
	line "#mon how to"

	para "use Rollout for"
	line "a Silver Leaf."
	done

Text_Route46TutorNoSilverLeaf:
	text "Ah well, you don't"
	line "have a Silver"
	cont "Leaf."
	done

Text_Route46TutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Rollout?"
	done

Text_Route46TutorRefused:
	text "Suit yourself."
	done

Text_Route46TutorClear:
	text ""
	done

Text_Route46TutorTaught:
	text "All done! Your"
	line "#mon learned"
	cont "to use Rollout!"
	done

HikerBaileySeenText:
	text "Awright! I'll show"
	line "you the power of"
	cont "mountain #mon!"
	done

HikerBaileyBeatenText:
	text "Mercy! You showed"
	line "me your power!"
	done

CamperTedSeenText:
	text "I'm raising #-"
	line "mon too!"

	para "Will you battle"
	line "with me?"
	done

CamperTedBeatenText:
	text "Wha…?"
	done

PicnickerErin1SeenText:
	text "I raise #mon"
	line "too!"

	para "Will you battle"
	line "with me?"
	done

PicnickerErin1BeatenText:
	text "Oh, rats!"
	done

UnknownText_0x1a98c6:
	text "I've been to many"
	line "Gyms, but the Gym"

	para "in Goldenrod is my"
	line "favorite."

	para "It's filled with"
	line "pretty flowers!"
	done

UnknownText_0x1a9927:
	text "Aww… I keep losing"
	line "all the time!"

	para "I'll just have to"
	line "try harder!"

	para "Anyway, thanks for"
	line "battling me again"

	para "and again. Here's"
	line "that present from"
	cont "the other time."
	done

Route46SignText:
	text "Route 46"
	line "Mountain Rd. Ahead"
	done

Route46LassText:
	text "A dead end…?"

	para "Did I take the"
	line "wrong path?"

	para "I didn't know this"
	line "was only one way."
	done
