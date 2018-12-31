MountMoonB2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MountMoonB2F_MapEventHeader:

.Warps: db 4
	warp_def 24, 10, 4, MOUNT_MOON_B1F
	warp_def 7, 21, 5, MOUNT_MOON_B1F
	warp_def 15, 17, 6, MOUNT_MOON_B1F
	warp_def 9, 3, 7, MOUNT_MOON_B1F

.XYTriggers: db 0

.Signposts: db 3
	signpost 7, 28, SIGNPOST_ITEM + ETHER, EVENT_MOUNT_MOON_B2F_HIDDEN_ETHER
	signpost 9, 7, SIGNPOST_ITEM + STARDUST, EVENT_MOUNT_MOON_B2F_HIDDEN_STARDUST
	signpost 30, 10, SIGNPOST_ITEM + PP_UP, EVENT_MOUNT_MOON_B2F_HIDDEN_PP_UP

.PersonEvents: db 11
	person_event SPRITE_YOUNGSTER, 9, 24, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerYoungsterJosh, -1
	person_event SPRITE_YOUNGSTER, 21, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBird_keeperMick, -1
	person_event SPRITE_HEX_MANIAC, 18, 29, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerHexManiacEsther, -1
	person_event SPRITE_COOLTRAINER_M, 15, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerCooltrainermConnor, -1
	person_event SPRITE_SUPER_NERD, 8, 9, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerSuperNerdMiguel, -1
	person_event SPRITE_BOULDER_ROCK_FOSSIL, 6, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, HELIX_FOSSIL, 1, EVENT_MOUNT_MOON_B2F_HELIX_FOSSIL
	person_event SPRITE_BOULDER_ROCK_FOSSIL, 6, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, DOME_FOSSIL, 1, EVENT_MOUNT_MOON_B2F_DOME_FOSSIL
	itemball_event 14, 11, MOON_STONE, 1, EVENT_MOUNT_MOON_B2F_MOON_STONE
	itemball_event 21, 18, DUSK_STONE, 1, EVENT_MOUNT_MOON_B2F_DUSK_STONE
	itemball_event 3, 22, SHINY_STONE, 1, EVENT_MOUNT_MOON_B2F_SHINY_STONE
	itemball_event 11, 26, BIG_MUSHROOM, 1, EVENT_MOUNT_MOON_B2F_BIG_MUSHROOM

TrainerYoungsterJosh:
	trainer EVENT_BEAT_YOUNGSTER_JOSH, YOUNGSTER, YOUNGSTER_JOSH, YoungsterJoshSeenText, YoungsterJoshBeatenText, 0, YoungsterJoshScript

YoungsterJoshScript:
	end_if_just_battled
	jumptextfaceplayer YoungsterJoshAfterText

TrainerBird_keeperMick:
	trainer EVENT_BEAT_BIRD_KEEPER_MICK, BIRD_KEEPER, MICK, Bird_keeperMickSeenText, Bird_keeperMickBeatenText, 0, Bird_keeperMickScript

Bird_keeperMickScript:
	end_if_just_battled
	jumptextfaceplayer Bird_keeperMickAfterText

TrainerHexManiacEsther:
	trainer EVENT_BEAT_HEX_MANIAC_ESTHER, HEX_MANIAC, ESTHER, HexManiacEstherSeenText, HexManiacEstherBeatenText, 0, HexManiacEstherScript

HexManiacEstherScript:
	end_if_just_battled
	jumptextfaceplayer HexManiacEstherAfterText

TrainerCooltrainermConnor:
	trainer EVENT_BEAT_COOLTRAINERM_CONNOR, COOLTRAINERM, CONNOR, CooltrainermConnorSeenText, CooltrainermConnorBeatenText, 0, CooltrainermConnorScript

CooltrainermConnorScript:
	end_if_just_battled
	jumptextfaceplayer CooltrainermConnorAfterText

TrainerSuperNerdMiguel:
	trainer EVENT_BEAT_SUPER_NERD_MIGUEL, SUPER_NERD, MIGUEL, SuperNerdMiguelSeenText, SuperNerdMiguelBeatenText, 0, SuperNerdMiguelScript

SuperNerdMiguelScript:
	end_if_just_battled
	jumptextfaceplayer SuperNerdMiguelAfterText

YoungsterJoshSeenText:
	text "You came to ex-"
	line "plore the cave,"
	cont "right?"

	para "Be careful, you"
	line "may get lost."
	done

YoungsterJoshBeatenText:
	text "You're not lost"
	line "at all."
	done

YoungsterJoshAfterText:
	text "With that team of"
	line "#mon, you must"

	para "have explored a"
	line "lot of places."

	para "Getting lost is"
	line "your everyday"
	cont "fare, huh?"
	done

Bird_keeperMickSeenText:
	text "I'm not sure why"
	line "I came here."

	para "My birds can't fly"
	line "in this cave!"
	done

Bird_keeperMickBeatenText:
	text "Yeah, this was a"
	line "bad idea."
	done

Bird_keeperMickAfterText:
	text "Birds of a feather"
	line "flock together."

	para "I should go hang"
	line "out with other"

	para "Bird Keepers some-"
	line "where sensible."
	done

HexManiacEstherSeenText:
	text "Mirror, mirror,"
	line "on the wall,"

	para "who will throw"
	line "their # Ball?"
	done

HexManiacEstherBeatenText:
	text "You will!"
	done

HexManiacEstherAfterText:
	text "Magic mirror,"
	line "great and wise,"

	para "failed to see my"
	line "swift demise."
	done

CooltrainermConnorSeenText:
	text "You've either got"
	line "it or you don't."
	done

CooltrainermConnorBeatenText:
	text "Whoa!"
	line "You've got it!"
	done

CooltrainermConnorAfterText:
	text "Style and charm"
	line "go hand in hand."

	para "They're the cool-"
	line "est combination."
	done

SuperNerdMiguelSeenText:
	text "I found these"
	line "fossils and re-"
	cont "vived them!"

	para "Now they're both"
	line "mine!"
	done

SuperNerdMiguelBeatenText:
	text "My fossils were"
	line "crushed!"
	done

SuperNerdMiguelAfterText:
	text "Maybe if I had"
	line "an Aerodactyl…"
	done
