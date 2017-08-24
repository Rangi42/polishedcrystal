CeladonDeptStore3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonDeptStore3F_MapEventHeader:

.Warps: db 3
	warp_def 0, 12, 1, CELADON_DEPT_STORE_2F
	warp_def 0, 15, 2, CELADON_DEPT_STORE_4F
	warp_def 0, 2, 1, CELADON_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 5
	signpost 0, 14, SIGNPOST_JUMPTEXT, CeladonDeptStore3FDirectoryText
	signpost 3, 2, SIGNPOST_JUMPTEXT, CeladonDeptStore3FRPGText
	signpost 3, 5, SIGNPOST_JUMPTEXT, CeladonDeptStore3FSportsGameText
	signpost 5, 2, SIGNPOST_JUMPTEXT, CeladonDeptStore3FPuzzleGameText
	signpost 5, 5, SIGNPOST_JUMPTEXT, CeladonDeptStore3FFightingGameText

.PersonEvents: db 9
	person_event SPRITE_CLERK, 1, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, pokemart, MARTTYPE_TM, MART_CELADON_3F_TM, -1
	person_event SPRITE_CLERK, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonDeptStore3FClerk2Script, -1
	person_event SPRITE_YOUNGSTER, 5, 7, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x70d53, -1
	person_event SPRITE_SUPER_NERD, 4, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x70e61, -1
	person_event SPRITE_CLERK, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, VideoGameClerkText, -1
	person_event SPRITE_SNES, 3, 1, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonDeptStore3FSnesScript, -1
	person_event SPRITE_N64, 5, 1, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonDeptStore3FN64Script, -1
	person_event SPRITE_GAMECUBE, 3, 4, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonDeptStore3FGameCubeScript, -1
	person_event SPRITE_WII, 5, 4, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonDeptStore3FWiiScript, -1

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
	writebyte COUNTER
	writetext Text_CeladonDeptStore3FTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
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
	if_equal $2, VideoGameClerkNoMoneyScript
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
	if_equal $2, VideoGameClerkNoMoneyScript
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
	if_equal $2, VideoGameClerkNoMoneyScript
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
	if_equal $2, VideoGameClerkNoMoneyScript
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

Text_CeladonDeptStore3FTutorClear:
	text ""
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

UnknownText_0x70d53:
	text "I can't decide"
	line "which #mon I"

	para "should use this"
	line "TM on…"

	para "Good thing it"
	line "doesn't run out."
	done

UnknownText_0x70e61:
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
