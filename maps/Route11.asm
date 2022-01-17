Route11_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 45,  8, ROUTE_11_GATE, 1
	warp_event 45,  9, ROUTE_11_GATE, 2

	def_coord_events

	def_bg_events
	bg_event  5,  7, BGEVENT_JUMPTEXT, Route11SignText
	bg_event 44,  5, BGEVENT_ITEM + REVIVE, EVENT_ROUTE_11_HIDDEN_REVIVE

	def_object_events
	object_event 32, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterOwen, -1
	object_event 30,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterJason, -1
	object_event 21,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerYoungsterAlfie, -1
	object_event 40,  7, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerPsychicHerman, -1
	object_event 12,  6, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicFidel, -1
	object_event 24, 14, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicUri, -1
	object_event 38,  1, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerBernie, -1
	object_event 38, 14, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerCamden, -1
	object_event  9,  3, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGuitaristmRoger, -1
	object_event 10, 16, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGuitaristfRitsuko, -1
	fruittree_event 44,  2, FRUITTREE_ROUTE_11, GANLON_BERRY, PAL_NPC_PURPLE
	tmhmball_event 44, 13, TM_VENOSHOCK, EVENT_ROUTE_11_TM_VENOSHOCK

GenericTrainerYoungsterOwen:
	generictrainer YOUNGSTER, OWEN, EVENT_BEAT_YOUNGSTER_OWEN, YoungsterOwenSeenText, YoungsterOwenBeatenText

	ctxt "I fought fair and"
	line "square with honor."

	para "I don't regret"
	line "this at all."
	done

YoungsterOwenSeenText:
	ctxt "There's no cheat-"
	line "ing in #mon."

	para "Let's keep it fair"
	line "and square!"
	done

YoungsterOwenBeatenText:
	ctxt "Huh? How did this"
	line "happen?"
	done

GenericTrainerYoungsterJason:
	generictrainer YOUNGSTER, JASON, EVENT_BEAT_YOUNGSTER_JASON, YoungsterJasonSeenText, YoungsterJasonBeatenText

	ctxt "I'm going to catch"
	line "more #mon in"
	cont "the grass."
	done

YoungsterJasonSeenText:
	ctxt "It itches and"
	line "tickles a bit when"

	para "I wear shorts in"
	line "the grass."
	done

YoungsterJasonBeatenText:
	ctxt "Aiyaaah!"
	line "I got stomped!"
	done

GenericTrainerYoungsterAlfie:
	generictrainer YOUNGSTER, ALFIE, EVENT_BEAT_YOUNGSTER_ALFIE, .SeenText, .BeatenText

	ctxt "Everything's more"
	line "fun when it's a"
	cont "competition."
	done

.SeenText:
	ctxt "Three, two, one,"
	line "GO!"
	done

.BeatenText:
	ctxt "Game, set, match."
	done

GenericTrainerPsychicHerman:
	generictrainer PSYCHIC_T, HERMAN, EVENT_BEAT_PSYCHIC_HERMAN, PsychicHermanSeenText, PsychicHermanBeatenText

	ctxt "…"

	para "I lost while I had"
	line "my eyes closed…"
	done

PsychicHermanSeenText:
	ctxt "…"
	done

PsychicHermanBeatenText:
	ctxt "…"
	done

GenericTrainerPsychicFidel:
	generictrainer PSYCHIC_T, FIDEL, EVENT_BEAT_PSYCHIC_FIDEL, PsychicFidelSeenText, PsychicFidelBeatenText

	ctxt "Strength in con-"
	line "viction…"

	para "You're strong be-"
	line "cause you believe"
	cont "in your #mon."
	done

PsychicFidelSeenText:
	ctxt "I can see it…"

	para "Everything to see"
	line "about you…"
	done

PsychicFidelBeatenText:
	ctxt "I couldn't foresee"
	line "your power…"
	done

GenericTrainerPsychicUri:
	generictrainer PSYCHIC_T, URI, EVENT_BEAT_PSYCHIC_URI, .SeenText, .BeatenText

	ctxt "Prof.Oak won't"
	line "give me a #dex."
	cont "I wonder why?"
	done

.SeenText:
	ctxt "It happened one"
	line "morning--a boy"
	cont "with ESP awoke in"

	para "bed transformed"
	line "into Kadabra!"
	done

.BeatenText:
	ctxt "Urban legend?"
	line "What's that?"
	done

GenericTrainerEngineerBernie:
	generictrainer ENGINEER, BERNIE, EVENT_BEAT_ENGINEER_BERNIE, .SeenText, .BeatenText

	ctxt "Spread the word"
	line "to save energy!"
	done

.SeenText:
	ctxt "Careful!"
	line "I'm laying down"
	cont "some cables!"
	done

.BeatenText:
	ctxt "That was"
	line "electric!"
	done

GenericTrainerEngineerCamden:
	generictrainer ENGINEER, CAMDEN, EVENT_BEAT_ENGINEER_CAMDEN, .SeenText, .BeatenText

	ctxt "Building a bridge"
	line "and building a"
	cont "team of #mon"

	para "both require know-"
	line "ledge and skill."
	done

.SeenText:
	ctxt "I learned engin-"
	line "eering at Celadon"
	cont "University!"
	done

.BeatenText:
	ctxt "Shut down!"
	done

GenericTrainerGuitaristmRoger:
	generictrainer GUITARISTM, ROGER, EVENT_BEAT_GUITARISTM_ROGER, .SeenText, .BeatenText

	ctxt "Don't give in"
	line "without a fight!"
	done

.SeenText:
	ctxt "Strangers passing"
	line "in the street,"

	para "by chance two"
	line "separate glances"
	cont "meet!"
	done

.BeatenText:
	ctxt "Shine on, you"
	line "crazy diamond!"
	done

GenericTrainerGuitaristfRitsuko:
	generictrainer GUITARISTF, RITSUKO, EVENT_BEAT_GUITARISTF_RITSUKO, .SeenText, .BeatenText

	ctxt "♪ Rock'n, rock'n'"
	line "roll radio… ♪"
	done

.SeenText:
	ctxt "Hey ho, let's go!"
	done

.BeatenText:
	ctxt "There's no success"
	line "for me…"
	done

Route11SignText:
	ctxt "Route 11"
	done
