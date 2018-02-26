VermilionCity_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 14 ; warp events
	warp_event  5,  5, VERMILION_HOUSE_FISHING_SPEECH_HOUSE, 1
	warp_event  9,  5, VERMILION_POKECENTER_1F, 1
	warp_event  7, 17, POKEMON_FAN_CLUB, 1
	warp_event 13, 17, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE, 1
	warp_event 21, 17, VERMILION_MART, 2
	warp_event 21, 21, VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE, 1
	warp_event 10, 23, VERMILION_GYM, 1
	warp_event 17, 35, VERMILION_PORT_PASSAGE, 1
	warp_event 18, 35, VERMILION_PORT_PASSAGE, 2
	warp_event 36, 17, DIGLETTS_CAVE, 1
	warp_event 29, 35, SEAGALLOP_FERRY_VERMILION_GATE, 1
	warp_event 30, 35, SEAGALLOP_FERRY_VERMILION_GATE, 1
	warp_event 13,  5, VERMILION_POLLUTION_SPEECH_HOUSE, 1
	warp_event 19,  5, VERMILION_S_S_ANNE_SPEECH_HOUSE, 1

	db 2 ; coord events
	coord_event 18, 32, 0, LawrenceLeftIntroScript
	coord_event 19, 32, 0, LawrenceRightIntroScript

	db 8 ; bg events
	bg_event 25,  5, SIGNPOST_JUMPTEXT, VermilionCitySignText
	bg_event  5, 23, SIGNPOST_JUMPTEXT, VermilionGymSignText
	bg_event  5, 17, SIGNPOST_JUMPTEXT, PokemonFanClubSignText
	bg_event 33, 17, SIGNPOST_JUMPTEXT, VermilionCityDiglettsCaveSignText
	bg_event 27, 19, SIGNPOST_JUMPTEXT, VermilionCityPortSignText
	bg_event 28, 13, SIGNPOST_JUMPTEXT, VermilionCityTruckText
	bg_event 29, 13, SIGNPOST_JUMPTEXT, VermilionCityTruckText
	bg_event 12, 23, SIGNPOST_ITEM + FULL_HEAL, EVENT_VERMILION_CITY_HIDDEN_FULL_HEAL

	db 14 ; object events
	object_event 35, 18, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, VermilionSnorlax, EVENT_VERMILION_CITY_SNORLAX
	object_event 19, 28, SPRITE_VERMILION_LAWRENCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_VERMILION_CITY
	object_event 18, 13, SPRITE_VERMILION_LAWRENCE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aaa15, -1
	object_event 23, 10, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionMachokeOwnerText, -1
	object_event 26, 11, SPRITE_MACHOKE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, VermilionMachoke, -1
	object_event 14, 20, SPRITE_ROCKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aab1a, -1
	object_event 25, 16, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionCitySuperNerdText, -1
	object_event 10,  9, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionCitySailorText, -1
	object_event 31, 16, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, VermilionGymBadgeGuy, -1
	cuttree_event 13, 23, EVENT_VERMILION_CITY_CUT_TREE
	smashrock_event 26, 14
	smashrock_event 23, 12
	smashrock_event 28, 7
	smashrock_event 29, 9

	const_def 1 ; object constants
	const VERMILIONCITY_BIG_SNORLAX
	const VERMILIONCITY_LAWRENCE

LawrenceLeftIntroScript:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	showtext LawrenceOverheardText
	applymovement VERMILIONCITY_LAWRENCE, LawrenceApproachLeftMovementData
	playsound SFX_TACKLE
	applymovement VERMILIONCITY_LAWRENCE, LawrenceBumpLeftMovementData
	showemote EMOTE_SHOCK, VERMILIONCITY_LAWRENCE, 15
	pause 15
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAroundLeftMovementData
	turnobject PLAYER, RIGHT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext LawrenceIntroText
	turnobject PLAYER, DOWN
	applymovement VERMILIONCITY_LAWRENCE, LawrenceDepartLeftMovementData
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONCITY_LAWRENCE
	variablesprite SPRITE_VERMILION_LAWRENCE, SPRITE_COOLTRAINER_F
	special MapCallbackSprites_LoadUsedSpritesGFX
	setscene $1
	setflag ENGINE_FLYPOINT_VERMILION
	special RestartMapMusic
	end

LawrenceRightIntroScript:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	showtext LawrenceOverheardText
	applymovement VERMILIONCITY_LAWRENCE, LawrenceApproachRightMovementData
	playsound SFX_TACKLE
	applymovement VERMILIONCITY_LAWRENCE, LawrenceBumpRightMovementData
	showemote EMOTE_SHOCK, VERMILIONCITY_LAWRENCE, 15
	pause 15
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAroundRightMovementData
	turnobject PLAYER, LEFT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext LawrenceIntroText
	turnobject PLAYER, DOWN
	applymovement VERMILIONCITY_LAWRENCE, LawrenceDepartRightMovementData
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONCITY_LAWRENCE
	variablesprite SPRITE_VERMILION_LAWRENCE, SPRITE_COOLTRAINER_F
	special MapCallbackSprites_LoadUsedSpritesGFX
	setscene $1
	setflag ENGINE_FLYPOINT_VERMILION
	special RestartMapMusic
	end

LawrenceApproachLeftMovementData:
	step_left
LawrenceApproachRightMovementData:
	step_down
	step_down
	step_down
	step_end

LawrenceBumpLeftMovementData:
LawrenceBumpRightMovementData:
	fix_facing
	big_step_up
	remove_fixed_facing
	step_sleep_8
	step_sleep_8
	step_end

LawrenceWalkAroundLeftMovementData:
	step_right
	step_down
	step_down
	turn_head_left
	step_end

LawrenceWalkAroundRightMovementData:
	step_left
	step_down
	step_down
	turn_head_right
	step_end

LawrenceDepartLeftMovementData:
	step_down
	step_down
	step_left
	step_down
	step_end

LawrenceDepartRightMovementData:
	step_down
	step_down
	step_down
	step_end

VermilionMachoke:
	showcrytext VermilionMachokeText1, MACHOKE
	earthquake 30
	jumptext VermilionMachokeText2

VermilionSnorlax:
	opentext
	special SpecialSnorlaxAwake
	iftrue UnknownScript_0x1aa9ab
	jumpopenedtext UnknownText_0x1aab64

UnknownScript_0x1aa9ab:
	writetext UnknownText_0x1aab84
	pause 15
	cry SNORLAX
	closetext
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon SNORLAX, 60
	startbattle
	disappear VERMILIONCITY_BIG_SNORLAX
	setevent EVENT_FOUGHT_SNORLAX
	reloadmapafterbattle
	end

VermilionGymBadgeGuy:
	checkevent EVENT_GOT_BOTTLE_CAP_FROM_VERMILION_GUY
	iftrue_jumptextfaceplayer UnknownText_0x1aad4a
	checkcode VAR_BADGES
	ifequal 16, .AllBadges
	ifgreater 13, .MostBadges
	ifgreater 9, .SomeBadges
	jumptextfaceplayer UnknownText_0x1aabc8

.SomeBadges:
	jumptextfaceplayer UnknownText_0x1aac2b

.MostBadges:
	jumptextfaceplayer UnknownText_0x1aac88

.AllBadges:
	faceplayer
	opentext
	writetext UnknownText_0x1aacf3
	buttonsound
	verbosegiveitem BOTTLE_CAP
	iffalse_endtext
	setevent EVENT_GOT_BOTTLE_CAP_FROM_VERMILION_GUY
	thisopenedtext

UnknownText_0x1aad4a:
	text "Having a variety"
	line "of #mon types"

	para "should give you an"
	line "edge in battle."

	para "I'm sure the Kanto"
	line "Gym Badges will"
	cont "help you."
	done

LawrenceOverheardText:
	text "…So the legendary"
	line "#mon was not"
	cont "on that island…"

	para "I must continue my"
	line "search elsewhere…"
	done

LawrenceIntroText:
	text "Lawrence: Please"
	line "excuse me for"
	cont "bumping into you."

	para "I'm in a hurry to"
	line "complete my"
	cont "collection."

	para "My name is"
	line "Lawrence III."

	para "And you're the"
	line "League Champion?"

	para "…Well, appearances"
	line "can be deceiving."

	para "Legendary #mon"
	line "have always been"
	cont "my passion."

	para "I took the Seagal-"
	line "lop Ferry here to"

	para "Shamouti Island,"
	line "but did not find"
	cont "the one I sought."

	para "Oh, you've encoun-"
	line "tered #mon out"
	cont "of Johto's legends?"

	para "Then our paths may"
	line "cross again as"
	cont "fellow collectors."

	para "But I really must"
	line "be on my way."
	cont "Farewell!"
	done

UnknownText_0x1aaa15:
	text "Vermilion Port is"
	line "Kanto's seaside"
	cont "gateway."

	para "Luxury liners from"
	line "around the world"
	cont "dock here."
	done

VermilionMachokeOwnerText:
	text "My #mon has"
	line "been preparing the"

	para "land for construc-"
	line "tion for so long,"
	cont "it evolved!"

	para "But I have no"
	line "money to start the"
	cont "project…"
	done

VermilionMachokeText1:
	text "Machoke: Guooh"
	line "gogogoh!"
	done

VermilionMachokeText2:
	text "A Machoke is"
	line "growling while"

	para "stomping the"
	line "ground flat."
	done

UnknownText_0x1aab1a:
	text "There are eight"
	line "Gyms in Kanto."

	para "That big building"
	line "is Vermilion's"
	cont "#mon Gym."
	done

VermilionCitySuperNerdText:
	text "The man over there"
	line "said his building"

	para "would be finished"
	line "by now."

	para "What's the hold-up?"
	done

VermilionCitySailorText:
	text "Nothing beats"
	line "good sea air!"
	done

UnknownText_0x1aab64:
	text "Snorlax is snoring"
	line "peacefully…"
	done

UnknownText_0x1aab84:
	text "The #gear was"
	line "placed near the"
	cont "sleeping Snorlax…"

	para "…"

	para "Snorlax woke up!"
	done

UnknownText_0x1aabc8:
	text "Skilled trainers"
	line "gather in Kanto."

	para "Gym Leaders are"
	line "especially strong."

	para "They won't be easy"
	line "to defeat."
	done

UnknownText_0x1aac2b:
	text "You've started to"
	line "collect Kanto Gym"
	cont "Badges?"

	para "Don't you agree"
	line "that the trainers"
	cont "here are tough?"
	done

UnknownText_0x1aac88:
	text "I guess you'll be"
	line "finished with your"

	para "conquest of Kanto"
	line "Gyms soon."

	para "Let me know if"
	line "you get all eight"
	cont "Badges."
	done

UnknownText_0x1aacf3:
	text "Congratulations!"

	para "You got all the"
	line "Kanto Gym Badges."

	para "I've got a reward"
	line "for your efforts."
	done

VermilionCitySignText:
	text "Vermilion City"

	para "The Port of"
	line "Exquisite Sunsets"
	done

VermilionGymSignText:
	text "Vermilion City"
	line "#mon Gym"
	cont "Leader: Lt.Surge"

	para "The Lightning"
	line "American"
	done

PokemonFanClubSignText:
	text "#mon Fan Club"

	para "All #mon Fans"
	line "Welcome!"
	done

VermilionCityDiglettsCaveSignText:
	text "Diglett's Cave"
	done

VermilionCityPortSignText:
	text "Vermilion Port"
	line "Entrance"
	done

VermilionCityTruckText:
	text "It's a truck full"
	line "of building supp-"
	cont "lies."

	para "Underneath it"
	line "there's…"
	cont "nothing!"
	done
