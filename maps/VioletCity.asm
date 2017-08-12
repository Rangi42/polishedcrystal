VioletCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, VioletCityFlyPoint
	dbw MAPCALLBACK_SPRITES, VioletCitySwimmerGuySprite

VioletCity_MapEventHeader:

.Warps: db 11
	warp_def $15, $9, 2, VIOLET_MART
	warp_def $15, $12, 1, VIOLET_GYM
	warp_def $15, $1e, 1, EARLS_POKEMON_ACADEMY
	warp_def $13, $3, 1, VIOLET_NICKNAME_SPEECH_HOUSE
	warp_def $1d, $1f, 1, VIOLET_POKECENTER_1F
	warp_def $21, $15, 1, VIOLET_ONIX_TRADE_HOUSE
	warp_def $5, $17, 1, SPROUT_TOWER_1F
	warp_def $1c, $27, 1, ROUTE_31_VIOLET_GATE
	warp_def $1d, $27, 2, ROUTE_31_VIOLET_GATE
	warp_def $c, $2, 3, ROUTE_36_VIOLET_GATE
	warp_def $d, $2, 4, ROUTE_36_VIOLET_GATE

.XYTriggers: db 0

.Signposts: db 6
	signpost 24, 24, SIGNPOST_JUMPTEXT, VioletCitySignText
	signpost 21, 15, SIGNPOST_JUMPTEXT, VioletGymSignText
	signpost  8, 24, SIGNPOST_JUMPTEXT, SproutTowerSignText
	signpost 21, 27, SIGNPOST_JUMPTEXT, EarlsPokemonAcademySignText
	signpost 18, 37, SIGNPOST_ITEM, VioletCityHiddenHyperPotion
	signpost 12, 21, SIGNPOST_ITEM, VioletCityHiddenPokeBall

.PersonEvents: db 13
	person_event SPRITE_FISHER, 20, 13, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, VioletCityEarlScript, EVENT_VIOLET_CITY_EARL
	person_event SPRITE_NEW_BARK_LYRA, 32, 28, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_JUMPTEXTFP, 0, VioletCityLassText, -1
	person_event SPRITE_COOLTRAINER_M, 18, 26, SPRITEMOVEDATA_WANDER, 2, 1, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_RED, PERSONTYPE_JUMPTEXTFP, 0, VioletCityCooltrainerM1Text, -1
	person_event SPRITE_COOLTRAINER_F, 18, 26, SPRITEMOVEDATA_WANDER, 2, 1, -1, (1 << NITE), (1 << 3) | PAL_OW_RED, PERSONTYPE_JUMPTEXTFP, 0, VioletCityCooltrainerFText, -1
	person_event SPRITE_GRAMPS, 24, 16, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, VioletCityGrampsText, -1
	person_event SPRITE_YOUNGSTER, 22, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_JUMPTEXTFP, 0, VioletCityYoungsterText, -1
	person_event SPRITE_FISHER, 12, 26, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_JUMPTEXTFP, 0, VioletCityFisherText, -1
	person_event SPRITE_BALL_CUT_FRUIT, 23, 36, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, cuttree, EVENT_VIOLET_CITY_CUT_TREE
	person_event SPRITE_BALL_CUT_FRUIT, 33, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_FRUITTREE, 0, FRUITTREE_VIOLET_CITY, CHERI_BERRY, -1
	person_event SPRITE_BALL_CUT_FRUIT, 6, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, PP_UP, 1, EVENT_VIOLET_CITY_PP_UP
	person_event SPRITE_BALL_CUT_FRUIT, 11, 35, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RARE_CANDY, 1, EVENT_VIOLET_CITY_RARE_CANDY
	person_event SPRITE_COOLTRAINER_M, 29, 35, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_JUMPTEXTFP, 0, VioletCityCooltrainerM2Text, -1

const_value set 2
	const VIOLETCITY_EARL

VioletCityFlyPoint:
	setflag ENGINE_FLYPOINT_VIOLET
	return

VioletCitySwimmerGuySprite:
	variablesprite SPRITE_GUIDE_GENT, SPRITE_SWIMMER_GUY
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
	spriteface PLAYER, UP
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	stopfollow
	special RestartMapMusic
	showtext Text_HereTeacherIAm
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	applymovement VIOLETCITY_EARL, VioletCityFinishFollowEarl_MovementData
	playsound SFX_ENTER_DOOR
	disappear VIOLETCITY_EARL
	clearevent EVENT_EARLS_ACADEMY_EARL
	waitsfx
	end

VioletCityHiddenHyperPotion:
	dwb EVENT_VIOLET_CITY_HIDDEN_HYPER_POTION, HYPER_POTION

VioletCityHiddenPokeBall:
	dwb EVENT_VIOLET_CITY_HIDDEN_POKE_BALL, POKE_BALL

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

VioletCityFinishFollowEarl_MovementData:
	step_up
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
