const_value set 2
	const ROUTE14_POKEFAN_M1
	const ROUTE14_POKEFAN_M2
	const ROUTE14_YOUNGSTER1
	const ROUTE14_YOUNGSTER2
	const ROUTE14_YOUNGSTER3
	const ROUTE14_YOUNGSTER4
	const ROUTE14_TEACHER
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

TrainerPokefanmTrevor:
	trainer EVENT_BEAT_POKEFANM_TREVOR, POKEFANM, TREVOR, PokefanmTrevorSeenText, PokefanmTrevorBeatenText, 0, PokefanmTrevorScript

PokefanmTrevorScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad660
	waitbutton
	closetext
	end

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

TrainerPokefanmCarter:
	trainer EVENT_BEAT_POKEFANM_CARTER, POKEFANM, CARTER, PokefanmCarterSeenText, PokefanmCarterBeatenText, 0, PokefanmCarterScript

PokefanmCarterScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad508
	waitbutton
	closetext
	end

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

TrainerBird_keeperRoy:
	trainer EVENT_BEAT_BIRD_KEEPER_ROY, BIRD_KEEPER, ROY, Bird_keeperRoySeenText, Bird_keeperRoyBeatenText, 0, Bird_keeperRoyScript

Bird_keeperRoyScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad5a4
	waitbutton
	closetext
	end

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

TrainerBird_keeperJosh:
	trainer EVENT_BEAT_BIRD_KEEPER_JOSH, BIRD_KEEPER, BIRD_KEEPER_JOSH, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "My weight puts me"
	line "in the feather-"
	cont "weight class!"

	para "…Huh? What do you"
	line "mean that doesn't"
	cont "sound very strong?"
	done

.BeatenText:
	text "I lost as lightly"
	line "as a feather"
	cont "floats!"
	done

.AfterText:
	text "Maybe I should lie"
	line "and say I'm in the"
	cont "heavyweight class…"
	done

TrainerSchoolboyConnor:
	trainer EVENT_BEAT_SCHOOLBOY_CONNOR, SCHOOLBOY, SCHOOLBOY_CONNOR, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "I can't wait to go"
	line "home and drop off"
	cont "my Bag!"
	done

.BeatenText:
	text "I was in too much"
	line "of a hurry."
	done

.AfterText:
	text "Don't rush, and"
	line "take the road one"
	cont "step at a time."

	para "Great advice!"
	done

TrainerSchoolboyTorin:
	trainer EVENT_BEAT_SCHOOLBOY_TORIN, SCHOOLBOY, TORIN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "It's good to put"
	line "what you learn to"
	cont "use immediately!"
	done

.BeatenText:
	text "I see. I see."
	done

.AfterText:
	text "All right! Next"
	line "time, I won't make"
	cont "any mistakes!"
	done

TrainerSchoolboyTravis:
	trainer EVENT_BEAT_SCHOOLBOY_TRAVIS, SCHOOLBOY, TRAVIS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Do you have after-"
	line "school study"
	cont "sessions?"
	done

.BeatenText:
	text "So strong…"
	done

.AfterText:
	text "Maybe I should"
	line "join your study"
	cont "sessions!"
	done

TrainerTeacherClarice:
	trainer EVENT_BEAT_TEACHER_CLARICE, TEACHER, CLARICE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "All right, let's"
	line "get this #mon"
	cont "battle started!"
	done

.BeatenText:
	text "All right! That"
	line "concludes today's"
	cont "battle."
	done

.AfterText:
	text "Don't relax just"
	line "'cause you won."

	para "Once you get home,"
	line "you should do a"
	cont "full review!"
	done

Route14CutTree:
	jumpstd cuttree

Route14_MapEventHeader:
.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 12
	person_event SPRITE_POKEFAN_M, 6, 13, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerPokefanmTrevor, -1
	person_event SPRITE_POKEFAN_M, 19, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerPokefanmCarter, -1
	person_event SPRITE_YOUNGSTER, 27, 11, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperRoy, -1
	person_event SPRITE_YOUNGSTER, 12, 15, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBird_keeperJosh, -1
	person_event SPRITE_YOUNGSTER, 15, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerSchoolboyConnor, -1
	person_event SPRITE_YOUNGSTER, 13, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerSchoolboyTorin, -1
	person_event SPRITE_YOUNGSTER, 11, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerSchoolboyTravis, -1
	person_event SPRITE_TEACHER, 13, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerTeacherClarice, -1
	person_event SPRITE_TEACHER, 5, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 4, Kim, -1
	person_event SPRITE_BALL_CUT_FRUIT, 8, 5, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route14CutTree, EVENT_ROUTE_14_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 14, 11, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route14CutTree, EVENT_ROUTE_14_CUT_TREE_2
	person_event SPRITE_BALL_CUT_FRUIT, 24, 3, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route14CutTree, EVENT_ROUTE_14_CUT_TREE_3
