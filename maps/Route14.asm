const_value set 2
	const ROUTE14_POKEFAN_M1
	const ROUTE14_YOUNGSTER
	const ROUTE14_POKEFAN_M2
	const ROUTE14_KIM
	const ROUTE14_CUT_TREE1
	const ROUTE14_CUT_TREE2
	const ROUTE14_CUT_TREE3

Route14_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Kim:
	faceplayer
	opentext
	trade $5
	waitbutton
	closetext
	end

TrainerPokefanmCarter:
	trainer EVENT_BEAT_POKEFANM_CARTER, POKEFANM, CARTER, PokefanmCarterSeenText, PokefanmCarterBeatenText, 0, PokefanmCarterScript

PokefanmCarterScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad508
	waitbutton
	closetext
	end

TrainerBird_keeperRoy:
	trainer EVENT_BEAT_BIRD_KEEPER_ROY, BIRD_KEEPER, ROY, Bird_keeperRoySeenText, Bird_keeperRoyBeatenText, 0, Bird_keeperRoyScript

Bird_keeperRoyScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad5a4
	waitbutton
	closetext
	end

TrainerPokefanmTrevor:
	trainer EVENT_BEAT_POKEFANM_TREVOR, POKEFANM, TREVOR, PokefanmTrevorSeenText, PokefanmTrevorBeatenText, 0, PokefanmTrevorScript

PokefanmTrevorScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad660
	waitbutton
	closetext
	end

Route14CutTree:
	jumpstd cuttree

PokefanmCarterSeenText:
	text "Let me tell you,"
	line "I had a hard time"

	para "catching my prized"
	line "#mon."
	done

PokefanmCarterBeatenText:
	text "Awaaah!"
	done

UnknownText_0x1ad508:
	text "Squirtle, Charman-"
	line "der and Bulbasaur…"

	para "I think that's a"
	line "well-balanced mix."
	done

Bird_keeperRoySeenText:
	text "My dream is to fly"
	line "with my beloved"
	cont "bird #mon."
	done

Bird_keeperRoyBeatenText:
	text "I can dream, but I"
	line "can't ever fly…"
	done

UnknownText_0x1ad5a4:
	text "You have #mon"
	line "that know the HM"

	para "move Fly, don't"
	line "you? I envy you."
	done

PokefanmTrevorSeenText:
	text "Hi. Did you know…?"

	para "#mon get more"
	line "friendly if you"

	para "train them in a"
	line "place that they"
	cont "remember."
	done

PokefanmTrevorBeatenText:
	text "Where did I meet"
	line "this Psyduck?"
	done

UnknownText_0x1ad660:
	text "If only there were"
	line "an easy way to"

	para "identify where I"
	line "got my #mon…"

	para "Oh! I can just"
	line "check its stats!"
	done

Route14_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 7
	person_event SPRITE_POKEFAN_M, 15, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerPokefanmCarter, -1
	person_event SPRITE_YOUNGSTER, 27, 11, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperRoy, -1
	person_event SPRITE_POKEFAN_M, 11, 6, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerPokefanmTrevor, -1
	person_event SPRITE_TEACHER, 5, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 4, Kim, -1
	person_event SPRITE_BALL_CUT_FRUIT, 8, 5, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route14CutTree, EVENT_ROUTE_14_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 14, 11, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route14CutTree, EVENT_ROUTE_14_CUT_TREE_2
	person_event SPRITE_BALL_CUT_FRUIT, 24, 3, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route14CutTree, EVENT_ROUTE_14_CUT_TREE_3
