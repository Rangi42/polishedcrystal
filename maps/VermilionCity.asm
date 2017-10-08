VermilionCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VermilionCity_MapEventHeader:

.Warps: db 14
	warp_def 5, 5, 1, VERMILION_HOUSE_FISHING_SPEECH_HOUSE
	warp_def 5, 9, 1, VERMILION_POKECENTER_1F
	warp_def 17, 7, 1, POKEMON_FAN_CLUB
	warp_def 17, 13, 1, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE
	warp_def 17, 21, 2, VERMILION_MART
	warp_def 21, 21, 1, VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE
	warp_def 23, 10, 1, VERMILION_GYM
	warp_def 35, 17, 1, VERMILION_PORT_PASSAGE
	warp_def 35, 18, 2, VERMILION_PORT_PASSAGE
	warp_def 17, 36, 1, DIGLETTS_CAVE
	warp_def 35, 29, 1, SEAGALLOP_FERRY_VERMILION_GATE
	warp_def 35, 30, 1, SEAGALLOP_FERRY_VERMILION_GATE
	warp_def 5, 13, 1, VERMILION_POLLUTION_SPEECH_HOUSE
	warp_def 5, 19, 1, VERMILION_S_S_ANNE_SPEECH_HOUSE

.XYTriggers: db 2
	xy_trigger 0, 32, 18, LawrenceLeftIntroScript
	xy_trigger 0, 32, 19, LawrenceRightIntroScript

.Signposts: db 8
	signpost 5, 25, SIGNPOST_JUMPTEXT, VermilionCitySignText
	signpost 23, 5, SIGNPOST_JUMPTEXT, VermilionGymSignText
	signpost 17, 5, SIGNPOST_JUMPTEXT, PokemonFanClubSignText
	signpost 17, 33, SIGNPOST_JUMPTEXT, VermilionCityDiglettsCaveSignText
	signpost 19, 27, SIGNPOST_JUMPTEXT, VermilionCityPortSignText
	signpost 13, 28, SIGNPOST_JUMPTEXT, VermilionCityTruckText
	signpost 13, 29, SIGNPOST_JUMPTEXT, VermilionCityTruckText
	signpost 23, 12, SIGNPOST_ITEM + FULL_HEAL, EVENT_VERMILION_CITY_HIDDEN_FULL_HEAL

.PersonEvents: db 14
	person_event SPRITE_BIG_SNORLAX, 18, 35, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, VermilionSnorlax, EVENT_VERMILION_CITY_SNORLAX
	person_event SPRITE_LAWRENCE, 28, 19, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_VERMILION_CITY
	person_event SPRITE_COOLTRAINER_F, 13, 18, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aaa15, -1
	person_event SPRITE_GRAMPS, 10, 23, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionMachopOwnerText, -1
	person_event SPRITE_MACHOP, 11, 26, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, VermilionMachop, -1
	person_event SPRITE_ROCKER, 20, 14, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1aab1a, -1
	person_event SPRITE_SUPER_NERD, 16, 25, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionCitySuperNerdText, -1
	person_event SPRITE_SAILOR, 9, 10, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, VermilionCitySailorText, -1
	person_event SPRITE_POKEFAN_M, 16, 31, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, VermilionGymBadgeGuy, -1
	cuttree_event 23, 13, EVENT_VERMILION_CITY_CUT_TREE
	smashrock_event 14, 26
	smashrock_event 12, 23
	smashrock_event 7, 28
	smashrock_event 9, 29

const_value set 1
	const VERMILIONCITY_BIG_SNORLAX
	const VERMILIONCITY_LAWRENCE

LawrenceLeftIntroScript:
	spriteface PLAYER, UP
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
	spriteface PLAYER, RIGHT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext LawrenceIntroText
	spriteface PLAYER, DOWN
	applymovement VERMILIONCITY_LAWRENCE, LawrenceDepartLeftMovementData
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONCITY_LAWRENCE
	dotrigger $1
	setflag ENGINE_FLYPOINT_VERMILION
	special RestartMapMusic
	end

LawrenceRightIntroScript:
	spriteface PLAYER, UP
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
	spriteface PLAYER, LEFT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext LawrenceIntroText
	spriteface PLAYER, DOWN
	applymovement VERMILIONCITY_LAWRENCE, LawrenceDepartRightMovementData
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONCITY_LAWRENCE
	dotrigger $1
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

VermilionMachop:
	showcrytext VermilionMachopText1, MACHOP
	earthquake 30
	jumptext VermilionMachopText2

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
	if_equal 16, .AllBadges
	if_greater_than 13, .MostBadges
	if_greater_than 9, .SomeBadges
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
.AlreadyGotItem:
	jumpopenedtext UnknownText_0x1aad4a

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

VermilionMachopOwnerText:
	text "My #mon is"
	line "preparing the land"
	cont "for construction."

	para "But I have no"
	line "money to start the"
	cont "project…"
	done

VermilionMachopText1:
	text "Machop: Guooh"
	line "gogogoh!"
	done

VermilionMachopText2:
	text "A Machop is growl-"
	line "ing while stomping"
	cont "the ground flat."
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

UnknownText_0x1aad4a:
	text "Having a variety"
	line "of #mon types"

	para "should give you an"
	line "edge in battle."

	para "I'm sure the Kanto"
	line "Gym Badges will"
	cont "help you."
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
