MountMortar1FInside_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MountMortar1FInside_MapEventHeader:

.Warps: db 6
	warp_def 47, 11, 5, MOUNT_MORTAR_1F_OUTSIDE
	warp_def 47, 29, 6, MOUNT_MORTAR_1F_OUTSIDE
	warp_def 39, 5, 8, MOUNT_MORTAR_1F_OUTSIDE
	warp_def 41, 33, 9, MOUNT_MORTAR_1F_OUTSIDE
	warp_def 19, 3, 1, MOUNT_MORTAR_B1F
	warp_def 9, 9, 2, MOUNT_MORTAR_2F_INSIDE

.XYTriggers: db 0

.Signposts: db 1
	signpost 11, 30, SIGNPOST_ITEM + MAX_REPEL, EVENT_MOUNT_MORTAR_1F_INSIDE_HIDDEN_MAX_REPEL

.PersonEvents: db 10
	strengthboulder_event 43, 21
	itemball_event 38, 35, SMOOTH_ROCK, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_SMOOTH_ROCK
	itemball_event 10, 16, MAX_REVIVE, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_MAX_REVIVE
	itemball_event 27, 10, HYPER_POTION, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_HYPER_POTION
	itemball_event 20, 22, MAX_POTION, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_MAX_POTION
	itemball_event 19, 35, NUGGET, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_NUGGET
	person_event SPRITE_SUPER_NERD, 43, 33, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacMiller, -1
	person_event SPRITE_SUPER_NERD, 28, 24, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdMarkus, -1
	itemball_event 16, 8, IRON, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_IRON
	itemball_event 17, 17, ULTRA_BALL, 1, EVENT_MOUNT_MORTAR_1F_INSIDE_ULTRA_BALL

TrainerPokemaniacMiller:
	trainer EVENT_BEAT_POKEMANIAC_MILLER, POKEMANIAC, MILLER, PokemaniacMillerSeenText, PokemaniacMillerBeatenText, 0, PokemaniacMillerScript

PokemaniacMillerScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7debd

TrainerSupernerdMarkus:
	trainer EVENT_BEAT_SUPER_NERD_MARKUS, SUPER_NERD, MARKUS, SupernerdMarkusSeenText, SupernerdMarkusBeatenText, 0, SupernerdMarkusScript

SupernerdMarkusScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7df97

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
