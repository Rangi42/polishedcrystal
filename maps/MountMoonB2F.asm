MountMoonB2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 10, 24, 4, MOUNT_MOON_B1F
	warp_event 21, 7, 5, MOUNT_MOON_B1F
	warp_event 17, 15, 6, MOUNT_MOON_B1F
	warp_event 3, 9, 7, MOUNT_MOON_B1F

	db 0 ; coord events

	db 3 ; bg events
	bg_event 28, 7, SIGNPOST_ITEM + ETHER, EVENT_MOUNT_MOON_B2F_HIDDEN_ETHER
	bg_event 7, 9, SIGNPOST_ITEM + STARDUST, EVENT_MOUNT_MOON_B2F_HIDDEN_STARDUST
	bg_event 10, 30, SIGNPOST_ITEM + PP_UP, EVENT_MOUNT_MOON_B2F_HIDDEN_PP_UP

	db 11 ; object events
	object_event 24, 9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerYoungsterJosh, -1
	object_event 12, 21, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBird_keeperMick, -1
	object_event 29, 18, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerHexManiacEsther, -1
	object_event 4, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerCooltrainermConnor, -1
	object_event 9, 8, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerSuperNerdMiguel, -1
	object_event 10, 6, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, HELIX_FOSSIL, 1, EVENT_MOUNT_MOON_B2F_HELIX_FOSSIL
	object_event 11, 6, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_POKEBALL, PLAYEREVENT_ITEMBALL, DOME_FOSSIL, 1, EVENT_MOUNT_MOON_B2F_DOME_FOSSIL
	itemball_event 11, 14, MOON_STONE, 1, EVENT_MOUNT_MOON_B2F_MOON_STONE
	itemball_event 18, 21, DUSK_STONE, 1, EVENT_MOUNT_MOON_B2F_DUSK_STONE
	itemball_event 22, 3, SHINY_STONE, 1, EVENT_MOUNT_MOON_B2F_SHINY_STONE
	itemball_event 26, 11, BIG_MUSHROOM, 1, EVENT_MOUNT_MOON_B2F_BIG_MUSHROOM

TrainerYoungsterJosh:
	trainer YOUNGSTER, YOUNGSTER_JOSH, EVENT_BEAT_YOUNGSTER_JOSH, YoungsterJoshSeenText, YoungsterJoshBeatenText, 0, YoungsterJoshScript

YoungsterJoshScript:
	end_if_just_battled
	jumptextfaceplayer YoungsterJoshAfterText

TrainerBird_keeperMick:
	trainer BIRD_KEEPER, MICK, EVENT_BEAT_BIRD_KEEPER_MICK, Bird_keeperMickSeenText, Bird_keeperMickBeatenText, 0, Bird_keeperMickScript

Bird_keeperMickScript:
	end_if_just_battled
	jumptextfaceplayer Bird_keeperMickAfterText

TrainerHexManiacEsther:
	trainer HEX_MANIAC, ESTHER, EVENT_BEAT_HEX_MANIAC_ESTHER, HexManiacEstherSeenText, HexManiacEstherBeatenText, 0, HexManiacEstherScript

HexManiacEstherScript:
	end_if_just_battled
	jumptextfaceplayer HexManiacEstherAfterText

TrainerCooltrainermConnor:
	trainer COOLTRAINERM, CONNOR, EVENT_BEAT_COOLTRAINERM_CONNOR, CooltrainermConnorSeenText, CooltrainermConnorBeatenText, 0, CooltrainermConnorScript

CooltrainermConnorScript:
	end_if_just_battled
	jumptextfaceplayer CooltrainermConnorAfterText

TrainerSuperNerdMiguel:
	trainer SUPER_NERD, MIGUEL, EVENT_BEAT_SUPER_NERD_MIGUEL, SuperNerdMiguelSeenText, SuperNerdMiguelBeatenText, 0, SuperNerdMiguelScript

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
