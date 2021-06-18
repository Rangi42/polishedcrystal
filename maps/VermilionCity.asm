VermilionCity_MapScriptHeader:
	def_scene_scripts
	scene_script LawrenceIntroScript

	def_callbacks
	callback MAPCALLBACK_OBJECTS, VermilionCitySetupLawrenceCallback
	callback MAPCALLBACK_BLOCKS, VermilionCitySetupBattleFactoryCallback

	def_warp_events
	warp_event  5,  5, VERMILION_HOUSE_FISHING_SPEECH_HOUSE, 1
	warp_event  9,  5, VERMILION_POKECENTER_1F, 1
	warp_event  7, 17, POKEMON_FAN_CLUB, 1
	warp_event 13, 17, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE, 1
	warp_event 21, 17, VERMILION_MART, 2
	warp_event 21, 21, VERMILION_HOUSE_DIGLETTS_CAVE_SPEECH_HOUSE, 1
	warp_event 10, 23, VERMILION_GYM, 1
	warp_event 18, 35, VERMILION_PORT, 1
	warp_event 19, 35, VERMILION_PORT, 3
	warp_event 36, 17, DIGLETTS_CAVE, 1
	warp_event 28, 35, SEAGALLOP_FERRY_VERMILION_GATE, 1
	warp_event 29, 35, SEAGALLOP_FERRY_VERMILION_GATE, 1
	warp_event 13,  5, VERMILION_POLLUTION_SPEECH_HOUSE, 1
	warp_event 19,  5, VERMILION_S_S_ANNE_SPEECH_HOUSE, 1
	warp_event 29,  9, BATTLE_FACTORY_1F, 1
	warp_event 30,  9, BATTLE_FACTORY_1F, 2

	def_coord_events

	def_bg_events
	bg_event 19,  9, BGEVENT_JUMPTEXT, VermilionCitySignText
	bg_event  5, 23, BGEVENT_JUMPTEXT, VermilionGymSignText
	bg_event  5, 17, BGEVENT_JUMPTEXT, PokemonFanClubSignText
	bg_event 33, 17, BGEVENT_JUMPTEXT, VermilionCityDiglettsCaveSignText
	bg_event 27, 19, BGEVENT_JUMPTEXT, VermilionCityPortSignText
	bg_event 23, 13, BGEVENT_JUMPTEXT, VermilionCityBattleFactorySignText
	bg_event 11, 27, BGEVENT_JUMPTEXT, VermilionCityAdvancedTipsSignText
	bg_event 12, 23, BGEVENT_ITEM + FULL_HEAL, EVENT_VERMILION_CITY_HIDDEN_FULL_HEAL

	def_object_events
	object_event 35, 18, SPRITE_BIG_SNORLAX, SPRITEMOVEDATA_SNORLAX, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionSnorlax, EVENT_VERMILION_CITY_SNORLAX
	object_event 18, 31, SPRITE_LAWRENCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LAWRENCE_VERMILION_CITY
	object_event 18, 13, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCityTeacherText, -1
	object_event 27, 13, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionMachokeOwnerScript, -1
	pokemon_event 28, 13, MACHOKE, -1, -1, PAL_NPC_BLUE, VermilionMachokeText, -1
	object_event 16, 20, SPRITE_ROCKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCitySuperNerdText, -1
	object_event 32, 12, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VermilionCitySuperNerd2Script, -1
	object_event 11,  9, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 3, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCitySailorText, -1
	object_event 31, 16, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, VermilionGymBadgeGuy, -1
	object_event 29, 10, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCityOfficerFText, EVENT_RESTORED_POWER_TO_KANTO
	object_event 30, 10, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, VermilionCityOfficerText, EVENT_RESTORED_POWER_TO_KANTO
	cuttree_event 13, 23, EVENT_VERMILION_CITY_CUT_TREE

	object_const_def
	const VERMILIONCITY_BIG_SNORLAX
	const VERMILIONCITY_LAWRENCE

VermilionCitySetupLawrenceCallback:
	checkscene
	iftrue .done
	readvar VAR_XCOORD
	ifequal 18, .done
	disappear VERMILIONCITY_LAWRENCE
	moveobject VERMILIONCITY_LAWRENCE, 19, 31
	appear VERMILIONCITY_LAWRENCE
.done
	endcallback

VermilionCitySetupBattleFactoryCallback:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .done
	callasm .DarkenPowerPlantDoors
.done
	endcallback

.DarkenPowerPlantDoors:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressedAttributes)
	ldh [rSVBK], a
	xor a ; PAL_BG_GRAY
	ld hl, wDecompressedAttributes + 16 * $34 + 8
	call .FillQuadrant
	ld hl, wDecompressedAttributes + 16 * $92 + 10
	call .FillQuadrant
	ld a, PAL_BG_BROWN
	ld [wDecompressedAttributes + 16 * $68 + 1], a
	ld [wDecompressedAttributes + 16 * $68 + 10], a
	ld [wDecompressedAttributes + 16 * $69 + 1], a
	ld [wDecompressedAttributes + 16 * $69 + 8], a
	ld [wDecompressedAttributes + 16 * $69 + 10], a
	ld [wDecompressedAttributes + 16 * $7f + 1], a
	ld [wDecompressedAttributes + 16 * $7f + 3], a
	ld [wDecompressedAttributes + 16 * $7f + 8], a
	ld [wDecompressedAttributes + 16 * $7f + 11], a
	pop af
	ldh [rSVBK], a
	ret

.FillQuadrant:
	ld [hli], a
	ld [hli], a
	inc hl
	inc hl
	ld [hli], a
	ld [hl], a
	ret

LawrenceIntroScript:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	showtext LawrenceOverheardText
	applymovement VERMILIONCITY_LAWRENCE, LawrenceApproachMovementData
	playsound SFX_TACKLE
	applymovement VERMILIONCITY_LAWRENCE, LawrenceBumpMovementData
	showemote EMOTE_SHOCK, VERMILIONCITY_LAWRENCE, 15
	pause 15
	readvar VAR_XCOORD
	ifequal 18, .left
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAroundRightMovementData
	turnobject PLAYER, LEFT
	sjump .continue

.left
	applymovement VERMILIONCITY_LAWRENCE, LawrenceWalkAroundLeftMovementData
	turnobject PLAYER, RIGHT
.continue
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext LawrenceIntroText
	applyonemovement VERMILIONCITY_LAWRENCE, turn_head_down
	pause 15
	playsound SFX_EXIT_BUILDING
	disappear VERMILIONCITY_LAWRENCE
	setscene $1
	setflag ENGINE_FLYPOINT_VERMILION
	special RestartMapMusic
	end

LawrenceApproachMovementData:
	step_down
	step_down
	step_down
	step_end

LawrenceBumpMovementData:
	fix_facing
	run_step_up
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

VermilionSnorlax:
	opentext
	special SpecialSnorlaxAwake
	iftrue .Awake
	jumpopenedtext VermilionCitySnorlaxSleepingText

.Awake:
	writetext VermilionCityRadioNearSnorlaxText
	pause 15
	cry SNORLAX
	closetext
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon SNORLAX, 60
	startbattle
	disappear VERMILIONCITY_BIG_SNORLAX
	setevent EVENT_FOUGHT_SNORLAX
	reloadmapafterbattle
	end

VermilionGymBadgeGuy:
	checkevent EVENT_GOT_BOTTLE_CAP_FROM_VERMILION_GUY
	iftrue_jumptextfaceplayer VermilionCityBadgeGuyBattleEdgeText
	readvar VAR_BADGES
	ifequal 16, .AllBadges
	ifgreater 13, .MostBadges
	ifgreater 9, .SomeBadges
	jumptextfaceplayer VermilionCityBadgeGuyTrainerText

.SomeBadges:
	jumptextfaceplayer VermilionCityBadgeGuySomeBadgesText

.MostBadges:
	jumptextfaceplayer VermilionCityBadgeGuyMostBadgesText

.AllBadges:
	faceplayer
	opentext
	writetext VermilionCityBadgeGuyAllBadgesText
	promptbutton
	verbosegiveitem BOTTLE_CAP
	iffalse_endtext
	setevent EVENT_GOT_BOTTLE_CAP_FROM_VERMILION_GUY
	writetext VermilionCityBadgeGuyBattleEdgeText
	waitendtext

VermilionMachokeOwnerScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer VermilionMachokeOwnerText
	jumpthistextfaceplayer

	text "My #mon"
	line "prepared the land"

	para "to construct that"
	line "huge building!"

	para "It's quite a shame"
	line "that the public"
	cont "can't enter yet…"
	done

VermilionCitySuperNerd2Script:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer VermilionCitySuperNerd2Text
	jumpthistextfaceplayer

	text "The Battle Factory"
	line "is brand-new!"

	para "But it draws a"
	line "huge amount of"
	cont "power…"

	para "With the Power"
	line "Plant offline,"
	cont "it's useless!"
	done

VermilionCityBadgeGuyBattleEdgeText:
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

VermilionCityTeacherText:
	text "Vermilion Port is"
	line "Kanto's seaside"
	cont "gateway."

	para "Luxury liners from"
	line "around the world"
	cont "dock here."
	done

VermilionMachokeOwnerText:
	text "My #mon"
	line "prepared the land"

	para "to construct that"
	line "huge building!"

	para "It was a Machop"
	line "three years ago,"

	para "but the effort"
	line "made it evolve!"
	done

VermilionMachokeText:
	text "Machoke: Guooh"
	line "gogogoh!"
	done

VermilionCitySuperNerdText:
	text "There are eight"
	line "Gyms in Kanto."

	para "That big building"
	line "is Vermilion's"
	cont "#mon Gym."
	done

VermilionCitySuperNerd2Text:
	text "The Battle Factory"
	line "is brand-new, but"

	para "trainers are al-"
	line "ready arriving"

	para "from distant"
	line "regions to take"
	cont "its challenge!"
	done

VermilionCityOfficerFText:
	text "The Power Plant's"
	line "generator is shut"
	cont "down, so it's not"

	para "safe to open the"
	line "Battle Factory."
	done

VermilionCityOfficerText:
	text "Sorry, the Battle"
	line "Factory is closed"

	para "until the Power"
	line "Plant is up and"
	cont "running again."
	done

VermilionCitySailorText:
	text "Nothing beats"
	line "good sea air!"
	done

VermilionCitySnorlaxSleepingText:
	text "Snorlax is snoring"
	line "peacefully…"
	done

VermilionCityRadioNearSnorlaxText:
	text "The #gear was"
	line "placed near the"
	cont "sleeping Snorlax…"

	para "…"

	para "Snorlax woke up!"
	done

VermilionCityBadgeGuyTrainerText:
	text "Skilled trainers"
	line "gather in Kanto."

	para "Gym Leaders are"
	line "especially strong."

	para "They won't be easy"
	line "to defeat."
	done

VermilionCityBadgeGuySomeBadgesText:
	text "You've started to"
	line "collect Kanto Gym"
	cont "Badges?"

	para "Don't you agree"
	line "that the trainers"
	cont "here are tough?"
	done

VermilionCityBadgeGuyMostBadgesText:
	text "I guess you'll be"
	line "finished with your"

	para "conquest of Kanto"
	line "Gyms soon."

	para "Let me know if"
	line "you get all eight"
	cont "Badges."
	done

VermilionCityBadgeGuyAllBadgesText:
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

VermilionCityAdvancedTipsSignText:
	text "Advanced Tips!"

	para "Your Trainer Card"
	line "has room to show"
	cont "sixteen Badges!"
	done

VermilionCityBattleFactorySignText:
	text "Battle Factory"

	para "Win it All with"
	line "Rental #mon!"
	done
