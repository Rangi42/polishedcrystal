CeladonDeptStore3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 12,  0, CELADON_DEPT_STORE_2F, 1
	warp_event 15,  0, CELADON_DEPT_STORE_4F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, CeladonDeptStore3FDirectoryText
	bg_event  2,  3, BGEVENT_JUMPTEXT, CeladonDeptStore3FRPGText
	bg_event  5,  3, BGEVENT_JUMPTEXT, CeladonDeptStore3FSportsGameText
	bg_event  2,  5, BGEVENT_JUMPTEXT, CeladonDeptStore3FPuzzleGameText
	bg_event  5,  5, BGEVENT_JUMPTEXT, CeladonDeptStore3FFightingGameText

	def_object_events
	object_event  9,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_TM, MART_CELADON_3F_TM, -1
	object_event  8,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FClerk2Script, -1
	object_event  7,  5, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStore3FYoungsterText, -1
	object_event 13,  4, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStore3FSuperNerdText, -1
	object_event  0,  4, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, VideoGameClerkText, -1
	object_event  1,  3, SPRITE_SNES, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FSnesScript, -1
	object_event  1,  5, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FN64Script, -1
	object_event  4,  3, SPRITE_GAMECUBE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FGameCubeScript, -1
	object_event  4,  5, SPRITE_WII, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FWiiScript, -1

CeladonDeptStore3FClerk2Script:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_COUNTER_INTRO
	iftrue CeladonDeptStore3FTutorCounterScript
	writetext CeladonDeptStore3FClerk2Text
	waitbutton
	setevent EVENT_LISTENED_TO_COUNTER_INTRO
CeladonDeptStore3FTutorCounterScript:
	writetext Text_CeladonDeptStore3FTutorCounter
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_CeladonDeptStore3FTutorQuestion
	yesorno
	iffalse .TutorRefused
	setval COUNTER
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_CeladonDeptStore3FTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_CeladonDeptStore3FTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_CeladonDeptStore3FTutorTaught

VideoGameClerkNoMoneyScript:
	jumpopenedtext VideoGameClerkNoMoneyText

CeladonDeptStore3FSnesScript:
	checkevent EVENT_DECO_SNES
	iftrue_jumptext CeladonDeptStore3FSnesText
	opentext
	writetext VideoGameClerkSellSnesText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext VideoGameClerkNoSaleText
	checkmoney $0, 20000
	ifequal $2, VideoGameClerkNoMoneyScript
	takemoney $0, 20000
	setevent EVENT_DECO_SNES
	writetext BoughtSnesText
	playsound SFX_TRANSACTION
	waitbutton
	jumpopenedtext SnesSentText

CeladonDeptStore3FN64Script:
	checkevent EVENT_DECO_N64
	iftrue_jumptext CeladonDeptStore3FN64Text
	opentext
	writetext VideoGameClerkSellN64Text
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext VideoGameClerkNoSaleText
	checkmoney $0, 25000
	ifequal $2, VideoGameClerkNoMoneyScript
	takemoney $0, 25000
	setevent EVENT_DECO_N64
	writetext BoughtN64Text
	playsound SFX_TRANSACTION
	waitbutton
	jumpopenedtext N64SentText

CeladonDeptStore3FGameCubeScript:
	checkevent EVENT_DECO_GAMECUBE
	iftrue_jumptext CeladonDeptStore3FGameCubeText
	opentext
	writetext VideoGameClerkSellGameCubeText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext VideoGameClerkNoSaleText
	checkmoney $0, 30000
	ifequal $2, VideoGameClerkNoMoneyScript
	takemoney $0, 30000
	setevent EVENT_DECO_GAMECUBE
	writetext BoughtGameCubeText
	playsound SFX_TRANSACTION
	waitbutton
	jumpopenedtext GameCubeSentText

CeladonDeptStore3FWiiScript:
	checkevent EVENT_DECO_WII
	iftrue_jumptext CeladonDeptStore3FWiiText
	opentext
	writetext VideoGameClerkSellWiiText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext VideoGameClerkNoSaleText
	checkmoney $0, 40000
	ifequal $2, VideoGameClerkNoMoneyScript
	takemoney $0, 40000
	setevent EVENT_DECO_WII
	writetext BoughtWiiText
	playsound SFX_TRANSACTION
	waitbutton
	jumpopenedtext WiiSentText

CeladonDeptStore3FClerk2Text:
	text "There's a neat move"
	line "called Counter."

	para "Not the kind of"
	line "counter I'm leaning"
	cont "on, mind you!"
	done

Text_CeladonDeptStore3FTutorCounter:
	text "I'll teach your"
	line "#mon how to use"

	para "Counter if you pay"
	line "me a Silver Leaf."
	done

Text_CeladonDeptStore3FTutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf…"
	done

Text_CeladonDeptStore3FTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Counter?"
	done

Text_CeladonDeptStore3FTutorRefused:
	text "Never mind."
	done

Text_CeladonDeptStore3FTutorTaught:
	text "Now your #mon"
	line "knows Counter."
	done

VideoGameClerkText:
	text "We sell brand-new"
	line "and vintage game"
	cont "systems!"

	para "Try them out for"
	line "yourself!"
	done

VideoGameClerkNoSaleText:
	text "Clerk: Well, if"
	line "you say so."
	done

VideoGameClerkNoMoneyText:
	text "Clerk: You can't"
	line "afford it!"
	done

VideoGameClerkSellSnesText:
	text "Clerk: That SNES"
	line "can be yours for"

	para "just ¥20,000!"
	line "Want one?"
	done

VideoGameClerkSellN64Text:
	text "Clerk: That N64"
	line "can be yours for"

	para "just ¥25,000!"
	line "Want one?"
	done

VideoGameClerkSellGameCubeText:
	text "Clerk: That Game-"
	line "Cube can be yours"

	para "for just ¥30,000!"
	line "Want one?"
	done

VideoGameClerkSellWiiText:
	text "Clerk: That Wii"
	line "can be yours for"

	para "just ¥40,000!"
	line "Want one?"
	done

BoughtSnesText:
	text "<PLAYER> bought"
	line "Super NES."
	done

SnesSentText:
	text "Super NES"
	line "was sent home."
	done

BoughtN64Text:
	text "<PLAYER> bought"
	line "Nintendo 64."
	done

N64SentText:
	text "Nintendo 64"
	line "was sent home."
	done

BoughtGameCubeText:
	text "<PLAYER> bought"
	line "GameCube."
	done

GameCubeSentText:
	text "GameCube"
	line "was sent home."
	done

BoughtWiiText:
	text "<PLAYER> bought"
	line "Wii."
	done

WiiSentText:
	text "Wii"
	line "was sent home."
	done

CeladonDeptStore3FYoungsterText:
	text "I can't decide"
	line "which #mon I"

	para "should use this"
	line "TM on…"

	para "Good thing it"
	line "doesn't run out."
	done

CeladonDeptStore3FSuperNerdText:
	text "The Tech Shop"
	line "sells some cool"
	cont "game systems."
	done

CeladonDeptStore3FDirectoryText:
	text "Make Your #mon"
	line "Stronger!"

	para "3F: Tech Shop"
	done

CeladonDeptStore3FSnesText:
	text "It's a Super NES!"

	para "I have one of"
	line "those at home!"
	done

CeladonDeptStore3FN64Text:
	text "It's an N64!"

	para "I have one of"
	line "those at home!"
	done

CeladonDeptStore3FGameCubeText:
	text "It's a GameCube!"

	para "I have one of"
	line "those at home!"
	done

CeladonDeptStore3FWiiText:
	text "It's a Wii!"

	para "I have one of"
	line "those at home!"
	done

CeladonDeptStore3FRPGText:
	text "An RPG! There's"
	line "no time for that!"
	done

CeladonDeptStore3FSportsGameText:
	text "A sports game!"
	line "Dad'll like that!"
	done

CeladonDeptStore3FPuzzleGameText:
	text "A puzzle game!"
	line "Looks addictive!"
	done

CeladonDeptStore3FFightingGameText:
	text "A fighting game!"
	line "Looks tough!"
	done
