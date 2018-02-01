Route11_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 47, 8, 1, ROUTE_11_GATE
	warp_event 47, 9, 2, ROUTE_11_GATE

	db 0 ; coord events

	db 2 ; bg events
	bg_event 5, 7, SIGNPOST_JUMPTEXT, Route11SignText
	bg_event 44, 5, SIGNPOST_ITEM + REVIVE, EVENT_ROUTE_11_HIDDEN_REVIVE

	db 12 ; object events
	object_event 32, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterOwen, -1
	object_event 30, 4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterJason, -1
	object_event 21, 2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterAlfie, -1
	object_event 40, 7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerPsychicHerman, -1
	object_event 12, 6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPsychicFidel, -1
	object_event 24, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPsychicUri, -1
	object_event 7, 15, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerEngineerBernie, -1
	object_event 38, 14, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerEngineerCamden, -1
	object_event 9, 3, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerGuitaristmRoger, -1
	object_event 13, 16, SPRITE_VERMILION_LAWRENCE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerGuitaristfRitsuko, -1
	fruittree_event 44, 2, FRUITTREE_ROUTE_11, GANLON_BERRY
	tmhmball_event 44, 13, TM_VENOSHOCK, EVENT_ROUTE_11_TM_VENOSHOCK

TrainerYoungsterOwen:
	trainer YOUNGSTER, OWEN, EVENT_BEAT_YOUNGSTER_OWEN, YoungsterOwenSeenText, YoungsterOwenBeatenText, 0, YoungsterOwenScript

YoungsterOwenScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x680b2

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
	trainer YOUNGSTER, JASON, EVENT_BEAT_YOUNGSTER_JASON, YoungsterJasonSeenText, YoungsterJasonBeatenText, 0, YoungsterJasonScript

YoungsterJasonScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6814a

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
	trainer YOUNGSTER, ALFIE, EVENT_BEAT_YOUNGSTER_ALFIE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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
	trainer PSYCHIC_T, HERMAN, EVENT_BEAT_PSYCHIC_HERMAN, PsychicHermanSeenText, PsychicHermanBeatenText, 0, PsychicHermanScript

PsychicHermanScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6817b

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
	trainer PSYCHIC_T, FIDEL, EVENT_BEAT_PSYCHIC_FIDEL, PsychicFidelSeenText, PsychicFidelBeatenText, 0, PsychicFidelScript

PsychicFidelScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x681ec

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
	trainer PSYCHIC_T, URI, EVENT_BEAT_PSYCHIC_URI, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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
	trainer ENGINEER, BERNIE, EVENT_BEAT_ENGINEER_BERNIE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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
	trainer ENGINEER, CAMDEN, EVENT_BEAT_ENGINEER_CAMDEN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

TrainerGuitaristmRoger:
	trainer GUITARISTM, ROGER, EVENT_BEAT_GUITARISTM_ROGER, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Strangers passing"
	line "in the street,"

	para "by chance two"
	line "separate glances"
	cont "meet!"
	done

.BeatenText:
	text "Shine on, you"
	line "crazy diamond!"
	done

.AfterText:
	text "Don't give in"
	line "without a fight!"
	done

TrainerGuitaristfRitsuko:
	trainer GUITARISTF, RITSUKO, EVENT_BEAT_GUITARISTF_RITSUKO, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Hey ho, let's go!"
	done

.BeatenText:
	text "There's no success"
	line "for me…"
	done

.AfterText:
	text "♪ Rock'n, rock'n'"
	line "roll radio… ♪"
	done

Route11SignText:
	text "Route 11"
	done
