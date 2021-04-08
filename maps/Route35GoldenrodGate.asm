Route35GoldenrodGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, ROUTE_35, 1
	warp_event  5,  0, ROUTE_35, 2
	warp_event  4,  7, GOLDENROD_CITY, 12
	warp_event  5,  7, GOLDENROD_CITY, 12

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RandyScript, -1
	object_event  6,  4, SPRITE_BREEDER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route35GoldenrodGatePokefanFScript, -1
	object_event  3,  2, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route35GoldenrodGateFisherText, -1

RandyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HP_UP_FROM_RANDY
	iftrue .gothpup
	checkevent EVENT_GAVE_KENYA
	iftrue .questcomplete
	checkevent EVENT_GOT_KENYA
	iftrue .alreadyhavekenya
	writetext Route35GoldenrodGateRandyAskTakeThisMonToMyFriendText
	yesorno
	iffalse .refused
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .partyfull
	writetext Route35GoldenrodGateRandyThanksText
	promptbutton
	waitsfx
	writetext Route35GoldenrodGatePlayerReceivedAMonWithMailText
	playsound SFX_KEY_ITEM
	waitsfx
	givepoke FARFETCH_D, FEMALE | NO_FORM, 10, NO_ITEM, NET_BALL, NO_MOVE, TRUE, GiftFarfetch_dName, GiftFarfetch_dOTName, GiftFarfetch_dOTIDAndCaughtGender
	givepokemail GiftFarfetch_dMail
	setevent EVENT_GOT_KENYA
.alreadyhavekenya
	jumpopenedtext Route35GoldenrodGateRandyWeirdTreeBlockingRoadText

.partyfull
	jumpopenedtext Route35GoldenrodGateRandyCantCarryAnotherMonText

.refused
	jumpopenedtext Route35GoldenrodGateRandyOhNeverMindThenText

.questcomplete
	writetext Route35GoldenrodGateRandySomethingForYourTroubleText
	promptbutton
	verbosegiveitem HP_UP
	iffalse .bagfull
	setevent EVENT_GOT_HP_UP_FROM_RANDY
.gothpup
	writetext Route35GoldenrodGateRandyMyPalWasSnoozingRightText
	waitbutton
.bagfull
	endtext

GiftFarfetch_dMail:
	db   FLOWER_MAIL
	db   "Dark Cave leads"
	next "to another road@"

GiftFarfetch_dName:
	rawchar "Kenya@"

GiftFarfetch_dOTName:
	rawchar "Randy@"

GiftFarfetch_dOTIDAndCaughtGender:
	bigdw 01001
	db MALE

Route35GoldenrodGatePokefanFScript:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .aftersudowoodo
	jumpopenedtext Route35GoldenrodGatePokefanFText

.aftersudowoodo
	jumpopenedtext Route35GoldenrodGatePokefanFText_FoughtSudowoodo

Route35GoldenrodGateRandyAskTakeThisMonToMyFriendText:
	text "Excuse me, kid!"
	line "Can you do a guy"
	cont "a favor?"

	para "Can you take this"
	line "#mon with Mail"
	cont "to my friend?"

	para "He's on Route 31."
	done

Route35GoldenrodGateRandyThanksText:
	text "You will? Perfect!"
	line "Thanks, kid!"

	para "My pal's a chubby"
	line "guy who snoozes"
	cont "all the time."

	para "You'll recognize"
	line "him right away!"
	done

Route35GoldenrodGatePlayerReceivedAMonWithMailText:
	text "<PLAYER> received a"
	line "#mon with Mail."
	done

Route35GoldenrodGateRandyWeirdTreeBlockingRoadText:
	text "You can read it,"
	line "but don't lose it!"
	cont "Route 31!"

	para "Oh, yeah. There"
	line "was a weird tree"
	cont "blocking the road."

	para "I wonder if it's"
	line "been cleared?"
	done

Route35GoldenrodGateRandyCantCarryAnotherMonText:
	text "You can't carry"
	line "another #mon…"
	done

Route35GoldenrodGateRandyOhNeverMindThenText:
	text "Oh… Never mind,"
	line "then…"
	done

Route35GoldenrodGateRandySomethingForYourTroubleText:
	text "Thanks, kid! You"
	line "made the delivery"
	cont "for me!"

	para "Here's something"
	line "for your trouble!"
	done

Route35GoldenrodGateRandyMyPalWasSnoozingRightText:
	text "My pal was snooz-"
	line "ing, right? Heh,"
	cont "what'd I say?"
	done

Route35GoldenrodGatePokefanFText:
	text "A strange tree is"
	line "blocking the road."

	para "It wriggles around"
	line "if you talk to it."

	para "I heard it became"
	line "wild when someone"

	para "watered it with a"
	line "SquirtBottle."
	done

Route35GoldenrodGatePokefanFText_FoughtSudowoodo:
	text "I like the #mon"
	line "Lullaby they play"
	cont "on the radio."
	done

Route35GoldenrodGateFisherText:
	text "I wonder how many"
	line "kinds of #mon"

	para "there are in the"
	line "world."

	para "Three years ago,"
	line "Prof.Oak said that"

	para "there were 150"
	line "different kinds."
	done
