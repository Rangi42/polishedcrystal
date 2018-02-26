VioletCity_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, VioletCityFlyPoint

	db 11 ; warp events
	warp_event  9, 21, VIOLET_MART, 2
	warp_event 18, 21, VIOLET_GYM, 1
	warp_event 30, 21, EARLS_POKEMON_ACADEMY, 1
	warp_event  3, 19, VIOLET_NICKNAME_SPEECH_HOUSE, 1
	warp_event 31, 29, VIOLET_POKECENTER_1F, 1
	warp_event 21, 33, VIOLET_ONIX_TRADE_HOUSE, 1
	warp_event 23,  5, SPROUT_TOWER_1F, 1
	warp_event 39, 28, ROUTE_31_VIOLET_GATE, 1
	warp_event 39, 29, ROUTE_31_VIOLET_GATE, 2
	warp_event  2, 12, ROUTE_36_VIOLET_GATE, 3
	warp_event  2, 13, ROUTE_36_VIOLET_GATE, 4

	db 0 ; coord events

	db 6 ; bg events
	bg_event 24, 24, SIGNPOST_JUMPTEXT, VioletCitySignText
	bg_event 15, 21, SIGNPOST_JUMPTEXT, VioletGymSignText
	bg_event 25,  7, SIGNPOST_JUMPTEXT, SproutTowerSignText
	bg_event 27, 21, SIGNPOST_JUMPTEXT, EarlsPokemonAcademySignText
	bg_event 37, 18, SIGNPOST_ITEM + HYPER_POTION, EVENT_VIOLET_CITY_HIDDEN_HYPER_POTION
	bg_event 21, 13, SIGNPOST_ITEM + POKE_BALL, EVENT_VIOLET_CITY_HIDDEN_POKE_BALL

	db 13 ; object events
	object_event 13, 20, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, VioletCityEarlScript, EVENT_VIOLET_CITY_EARL
	object_event 28, 32, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletCityLassText, -1
	object_event 26, 18, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 2, 1, -1, (1 << MORN) | (1 << DAY), PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletCityCooltrainerM1Text, -1
	object_event 26, 18, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 2, 1, -1, (1 << NITE), PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletCityCooltrainerFText, -1
	object_event 17, 24, SPRITE_GUIDE_GENT, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletCityGrampsText, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event 16, 24, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletCityGrampsText, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event  5, 22, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletCityYoungsterText, -1
	object_event 26, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletCityFisherText, -1
	object_event 35, 29, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, VioletCityCooltrainerM2Text, -1
	cuttree_event 36, 23, EVENT_VIOLET_CITY_CUT_TREE
	fruittree_event 14, 33, FRUITTREE_VIOLET_CITY, CHERI_BERRY
	itemball_event 10,  6, PP_UP, 1, EVENT_VIOLET_CITY_PP_UP
	itemball_event 35, 12, RARE_CANDY, 1, EVENT_VIOLET_CITY_RARE_CANDY

	const_def 1 ; object constants
	const VIOLETCITY_EARL

VioletCityFlyPoint:
	setflag ENGINE_FLYPOINT_VIOLET
	return

VioletCityEarlScript:
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	faceplayer
	opentext
	writetext Text_EarlAsksIfYouBeatFalkner
	yesorno
	iffalse .FollowEarl
	jumpopenedtext Text_VeryNiceIndeed

.FollowEarl:
	writetext Text_FollowEarl
	waitbutton
	closetext
	playmusic MUSIC_SHOW_ME_AROUND
	follow VIOLETCITY_EARL, PLAYER
	applymovement VIOLETCITY_EARL, VioletCityFollowEarl_MovementData
	turnobject PLAYER, UP
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	stopfollow
	special RestartMapMusic
	showtext Text_HereTeacherIAm
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	applyonemovement VIOLETCITY_EARL, step_up
	playsound SFX_ENTER_DOOR
	disappear VIOLETCITY_EARL
	clearevent EVENT_EARLS_ACADEMY_EARL
	waitsfx
	end

VioletCityFollowEarl_MovementData:
	big_step_down
	big_step_down
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	big_step_down
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	big_step_up
	turn_head_down
	step_end

VioletCitySpinningEarl_MovementData:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

Text_EarlAsksIfYouBeatFalkner:
	text "Hello!"
	line "You are trainer?"

	para "Battle Gym Leader,"
	line "win you did?"
	done

Text_VeryNiceIndeed:
	text "Ooh, la la!"
	line "Very indeed nice!"
	done

Text_FollowEarl:
	text "Is that so? Then"
	line "study shall you!"
	cont "Follow me!"
	done

Text_HereTeacherIAm:
	text "Here, teacher I"
	line "am. Good it is"
	cont "you study here!"
	done

VioletCityLassText:
	text "Ghosts are rumored"
	line "to appear in"
	cont "Sprout Tower."

	para "They said Normal-"
	line "type #mon moves"

	para "had no effect on"
	line "ghosts."
	done

VioletCityCooltrainerM1Text:
	text "Hey, you're a"
	line "#mon trainer?"

	para "If you beat the"
	line "Gym Leader here,"

	para "you'll be ready"
	line "for prime time!"
	done

VioletCityCooltrainerFText:
	text "Bellsprout is a"
	line "popular #mon"
	cont "in this town."

	para "It doesn't do well"
	line "against our Gym"
	cont "Leader, though…"
	done

VioletCityGrampsText:
	text "Falkner, from the"
	line "Violet #mon"

	para "Gym, is a fine"
	line "trainer!"

	para "He inherited his"
	line "father's gym and"

	para "has done a great"
	line "job with it."
	done

VioletCityYoungsterText:
	text "I saw a wiggly"
	line "tree up ahead!"

	para "If you touch it,"
	line "it squirms and"
	cont "dances! Cool!"
	done

VioletCityFisherText:
	text "How does such a"
	line "wobbly building"

	para "survive an earth-"
	line "quake? I must be"
	cont "missing something."
	done

VioletCityCooltrainerM2Text:
	text "We care about the"
	line "traditional build-"
	cont "ings around here."

	para "Even the # Mart"
	line "and #mon Center"

	para "are painted som-"
	line "berly to blend in."
	done

VioletCitySignText:
	text "Violet City"

	para "The City of"
	line "Nostalgic Scents"
	done

VioletGymSignText:
	text "Violet City"
	line "#mon Gym"
	cont "Leader: Falkner"

	para "The Elegant Master"
	line "of Flying #mon"
	done

SproutTowerSignText:
	text "Sprout Tower"

	para "Experience the"
	line "Way of #mon"
	done

EarlsPokemonAcademySignText:
	text "Earl's #mon"
	line "Academy"
	done
