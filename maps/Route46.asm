Route46_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route46_MapEventHeader:

.Warps: db 3
	warp_def 33, 7, 1, ROUTE_29_46_GATE
	warp_def 33, 8, 2, ROUTE_29_46_GATE
	warp_def 5, 14, 3, DARK_CAVE_VIOLET_ENTRANCE

.XYTriggers: db 0

.Signposts: db 1
	signpost 27, 9, SIGNPOST_JUMPTEXT, Route46SignText

.PersonEvents: db 8
	person_event SPRITE_POKEFAN_M, 13, 15, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, Route46HikerScript, -1
	person_event SPRITE_POKEFAN_M, 19, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerBailey, -1
	person_event SPRITE_YOUNGSTER, 14, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerCamperTed, -1
	person_event SPRITE_LASS, 13, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerPicnickerErin1, -1
	person_event SPRITE_LASS, 26, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Route46LassText, -1
	fruittree_event 5, 7, FRUITTREE_ROUTE_46_1, CHERI_BERRY
	fruittree_event 6, 8, FRUITTREE_ROUTE_46_2, CHESTO_BERRY
	itemball_event 15, 1, X_SPEED, 1, EVENT_ROUTE_46_X_SPEED

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
	if_equal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_Route46TutorRefused

.NoSilverLeaf
	jumpopenedtext Text_Route46TutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_Route46TutorTaught

TrainerCamperTed:
	trainer EVENT_BEAT_CAMPER_TED, CAMPER, TED, CamperTedSeenText, CamperTedBeatenText, 0, CamperTedScript

CamperTedScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a9851

TrainerPicnickerErin1:
	trainer EVENT_BEAT_PICNICKER_ERIN, PICNICKER, ERIN1, PicnickerErin1SeenText, PicnickerErin1BeatenText, 0, PicnickerErin1Script

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
	if_equal $1, UnknownScript_0x1a9763
	if_equal $2, UnknownScript_0x1a975f
	trainertotext PICNICKER, ERIN1, $0
	scall UnknownScript_0x1a9757
	jump UnknownScript_0x1a975b

UnknownScript_0x1a96da:
	scall UnknownScript_0x1a9767
	winlosstext PicnickerErin1BeatenText, 0
	copybytetovar wErinFightCount
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
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
	end

UnknownScript_0x1a9753:
	jumpstd asknumber2f
	end

UnknownScript_0x1a9757:
	jumpstd registerednumberf
	end

UnknownScript_0x1a975b:
	jumpstd numberacceptedf
	end

UnknownScript_0x1a975f:
	jumpstd numberdeclinedf
	end

UnknownScript_0x1a9763:
	jumpstd phonefullf
	end

UnknownScript_0x1a9767:
	jumpstd rematchf
	end

UnknownScript_0x1a976b:
	setevent EVENT_ERIN_CALCIUM
	jumpstd packfullf
	end

UnknownScript_0x1a9772:
	jumpstd rematchgiftf
	end

TrainerHikerBailey:
	trainer EVENT_BEAT_HIKER_BAILEY, HIKER, BAILEY, HikerBaileySeenText, HikerBaileyBeatenText, 0, HikerBaileyScript

HikerBaileyScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a97e8

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

UnknownText_0x1a97e8:
	text "It's over. I don't"
	line "mind. We Hikers"
	cont "are like that."
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

UnknownText_0x1a9851:
	text "I did my best but"
	line "came up short."

	para "No excuses--I"
	line "admit I lost."
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
