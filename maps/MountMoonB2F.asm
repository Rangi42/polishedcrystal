const_value set 2
	const MOUNTMOONB2F_YOUNGSTER1
	const MOUNTMOONB2F_YOUNGSTER2
	const MOUNTMOONB2F_HEX_MANIAC
	const MOUNTMOONB2F_COOLTRAINER_M
	const MOUNTMOONB2F_SUPER_NERD

MountMoonB2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerYoungsterJosh:
	trainer EVENT_BEAT_YOUNGSTER_JOSH, YOUNGSTER, YOUNGSTER_JOSH, YoungsterJoshSeenText, YoungsterJoshBeatenText, 0, YoungsterJoshScript

YoungsterJoshScript:
	end_if_just_battled
	opentext
	writetext YoungsterJoshAfterText
	waitbutton
	closetext
	end

TrainerBird_keeperMick:
	trainer EVENT_BEAT_BIRD_KEEPER_MICK, BIRD_KEEPER, MICK, Bird_keeperMickSeenText, Bird_keeperMickBeatenText, 0, Bird_keeperMickScript

Bird_keeperMickScript:
	end_if_just_battled
	opentext
	writetext Bird_keeperMickAfterText
	waitbutton
	closetext
	end

TrainerHexManiacEsther:
	trainer EVENT_BEAT_HEX_MANIAC_ESTHER, HEX_MANIAC, ESTHER, HexManiacEstherSeenText, HexManiacEstherBeatenText, 0, HexManiacEstherScript

HexManiacEstherScript:
	end_if_just_battled
	opentext
	writetext HexManiacEstherAfterText
	waitbutton
	closetext
	end

TrainerCooltrainermConnor:
	trainer EVENT_BEAT_COOLTRAINERM_CONNOR, COOLTRAINERM, CONNOR, CooltrainermConnorSeenText, CooltrainermConnorBeatenText, 0, CooltrainermConnorScript

CooltrainermConnorScript:
	end_if_just_battled
	opentext
	writetext CooltrainermConnorAfterText
	waitbutton
	closetext
	end

TrainerSuperNerdMiguel:
	trainer EVENT_BEAT_SUPER_NERD_MIGUEL, SUPER_NERD, MIGUEL, SuperNerdMiguelSeenText, SuperNerdMiguelBeatenText, 0, SuperNerdMiguelScript

SuperNerdMiguelScript:
	end_if_just_battled
	opentext
	writetext SuperNerdMiguelAfterText
	waitbutton
	closetext
	end

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

MountMoonB2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $18, $a, 4, MOUNT_MOON_B1F
	warp_def $7, $15, 5, MOUNT_MOON_B1F
	warp_def $f, $11, 6, MOUNT_MOON_B1F
	warp_def $9, $3, 7, MOUNT_MOON_B1F
	warp_def $15, $12, 9, MOUNT_MOON_B1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_YOUNGSTER, 9, 24, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerYoungsterJosh, -1
	person_event SPRITE_YOUNGSTER, 22, 12, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 1, TrainerBird_keeperMick, -1
	person_event SPRITE_HEX_MANIAC, 18, 29, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerHexManiacEsther, -1
	person_event SPRITE_COOLTRAINER_M, 15, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerCooltrainermConnor, -1
	person_event SPRITE_SUPER_NERD, 8, 9, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerSuperNerdMiguel, -1
