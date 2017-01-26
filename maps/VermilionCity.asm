const_value set 2
	const VERMILIONCITY_COOLTRAINERF
	const VERMILIONCITY_GRAMPS
	const VERMILIONCITY_MACHOP
	const VERMILIONCITY_SUPER_NERD
	const VERMILIONCITY_BIG_SNORLAX
	const VERMILIONCITY_POKEFAN_M
	const VERMILIONCITY_LAWRENCE
	const VERMILIONCITY_CUT_TREE

VermilionCity_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.Trigger0:
	end

.Trigger1:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_VERMILION
	return

LawrenceLeftIntroScript:
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	opentext
	writetext LawrenceOverheardText
	waitbutton
	closetext
	applymovement VERMILIONCITY_LAWRENCE, LawrenceApproachLeftMovementData
	playsound SFX_TACKLE
	applymovement VERMILIONCITY_LAWRENCE, LawrenceBumpLeftMovementData
	showemote EMOTE_SHOCK, VERMILIONCITY_LAWRENCE, 15
	pause 15
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAroundLeftMovementData
	spriteface PLAYER, RIGHT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	opentext
	writetext LawrenceIntroText
	waitbutton
	verbosegiveitem ORANGETICKET
	writetext LawrenceOrangeTicketText
	waitbutton
	closetext
	spriteface PLAYER, DOWN
	applymovement VERMILIONCITY_LAWRENCE, LawrenceDepartLeftMovementData
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONCITY_LAWRENCE
	domaptrigger ROUTE_10_NORTH, $1
	dotrigger $1
	special RestartMapMusic
	end

LawrenceRightIntroScript:
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	opentext
	writetext LawrenceOverheardText
	waitbutton
	closetext
	applymovement VERMILIONCITY_LAWRENCE, LawrenceApproachRightMovementData
	playsound SFX_TACKLE
	applymovement VERMILIONCITY_LAWRENCE, LawrenceBumpRightMovementData
	showemote EMOTE_SHOCK, VERMILIONCITY_LAWRENCE, 15
	pause 15
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAroundRightMovementData
	spriteface PLAYER, LEFT
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	opentext
	writetext LawrenceIntroText
	waitbutton
	verbosegiveitem ORANGETICKET
	writetext LawrenceOrangeTicketText
	waitbutton
	closetext
	spriteface PLAYER, DOWN
	applymovement VERMILIONCITY_LAWRENCE, LawrenceDepartRightMovementData
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONCITY_LAWRENCE
	domaptrigger ROUTE_10_NORTH, $1
	dotrigger $1
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

CooltrainerFScript_0x1aa983:
	jumptextfaceplayer UnknownText_0x1aaa15

VermilionMachopOwner:
	jumptextfaceplayer VermilionMachopOwnerText

VermilionMachop:
	opentext
	writetext VermilionMachopText1
	cry MACHOP
	waitbutton
	closetext
	earthquake 30
	opentext
	writetext VermilionMachopText2
	waitbutton
	closetext
	end

SuperNerdScript_0x1aa99b:
	jumptextfaceplayer UnknownText_0x1aab1a

VermilionSnorlax:
	opentext
	special SpecialSnorlaxAwake
	iftrue UnknownScript_0x1aa9ab
	writetext UnknownText_0x1aab64
	waitbutton
	closetext
	end

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
	faceplayer
	opentext
	checkevent EVENT_GOT_BOTTLE_CAP_FROM_VERMILION_GUY
	iftrue .AlreadyGotItem
	checkcode VAR_BADGES
	if_equal 16, .AllBadges
	if_greater_than 13, .MostBadges
	if_greater_than 9, .SomeBadges
	writetext UnknownText_0x1aabc8
	waitbutton
	closetext
	end

.SomeBadges:
	writetext UnknownText_0x1aac2b
	waitbutton
	closetext
	end

.MostBadges:
	writetext UnknownText_0x1aac88
	waitbutton
	closetext
	end

.AllBadges:
	writetext UnknownText_0x1aacf3
	buttonsound
	verbosegiveitem BOTTLE_CAP
	iffalse .Done
	setevent EVENT_GOT_BOTTLE_CAP_FROM_VERMILION_GUY
.AlreadyGotItem:
	writetext UnknownText_0x1aad4a
	waitbutton
.Done:
	closetext
	end

VermilionCitySign:
	jumptext VermilionCitySignText

VermilionGymSign:
	jumptext VermilionGymSignText

PokemonFanClubSign:
	jumptext PokemonFanClubSignText

VermilionCityDiglettsCaveSign:
	jumptext VermilionCityDiglettsCaveSignText

VermilionCityPortSign:
	jumptext VermilionCityPortSignText

VermilionCityPokeCenterSign:
	jumpstd pokecentersign

VermilionCityMartSign:
	jumpstd martsign

VermilionCityCutTree:
	jumpstd cuttree

VermilionCityHiddenFullHeal:
	dwb EVENT_VERMILION_CITY_HIDDEN_FULL_HEAL, FULL_HEAL

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

	para "Legendary #mon"
	line "have always been"
	cont "my passion."

	para "I've just returned"
	line "from Shamouti"
	cont "Island."

	para "There was no sign"
	line "of the #mon I"

	para "seek, so I have no"
	line "more use for this."
	done

LawrenceOrangeTicketText:
	text "You can use that"
	line "ticket at the"

	para "ferry here in"
	line "Vermilion Port"

	para "to visit Shamouti"
	line "Island."

	para "It's a source of"
	line "many legends, but"

	para "no more legendary"
	line "#mon…"

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

VermilionCity_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 12
	warp_def $5, $5, 1, VERMILION_HOUSE_FISHING_SPEECH_HOUSE
	warp_def $5, $9, 1, VERMILION_POKECENTER_1F
	warp_def $d, $7, 1, POKEMON_FAN_CLUB
	warp_def $d, $d, 1, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE
	warp_def $d, $15, 2, VERMILION_MART
	warp_def $11, $15, 1, VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE
	warp_def $13, $a, 1, VERMILION_GYM
	warp_def $1f, $11, 1, VERMILION_PORT_PASSAGE
	warp_def $1f, $12, 2, VERMILION_PORT_PASSAGE
	warp_def $7, $22, 1, DIGLETTS_CAVE
	warp_def $1f, $1d, 1, SEAGALLOP_FERRY_VERMILION_GATE
	warp_def $1f, $1e, 1, SEAGALLOP_FERRY_VERMILION_GATE

.XYTriggers:
	db 2
	xy_trigger 0, $1c, $12, $0, LawrenceLeftIntroScript, $0, $0
	xy_trigger 0, $1c, $13, $0, LawrenceRightIntroScript, $0, $0

.Signposts:
	db 8
	signpost 3, 25, SIGNPOST_READ, VermilionCitySign
	signpost 19, 5, SIGNPOST_READ, VermilionGymSign
	signpost 13, 5, SIGNPOST_READ, PokemonFanClubSign
	signpost 9, 33, SIGNPOST_READ, VermilionCityDiglettsCaveSign
	signpost 15, 27, SIGNPOST_READ, VermilionCityPortSign
	signpost 5, 10, SIGNPOST_READ, VermilionCityPokeCenterSign
	signpost 13, 22, SIGNPOST_READ, VermilionCityMartSign
	signpost 19, 12, SIGNPOST_ITEM, VermilionCityHiddenFullHeal

.PersonEvents:
	db 9
	person_event SPRITE_COOLTRAINER_F, 9, 18, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x1aa983, -1
	person_event SPRITE_GRAMPS, 6, 23, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, VermilionMachopOwner, -1
	person_event SPRITE_MACHOP, 7, 26, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, VermilionMachop, -1
	person_event SPRITE_SUPER_NERD, 16, 14, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x1aa99b, -1
	person_event SPRITE_BIG_SNORLAX, 8, 34, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, VermilionSnorlax, EVENT_VERMILION_CITY_SNORLAX
	person_event SPRITE_POKEFAN_M, 12, 31, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, VermilionGymBadgeGuy, -1
	person_event SPRITE_LAWRENCE, 24, 19, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_VERMILION_CITY
	person_event SPRITE_CUT_TREE, 18, 13, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, VermilionCityCutTree, EVENT_VERMILION_CITY_CUT_TREE
