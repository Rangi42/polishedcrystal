OlsteetonUniDiningHall_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8,  0, OLSTEETON_UNI, 14
	warp_event  0,  4, OLSTEETON_UNI_DORM_WEST_1F, 3
	warp_event  0,  5, OLSTEETON_UNI_DORM_WEST_1F, 4
	warp_event 15,  4, OLSTEETON_UNI_DORM_EAST_1F, 3
	warp_event 15,  5, OLSTEETON_UNI_DORM_EAST_1F, 4

	def_coord_events

	def_bg_events
	bg_event 10,  0, BGEVENT_JUMPTEXT, OlsteetonUniDiningHallSignText

	def_object_events
	object_event  4,  1, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDiningHallCooltrainerfText, -1
	object_event 11,  3, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDiningHallBeautyText, -1
	object_event  2,  6, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDiningHallYoungster1Text, -1
	object_event  8,  6, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDiningHallLadyText, -1
	object_event 11,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, OlsteetonUniDiningHallYoungster2Script, -1
	object_event  9,  2, SPRITE_BAKER, SPRITEMOVEDATA_STANDING_DOWN, 1, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonUniDiningHallBakerScript, -1

	object_const_def
OlsteetonUniDiningHallCooltrainerfText:
	text "This place makes"
	line "the best Cinnabar-"
	cont "style hamburger"

	para "steaks this side"
	line "of Kanto!"

	para "It's just like"
	line "being home."
	done

OlsteetonUniDiningHallBeautyText:
	text "The cook finally"
	line "made another batch"
	cont "of Old Gateau!"

	para "I might go back"
	line "for seconds."
	done

OlsteetonUniDiningHallYoungster1Text:
	text "I asked the cafe-"
	line "teria to stock"
	cont "Casteliacones."

	para "They remind me of"
	line "home, and they're"
	cont "yummy too!"
	done

OlsteetonUniDiningHallLadyText:
	text "I'm on a diet."
	line "Today it's a"
	para "nutritious Slip"
	line "Seed salad for me."
	done

OlsteetonUniDiningHallYoungster2Script:
	checkevent EVENT_GOT_LEMONADE_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem LEMONADE
	iffalse_endtext
	setevent EVENT_GOT_LEMONADE_IN_UNIVERSITY
	jumpopenedtext .Text2

.Text1:
	text "The vending ma-"
	line "chine gave me an"
	cont "extra drink!"

	para "Let me share it"
	line "with you."
	done

.Text2:
	text "I love a cold"
	line "Lemonade after a"
	cont "tough battle."
	done

OlsteetonUniDiningHallBakerScript:
	faceplayer
	opentext
	checkflag ENGINE_BOUGHT_LEFTOVERS
	iftrue_jumpopenedtext .Text3
	writetext .Text1
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .Text4
	checkmoney YOUR_MONEY, 4000
	ifequalfwd HAVE_LESS, .NotEnoughMoney
	giveitem LEFTOVERS
	iffalse_jumpopenedtext .Text6
	setflag ENGINE_BOUGHT_LEFTOVERS
	waitsfx
	playsound SFX_TRANSACTION
	takemoney YOUR_MONEY, 4000
	special PlaceMoneyTopRight
	jumpthisopenedtext

.Text2:
	text "Here you go, hon!"
	line "Enjoy it!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "You don't have"
	line "enough money…"
	done

.Text1:
	text "What's that, hon?"

	para "Sorry, we're done"
	line "serving dinner."

	para "There are some"
	line "Leftovers, but"

	para "it'll cost ¥4000."
	line "Want some?"
	done

.Text3:
	text "There aren't any"
	line "more Leftovers"
	cont "today."
	done

.Text4:
	text "Have a nice day!"
	done

.Text6:
	text "You can't carry"
	line "it, hon."
	done

OlsteetonUniDiningHallSignText:
	text "Please clean up"
	line "when you are"
	cont "finished eating."
	done
