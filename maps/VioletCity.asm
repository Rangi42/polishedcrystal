const_value set 2
	const VIOLETCITY_EARL
	const VIOLETCITY_LASS
	const VIOLETCITY_SUPER_NERD
	const VIOLETCITY_GRAMPS
	const VIOLETCITY_YOUNGSTER
	const VIOLETCITY_FRUIT_TREE
	const VIOLETCITY_POKE_BALL1
	const VIOLETCITY_POKE_BALL2

VioletCity_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_VIOLET
	return

VioletCityEarlScript:
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	faceplayer
	opentext
	writetext Text_EarlAsksIfYouBeatFalkner
	yesorno
	iffalse .FollowEarl
	jump .PointlessJump

.PointlessJump:
	writetext Text_VeryNiceIndeed
	waitbutton
	closetext
	end

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
	opentext
	writetext Text_HereTeacherIAm
	waitbutton
	closetext
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	applymovement VIOLETCITY_EARL, VioletCityFinishFollowEarl_MovementData
	playsound SFX_ENTER_DOOR
	disappear VIOLETCITY_EARL
	clearevent EVENT_EARLS_ACADEMY_EARL
	waitsfx
	end

VioletCityLassScript:
	jumptextfaceplayer VioletCityLassText

VioletCitySuperNerdScript:
	jumptextfaceplayer VioletCitySuperNerdText

VioletCityGrampsScript:
	jumptextfaceplayer VioletCityGrampsText

VioletCityYoungsterScript:
	jumptextfaceplayer VioletCityYoungsterText

VioletCitySign:
	jumptext VioletCitySignText

VioletGymSign:
	jumptext VioletGymSignText

SproutTowerSign:
	jumptext SproutTowerSignText

EarlsPokemonAcademySign:
	jumptext EarlsPokemonAcademySignText

VioletCityPokeCenterSign:
	jumpstd pokecentersign

VioletCityMartSign:
	jumpstd martsign

VioletCityPPUp:
	itemball PP_UP

VioletCityRareCandy:
	itemball RARE_CANDY

VioletCityFruitTreeScript:
	fruittree FRUITTREE_VIOLET_CITY

VioletCityHiddenHyperPotion:
	dwb EVENT_VIOLET_CITY_HIDDEN_HYPER_POTION, HYPER_POTION

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

VioletCitySuperNerdText:
	text "Hey, you're a"
	line "#mon trainer?"

	para "If you beat the"
	line "Gym Leader here,"

	para "you'll be ready"
	line "for prime time!"
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

VioletCity_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 9
	warp_def $17, $9, 2, VIOLET_MART
	warp_def $17, $12, 1, VIOLET_GYM
	warp_def $17, $1e, 1, EARLS_POKEMON_ACADEMY
	warp_def $15, $3, 1, VIOLET_NICKNAME_SPEECH_HOUSE
	warp_def $1f, $1f, 1, VIOLET_POKECENTER_1F
	warp_def $23, $15, 1, VIOLET_ONIX_TRADE_HOUSE
	warp_def $5, $17, 1, SPROUT_TOWER_1F
	warp_def $1e, $27, 1, ROUTE_31_VIOLET_GATE
	warp_def $1e, $27, 2, ROUTE_31_VIOLET_GATE

.XYTriggers:
	db 0

.Signposts:
	db 7
	signpost 26, 24, SIGNPOST_READ, VioletCitySign
	signpost 23, 15, SIGNPOST_READ, VioletGymSign
	signpost  8, 24, SIGNPOST_READ, SproutTowerSign
	signpost 23, 27, SIGNPOST_READ, EarlsPokemonAcademySign
	signpost 31, 32, SIGNPOST_READ, VioletCityPokeCenterSign
	signpost 23, 10, SIGNPOST_READ, VioletCityMartSign
	signpost 20, 37, SIGNPOST_ITEM, VioletCityHiddenHyperPotion

.PersonEvents:
	db 8
	person_event SPRITE_FISHER, 22, 13, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, VioletCityEarlScript, EVENT_VIOLET_CITY_EARL
	person_event SPRITE_LASS, 34, 28, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, VioletCityLassScript, -1
	person_event SPRITE_SUPER_NERD, 20, 26, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, VioletCitySuperNerdScript, -1
	person_event SPRITE_GRAMPS, 26, 17, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, VioletCityGrampsScript, -1
	person_event SPRITE_YOUNGSTER, 24, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, VioletCityYoungsterScript, -1
	person_event SPRITE_FRUIT_TREE, 35, 14, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, VioletCityFruitTreeScript, -1
	person_event SPRITE_POKE_BALL, 9, 8, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, VioletCityPPUp, EVENT_VIOLET_CITY_PP_UP
	person_event SPRITE_POKE_BALL, 11, 35, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, VioletCityRareCandy, EVENT_VIOLET_CITY_RARE_CANDY
