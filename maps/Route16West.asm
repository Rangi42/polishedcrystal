Route16West_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 35,  1, PSYCHIC_INVERS_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 59,  2, BGEVENT_JUMPTEXT, Route16WestSignpostText
	bg_event 24,  5, BGEVENT_ITEM + RARE_CANDY, EVENT_ROUTE_16_WEST_HIDDEN_RARE_CANDY

	def_object_events
	object_event 56,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassGina, -1
	object_event 17,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerLassAlice, -1
	object_event  9, 12, SPRITE_COSPLAYER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCosplayerKuroko, -1
	object_event 40, 11, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainerfSera, -1
	object_event  6,  2, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyNicole, -1
	itemball_event 42, 14, METRONOME_I, 1, EVENT_ROUTE_16_WEST_METRONOME
	itemball_event 51,  2, PP_UP, 1, EVENT_ROUTE_16_WEST_PP_UP
	itemball_event 21,  2, MAX_REVIVE, 1, EVENT_ROUTE_16_WEST_MAX_REVIVE
	cuttree_event  3,  7, EVENT_ROUTE_16_WEST_CUT_TREE_1
	cuttree_event 57,  2, EVENT_ROUTE_16_WEST_CUT_TREE_2

GenericTrainerLassGina:
	generictrainer LASS, GINA, EVENT_BEAT_LASS_GINA, .SeenText, .BeatenText

	text "My strappy sandals"
	line "look sooo cute,"
	cont "though! ♥"
	done

.SeenText:
	text "Check out my new"
	line "outfit!"
	done

.BeatenText:
	text "If I'd spent money"
	line "on Potions instead"
	cont "of clothes…"
	done

GenericTrainerLassAlice:
	generictrainer LASS, ALICE, EVENT_BEAT_LASS_ALICE, .SeenText, .BeatenText

	text "I'm really a guy…"
	line "Don't tell anyone!"
	done

.SeenText:
	text "Our eyes met!"

	para "Now you must date"
	line "me! ♥"

	para "No wait, I mean,"
	line "we must battle!"
	done

.BeatenText:
	text "How could you be"
	line "so cruel?"
	done

GenericTrainerCosplayerKuroko:
	generictrainer COSPLAYER, KUROKO, EVENT_BEAT_COSPLAYER_KUROKO, .SeenText, .BeatenText

	text "One time a trainer"
	line "threw a # Ball"
	cont "at me!"
	done

.SeenText:
	text "See how lifelike"
	line "my cosplay is?"
	done

.BeatenText:
	text "You just don't"
	line "appreciate art!"
	done

GenericTrainerCooltrainerfSera:
	generictrainer COOLTRAINERF, SERA, EVENT_BEAT_COOLTRAINERF_SERA, .SeenText, .BeatenText

	text "I've gone out as a"
	line "a Cosplayer, but"

	para "an Ace Trainer's"
	line "outfit is more"
	cont "intimidating."
	done

.SeenText:
	text "Do you think you"
	line "can handle me?"
	done

.BeatenText:
	text "Congrats! ♥"
	done

GenericTrainerBeautyNicole:
	generictrainer BEAUTY, BEAUTY_NICOLE, EVENT_BEAT_BEAUTY_NICOLE, .SeenText, .BeatenText

	text "Cute #mon can"
	line "be strong too,"
	cont "you know!"
	done

.SeenText:
	text "Aren't my #mon"
	line "the cutest?"
	done

.BeatenText:
	text "They're even cute"
	line "while fainted…"
	done

Route16WestSignpostText:
	text "Route 16"
	done
