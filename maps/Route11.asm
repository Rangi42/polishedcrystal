const_value set 2
	const ROUTE11_YOUNGSTER1
	const ROUTE11_YOUNGSTER2
	const ROUTE11_YOUNGSTER3
	const ROUTE11_YOUNGSTER4
	const ROUTE11_YOUNGSTER5
	const ROUTE11_YOUNGSTER6
	const ROUTE11_ENGINEER1
	const ROUTE11_ENGINEER2
	const ROUTE11_FRUIT_TREE

Route11_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerYoungsterOwen:
	trainer EVENT_BEAT_YOUNGSTER_OWEN, YOUNGSTER, OWEN, YoungsterOwenSeenText, YoungsterOwenBeatenText, 0, YoungsterOwenScript

YoungsterOwenScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x680b2
	waitbutton
	closetext
	end

YoungsterOwenSeenText:
	text "There's no cheat-"
	line "ing in #mon."

	para "Let's keep it fair"
	line "and square!"
	done

YoungsterOwenBeatenText:
	text "Huh? How did this"
	line "happen?"
	done

UnknownText_0x680b2:
	text "I fought fair and"
	line "square with honor."

	para "I don't regret"
	line "this at all."
	done

TrainerYoungsterJason:
	trainer EVENT_BEAT_YOUNGSTER_JASON, YOUNGSTER, JASON, YoungsterJasonSeenText, YoungsterJasonBeatenText, 0, YoungsterJasonScript

YoungsterJasonScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x6814a
	waitbutton
	closetext
	end

YoungsterJasonSeenText:
	text "It itches and"
	line "tickles a bit when"

	para "I wear shorts in"
	line "the grass."
	done

YoungsterJasonBeatenText:
	text "Aiyaaah!"
	line "I got stomped!"
	done

UnknownText_0x6814a:
	text "I'm going to catch"
	line "more #mon in"
	cont "the grass."
	done

TrainerYoungsterAlfie:
	trainer EVENT_BEAT_YOUNGSTER_ALFIE, YOUNGSTER, ALFIE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Three, two, one,"
	line "GO!"
	done

.BeatenText:
	text "Game, set, match."
	done

.AfterText:
	text "Everything's more"
	line "fun when it's a"
	cont "competition."
	done

TrainerPsychicHerman:
	trainer EVENT_BEAT_PSYCHIC_HERMAN, PSYCHIC_T, HERMAN, PsychicHermanSeenText, PsychicHermanBeatenText, 0, PsychicHermanScript

PsychicHermanScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x6817b
	waitbutton
	closetext
	end

PsychicHermanSeenText:
	text "…"
	done

PsychicHermanBeatenText:
	text "…"
	done

UnknownText_0x6817b:
	text "…"

	para "I lost while I had"
	line "my eyes closed…"
	done

TrainerPsychicFidel:
	trainer EVENT_BEAT_PSYCHIC_FIDEL, PSYCHIC_T, FIDEL, PsychicFidelSeenText, PsychicFidelBeatenText, 0, PsychicFidelScript

PsychicFidelScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x681ec
	waitbutton
	closetext
	end

PsychicFidelSeenText:
	text "I can see it…"

	para "Everything to see"
	line "about you…"
	done

PsychicFidelBeatenText:
	text "I couldn't foresee"
	line "your power…"
	done

UnknownText_0x681ec:
	text "Strength in con-"
	line "viction…"

	para "You're strong be-"
	line "cause you believe"
	cont "in your #mon."
	done

TrainerPsychicUri:
	trainer EVENT_BEAT_PSYCHIC_URI, PSYCHIC_T, URI, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "It happened one"
	line "morning--a boy"
	cont "with ESP awoke in"

	para "bed transformed"
	line "into Kadabra!"
	done

.BeatenText:
	text "Urban legend?"
	line "What's that?"
	done

.AfterText:
	text "Prof.Oak won't"
	line "give me a #dex."
	cont "I wonder why?"
	done

TrainerEngineerBernie:
	trainer EVENT_BEAT_ENGINEER_BERNIE, ENGINEER, BERNIE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "Careful!"
	line "I'm laying down"
	cont "some cables!"
	done

.BeatenText:
	text "That was"
	line "electric!"
	done

.AfterText:
	text "Spread the word"
	line "to save energy!"
	done

TrainerEngineerCamden:
	trainer EVENT_BEAT_ENGINEER_CAMDEN, ENGINEER, CAMDEN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "I learned engin-"
	line "eering at Celadon"
	cont "University!"
	done

.BeatenText:
	text "Shut down!"
	done

.AfterText:
	text "Building a bridge"
	line "and building a"
	cont "team of #mon"

	para "both require know-"
	line "ledge and skill."
	done

Route11Sign:
	jumptext Route11SignText

FruitTreeScript_0x68055:
	fruittree FRUITTREE_ROUTE_11

Route11HiddenRevive:
	dwb EVENT_ROUTE_11_HIDDEN_REVIVE, REVIVE

Route11SignText:
	text "Route 11"
	done

Route11_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $8, $2f, 1, ROUTE_11_GATE
	warp_def $9, $2f, 2, ROUTE_11_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 7, 5, SIGNPOST_READ, Route11Sign
	signpost 5, 44, SIGNPOST_ITEM, Route11HiddenRevive

.PersonEvents:
	db 9
	person_event SPRITE_YOUNGSTER, 14, 32, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterOwen, -1
	person_event SPRITE_YOUNGSTER, 4, 30, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterJason, -1
	person_event SPRITE_YOUNGSTER, 2, 21, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterAlfie, -1
	person_event SPRITE_YOUNGSTER, 7, 40, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerPsychicHerman, -1
	person_event SPRITE_YOUNGSTER, 6, 12, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPsychicFidel, -1
	person_event SPRITE_YOUNGSTER, 14, 24, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPsychicUri, -1
	person_event SPRITE_ENGINEER, 15, 7, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerEngineerBernie, -1
	person_event SPRITE_ENGINEER, 14, 38, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerEngineerCamden, -1
	person_event SPRITE_BALL_CUT_FRUIT, 2, 44, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x68055, -1
