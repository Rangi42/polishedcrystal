MountMortar1FInside_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MountMortar1FInside_MapEventHeader:

.Warps: db 6
	warp_def $2f, $b, 5, MOUNT_MORTAR_1F_OUTSIDE
	warp_def $2f, $1d, 6, MOUNT_MORTAR_1F_OUTSIDE
	warp_def $27, $5, 8, MOUNT_MORTAR_1F_OUTSIDE
	warp_def $29, $21, 9, MOUNT_MORTAR_1F_OUTSIDE
	warp_def $13, $3, 1, MOUNT_MORTAR_B1F
	warp_def $9, $9, 2, MOUNT_MORTAR_2F_INSIDE

.XYTriggers: db 0

.Signposts: db 1
	signpost 11, 30, SIGNPOST_ITEM, MountMortar1FInsideHiddenMaxRepel

.PersonEvents: db 10
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 43, 21, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, strengthboulder, -1
	person_event SPRITE_BALL_CUT_FRUIT, 38, 35, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SMOOTH_ROCK, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_SMOOTH_ROCK
	person_event SPRITE_BALL_CUT_FRUIT, 10, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, MAX_REVIVE, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_MAX_REVIVE
	person_event SPRITE_BALL_CUT_FRUIT, 27, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, HYPER_POTION, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_HYPER_POTION
	person_event SPRITE_BALL_CUT_FRUIT, 20, 22, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, MAX_POTION, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_MAX_POTION
	person_event SPRITE_BALL_CUT_FRUIT, 19, 35, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, NUGGET, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_NUGGET
	person_event SPRITE_SUPER_NERD, 43, 33, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacMiller, -1
	person_event SPRITE_SUPER_NERD, 28, 24, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdMarkus, -1
	person_event SPRITE_BALL_CUT_FRUIT, 16, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, IRON, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_IRON
	person_event SPRITE_BALL_CUT_FRUIT, 17, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, ULTRA_BALL, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_ULTRA_BALL

TrainerPokemaniacMiller:
	trainer EVENT_BEAT_POKEMANIAC_MILLER, POKEMANIAC, MILLER, PokemaniacMillerSeenText, PokemaniacMillerBeatenText, 0, PokemaniacMillerScript

PokemaniacMillerScript:
	end_if_just_battled
	jumptext UnknownText_0x7debd

TrainerSupernerdMarkus:
	trainer EVENT_BEAT_SUPER_NERD_MARKUS, SUPER_NERD, MARKUS, SupernerdMarkusSeenText, SupernerdMarkusBeatenText, 0, SupernerdMarkusScript

SupernerdMarkusScript:
	end_if_just_battled
	jumptext UnknownText_0x7df97

MountMortar1FInsideHiddenMaxRepel:
	dwb EVENT_MOUNT_MORTAR_1F_INSIDE_HIDDEN_MAX_REPEL, MAX_REPEL

PokemaniacMillerSeenText:
	text "I'm not losing"
	line "this time!"
	done

PokemaniacMillerBeatenText:
	text "I lost to some"
	line "kid…?"
	done

UnknownText_0x7debd:
	text "A while back, this"
	line "karate dude wanted"

	para "to battle. He was"
	line "ridiculously good."

	para "He just thrashed"
	line "us silly."

	para "He went in deeper"
	line "saying it was for"

	para "his training. I"
	line "wonder how he is?"
	done

SupernerdMarkusSeenText:
	text "Hey! Hugh!"
	done

SupernerdMarkusBeatenText:
	text "I mistook you for"
	line "someone else…"
	done

UnknownText_0x7df97:
	text "I came to explore"
	line "Mt.Mortar, but I"

	para "got separated from"
	line "my partner…"

	para "Did you run into a"
	line "trainer who uses a"

	para "Seadra that knows"
	line "Waterfall?"
	done
