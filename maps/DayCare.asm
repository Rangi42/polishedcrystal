DayCare_MapScriptHeader:
	def_scene_scripts
	scene_script DayCareTrigger0

	def_callbacks
	callback MAPCALLBACK_OBJECTS, DayCareEggCheckCallback

	def_warp_events
	warp_event  0,  4, ROUTE_34, 3
	warp_event  0,  5, ROUTE_34, 4
	warp_event  2,  7, ROUTE_34, 5
	warp_event  3,  7, ROUTE_34, 5

	def_coord_events

	def_bg_events
	bg_event  5,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  5,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DayCareLadyScript, -1
	object_event  0,  5, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LYRA_DAYCARE
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Inside, EVENT_DAYCARE_MAN_IN_DAYCARE

	object_const_def
	const DAYCARE_GRANNY
	const DAYCARE_LYRA

DayCareTrigger0:
	sdefer DayCare_MeetGrandma
	end

DayCareEggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftruefwd .PutDayCareManOutside
	clearevent EVENT_DAYCARE_MAN_IN_DAYCARE
	setevent EVENT_DAYCARE_MAN_ON_ROUTE_34
	endcallback

.PutDayCareManOutside:
	setevent EVENT_DAYCARE_MAN_IN_DAYCARE
	clearevent EVENT_DAYCARE_MAN_ON_ROUTE_34
	endcallback

DayCare_MeetGrandma:
	follow DAYCARE_LYRA, PLAYER
	applymovement DAYCARE_LYRA, DayCareMovementData_LyraApproachesGrandma
	stopfollow
	turnobject PLAYER, UP
	turnobject DAYCARE_GRANNY, DOWN
	opentext
	writetext DayCareLyraHelloText
	waitbutton
	readvar VAR_PLAYERGENDER
	scalltable DayCareGrandmaISeeTable
	showemote EMOTE_SHOCK, DAYCARE_LYRA, 15
	readvar VAR_PLAYERGENDER
	scalltable DayCareLyraProtestTable
	turnobject DAYCARE_LYRA, DOWN
	showtext DayCareLyraGoodbyeText
	applymovement DAYCARE_LYRA, DayCareMovementData_LyraStartsToLeave
	showemote EMOTE_SHOCK, DAYCARE_LYRA, 15
	turnobject DAYCARE_LYRA, LEFT
	turnobject PLAYER, RIGHT
	showtext DayCareLyraForgotText
	addcellnum PHONE_LYRA
	opentext
	writetext GotLyrasNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	writetext DayCareLyraHasInfoText
	waitbutton
	closetext
	turnobject DAYCARE_LYRA, UP
	showtext DayCareLyraEmbarassedText
	applymovement DAYCARE_LYRA, DayCareMovementData_LyraLeaves
	disappear DAYCARE_LYRA
	setscene $1
	end

DayCareManScript_Inside:
	faceplayer
	opentext
	checkevent EVENT_GOT_ODD_EGG
	iftruefwd .AlreadyHaveOddEgg
	writetext DayCareManText_GiveOddEgg
	promptbutton
	special GiveOddEgg
	iffalse_jumpopenedtext DayCareText_PartyAndBoxFull
	writetext DayCareText_GotOddEgg
	playsound SFX_GET_EGG_FROM_DAYCARE_LADY
	waitsfx
	ifequalfwd 1, .InParty
	special Special_CurBoxFullCheck
	iffalsefwd .BoxNotFull
	farwritetext _CurBoxFullText
.BoxNotFull
	special GetCurBoxName
	farwritetext _EggSentToPCText
	promptbutton
.InParty:
	writetext DayCareText_DescribeOddEgg
	setevent EVENT_GOT_ODD_EGG
	waitendtext

.AlreadyHaveOddEgg:
	special Special_DayCareMan
	waitendtext

DayCareLadyScript:
	faceplayer
	opentext
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue_jumpopenedtext Text_GrampsLookingForYou
	checkevent EVENT_LYRA_GAVE_AWAY_EGG
	iffalsefwd .NoLyrasEgg
	checkevent EVENT_GOT_LYRAS_EGG
	iftruefwd .NoLyrasEgg
	writetext DayCareLadyText_GiveLyrasEgg
	promptbutton
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .GiveCyndaquilEgg
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .GiveTotodileEgg
	giveegg CHIKORITA
	sjumpfwd .GotLyrasEgg

.GiveCyndaquilEgg:
	giveegg CYNDAQUIL
	sjumpfwd .GotLyrasEgg

.GiveTotodileEgg:
	giveegg TOTODILE
.GotLyrasEgg
	iffalse_jumpopenedtext DayCareText_PartyAndBoxFull
	writetext DayCareLadyText_DescribeLyrasEgg
	setevent EVENT_GOT_LYRAS_EGG
	waitendtext

.NoLyrasEgg:
	special Special_DayCareLady
	waitendtext

DayCareMovementData_LyraApproachesGrandma:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_up
	step_end

DayCareMovementData_LyraStartsToLeave:
	step_right
	step_down
	step_end

DayCareMovementData_LyraLeaves:
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

DayCareLyraHelloText:
	text "Lyra: Grandma!"

	para "Let me introduce"
	line "my friend."

	para "This is <PLAYER>!"
	done

DayCareGrandmaISeeTable:
	dw .Male
	dw .Female
	dw .Enby

.Male:
	jumpthisopenedtext

	text "Grandma: Ah ha."

	para "This is your"
	line "boy… friend."

	para "I see. Hmm."
	done

.Female:
	jumpthisopenedtext

	text "Grandma: Ah ha."

	para "This is your"
	line "girl… friend."

	para "I see. Hmm."
	done

.Enby:
	jumpthisopenedtext

	text "Grandma: Ah ha."

	para "This is your"
	line "close… friend."

	para "I see. Hmm."
	done

DayCareLyraProtestTable:
	dw .Male
	dw .Female
	dw .Enby

.Male:
	jumpthistext

	text "Lyra: What?"
	line "Grandma…!"

	para "What are you"
	line "talking about?"

	para "He just lives"
	line "nearby…"

	para "Grandma: Hahaha."
	line "I know, I know."

	para "You must be sure"
	line "he's talented."

	para "Right, <PLAYER>?"
	line "Come and see us"
	cont "anytime!"
	done

.Female:
	jumpthistext

	text "Lyra: What?"
	line "Grandma…!"

	para "What are you"
	line "talking about?"

	para "She just lives"
	line "nearby…"

	para "Grandma: Hahaha."
	line "I know, I know."

	para "You must be sure"
	line "she's talented."

	para "Right, <PLAYER>?"
	line "Come and see us"
	cont "anytime!"
	done

.Enby:
	jumpthistext

	text "Lyra: What?"
	line "Grandma…!"

	para "What are you"
	line "talking about?"

	para "They just live"
	line "nearby…"

	para "Grandma: Hahaha."
	line "I know, I know."

	para "You must be sure"
	line "they're talented."

	para "Right, <PLAYER>?"
	line "Come and see us"
	cont "anytime!"
	done

DayCareLyraGoodbyeText:
	text "Lyra: Well, I'd"
	line "better go now…"
	cont "See ya!"
	done

DayCareLyraForgotText:
	text "Lyra: Oh!"
	line "I almost forgot!"

	para "Here! This is my"
	line "#gear number!"
	done

GotLyrasNumberText:
	text "<PLAYER> got Lyra's"
	line "phone number."
	done

DayCareLyraHasInfoText:
	text "Call me any time"
	line "you want!"

	para "Grandma and Grand-"
	line "pa taught me a lot"

	para "about raising"
	line "#mon, and I'd"

	para "like to share it"
	line "with you."
	done

DayCareLyraEmbarassedText:
	text "Lyra: Grandma!"

	para "Don't you say"
	line "anything."

	para "We're both train-"
	line "ers, and we're"

	para "supposed to ex-"
	line "change numbers."
	cont "That's all."
	done

Text_GrampsLookingForYou:
	text "Gramps was looking"
	line "for you."
	done

DayCareManText_GiveOddEgg:
	text "I'm the Day-Care"
	line "Man."

	para "Do you know about"
	line "Eggs?"

	para "I was raising"
	line "#mon with my"
	cont "wife, you see."

	para "We were shocked to"
	line "find an Egg!"

	para "How incredible is"
	line "that?"

	para "Well, wouldn't you"
	line "like this Egg?"

	para "Then fine, this is"
	line "yours to keep!"
	done

DayCareText_GotOddEgg:
	text "<PLAYER> received"
	line "the Odd Egg!"
	done

DayCareText_DescribeOddEgg:
	text "I found that when"
	line "I was caring for"

	para "someone's #mon"
	line "before."

	para "But the trainer"
	line "didn't want the"

	para "Egg, so I'd kept"
	line "it around."
	done

DayCareLadyText_GiveLyrasEgg:
	text "Hello, dear."

	para "Lyra told me this"
	line "Egg was a gift for"
	cont "you. Here you go!"
	done

DayCareLadyText_DescribeLyrasEgg:
	text "That Egg came from"
	line "her first #mon."

	para "She must really"
	line "trust you as a"
	cont "trainer."
	done

DayCareText_PartyAndBoxFull:
	text "You have no room"
	line "for this, even in"
	cont "your Box."
	done
